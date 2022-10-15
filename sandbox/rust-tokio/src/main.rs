use core::panic;
use std::{
    collections::{hash_map::DefaultHasher, HashMap},
    hash::{Hash, Hasher},
    sync::{Arc, Mutex},
};

use mini_redis::{Command, Connection, Frame};
use tokio::net::TcpListener;

#[tokio::main]
async fn main() {
    let listener = TcpListener::bind("127.0.0.1:6379").await.unwrap();

    let db = Arc::new(vec![Mutex::new(HashMap::new())]);

    loop {
        let (stream, _addr) = listener.accept().await.unwrap();

        let db = db.clone();

        tokio::spawn(async move {
            let mut conn = Connection::new(stream);

            while let Some(request) = conn.read_frame().await.unwrap() {
                println!("req: {:?}", request);

                let response = match Command::from_frame(request).unwrap() {
                    Command::Set(cmd) => {
                        let key = cmd.key().to_string();
                        let mut db = db[hash(&key) % db.len()].lock().unwrap();
                        db.insert(key, cmd.value().to_vec());
                        Frame::Simple("OK".to_string())
                    }
                    Command::Get(cmd) => {
                        let key = cmd.key().to_string();
                        let db = db[hash(&key) % db.len()].lock().unwrap();
                        db.get(&key)
                            .map_or(Frame::Null, |value| Frame::Bulk(value.clone().into()))
                    }
                    cmd => panic!("unimplemented: {:#?}", cmd),
                };

                println!("res: {:?}", response);

                conn.write_frame(&response).await.unwrap();
            }
        });
    }
}

fn hash(s: &String) -> usize {
    let mut hasher = DefaultHasher::new();
    s.hash(&mut hasher);
    hasher.finish() as usize
}
