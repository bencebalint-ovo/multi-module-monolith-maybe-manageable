from lib1 import cats

def lambda_handler(event):
    print('hello from lambda, got event "%s"' % event)
    print("FYI %s" % cats.meow())


if __name__ == "__main__":
    print("running as main with empty event")
    lambda_handler(None)
