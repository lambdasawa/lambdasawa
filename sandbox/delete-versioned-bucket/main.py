import boto3; s3 = boto3.resource('s3'); b = s3.Bucket(''); b.object_versions.all().delete(); b.delete()
