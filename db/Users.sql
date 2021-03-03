CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    first_name TEXT,
    surname TEXT,
    email TEXT,
    password TEXT,
    privilege TEXT,
    has_mentee INTEGER,
    last_send TEXT
);

CREATE TABLE descriptions (
    user_id INTEGER,
    description TEXT
);
