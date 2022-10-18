use std::time::SystemTime;

use crate::schema::users;
use diesel::prelude::*;

#[derive(Queryable)]
pub struct User {
    pub id: i32,
    pub slug: String,
    pub password_digest: String,
    pub created_at: SystemTime,
    pub updated_at: SystemTime,
}

#[derive(Insertable)]
#[diesel(table_name = users)]
pub struct NewUser<'a> {
    pub slug: &'a str,
    pub password_digest: &'a str,
}
