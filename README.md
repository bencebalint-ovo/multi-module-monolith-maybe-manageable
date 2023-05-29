# mmmmm

## Prerequisites
* `docker`
* `aws`
* `poetry`
* `virtualenv`
* `tflocal` (for simpler local deployment; `pip install terraform-local`)

## Quick start

1. start LocalStack
   ```shell
   docker compose up -d
   ```
2. build deployment packages (see [build.sh](build.sh))
    ```shell
    ./build.sh lambda1
    ```
    ```shell
    ./build.sh lambda2
    ```
3. deploy to LocalStack Lambda (see [lambda1/main.tf](lambda1/main.tf))
    ```shell
    tflocal -chdir=lambda1 init && tflocal -chdir=lambda1 apply -auto-approve
    ```
    ```shell
    tflocal -chdir=lambda2 init && tflocal -chdir=lambda2 apply -auto-approve
    ```
4. invoke lambdas
    ```shell
    aws lambda invoke --function-name lambda1 --endpoint-url=http://localhost:4566 /dev/stdout
    ```
    ```shell
    aws lambda invoke --function-name lambda2 --endpoint-url=http://localhost:4566 /dev/stdout
    ```
5. inspect deployment ZIPs
   ```shell 
   unzip -l lambda1/dist/function.zip
   ```
   ```shell 
   unzip -l lambda2/dist/function.zip
   ```
   should look something like
   ```
   $ unzip -l lambda1/dist/function.zip
   Archive:  lambda1/dist/function.zip
     Length      Date    Time    Name
   ---------  ---------- -----   ----
           0  01-01-2049 00:00   __init__.py
        4662  01-01-2049 00:00   __pycache__/_virtualenv.cpython-311.pyc
          18  01-01-2049 00:00   _virtualenv.pth
        4311  01-01-2049 00:00   _virtualenv.py
           6  01-01-2049 00:00   lambda1-0.1.0.dist-info/INSTALLER
         597  01-01-2049 00:00   lambda1-0.1.0.dist-info/METADATA
         899  01-01-2049 00:00   lambda1-0.1.0.dist-info/RECORD
         119  01-01-2049 00:00   lambda1-0.1.0.dist-info/direct_url.json
          70  01-01-2049 00:00   lambda1.pth
         178  01-01-2049 00:00   lambda_handler.py
           0  01-01-2049 00:00   lib1/__init__.py
          44  01-01-2049 00:00   lib1/cats.py
          12  01-01-2049 00:00   lib1-0.1.0.dist-info/INSTALLER
         390  01-01-2049 00:00   lib1-0.1.0.dist-info/METADATA
         458  01-01-2049 00:00   lib1-0.1.0.dist-info/RECORD
          88  01-01-2049 00:00   lib1-0.1.0.dist-info/WHEEL
         100  01-01-2049 00:00   lib1-0.1.0.dist-info/direct_url.json
           0  01-01-2049 00:00   shared_lib/__init__.py
          50  01-01-2049 00:00   shared_lib/wisdom.py
          12  01-01-2049 00:00   shared_lib-0.1.0.dist-info/INSTALLER
         396  01-01-2049 00:00   shared_lib-0.1.0.dist-info/METADATA
         502  01-01-2049 00:00   shared_lib-0.1.0.dist-info/RECORD
          88  01-01-2049 00:00   shared_lib-0.1.0.dist-info/WHEEL
         106  01-01-2049 00:00   shared_lib-0.1.0.dist-info/direct_url.json
   ---------                     -------
       13106                     24 files
   ```