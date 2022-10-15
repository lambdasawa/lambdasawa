use std::{fs::File, path::Path};

fn main() {
    for arg in std::env::args().skip(1) {
        let path = Path::new(&arg);

        if !path.exists() {
            File::create(path).expect("Failed to create file");
        }
    }
}
