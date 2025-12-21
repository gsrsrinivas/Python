import logging
import sys
from logging.handlers import RotatingFileHandler


# 🌈 Custom formatter for color-coded console output
class CustomFormatter(logging.Formatter):
    grey = "\x1b[38;21m"
    yellow = "\x1b[33;21m"
    red = "\x1b[31;21m"
    bold_red = "\x1b[31;1m"
    reset = "\x1b[0m"
    format_str = "%(asctime)s - %(levelname)s - %(message)s"

    FORMATS = {
        logging.DEBUG: grey + format_str + reset,
        logging.INFO: grey + format_str + reset,
        logging.WARNING: yellow + format_str + reset,
        logging.ERROR: red + format_str + reset,
        logging.CRITICAL: bold_red + format_str + reset
    }

    def format(self, record):
        log_fmt = self.FORMATS.get(record.levelno)
        formatter = logging.Formatter(log_fmt)
        return formatter.format(record)


# 🔁 Setup logger with rotating file + color console + print/sys.stderr redirection
def setup_logger(name="my_logger", log_file="execution.log", max_bytes=1024 * 1024, backup_count=5):
    logger = logging.getLogger(name)
    logger.setLevel(logging.DEBUG)

    if not logger.handlers:
        # Rotating file handler
        file_handler = RotatingFileHandler(log_file, maxBytes=max_bytes, backupCount=backup_count)
        file_handler.setLevel(logging.DEBUG)
        file_handler.setFormatter(logging.Formatter('%(asctime)s - %(levelname)s - %(message)s'))
        logger.addHandler(file_handler)

        # Console handler with color
        console_handler = logging.StreamHandler(sys.stdout)
        console_handler.setLevel(logging.DEBUG)
        console_handler.setFormatter(CustomFormatter())
        logger.addHandler(console_handler)

        # Redirect print() and sys.stderr to logger
        sys.stdout = StreamToLogger(logger, logging.INFO)
        sys.stderr = StreamToLogger(logger, logging.ERROR)

    return logger


# 🔄 Redirect print and stderr to logger
class StreamToLogger:
    def __init__(self, logger, log_level=logging.INFO):
        self.logger = logger
        self.log_level = log_level

    def write(self, message):
        message = message.strip()
        if message:
            self.logger.log(self.log_level, message)

    def flush(self):
        pass


# # 🧠 Decorator to log function calls and returns
# def log_calls(func):
#     @functools.wraps(func)
#     def wrapper(*args, **kwargs):
#         logger = logging.getLogger("my_logger")
#         logger.info(f"Calling {func.__name__} with args={args}, kwargs={kwargs}")
#         result = func(*args, **kwargs)
#         logger.info(f"{func.__name__} returned {result}")
#         return result
#     return wrapper

# 🧪 Example functions
# @log_calls
def greet(name):
    print(f"Hello, {name}!")


# @log_calls
def add(a, b):
    print(f"Adding {a} + {b}")
    return a + b


# 🚀 Main function
def main():
    logger = setup_logger()
    greet("GSR")
    result = add(5, 7)
    print(f"Result: {result}")
    raise ValueError("This is a test error for stderr logging")


if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        print(f"Exception caught: {e}")
