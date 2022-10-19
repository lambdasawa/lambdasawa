use crate::{
    models::tasks::{NewTask, Task},
    models::users::User,
    schema,
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
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize)]
pub struct Req {
    pub title: String,
}

#[derive(Debug, Serialize)]
pub struct Res {
    pub id: i32,
    pub user_id: i32,
    pub title: String,
    pub created_at: String,
    pub updated_at: String,
}

pub async fn handler(
    Extension(pool): Extension<Pool<ConnectionManager<PgConnection>>>,
    TypedHeader(authorization): TypedHeader<Authorization<Bearer>>,
    Json(req): Json<Req>,
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

    let task = diesel::insert_into(schema::tasks::table)
        .values(&NewTask {
            user_id: &user.id,
            title: &req.title,
        })
        .get_result::<Task>(conn)
        .map_err(|_| (StatusCode::INTERNAL_SERVER_ERROR, "Internal Server Error"))?;

    Ok((
        StatusCode::OK,
        Json(Res {
            id: task.id,
            user_id: task.user_id,
            title: task.title,
            created_at: DateTime::<Utc>::from(task.created_at).to_rfc3339(),
            updated_at: DateTime::<Utc>::from(task.updated_at).to_rfc3339(),
        }),
    ))
}
