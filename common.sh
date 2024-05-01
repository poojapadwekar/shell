log_file=/tmp/expense.log

download and extract() {
  echo Download $component Code
  curl -o /tmp/$component.zip https://expense-artifacts.s3.amazonaws.com/$component.zip >>$log_file

  echo Extracting $component code
  unzip /tmp/$component.zip >>$log_file
}

