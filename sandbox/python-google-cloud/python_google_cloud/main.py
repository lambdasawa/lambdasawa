from google.cloud import pubsub_v1
from google.cloud import storage
import sys
import os

project_id = os.environ["PROJECT_ID"]


def use_storage():
    bucket_name = "lambdasawa-sandbox-python-google-cloud"

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


def use_pubsub():
    topic_name = "lambdasawa-sandbox-python-google-cloud"
    subscription_name = "lambdasawa-sandbox-python-google-cloud-sub"

    publisher = pubsub_v1.PublisherClient()
    topic_path = publisher.topic_path(project_id, topic_name)
    publisher.publish(topic_path, data="Hello, Cloud Pub/Sub!".encode("utf-8"))
    print(f"Published message to {topic_path}.")

    def receive_message(message):
        print(f"Received message: {message.data.decode('utf-8')}")
        message.ack()

    subscriber = pubsub_v1.SubscriberClient()
    subscription_path = subscriber.subscription_path(project_id, subscription_name)
    streaming_pull_future = subscriber.subscribe(
        subscription_path, callback=receive_message
    )
    print(f"Listening for messages on {subscription_path}...\n")

    with subscriber:
        try:
            streaming_pull_future.result()
        except TimeoutError:
            streaming_pull_future.cancel()
            streaming_pull_future.result()


def default():
    raise Exception("Unknown arguments")


if __name__ == "__main__":
    {
        "storage": use_storage,
        "pubsub": use_pubsub,
    }.get(sys.argv[1], default)()
