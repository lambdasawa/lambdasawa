fn main() {
    let list = std::fs::read_dir("/tmp").expect("failed to read dir");
    let file_names = list.map(|entry| {
        entry
            .map(|e| {
                e.file_name()
                    .into_string()
                    .expect("failed to get file name")
            })
            .expect("failed to get entry")
    });
    file_names.for_each(|file_name| println!("{}", file_name));
}
