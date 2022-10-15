use std::io;

use serde_json::Value;

fn main() {
    let mut buffer = String::new();
    let stdin = io::stdin();
    stdin.read_line(&mut buffer).expect("failed to read line");

    let v: Value = serde_json::from_str(&buffer).expect("failed to serialize");

    let s: String = serde_json::to_string_pretty(&v).expect("failed to serialize");

    println!("{}", s);
}
