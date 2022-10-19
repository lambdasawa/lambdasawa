use crate::{models::users::User, utils::jwt::sign_jwt_token};
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
pub struct Res {
    access_token: String,
}

pub async fn handler(
    Extension(pool): Extension<Pool<ConnectionManager<PgConnection>>>,
    Json(req): Json<Req>,
) -> Result<impl IntoResponse> {
    use crate::schema::users::dsl::*;

    let conn = &mut pool
        .get()
        .map_err(|_| (StatusCode::INTERNAL_SERVER_ERROR, "Internal Server Error"))?;

    let user = crate::schema::users::table
        .filter(slug.eq(req.slug))
        .first::<User>(conn)
        .map_err(|_| (StatusCode::NOT_FOUND, "Not Found"))?;

    verify_password(&user, req.password)
        .map_err(|_| (StatusCode::UNAUTHORIZED, "Failed to authentication"))?;

    let jwt_token = sign_jwt_token(&user)
        .map_err(|_| (StatusCode::INTERNAL_SERVER_ERROR, "Internal Server Error"))?;

    Ok((
        StatusCode::OK,
        Json(Res {
            access_token: jwt_token,
        }),
    ))
}

fn verify_password(user: &User, password: String) -> argon2::password_hash::Result<()> {
    use argon2::{
        password_hash::{PasswordHash, PasswordVerifier},
        Argon2,
    };

    let parsed_hash = PasswordHash::new(user.password_digest.as_ref())?;

    Ok(Argon2::default().verify_password(password.as_bytes(), &parsed_hash)?)
}
