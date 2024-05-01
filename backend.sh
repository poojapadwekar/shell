source common.sh
component=backend

echo Disable nodejs
dnf module disable nodejs -y &>>$log_file
stat_check

echo enable nodejs
dnf module enable nodejs:18 -y &>>$log_file
stat_check

type npm >>$log_file
if [ $? -ne 0 ]; then
 echo Install NodeJS Repos
 dnf install nodejs -y &>>$log_file
 stat_check
fi

echo Copy Backend Service
cp backend.service /etc/systemd/system/backend.service &>>$log_file
stat_check

echo Add ApplicatiOn User
id expense &>>$log_file
if [ $? -ne 0 ]; then
  useradd expense &>>$log_file
fi
stat_check

echo Clear App Content
rm -rf /app &>>$log_file
stat_check

mkdir /app
stat_check

cd /app
stat_check

download_and_extract &>>$log_file#function is called
stat_check

echo Download Dependencies
npm install &>>$log_file
stat_check

echo Start Backend Service
systemctl daemon-reload &>>$log_file
stat_check

systemctl enable backend &>>$log_file
stat_check

systemctl start backend &>>$log_file
stat_check

echo Install MySQL Client
dnf install mysql -y &>>$log_file
stat_check

echo Load Schema
mysql -h 172.31.21.0 -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
stat_check

