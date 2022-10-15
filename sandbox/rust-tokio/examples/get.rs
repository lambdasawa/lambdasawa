use mini_redis::client;
use std::error::Error;

#[tokio::main]
async fn main() -> Result<(), Box<dyn Error + Send + Sync>> {
    let mut client = client::connect("127.0.0.1:6379").await?;

    let value = client.get("hello").await?;

    println!("{:?}", value);

    Ok(())
}
