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
2. build deployment package (see [build.sh](build.sh))
    ```shell
    ./build.sh
    ```
3. deploy to LocalStack Lambda (see [lambda1/main.tf](lambda1/main.tf))
    ```shell
    tflocal -chdir=lambda1 apply -auto-approve
    ```
4. inspect deployment ZIP ([lambda1/dist/function.zip](lambda1/dist/function.zip))
   ```shell 
   unzip -l lambda1/dist/function.zip
   ```
5. invoke lambda
    ```shell
    aws lambda invoke --function-name lambda1 --endpoint-url=http://localhost:4566 /dev/stdout
    ```
