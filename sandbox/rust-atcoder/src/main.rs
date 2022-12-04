use num::{integer::Roots, Integer};
use proconio::input;
use std::collections::{HashMap, HashSet};

// 素数判定
// O(√n)
fn is_prime(n: usize) -> bool {
    if n <= 1 {
        return false;
    }

    for i in 2..=n.sqrt() {
        if n % i == 0 {
            return false;
        }
    }

    true
}

// 約数列挙
// O(√n)
fn enumerate_divisors(n: usize) -> HashSet<usize> {
    let mut set = HashSet::new();

    for i in 2..=n.sqrt() {
        if n % i == 0 {
            set.insert(i);
            set.insert(n / i);
        }
    }

    set
}

// 素因数分解
// O(√n)
fn prime_factorization(n: usize) -> HashMap<usize, usize> {
    let mut map = HashMap::new();

    let mut n = n;

    for i in 2..=n.sqrt() {
        if n % i != 0 {
            continue;
        }

        let mut e = 0;
        while n % i == 0 {
            e += 1;
            n /= i;
        }

        map.insert(i, e);
    }

    if n != 1 {
        map.insert(n, 1);
    }

    map
}

// 互いに素であるかを返す。
fn is_disjoint(n: usize, m: usize) -> bool {
    n.gcd(&m) == 1 // O(log n)?
}

// オイラー関数
// 1..=n に含まれる互いに素な数の個数を返す。
// O(√n)
fn euler_phi_function(n: usize) -> usize {
    let primes = prime_factorization(n);

    let mut result = n;
    for (p, _) in primes {
        result *= p - 1;
        result /= p;
    }

    result
}

// ルジャンドルの定理
// n! が m で割り切れる回数を返す。
fn legendre(n: usize, m: usize) -> usize {
    let mut result = 0;

    let mut n = n;

    while n % m == 0 {
        result += n / m;

        n /= m;
    }

    result
}

// エラトステネスの篩
// O(n log log n)
fn eratosthenes(n: usize) -> Vec<bool> {
    let mut result = vec![true; n + 1];

    result[0] = false;
    result[1] = false;

    for i in 2..=n {
        if !result[i] {
            continue;
        }

        let mut j = i * 2;
        while j <= n {
            result[j] = false;
            j += i;
        }
    }

    result
}

fn main() {
    input! {}

    println!(
        "is_prime {:?}",
        (1..=10)
            .map(|i| (i, is_prime(i)))
            .collect::<HashMap<usize, bool>>()
    );

    println!("enumerate_divisors {:?}", enumerate_divisors(2022));

    println!("prime_factorization {:?}", prime_factorization(280));

    println!("eratosthenes {:?}", eratosthenes(10));

    println!("euler_phi_function {:?}", euler_phi_function(12));

    println!("legendre {:?}", legendre(30, 3));
}
