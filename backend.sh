source common.sh

echo Install NodeJS Repos
dnf module disable nodejs -y
dnf module enable nodejs:18 -y

dnf install nodejs -y >>$log_file

echo Copy Backend Service
cp backend.service /etc/systemd/system/backend.service >>$log_file

echo Add ApplicatiOn User
useradd expense >>$log_file

echo Clear App Content
rm -rf /app >>$log_file

mkdir /app

echo Download App Content
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip >>$log_file

cd /app
echo Extract App Content
unzip /tmp/backend.zip >>$log_file

echo Download Dependencies
npm install >>$log_file

echo Start Backend Service
systemctl daemon-reload >>$log_file
systemctl enable backend >>$log_file
systemctl start backend >>$log_file

echo Install MySQL Client
dnf install mysql -y >>$log_file

echo Load Schema
mysql -h 172.31.21.0 -uroot -pExpenseApp@1 < /app/schema/backend.sql >>$log_file


