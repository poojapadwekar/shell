source common.sh
component=frontend

echo Installing nginx
dnf install nginx -y &>>$log_file
stat_check &>>$log_file

echo Placing Expense Config file in Nginx
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
stat_check &>>$log_file

echo Removing old Nginx content
rm -rf /usr/share/nginx/html/* &>>$log_file
stat_check &>>$log_file

cd /usr/share/nginx/html
stat_check &>>$log_file

download_and_extract &>>$log_file#function is called
stat_check &>>$log_file


echo Starting Nginx Service
systemctl enable nginx &>>$log_file
stat_check &>>$log_file

systemctl restart nginx &>>$log_file
stat_check &>>$log_file