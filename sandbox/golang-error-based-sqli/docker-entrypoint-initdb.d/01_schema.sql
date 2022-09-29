USE app;

CREATE TABLE users
(
    id       bigint PRIMARY KEY,
    name     varchar(255) NOT NULL,
    password varchar(255) NOT NULL
);
