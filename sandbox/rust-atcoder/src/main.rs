use num::{integer::Roots, Integer};
use petgraph::{graph::NodeIndex, graph::UnGraph, unionfind::UnionFind};
use proconio::input;
use std::collections::{BinaryHeap, HashMap, HashSet, VecDeque};

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
// (1以外の共通の約数がないことを判定する)
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

    assert_eq!(is_prime(0), false);
    assert_eq!(is_prime(1), false);
    assert_eq!(is_prime(2), true);
    assert_eq!(is_prime(3), true);
    assert_eq!(is_prime(4), false);

    assert_eq!(
        enumerate_divisors(2022),
        HashSet::from([2, 3, 6, 337, 674, 1011])
    );

    assert_eq!(
        prime_factorization(280),
        HashMap::from([(2, 3), (5, 1), (7, 1)])
    );

    assert_eq!(
        eratosthenes(10),
        //   0,     1,     2,    3,    4,     5,    6,     7,    8,     9,     10
        vec![false, false, true, true, false, true, false, true, false, false, false]
    );

    assert_eq!(euler_phi_function(12), 4);

    assert_eq!(legendre(30, 3), 10);

    {
        // stack
        let mut s = vec![];
        s.push(1);
        s.push(2);
        s.push(3);
        assert_eq!(s.pop(), Some(3));
        assert_eq!(s.pop(), Some(2));
        assert_eq!(s.pop(), Some(1));
    }

    {
        // queue
        let mut q = VecDeque::new();
        q.push_back(1);
        q.push_back(2);
        q.push_back(3);
        assert_eq!(q.pop_front(), Some(1));
        assert_eq!(q.pop_front(), Some(2));
        assert_eq!(q.pop_front(), Some(3));
    }

    {
        // priority queue
        let mut h = BinaryHeap::new();
        h.push(1);
        h.push(3);
        h.push(2);
        assert_eq!(h.pop(), Some(3));
        assert_eq!(h.pop(), Some(2));
        assert_eq!(h.pop(), Some(1));
    }

    {
        // graph
        let g = UnGraph::<usize, usize, usize>::from_edges(&[(0, 1), (1, 2), (1, 3), (2, 3)]);
        assert_eq!(g.contains_edge(NodeIndex::new(0), NodeIndex::new(1)), true);
        assert_eq!(g.contains_edge(NodeIndex::new(0), NodeIndex::new(3)), false);
    }

    {
        // union find
        let mut uf = UnionFind::<usize>::new(10);
        uf.union(1, 2);
        uf.union(3, 4);
        uf.union(3, 5);
        assert_eq!(uf.equiv(4, 5), true);
        assert_eq!(uf.equiv(1, 3), false);
        assert_eq!(uf.find(2), 1);
    }
}
