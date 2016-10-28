BEGIN;
TRUNCATE TABLE games CASCADE;
INSERT INTO games (id, name, description, minPlayers, maxPlayers, publisher) VALUES
(1, '7 Wonders', 'drafting game', 2, 7, 'Asmodee'),
(2, 'Five Tribes', 'thing with meeples', 2, 4, 'Days of Wonder')
ON CONFLICT DO NOTHING;

TRUNCATE TABLE genres CASCADE;
INSERT INTO genres (id, name) VALUES
(1, 'euro'),
(2, 'drafting'),
(3, 'area control')
ON CONFLICT DO NOTHING;

INSERT INTO game_genre (gameId, genreId) VALUES
(1,1),
(1,2),
(2,1),
(2,2);
