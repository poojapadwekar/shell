source common.sh
component=backend

echo Install NodeJS Repos
dnf module disable nodejs -y &>>$log_file
dnf module enable nodejs:18 -y &>>$log_file

dnf install nodejs -y &>>$log_file

echo Copy Backend Service
cp backend.service /etc/systemd/system/backend.service &>>$log_file

echo Add ApplicatiOn User
useradd expense &>>$log_file

echo Clear App Content
rm -rf /app &>>$log_file

mkdir /app

cd /app

download_and_extract &>>$log_file#function is called

echo Download Dependencies
npm install &>>$log_file

echo Start Backend Service
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl start backend &>>$log_file

echo Install MySQL Client
dnf install mysql -y &>>$log_file

echo Load Schema
mysql -h 172.31.21.0 -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file


