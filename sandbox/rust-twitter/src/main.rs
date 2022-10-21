use std::error::Error;

static use_write_api: bool = false;

#[tokio::main]
async fn main() -> Result<(), Box<dyn Error>> {
    {
        use twitter_v2::authorization::BearerToken;
        use twitter_v2::TwitterApi;

        let api = TwitterApi::new(BearerToken::new(
            std::env::var("TWITTER_BEARER_TOKEN").unwrap(),
        ));

        let user = api
            .get_user_by_username("lambdasawa")
            .send()
            .await?
            .into_data()
            .expect("failed to get user");
        println!("{:#?}", user);

        let tweets = api
            .get_user_tweets(user.id)
            .send()
            .await?
            .into_data()
            .expect("failed to get user tweets");
        println!("{:#?}", tweets);
    }

    {
        use twitter_v2::authorization::Oauth1aToken;
        use twitter_v2::TwitterApi;

        let api = TwitterApi::new(Oauth1aToken::new(
            std::env::var("TWITTER_API_KEY").unwrap(),
            std::env::var("TWITTER_API_KEY_SECRET").unwrap(),
            std::env::var("TWITTER_ACCESS_TOKEN").unwrap(),
            std::env::var("TWITTER_ACCESS_TOKEN_SECRET").unwrap(),
        ));

        let me = api.get_users_me().send().await?;
        println!("{:#?}", me);
    }

    if use_write_api {
        let token = egg_mode::Token::Access {
            consumer: egg_mode::KeyPair::new(
                std::env::var("TWITTER_API_KEY").unwrap(),
                std::env::var("TWITTER_API_KEY_SECRET").unwrap(),
            ),
            access: egg_mode::KeyPair::new(
                std::env::var("TWITTER_ACCESS_TOKEN").unwrap(),
                std::env::var("TWITTER_ACCESS_TOKEN_SECRET").unwrap(),
            ),
        };

        let tweet = egg_mode::tweet::DraftTweet::new("test")
            .send(&token)
            .await?;
        println!("{:#?}", tweet);
    }

    Ok(())
}
