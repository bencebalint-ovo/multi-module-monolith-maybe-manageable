from lib2 import something_else
from shared_lib import wisdom


def lambda_handler(event, context):
    return {
        "fact": something_else.idk(),
        "shared": wisdom.what_is_good()
    }
