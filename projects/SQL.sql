-- Associated with chinook.db for pulling data out to get insights

-- 1. Top 3 Artists who have the most albums
SELECT
  T1.Name AS ArtistName,
  COUNT(T2.AlbumId) AS NumberOfAlbums
FROM artists AS T1
INNER JOIN albums AS T2
  ON T1.ArtistId = T2.ArtistId
GROUP BY
  T1.ArtistId,
  T1.Name
ORDER BY
  NumberOfAlbums DESC
LIMIT 3;

-- 2. The album with highest track from the Artists who have their first names started with ‘C’
SELECT
  T3.Title AS AlbumTitle,
  T1.Name AS ArtistName,
  COUNT(T2.TrackId) AS TrackCount
FROM artists AS T1
INNER JOIN albums AS T3
  ON T1.ArtistId = T3.ArtistId
INNER JOIN tracks AS T2
  ON T3.AlbumId = T2.AlbumId
WHERE
  T1.Name GLOB 'C*' -- Use GLOB for pattern matching (LIKE 'C%' also works)
GROUP BY
  T3.AlbumId,
  T3.Title,
  T1.Name
ORDER BY
  TrackCount DESC
LIMIT 1;

-- 3. List all the customers who has billing address in New York City

SELECT DISTINCT
  T1.CustomerId,
  T1.FirstName,
  T1.LastName,
  T2.BillingAddress,
  T2.BillingCity
FROM customers AS T1
INNER JOIN invoices AS T2
  ON T1.CustomerId = T2.CustomerId
WHERE
  T2.BillingCity = 'New York'
ORDER BY
  T1.LastName,
  T1.FirstName;

-- 4. Which genres has the highest track ?

SELECT
  T1.Name AS GenreName,
  COUNT(T2.TrackId) AS TotalTracks
FROM genres AS T1
INNER JOIN tracks AS T2
  ON T1.GenreId = T2.GenreId
GROUP BY
  T1.GenreId,
  T1.Name
ORDER BY
  TotalTracks DESC
LIMIT 1;

-- Which albums from the certain artists sold the most ?
SELECT
  T4.Name AS ArtistName,
  T3.Title AS AlbumTitle,
  SUM(T1.UnitPrice * T1.Quantity) AS TotalRevenue
FROM invoice_items AS T1
INNER JOIN tracks AS T2
  ON T1.TrackId = T2.TrackId
INNER JOIN albums AS T3
  ON T2.AlbumId = T3.AlbumId
INNER JOIN artists AS T4
  ON T3.ArtistId = T4.ArtistId
GROUP BY
  T3.AlbumId,
  T3.Title,
  T4.Name
ORDER BY
  TotalRevenue DESC
LIMIT 1;


