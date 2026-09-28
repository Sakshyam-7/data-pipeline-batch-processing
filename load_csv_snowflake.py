import dlt
import pandas as pd


pipeline = dlt.pipeline(
    pipeline_name='local_csv_pipeline',
    destination='snowflake',
    dataset_name='staging' 
)

files_to_load = {
    "bookings": "D:/airbnb/bookings.csv",
    "listings": "D:/airbnb/listings.csv",
    "hosts": "D:/airbnb/hosts.csv"
}


for table_name, file_path in files_to_load.items():
    print(f"Loading {file_path} into {table_name}...")
    
    df = pd.read_csv(file_path)
    
    load_info = pipeline.run(
        df,
        table_name=table_name,
        write_disposition="replace" 
    )
    
    print(load_info)