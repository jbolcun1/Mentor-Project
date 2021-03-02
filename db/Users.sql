CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    first_name TEXT,
    surname TEXT,
    email TEXT,
    password TEXT,
    privalige TEXT,
    has_mentee INTEGER
);

CREATE TABLE descriptions (
    user_id INTEGER,
    description TEXT
);
