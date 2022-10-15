use std::error::Error;

use serde;
use serde::{Deserialize, Serialize};

const URL: &str = "https://ifconfig.me/all.json";

#[derive(Debug, Serialize, Deserialize)]
pub struct IfconfigMeResponse {
    ip_addr: String,

    remote_host: String,

    user_agent: Option<String>,

    port: i64,

    method: String,

    mime: Option<String>,

    via: Option<String>,

    forwarded: Option<String>,
}

fn main() -> Result<(), Box<dyn Error>> {
    let resp = reqwest::blocking::get(URL)?.json::<IfconfigMeResponse>()?;
    println!("{:#?}", resp);
    Ok(())
}
