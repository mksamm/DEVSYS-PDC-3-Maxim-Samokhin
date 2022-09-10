# Курсовая работа по итогам модуля "DevOps и системное администрирование"

1. Создайте виртуальную машину Linux.

```
Vagrant.configure("2") do |config|
	config.vm.box = "bento/ubuntu-20.04"
	config.vm.network "forwarded_port", guest: 443, host: 443
	config.vm.provider "virtualbox" do |v|
  		v.memory = 2048
  		v.cpus = 2
	end
end
```
2. Установите ufw и разрешите к этой машине сессии на порты 22 и 443, при этом трафик на интерфейсе localhost (lo) должен ходить свободно на все порты.

> Настройка ufw
```
sudo sed -i 's/IPV6=yes/IPV6=no/g' /etc/default/ufw
sudo ufw allow https
sudo ufw allow ssh
sudo ufw allow in on lo to any
sudo ufw enable
sudo ufw status
```
Процесс установки и настройки ufw
![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/Course1.PNG)

3. Установите hashicorp vault.
```
# Добавление HashiCorp GPG key
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
# Добавление официального HashiCorp Linux репозитория
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
# Установка Vault
sudo apt-get update && sudo apt-get install vault
```
![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/Course2.PNG)

4. Cоздайте центр сертификации и выпустите сертификат для использования его в настройке веб-сервера nginx 
```
sudo apt -y install jq
vault server -dev -dev-root-token-id root
```
![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/Course3.PNG)

Необходимо открыть дополнительное окно терминала.
```
export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN=root
```

>Создание Root CA
```
# Включение механизма секретов pki в пути pki_root
vault secrets enable -path=pki_root pki
# Установка времени жизни для сертификатов 
vault secrets tune -max-lease-ttl=87600h pki_root
# Создание корневого сертификата
vault write -field=certificate pki_root/root/generate/internal common_name="netology.devops" ttl=87600h > RootCA.crt
# Добавление URL адреса CA и точку распределения
vault write pki_root/config/urls issuing_certificates="$VAULT_ADDR/v1/pki/ca" crl_distribution_points="$VAULT_ADDR/v1/pki/crl"
```

>Добавление промежуточного СА
```
vault secrets enable -path=pki_intermediate pki
# Установка время жизни для сертификатов 
vault secrets tune -max-lease-ttl=43800h pki_intermediate
# Генерируем CSR
vault write -format=json pki_intermediate/intermediate/generate/internal common_name="netology.devops Intermediate CA" | jq -r '.data.csr' > IntermediateCA.csr
# Подпишем закрытым ключом RootCA промежуточный сертификат и сохраним
vault write -format=json pki_root/root/sign-intermediate csr=@IntermediateCA.csr format=pem_bundle ttl="43800h" | jq -r '.data.certificate' > IntermediateCA.pem
# После того, как CSR подписан и получен сертификат, последний можно испортировать обратно в Vault
vault write pki_intermediate/intermediate/set-signed certificate=@IntermediateCA.pem
```

>Роль и выпуск сертификата
```
# Добавить роль, которая разрешает поддомены netology.devops сроком жизни до 30 дней
vault write pki_intermediate/roles/netology-dot-devops allowed_domains="netology.devops" allow_subdomains=true max_ttl="720h"
# Создать сертификат на 30 дней для доменного имени vault.netology.devops
vault write -format=json pki_intermediate/issue/netology-dot-devops common_name="vault.netology.devops" alt_names="vault.netology.devops" > vault.netology.devops.crt
# Сохраняем сертификат в правильном формате
cat vault.netology.devops.crt | jq -r '.data.private_key' > private.pem
cat vault.netology.devops.crt | jq -r '.data.certificate' > cert.crt
cat vault.netology.devops.crt | jq -r '.data.ca_chain[]' >> cert.crt
```
![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/Course4.PNG)

5. Установите корневой сертификат созданного центра сертификации в доверенные в хостовой системе.
Выполним копирование корневого сертификата в общую папку: 
```
cp ИМЯ_СЕРТИФИКАТА.crt /vagrant/
```
Затем на хостовой машины выполним:
```
WIN + R >> mmc
```
В окне "Корень консоли" переходим в вкладку "Доверенные корневые центры сертификации" > Правой кнопкой мыши выбираем в контекстном меню "Все задачи" > "Импорт".
Выбираем наш корневой сертификат. 

![img.png](https://github.com/mksamm/DEVSYS-PDC-3-Maxim-Samokhin/blob/main/Course5.PNG)

6. Установите nginx.
```
sudo apt install nginx
```
7.Настройте nginx на https, используя ранее подготовленный сертификат
```
# Создаем директорию для хранения сертификатов
sudo mkdir /etc/nginx/ssl
sudo cp private.pem /etc/nginx/ssl/private.pem
sudo cp cert.crt /etc/nginx/ssl/cert.crt
# Редактируем конфигурацию стандартной страницы
nano /etc/nginx/sites-available/default
server {
	listen				443 ssl;
	server_name         vault.netology.devops;
 	ssl_certificate     /etc/nginx/ssl/cert.crt;
	ssl_certificate_key /etc/nginx/ssl/private.pem;
	ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
	ssl_ciphers         HIGH:!aNULL:!MD5;
	...
# Сохраняем и перезапускаем сервис
sudo systemctl restart nginx
```


