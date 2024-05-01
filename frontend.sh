log_file=/tmp/expense.log
echo Installing nginx
dnf install nginx -y >>$log_file

echo Placing Expense Config file in Nginx
cp expense.conf /etc/nginx/default.d/expense.conf >>$log_file

echo Removing old Nginx content
rm -rf /usr/share/nginx/html/* >>$log_file

echo Download Frontend Code
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip >>$log_file


cd /usr/share/nginx/html

echo Extracting frontend code
unzip /tmp/frontend.zip >>$log_file

echo Starting Nginx Service
systemctl enable nginx >>$log_file
systemctl restart nginx >>$log_file
