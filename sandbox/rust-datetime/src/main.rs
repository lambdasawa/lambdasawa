use chrono::{DateTime, Duration, FixedOffset, TimeZone, Utc};

fn main() {
    let jst = FixedOffset::east_opt(9 * 60 * 60).unwrap();

    {
        let t: DateTime<Utc> = Utc::now();
        println!("{:?}", t.to_rfc3339());
    }
    {
        let t: DateTime<FixedOffset> = FixedOffset::east_opt(9 * 60 * 60)
            .unwrap()
            .with_ymd_and_hms(1995, 6, 16, 1, 2, 3)
            .unwrap();
        println!("{:?}", t.to_rfc3339());
    }
    {
        let t: DateTime<FixedOffset> =
            DateTime::parse_from_rfc3339("1995-06-16T01:02:03.456789+09:00").unwrap();
        println!("{:?}", t.to_rfc3339());
    }
    {
        let t: DateTime<Utc> = Utc.timestamp_opt(1678901234, 0).unwrap();
        println!("{:?}", t.to_rfc3339());
        println!("{:?}", Utc::now().timestamp());
        println!("{:?}", Utc::now().timestamp_millis());
    }
    {
        let t = Utc::now();
        let tz = &FixedOffset::east_opt(9 * 60 * 60).unwrap();
        println!("{:?}", t.with_timezone(tz).to_rfc3339());
    }
    {
        let t1 = jst.with_ymd_and_hms(1995, 6, 16, 1, 2, 3).unwrap();
        let t2 = jst.with_ymd_and_hms(2023, 5, 7, 19, 23, 45).unwrap();
        let d = t2 - t1;

        println!("{:?}", d.num_seconds() / 60 / 60 / 24 / 365);
    }
    {
        let t = jst.with_ymd_and_hms(1995, 6, 16, 1, 2, 3).unwrap();
        let d = Duration::seconds(10);

        println!("{:?}", t + d);
    }
}
