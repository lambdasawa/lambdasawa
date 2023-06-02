from google.cloud import storage

bucket_name = "lambsour"

storage_client = storage.Client()

if bucket_name in [bucket.name for bucket in storage_client.list_buckets()]:
    bucket = storage_client.get_bucket(bucket_name)
    print(f"Bucket {bucket.name} already exists.")
else:
    bucket = storage_client.create_bucket(bucket_name)
    print(f"Bucket {bucket.name} created.")

bucket.blob("foo/bar.txt").upload_from_filename("poetry.lock")
print(f"File uploaded to {bucket.name}.")

bucket.blob("foo/bar.txt").download_to_filename("foo.txt")
print(f"File downloaded from {bucket.name}.")

with open("foo.txt", "r") as file:
    print(file.read())
