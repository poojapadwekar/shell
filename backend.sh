source common.sh
component=backend

echo Install NodeJS Repos
dnf module disable nodejs -y &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILED
fi

dnf module enable nodejs:18 -y &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILED
fi

dnf install nodejs -y &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILED
fi

echo Copy Backend Service
cp backend.service /etc/systemd/system/backend.service &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILED
fi

echo Add ApplicatiOn User
useradd expense &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILED
  exit
fi

echo Clear App Content
rm -rf /app &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILED
fi

mkdir /app
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILED
fi

cd /app
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILED
fi

download_and_extract &>>$log_file#function is called
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILED
fi

echo Download Dependencies
npm install &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILED
fi

echo Start Backend Service
systemctl daemon-reload &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILED
fi

systemctl enable backend &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILED
fi

systemctl start backend &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILED
fi

echo Install MySQL Client
dnf install mysql -y &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILED
fi

echo Load Schema
mysql -h 172.31.21.0 -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILED
fi


