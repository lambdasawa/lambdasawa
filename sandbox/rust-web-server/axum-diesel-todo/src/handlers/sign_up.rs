use crate::models::{self, users::User};
use axum::{
    extract::Extension,
    http::StatusCode,
    response::{IntoResponse, Result},
    Json,
};
use diesel::{
    pg::PgConnection,
    prelude::*,
    r2d2::{ConnectionManager, Pool},
};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize)]
pub struct Req {
    slug: String,
    password: String,
}

#[derive(Debug, Serialize)]
pub struct Res {}

pub async fn handler(
    Extension(pool): Extension<Pool<ConnectionManager<PgConnection>>>,
    Json(req): Json<Req>,
) -> Result<impl IntoResponse> {
    let password_digest_str = calculate_password_digest(req.password)
        .map_err(|_| (StatusCode::INTERNAL_SERVER_ERROR, "Internal Server Error"))?;

    let conn = &mut pool
        .get()
        .map_err(|_| (StatusCode::INTERNAL_SERVER_ERROR, "Internal Server Error"))?;

    diesel::insert_into(crate::schema::users::table)
        .values(&models::users::NewUser {
            slug: req.slug.as_ref(),
            password_digest: password_digest_str.as_ref(),
        })
        .get_result::<User>(conn)
        .expect("Error saving new post");

    Ok((StatusCode::CREATED, Json(Res {})))
}

fn calculate_password_digest(password: String) -> argon2::password_hash::Result<String> {
    use argon2::{
        password_hash::{rand_core::OsRng, PasswordHasher, SaltString},
        Argon2,
    };

    let salt = SaltString::generate(&mut OsRng);

    let argon2 = Argon2::default();

    let digest = argon2
        .hash_password(password.as_bytes(), &salt)?
        .to_string();

    Ok(digest)
}
