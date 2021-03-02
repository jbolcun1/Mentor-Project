CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    first_name TEXT,
    surname TEXT,
    email TEXT,
    password TEXT,
    privilige TEXT,
    has_mentee INTEGER,
    last_send TEXT
);

CREATE TABLE descriptions (
    user_id INTEGER,
    description TEXT
);
