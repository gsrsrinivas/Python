import logging
from logging.handlers import RotatingFileHandler


def setup_rotating_logger(script_name, max_bytes=1024 * 1024, backup_count=5):
    logger = logging.getLogger(script_name)
    logger.setLevel(logging.INFO)

    log_file = f"{script_name}.log"
    handler = RotatingFileHandler(
        log_file,
        maxBytes=max_bytes,  # Rotate when file reaches 1MB
        backupCount=backup_count  # Keep last 5 logs
    )

    formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
    handler.setFormatter(formatter)

    # Avoid duplicate handlers if function is called multiple times
    if not logger.handlers:
        logger.addHandler(handler)

    return logger


# Example usage
logger = setup_rotating_logger(__file__)
logger.info("Script1 started execution")
