source common.sh
component=frontend

echo Installing nginx
dnf install nginx -y &>>$log_file
echo $?

echo Placing Expense Config file in Nginx
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
echo $?

echo Removing old Nginx content
rm -rf /usr/share/nginx/html/* &>>$log_file
echo $?

cd /usr/share/nginx/html
echo $?

download_and_extract &>>$log_file#function is called
echo $?

echo Starting Nginx Service
systemctl enable nginx &>>$log_file
echo $?

systemctl restart nginx &>>$log_file
echo $?
