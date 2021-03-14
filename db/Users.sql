CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    first_name TEXT,
    surname TEXT,
    email TEXT,
    password TEXT,
    privilege TEXT,
    job_Title TEXT,
    industry_Sector TEXT,
    degree TEXT,
    description, INTEGER,
    has_mentee INTEGER,
    has_mentor INTEGER,
    last_send TEXT
);

CREATE TABLE descriptions (
    user_id INTEGER,
    description TEXT
);
