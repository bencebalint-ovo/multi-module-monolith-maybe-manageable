from lib1 import cats
from shared_lib import wisdom


def lambda_handler(event, context):
    return {
        "fact": cats.meow(),
        "shared": wisdom.what_is_good()
    }
