DROP TABLE bounty;

CREATE TABLE bounty (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    species VARCHAR(255),
    bounty_value INT,
    weapon VARCHAR(255)
);