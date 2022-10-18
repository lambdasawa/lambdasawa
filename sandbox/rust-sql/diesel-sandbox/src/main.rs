use diesel::prelude::*;
use diesel_sandbox::models::*;
use diesel_sandbox::*;

fn main() {
    use self::schema::posts::dsl::*;
    use diesel_sandbox::schema::posts;

    let connection = &mut establish_connection();

    let result = diesel::insert_into(posts::table)
        .values(&NewPost {
            title: "Hello",
            body: "World",
        })
        .get_result::<Post>(connection)
        .unwrap();
    println!("INSERT {:?}", result);

    let result = diesel::update(posts.find(result.id))
        .set(published.eq(true))
        .get_result::<Post>(connection)
        .unwrap();
    println!("UPDATE {:?}", result);

    posts
        .filter(published.eq(true))
        .limit(5)
        .load::<Post>(connection)
        .expect("Error loading posts")
        .iter()
        .for_each(|post| println!("SELECT {:?}", post));

    let num_deleted = diesel::delete(posts.filter(title.like("%Hello%")))
        .execute(connection)
        .expect("Error deleting posts");
    println!("DELETE {:?}", num_deleted);
}
