source common.sh
component=frontend

echo Installing nginx
dnf install nginx -y &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[32mSUCCESS\e[0m"
fi

echo Placing Expense Config file in Nginx
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[32mSUCCESS\e[0m"
fi

echo Removing old Nginx content
rm -rf /usr/share/nginx/html/* &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[32mSUCCESS\e[0m"
fi

cd /usr/share/nginx/html
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[32mSUCCESS\e[0m"
fi

download_and_extract &>>$log_file#function is called
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[32mSUCCESS\e[0m"
fi

echo Starting Nginx Service
systemctl enable nginx &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[32mSUCCESS\e[0m"
fi

systemctl restart nginx &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[32mSUCCESS\e[0m"
fi