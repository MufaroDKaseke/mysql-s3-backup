@echo off
:: Backup Variables
set backup_path=C:\xampp\mysql\backups
set mysql_bin=C:\xampp\mysql\bin
set date_stamp=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%_%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%
set filename=backup_%date_stamp%.sql
set full_path=%backup_path%\%filename%
set s3_bucket=s3://momo-db-backups/mysql-backups/

:: Variables for MySQL check
setlocal enabledelayedexpansion
set MAX_ATTEMPTS=5
set /a COUNT=0

echo Checking if MySQL is running on port 3306...

:CHECK
netstat -an | find ":3306" >nul
if %ERRORLEVEL%==0 (
    echo MySQL is running!
    goto DONE
) else (
    echo MySQL is not running. Starting MySQL...
    cd /d "C:\xampp\mysql\bin"
    start mysqld.exe
)

:: Wait for a few seconds before checking again
timeout /t 5 >nul
set /a COUNT+=1

:: Exit if max attempts are reached
if !COUNT! GEQ %MAX_ATTEMPTS% (
    echo MySQL failed to start after %MAX_ATTEMPTS% attempts. Exiting...
    exit /b 1
)

goto CHECK

:DONE


:: Check if backup directory exists, create if not
if not exist "%backup_path%" (
  mkdir "%backup_path%"
  echo Created backup directory: %backup_path%
)

:: Create a MySQL backup
echo Backing up MySQL databases...
"%mysql_bin%\mysqldump" -u root --single-transaction --all-databases > "%full_path%"
echo Backup completed: %full_path%
