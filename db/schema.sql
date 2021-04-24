CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    first_name TEXT,
    surname TEXT,
    email TEXT,
    password TEXT,
    privilege INTEGER,
    title INTEGER,
    job_title TEXT,
    industry_sector INTEGER,
    available_time TEXT,
    university text,
    degree TEXT,
    telephone TEXT,
    description INTEGER,
    has_mentee INTEGER,
    has_mentor INTEGER,
    last_send TEXT,
    suspend INTEGER,
    FOREIGN KEY (privilege) REFERENCES privileges (id),
    FOREIGN KEY (title) REFERENCES titles (id),
    FOREIGN KEY (industry_Sector) REFERENCES industry_sectors (id),
    FOREIGN KEY (description) REFERENCES descriptions (id)
);

CREATE TABLE descriptions (
    id INTEGER PRIMARY KEY,
    description TEXT
);

CREATE TABLE privileges (
    id INTEGER PRIMARY KEY,
    privilege TEXT
);

CREATE TABLE titles (
    id INTEGER PRIMARY KEY,
    title TEXT
);

CREATE TABLE industry_sectors (
    id INTEGER PRIMARY KEY,
    sector TEXT
);

CREATE TABLE reports (
    id INTEGER PRIMARY KEY,
    user_id INTEGER,
    description_id INTEGER,
    date_time_made TEXT,
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (description_id) REFERENCES descriptions (id)
);

