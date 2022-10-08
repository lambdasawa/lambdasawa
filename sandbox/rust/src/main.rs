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

    {
        let mut vec = vec![2, 8, 5, 3, 1];
        vec.sort();
        println!("{:?}", vec);
    }

    {
        let mut vec = vec![2, 8, 5, 3, 1];
        vec.sort_by(|a, b| b.cmp(a));
        println!("{:?}", vec);
    }
}

#[test]
fn read_file_as_string() {
    use std::{
        fs::File,
        io::{BufRead, BufReader, Read},
    };

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

        let lines: Vec<String> = BufReader::new(file)
            .lines()
            .map(|l| l.expect("failed to read line"))
            .collect();

        println!("{:?}", lines);
    }
}

#[test]
fn write_string_to_file() {
    use std::{fs::File, io::Write};

    let mut file = File::create("foo.txt").expect("can not file create");

    file.write_all("bar".as_bytes())
        .expect("can not write file");
}

#[test]
fn append_string_to_file() {
    use std::{fs::OpenOptions, io::Write};

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

use std::collections::HashMap;

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

    let body: Vec<Issue> = response.json().expect("failed to get response body");

    println!("{:?}", body);
}

#[test]
fn external_process() {
    use std::process::Command;

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

#[test]
fn play_mp3() {
    use std::io::BufReader;

    let (_stream, handle) =
        rodio::OutputStream::try_default().expect("failed to create output stream");

    let sink = rodio::Sink::try_new(&handle).expect("failed to create sink");

    let buf_reader =
        BufReader::new(std::fs::File::open("./test.mp3").expect("failed to open file"));

    let decoder = rodio::Decoder::new(buf_reader).expect("failed to create decoder");

    sink.append(decoder);

    sink.sleep_until_end();
}

#[test]
fn sleep() {
    use std::{thread, time};

    for i in 1..=3 {
        thread::sleep(time::Duration::from_secs(1));
        println!("{} second", i);
    }
}

#[test]
fn strings() {
    {
        let s: &str = "foo";
        println!("{}", s);
    }

    {
        let mut s: String = String::from("foo");
        s.push_str("bar");
        println!("{}", s);
    }
}

#[test]
fn ownership() {
    {
        let s1 = String::from("take ownership, and do not return value");
        takes_ownership(s1);
        //        takes_ownership(s1);
    }
    {
        let s1 = String::from("take ownership, and return value");
        let s2 = takes_ownership(s1);
        let s3 = takes_ownership(s2);
        println!("{}", s3);
    }
    {
        let s1 = &String::from("borrowing");
        borrowing(s1);
        borrowing(s1);
        println!("{}", s1);
    }
    {
        let mut s = String::from("mutable borrowing");
        let s1 = &mut s;
        // let s2 = &mut s;
        mutable_borrowing(s1);
        mutable_borrowing(s1);

        println!("{}", s1);
    }
}

fn takes_ownership(s: String) -> String {
    println!("{}", s);

    s
}

fn borrowing(s: &String) {
    println!("{}", s);
}

fn mutable_borrowing(s: &mut String) {
    s.push_str("!");

    println!("{}", s);
}

#[derive(Debug)]
struct Rectangle {
    width: u32,
    height: u32,
}

impl Rectangle {
    fn square(size: u32) -> Rectangle {
        Rectangle {
            width: size,
            height: size,
        }
    }

    fn area(&self) -> u32 {
        self.width * self.height
    }
}

#[test]
fn use_struct() {
    let rect = Rectangle {
        width: 30,
        height: 50,
    };
    println!("{:?}", rect);
    println!("{:?}", rect.area());

    println!("{:?}", Rectangle::square(10).area());
}

#[derive(Debug)]
enum HttpMethod {
    GET,
    POST,
    PUT,
    PATCH,
    DELETE,
}

#[derive(Debug)]
enum HttpHeader {
    Cookie(HashMap<String, String>),
    BasicAuthorization(String, String),
}

impl HttpHeader {
    fn to_string(&self) -> String {
        match self {
            HttpHeader::Cookie(cookie) => {
                let mut cookie_string = String::new();
                for (key, value) in cookie {
                    cookie_string.push_str(&format!("{}={}; ", key, value));
                }
                cookie_string
            }
            HttpHeader::BasicAuthorization(key, value) => {
                format!("Basic {}:{}", key, value) // TODO: base64
            }
        }
    }
}

#[test]
fn use_enum() {
    println!("{:?}", HttpMethod::GET);

    {
        let mut map = HashMap::new();
        map.insert(String::from("key"), String::from("value"));
        println!("{:?}", HttpHeader::Cookie(map).to_string());
    }

    {
        println!(
            "{:?}",
            HttpHeader::BasicAuthorization(String::from("user"), String::from("password"))
                .to_string()
        );
    }
}
