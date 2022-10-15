use std::{env, error::Error};

fn main() -> Result<(), Box<dyn Error>> {
    let first_arg = env::args().skip(1).next().expect("arg 1 missing");

    match &first_arg[..] {
        "tcp-server-blocking" => blocking_tcp_server::start(),
        "tcp-client" => tcp_client::start(),
        _ => panic!("unknown command"),
    }
}

mod blocking_tcp_server {
    use std::{
        error::Error,
        io::{Read, Write},
        net::{TcpListener, TcpStream},
    };

    pub fn start() -> Result<(), Box<dyn Error>> {
        let listener = TcpListener::bind("127.0.0.1:9696").expect("failed to bind");

        loop {
            let (mut stream, _addr) = listener.accept()?;

            handle(&mut stream)?;
        }
    }

    fn handle(stream: &mut TcpStream) -> Result<(), Box<dyn Error>> {
        loop {
            let mut buffer = [0; 1024];

            let read_bytes = stream.read(&mut buffer)?;

            if read_bytes == 0 {
                break;
            }

            println!("{:?}", String::from_utf8(buffer[..read_bytes].to_vec()));

            stream.write_all(&buffer[..read_bytes])?;
        }

        Ok(())
    }
}

mod tcp_client {
    use std::{
        error::Error,
        io::{stdin, BufRead, BufReader, Write},
        net::TcpStream,
    };

    pub fn start() -> Result<(), Box<dyn Error>> {
        let mut stream = TcpStream::connect("127.0.0.1:9696").expect("failed to connect");

        loop {
            let mut line = String::new();
            stdin().read_line(&mut line).expect("failed to read line");

            if line.len() == 0 {
                break;
            }

            stream.write_all(line.as_bytes())?;

            let mut reader = BufReader::new(&stream);
            let mut buf = String::new();
            reader.read_line(&mut buf).expect("failed to read line");
            println!("{}", buf);
        }

        Ok(())
    }
}
