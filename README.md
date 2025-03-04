# MySQL To AWS S3 bucket
A simple batch script to automate MySQL backups on XAMPP (Windows), upload them to AWS S3


## Prerequisites
Before using this script, ensure:
- **XAMPP** is ofcourse installed (`C:\xampp` or modify the path in the script).
- **AWS CLI** is installed and configured with credentials (`aws configure`).
- You have an **S3 bucket** and **Access Key** ready for uploads.

## Setup
1. **Clone the repository**:
  ```sh
  git clone hhttps://github.com/MufaroDKaseke/mysql-s3-backup.git
  cd mysql-s3-backup
  ```

2. **Install AWS CLI** (if not already installed):  
  [Download AWS CLI](https://aws.amazon.com/cli/)

3. **Configure AWS CLI** with your credentials:  
   ```sh
   aws configure
   ```

    This will prompt you for:
     - **AWS Access Key ID**  
     - **AWS Secret Access Key**
     - **Default region name** (e.g., `af-south-1`)
     - **Default output format** (e.g., `json`)

4.  **Edit the script** and set your S3 bucket name:  
    ```batch
    set s3_bucket=s3://<your-buck-name>/mysql-backups/
    ```

5. **Run the script**:  
    ```batch
      mysql_backup.bat
      ```

      The script will:
      - Check if MySQL is running on port 3306
      - Create a backup directory if it doesn't exist
      - Create a timestamped backup of all MySQL databases
      - Upload the backup to your specified S3 bucket

6. **Check if it worked**:
  ```sh
  aws s3 ls s3://<your-bucket-name>/mysql-backups/
  ```

  You should see your backup file listed with today's timestamp.

Let me know if you need further modifications! 🚀