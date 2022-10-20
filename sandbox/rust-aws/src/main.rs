use std::error::Error;

#[tokio::main]
async fn main() -> Result<(), Box<dyn Error>> {
    let client = {
        let config = aws_config::from_env().load().await;
        aws_sdk_s3::Client::new(&config)
    };

    client
        .list_buckets()
        .send()
        .await?
        .buckets
        .unwrap_or([].to_vec())
        .iter()
        .for_each(|bucket| {
            println!("Bucket: {:?}", bucket.name);
        });

    Ok(())
}
