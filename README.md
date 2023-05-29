# mmmmm

## Prerequisites
* `docker`
* `aws`
* `poetry`
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
4. inspect deployment ZIPs ([lambda1/dist/function.zip](lambda1/dist/function.zip))
   ```shell 
   unzip -l lambda1/dist/function.zip
   ```
   ```shell 
   unzip -l lambda2/dist/function.zip
   ```
5. invoke lambdas
    ```shell
    aws lambda invoke --function-name lambda1 --endpoint-url=http://localhost:4566 /dev/stdout
    ```
    ```shell
    aws lambda invoke --function-name lambda2 --endpoint-url=http://localhost:4566 /dev/stdout
    ```
