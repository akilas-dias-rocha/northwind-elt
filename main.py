import kagglehub
import os

def download_data():
    base_dir = os.path.dirname(os.path.abspath(__file__))
    output_dir = os.path.join(base_dir, "northwind_data")
    
    path = kagglehub.dataset_download(
        "jeetahirwar/northwind-traders",
        output_dir=output_dir
    )
    print(f"Dataset downloaded on: {path}")

if __name__ == "__main__":
    download_data()
