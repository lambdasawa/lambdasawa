use std::{
    fs::{File, OpenOptions},
    io::{BufRead, BufReader, Read, Write},
    process::Command,
};

fn main() {
    println!("Hello, world!");
}

#[test]
fn hello_world() {
    println!("Hello, world!");
}

#[test]
fn fizzbuzz() {
    for i in 0..100 {
        if i % 15 == 0 {
            println!("FizzBuzz");
        } else if i % 3 == 0 {
            println!("Fizz");
        } else if i % 5 == 0 {
            println!("Buzz");
        } else {
            println!("{}", i);
        }
    }
}

#[test]
fn fizzbuzz_by_tuple() {
    for i in 0..100 {
        match (i % 3, i % 5) {
            (0, 0) => println!("FizzBuzz"),
            (0, _) => println!("Fizz"),
            (_, 0) => println!("Buzz"),
            _ => println!("{}", i),
        }
    }
}

#[test]
fn fizzbuzz_by_map() {
    (0..100)
        .map(|x| match (x % 3, x % 5) {
            (0, 0) => "FizzBuzz".to_string(),
            (0, _) => "Fizz".to_string(),
            (_, 0) => "Buzz".to_string(),
            _ => x.to_string(),
        })
        .for_each(|x| println!("{}", x));
}

#[test]
fn read_env() {
    let home = std::env::var("HOME").expect("HOME is empty");

    let environment = std::env::var("ENV").unwrap_or("dev".to_string());

    println!("home:{} env:{}", home, environment);
}

#[test]
fn collections() {
    {
        let vec = vec![1, 2, 3];
        for i in vec {
            println!("{}", i);
        }
    }

    println!(
        "{:?}",
        vec![1, 2, 3, 5, 8]
            .iter()
            .map(|x| *x * 10)
            .collect::<Vec<_>>()
    );

    println!(
        "{:?}",
        vec![1, 2, 3, 5, 8]
            .iter()
            .filter(|x| *x % 2 == 0)
            .collect::<Vec<_>>()
    );

    println!("{:?}", vec![1, 2, 3, 5, 8].iter().find(|x| *x % 2 == 0));

    println!("{:?}", vec![1, 2, 3, 5, 8].iter().find(|x| *x > &100));

    println!(
        "{:?}",
        vec![1, 2, 3, 5, 8].iter().take(2).collect::<Vec<_>>()
    );

    println!(
        "{:?}",
        vec![1, 2, 3, 5, 8].iter().skip(2).collect::<Vec<_>>()
    );

    println!("{:?}", vec![1, 2, 3, 5, 8].iter().sum::<i32>());

    println!("{:?}", vec![1, 2, 3, 5, 8].iter().count());
}

#[test]
fn read_file_as_string() {
    {
        let file = File::open("Cargo.toml").expect("file not found");

        let mut contents = String::new();

        BufReader::new(file)
            .read_to_string(&mut contents)
            .expect("read_failed");

        println!("{}", contents);
    }

    {
        let file = File::open("Cargo.toml").expect("file not found");

        println!("{:?}", BufReader::new(file).lines().collect::<Vec<_>>());
    }
}

#[test]
fn write_string_to_file() {
    let mut file = File::create("foo.txt").expect("can not file create");

    file.write_all("bar".as_bytes())
        .expect("can not write file");
}

#[test]
fn append_string_to_file() {
    let mut file = OpenOptions::new()
        .create(true)
        .write(true)
        .append(true)
        .open("bar.txt")
        .expect("can not open file");

    writeln!(file, "foo").expect("can not write file");
}

#[test]
fn http_request() {
    let response = reqwest::blocking::Client::new()
        .get("https://checkip.amazonaws.com/")
        .send()
        .expect("failed to http request");

    let body = response.text().expect("failed to get response body");

    println!("{}", body);
}

use serde::{Deserialize, Serialize};

pub type Issues = Vec<Issue>;

#[derive(Debug, Serialize, Deserialize)]
pub struct Issue {
    #[serde(rename = "url")]
    url: String,
}

#[test]
fn http_request_json() {
    let response = reqwest::blocking::Client::new()
        .get("https://api.github.com/repos/octocat/Spoon-Knife/issues")
        .header("User-Agent", "github.com/lambdasawa/lambdasawa")
        .send()
        .expect("failed to http request");

    let body = response
        .json::<Issues>()
        .expect("failed to get response body");

    println!("{:?}", body);
}

#[test]
fn external_process() {
    let output = Command::new("ls")
        .arg(".")
        .output()
        .expect("Failed to execute command");

    println!(
        "stdout: {}",
        String::from_utf8(output.stdout).expect("failed to convert to string"),
    );

    println!(
        "stderr: {}",
        String::from_utf8(output.stderr).expect("failed to convert to string"),
    );
}
