import json
import random

import pandas as pd


def generate_sample_json(index):
    """ Helper to create a nested JSON-like structure"""
    return {
        "id": index,
        "name": f"Item {index}",
        "details": {
            "manufacturer": f"Company {random.randint(1, 10)}",
            "warranty_years": random.choice([1, 2, 3]),
            "specs": {
                "weight": f"{random.uniform(1.0, 5.0):.2f} kg",
                "dimensions": {
                    "length": f"{random.uniform(10.0, 50.0):.2f} cm",
                    "width": f"{random.uniform(10.0, 50.0):.2f} cm",
                    "height": f"{random.uniform(10.0, 50.0):.2f} cm"
                }
            }
        },
        "tags": [random.choice(["electronics", "home", "garden", "sports", "fashion"]) for _ in
                 range(random.randint(2, 5))],
        "available": random.choice([True, False])
    }


def generate_sample_json_example():
    # Create 100 samples
    sample_data = [json.dumps(generate_sample_json(i)) for i in range(1, 101)]

    # Create a DataFrame and save to Excel
    df = pd.DataFrame({"json_data": sample_data})
    df.to_excel("../Files Output/100_sample_json_strings.xlsx", index=False)


if __name__ == "__main__":
    generate_sample_json_example()
