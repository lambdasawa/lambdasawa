use crate::{
    models::users::User,
    utils::jwt::{verify_jwt_token, UserID},
};
use axum::{
    extract::{Extension, TypedHeader},
    headers::{authorization::Bearer, Authorization},
    http::StatusCode,
    response::{IntoResponse, Result},
    Json,
};
use chrono::{DateTime, Utc};
use diesel::{
    pg::PgConnection,
    prelude::*,
    r2d2::{ConnectionManager, Pool},
};
use serde::Serialize;

#[derive(Debug, Serialize)]
pub struct Res {
    pub id: i32,
    pub slug: String,
    pub created_at: String,
    pub updated_at: String,
}

pub async fn handler(
    Extension(pool): Extension<Pool<ConnectionManager<PgConnection>>>,
    TypedHeader(authorization): TypedHeader<Authorization<Bearer>>,
) -> Result<impl IntoResponse> {
    use crate::schema::users::dsl::*;

    let jwt_token = authorization.token();

    println!("{:?}", jwt_token);

    let UserID(user_id) = verify_jwt_token(jwt_token)
        .map_err(|_| (StatusCode::UNAUTHORIZED, "Failed to authentication"))?;

    let conn = &mut pool
        .get()
        .map_err(|_| (StatusCode::INTERNAL_SERVER_ERROR, "Internal Server Error"))?;

    let user = crate::schema::users::table
        .filter(id.eq(user_id))
        .first::<User>(conn)
        .map_err(|_| (StatusCode::NOT_FOUND, "Not Found"))?;

    Ok((
        StatusCode::OK,
        Json(Res {
            id: user.id,
            slug: user.slug,
            created_at: DateTime::<Utc>::from(user.created_at).to_rfc3339(),
            updated_at: DateTime::<Utc>::from(user.updated_at).to_rfc3339(),
        }),
    ))
}
