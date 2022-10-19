mod handlers;
mod models;
mod schema;
mod utils;

use axum::{
    routing::{get, patch, post},
    Extension, Router,
};
use diesel::{
    pg::PgConnection,
    r2d2::{ConnectionManager, Pool},
};
use std::env;

#[tokio::main]
async fn main() {
    let database_url = env::var("DATABASE_URL").expect("DATABASE_URL must be set");
    let manager = ConnectionManager::<PgConnection>::new(database_url);
    let pool = Pool::new(manager).expect("Failed to create pool");

    let app = Router::new()
        .route("/signup", post(handlers::sign_up::handler))
        .route("/signin", post(handlers::sign_in::handler))
        .route("/me", get(handlers::me_get::handler))
        .route(
            "/tasks",
            post(handlers::tasks::create::handler).get(handlers::tasks::read_list::handler),
        )
        .route(
            "/tasks/:id",
            patch(handlers::tasks::update::handler).delete(handlers::tasks::delete::handler),
        )
        .layer(Extension(pool));

    axum::Server::bind(&"0.0.0.0:8096".parse().unwrap())
        .serve(app.into_make_service())
        .await
        .unwrap();
}
