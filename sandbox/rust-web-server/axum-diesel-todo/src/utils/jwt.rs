use std::time::{SystemTime, UNIX_EPOCH};

use crate::models::users::User;
use serde::{Deserialize, Serialize};

#[derive(Debug, Serialize, Deserialize)]
pub struct Claims {
    pub sub: String,
    pub exp: usize,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct UserID(pub i32);

static JWT_SECRET_NAME: &str = "JWT_SECRET";

pub fn sign_jwt_token(user: &User) -> jsonwebtoken::errors::Result<String> {
    let key = &jsonwebtoken::EncodingKey::from_secret(
        std::env::var(JWT_SECRET_NAME)
            .unwrap_or("default secret".to_string())
            .as_bytes(),
    );

    let header = &jsonwebtoken::Header::default();

    let claims = &Claims {
        sub: user.id.to_string(),
        exp: (SystemTime::now()
            .duration_since(UNIX_EPOCH)
            .unwrap()
            .as_secs()
            + 3600) as usize,
    };

    jsonwebtoken::encode(header, claims, key)
}

pub fn verify_jwt_token(token: &str) -> jsonwebtoken::errors::Result<UserID> {
    let key = &jsonwebtoken::DecodingKey::from_secret(
        std::env::var(JWT_SECRET_NAME)
            .unwrap_or("default secret".to_string())
            .as_bytes(),
    );

    let validation = &jsonwebtoken::Validation::default();

    let token = jsonwebtoken::decode::<Claims>(token, key, validation)?;

    let sub = token.claims.sub;

    let id = sub
        .parse::<i32>()
        .map_err(|_| jsonwebtoken::errors::ErrorKind::InvalidSubject)?;

    Ok(UserID(id))
}
