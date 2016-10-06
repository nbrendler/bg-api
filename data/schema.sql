CREATE TABLE IF NOT EXISTS users (
id SERIAL PRIMARY KEY,
name varchar
);

CREATE TABLE IF NOT EXISTS games (
  id SERIAL PRIMARY KEY,
  name varchar NOT NULL,
  description varchar,
  minPlayers int,
  maxPlayers int,
  publisher varchar
);

CREATE TABLE IF NOT EXISTS genres (
  id SERIAL PRIMARY KEY,
  name varchar NOT NULL
);

CREATE TABLE IF NOT EXISTS game_genre (
  gameId int REFERENCES games (id),
  genreId int REFERENCES genres (id)
);

CREATE TABLE IF NOT EXISTS sessions (
  id SERIAL PRIMARY KEY,
  gameId int REFERENCES games (id)
);

CREATE TABLE IF NOT EXISTS scores (
  sessionId int REFERENCES sessions (id),
  userId int REFERENCES users (id),
  score int
);
