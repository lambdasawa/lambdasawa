use axum::{
    body::{Bytes, Full},
    extract::{Path, Query},
    http::{HeaderMap, HeaderValue, Method, StatusCode},
    response::Response,
    routing::{get, post},
    Extension, Json, Router,
};
use serde::{Deserialize, Serialize};
use serde_json::{json, Value};
use std::{
    collections::HashMap,
    sync::{Arc, RwLock},
};
use tower_http::{cors::CorsLayer, trace::TraceLayer};

type KVS = Arc<RwLock<HashMap<String, String>>>;

#[tokio::main]
async fn main() {
    let kvs = Arc::new(RwLock::new(HashMap::<String, String>::new()));

    let app = Router::new()
        .route("/echo-path/:value", get(echo_path))
        .route("/echo-paths/*values", get(echo_paths))
        .route("/echo-query", get(echo_query))
        .route("/echo-headers", get(echo_headers))
        .route("/echo-string", post(echo_string))
        .route("/echo-bytes", post(echo_bytes))
        .route("/echo-json", post(echo_json))
        .route("/echo-struct", post(echo_struct))
        .route("/response-builder", get(response_builder))
        .route("/kvs", get(list_keys_from_kvs))
        .route("/kvs/:key", get(get_value_from_kvs).put(put_value_to_kvs))
        .layer(Extension(kvs))
        .layer(TraceLayer::new_for_http())
        .layer(
            CorsLayer::new()
                .allow_origin("http://localhost:3000".parse::<HeaderValue>().unwrap())
                .allow_methods([Method::GET]),
        );

    axum::Server::bind(&"0.0.0.0:8888".parse().unwrap())
        .serve(app.into_make_service())
        .await
        .unwrap();
}

async fn echo_path(Path(value): Path<String>) -> Json<Value> {
    Json(json!({ "value": value }))
}

async fn echo_paths(Path(values): Path<String>) -> Json<Value> {
    Json(json!({ "values": values }))
}

async fn echo_query(Query(params): Query<HashMap<String, String>>) -> Json<Value> {
    Json(json!({ "params": params }))
}

async fn echo_headers(headers: HeaderMap) -> Json<Value> {
    let headers = headers
        .into_iter()
        .filter_map(|(key, value)| match (key, value.to_owned().to_str()) {
            (Some(k), Ok(v)) => Some((k.to_string(), v.to_string())),
            _ => None,
        })
        .collect::<HashMap<_, _>>();

    Json(json!({ "headers": headers }))
}

async fn echo_string(body: String) -> Bytes {
    Bytes::from(body)
}

async fn echo_bytes(body: Bytes) -> String {
    String::from_utf8(body.to_vec()).unwrap()
}

async fn echo_json(Json(body): Json<Value>) -> Json<Value> {
    Json(body)
}

async fn response_builder() -> Response<Full<Bytes>> {
    Response::builder()
        .status(StatusCode::IM_A_TEAPOT)
        .header("x-lambdasawa", "true")
        .body(Full::from("Hello, World!"))
        .unwrap()
}

#[derive(Debug, Serialize, Deserialize)]
struct MyStruct {
    text: String,
}

async fn echo_struct(Json(my_struct): Json<MyStruct>) -> Json<MyStruct> {
    Json(my_struct)
}

async fn list_keys_from_kvs(Extension(kvs): Extension<KVS>) -> Json<Value> {
    let s = kvs.read().unwrap();

    let keys: Vec<&String> = s.keys().into_iter().collect();

    Json(json!({ "keys": keys }))
}

async fn get_value_from_kvs(
    Path(key): Path<String>,
    Extension(kvs): Extension<KVS>,
) -> Json<Value> {
    let s = kvs.read().unwrap();

    match s.get(&key) {
        Some(value) => Json(json!({ "value": value })),
        None => Json(json!({"value": ""})),
    }
}

async fn put_value_to_kvs(
    Path(key): Path<String>,
    body: Bytes,
    Extension(kvs): Extension<KVS>,
) -> Json<Value> {
    let mut s = kvs.write().unwrap();

    let value = String::from_utf8(body.to_vec()).unwrap();

    s.insert(key.clone(), value.clone());

    Json(json!({ key: value }))
}
