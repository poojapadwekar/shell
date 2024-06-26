log_file=/tmp/expense.log

download_and_extract() {
  echo Download $component Code
  curl -o /tmp/$component.zip https://expense-artifacts.s3.amazonaws.com/$component.zip >>$log_file

  echo Extracting $component code
  unzip /tmp/$component.zip >>$log_file
}


stat_check() {
  if [ $? -eq 0 ]; then
   echo -e "\e[32mSUCCESS\e[0m"
  else
   echo -e "\e[32mSUCCESS\e[0m"
  fi
}