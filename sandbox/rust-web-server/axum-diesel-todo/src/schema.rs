// @generated automatically by Diesel CLI.

diesel::table! {
    users (id) {
        id -> Int4,
        slug -> Varchar,
        password_digest -> Varchar,
        created_at -> Timestamp,
        updated_at -> Timestamp,
    }
}
