use num::{integer::Roots, Integer};
use petgraph::{graph::NodeIndex, graph::UnGraph, unionfind::UnionFind};
use proconio::{input, source::auto::AutoSource};
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

// 約数列挙
// O(√n)
fn divisor_enumeration(n: usize) -> HashSet<usize> {
    let mut set = HashSet::new();

    for i in 1..=n.sqrt() {
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
#[allow(dead_code)]
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

#[allow(non_snake_case)]
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
        divisor_enumeration(36),
        HashSet::from([1, 2, 3, 4, 6, 9, 12, 18, 36])
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

    {
        // binary search
        // https://atcoder.jp/contests/tessoku-book/tasks/tessoku_book_k
        let source = AutoSource::from(
            r#"
            15 47
            11 13 17 19 23 29 31 37 41 43 47 53 59 61 67
            "#,
        );
        input! {
            from source,
            N: usize,
            X: usize,
            A: [usize; N],
        };

        let mut l = 0;
        let mut r = N - 1;
        let mut found = None;
        while l <= r {
            let m = (l + r) / 2;
            let x = A[m];
            if x < X {
                l = m + 1;
            }
            if x > X {
                r = m - 1;
            }
            if x == X {
                found = Some(x);
                break;
            }
        }
        assert_eq!(found, Some(47));
    }

    {
        // DP
        // https://algo-method.com/tasks/307
        let source = AutoSource::from(
            r#"
            3
            7 -6 9
            "#,
        );
        input! {
            from source,
            N: usize,
            A: [isize; N],
        }

        // dp[n] = n 個目までの品物から重さの総和の最大値
        let mut dp = vec![0; N + 1];

        for i in 0..N {
            dp[i + 1] = dp[i].max(dp[i] + A[i]);
        }

        assert_eq!(dp.last().unwrap(), &16);
    }

    {
        // DP
        // https://algo-method.com/tasks/308
        let source = AutoSource::from(
            r#"
            6 9
            2 3
            1 2
            3 6
            2 1
            1 3
            5 85
            "#,
        );
        input! {
            from source,
            N: usize,
            W: usize,
            A: [(usize, usize); N],
        }

        // dp[n][w] = n 個目までの品物から重さの総和が w 以下となるように選んだときの価値の総和の最大値
        let mut dp = vec![vec![0; W + 1]; N + 1];

        for n in 0..N {
            let (weight, value) = A[n];
            for w in 0..=W {
                if w < weight {
                    dp[n + 1][w] = dp[n][w];
                    continue;
                }

                dp[n + 1][w] = dp[n][w].max(dp[n][w - weight] + value);
            }
        }

        assert_eq!(dp[N][W], 94);
    }

    {
        // DP
        // https://algo-method.com/tasks/309
        let source = AutoSource::from(
            r#"
            3 10
            7 5 3
            "#,
        );
        input! {
            from source,
            N: usize,
            M: usize,
            A: [usize; N],
        }

        // dp[n][m] = n 個目までの整数からいくつか選んで総和を m にできるかどうか
        let mut dp = vec![vec![false; 10009]; N + 1];
        dp[0][0] = true;

        for n in 0..N {
            for m in 0..=10000 {
                dp[n + 1][m] = dp[n + 1][m] || dp[n][m];

                if m >= A[n] {
                    dp[n + 1][m] = dp[n + 1][m] || dp[n][m - A[n]];
                }
            }
        }

        assert_eq!(dp[N][M], true);
    }
}
