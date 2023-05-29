from lib1 import cats


def lambda_handler(event, context):
    return {"fact": cats.meow()}


if __name__ == "__main__":
    print("running as main with empty event")
    lambda_handler(None)
