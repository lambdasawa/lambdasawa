use proconio::input;

fn round_n(value: u64, n: u64) -> u64 {
    let p = 10u64.pow(n as u32);
    let q = 10u64.pow((n - 1) as u32);
    let digit = value % p / q;
    value / p * p + if digit >= 5 { p } else { 0 }
}

fn main() {
    input! {
        K: u64,
        X: u64,
    }

    let mut n = K;
    for i in 1..=X {
        n = round_n(n, i);
    }

    println!("{}", n);
}
