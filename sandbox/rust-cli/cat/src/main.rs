use std::fs;

fn main() {
    let args = std::env::args();
    for arg in args.skip(1) {
        let content = fs::read_to_string(arg).expect("failed to read string");

        println!("{}", content);
    }
}
