use crate::{
    models::users::User,
    schema,
    utils::jwt::{verify_jwt_token, UserID},
};
use axum::{
    extract::{Extension, Path, TypedHeader},
    headers::{authorization::Bearer, Authorization},
    http::StatusCode,
    response::{IntoResponse, Result},
};
use diesel::{
    pg::PgConnection,
    prelude::*,
    r2d2::{ConnectionManager, Pool},
};

pub async fn handler(
    Extension(pool): Extension<Pool<ConnectionManager<PgConnection>>>,
    Path(id): Path<i32>,
    TypedHeader(authorization): TypedHeader<Authorization<Bearer>>,
) -> Result<impl IntoResponse> {
    let UserID(user_id_from_token) = verify_jwt_token(authorization.token())
        .map_err(|_| (StatusCode::UNAUTHORIZED, "Failed to authentication"))?;

    let conn = &mut pool
        .get()
        .map_err(|_| (StatusCode::INTERNAL_SERVER_ERROR, "Internal Server Error"))?;

    let user = schema::users::table
        .filter(schema::users::id.eq(user_id_from_token))
        .first::<User>(conn)
        .map_err(|_| (StatusCode::UNAUTHORIZED, "Failed to authentication"))?;

    diesel::delete(schema::tasks::table)
        .filter(schema::tasks::id.eq(id))
        .filter(schema::tasks::user_id.eq(user.id))
        .execute(conn)
        .map_err(|_| (StatusCode::INTERNAL_SERVER_ERROR, "Internal Server Error"))?;

    Ok(StatusCode::ACCEPTED)
}
