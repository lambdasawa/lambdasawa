use std::time::SystemTime;

use crate::schema::tasks;
use diesel::prelude::*;

#[derive(Queryable)]
pub struct Task {
    pub id: i32,
    pub user_id: i32,
    pub title: String,
    pub created_at: SystemTime,
    pub updated_at: SystemTime,
}

#[derive(Insertable)]
#[diesel(table_name = tasks)]
pub struct NewTask<'a> {
    pub user_id: &'a i32,
    pub title: &'a str,
}
