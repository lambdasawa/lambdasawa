use std::{
    env,
    fs::File,
    io::{BufRead, BufReader},
};

fn main() {
    let args: Vec<String> = env::args().skip(1).collect();

    let buf_read: Box<dyn BufRead> = if args.len() == 1 {
        Box::new(BufReader::new(
            File::open(&args[0]).expect("failed to open file"),
        ))
    } else {
        Box::new(BufReader::new(std::io::stdin()))
    };

    buf_read.lines().take(10).for_each(|line| {
        println!("{}", line.expect("failed to read line"));
    });
}
