-- Created a deduplicated version of the table
-- (removes ~450 rows that were exact duplicates)
CREATE TABLE spotify_tracks_clean AS
SELECT DISTINCT track_id, artists, album_name, track_name, popularity, duration_ms,
       explicit, danceability, energy, `key`, loudness, mode, speechiness,
       acousticness, instrumentalness, liveness, valence, tempo,
       time_signature, track_genre
FROM spotify_tracks;

-- Verifies row count dropped as expected (114,000 -> 113,550)
SELECT COUNT(*) FROM spotify_tracks_clean;

-- Re-add a clean primary key
ALTER TABLE spotify_tracks_clean
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY FIRST;

-- Swap the cleaned table in as the main table
RENAME TABLE spotify_tracks TO spotify_tracks_old,
             spotify_tracks_clean TO spotify_tracks;

-- Confirm no duplicate (track_id, genre) pairs remain
SELECT COUNT(*) - COUNT(DISTINCT CONCAT(track_id, '-', track_genre)) AS duplicate_row_count
FROM spotify_tracks;

-- Remove the old (uncleaned) backup table now that we've verified the clean version
DROP TABLE spotify_tracks_old;
