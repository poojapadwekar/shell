source common.sh
component=backend

echo Install NodeJS Repos
dnf module disable nodejs -y &>>$log_file
echo $?

dnf module enable nodejs:18 -y &>>$log_file
echo $?

dnf install nodejs -y &>>$log_file
echo $?

echo Copy Backend Service
cp backend.service /etc/systemd/system/backend.service &>>$log_file
echo $?

echo Add ApplicatiOn User
useradd expense &>>$log_file
echo $?

echo Clear App Content
rm -rf /app &>>$log_file
echo $?

mkdir /app
echo $?

cd /app
echo $?

download_and_extract &>>$log_file#function is called
echo $?

echo Download Dependencies
npm install &>>$log_file
echo $?

echo Start Backend Service
systemctl daemon-reload &>>$log_file
echo $?
systemctl enable backend &>>$log_file
echo $?
systemctl start backend &>>$log_file
echo $?

echo Install MySQL Client
dnf install mysql -y &>>$log_file
echo $?

echo Load Schema
mysql -h 172.31.21.0 -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
echo $?


