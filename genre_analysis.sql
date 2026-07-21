
-- This query collects music features for the top 5 and bottom 5 genres to identify success attributes.
SELECT 
    track_genre,
    ROUND(AVG(popularity), 2) AS avg_popularity,
    ROUND(AVG(danceability), 3) AS avg_danceability,
    ROUND(AVG(energy), 3) AS avg_energy,
    ROUND(AVG(tempo), 1) AS avg_tempo,
    ROUND(AVG(duration_ms) / 60000.0, 2) AS avg_duration_minutes,
    ROUND(SUM(CASE WHEN explicit = true THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS explicit_percentage
FROM spotify_tracks
WHERE track_genre IN ('pop-film', 'k-pop', 'chill', 'sad', 'grunge', 'chicago-house', 'detroit-techno', 'latin', 'romance', 'iranian')
GROUP BY track_genre
ORDER BY avg_popularity DESC;
