-- SQL final assignment
-- artist table ------------------------------------------
CREATE TABLE IF NOT EXISTS artist (
    artistID INT PRIMARY KEY AUTO_INCREMENT,
    fname VARCHAR(255) NOT NULL,
    lname VARCHAR(255)      
);
INSERT INTO artist
  (artistID, fname, lname)
VALUES 
  (null, 'Taylor', 'Swift'),
  (null, 'Harry', 'Styles'),
  (null, 'Justin', 'Bieber'),
  (null, 'Ed', 'Sheeran');

-- venue table ------------------------------------------
CREATE TABLE IF NOT EXISTS venue (
    venueID INT PRIMARY KEY AUTO_INCREMENT,
    venueName VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    provenceState VARCHAR(255) NOT NULL
);
INSERT INTO venue
  (venueID, venueName, city, provenceState)
VALUES 
  (null, 'Scotiabank Arena', 'Toronto', 'ON'),
  (null, 'United Center', 'Chicago', 'IL'),
  (null, 'Madison Square Garden', 'New York', 'NY'),
  (null, 'Kia Forum', 'Los Angeles', 'CA'),
  (null, 'Budweiser Gardens', 'London', 'ON'),
  (null, 'Budweiser Stage', 'Toronto', 'ON'),
  (null, 'Rogers Center', 'Toronto', 'ON');

-- Schedule table ------------------------------------------
CREATE TABLE IF NOT EXISTS schedule (
    showID INT PRIMARY KEY AUTO_INCREMENT,
    artistID INT NOT NULL,
    venueID INT NOT NULL,
    date_time DATETIME NOT NULL
);
INSERT INTO schedule
  (showID, artistID, venueID, date_time)
VALUES 
  (null, '1', '3', '2023-06-10 18:30:00'),
  (null, '1', '7', '2023-07-02 18:30:00'),
  (null, '1', '4', '2023-08-08 18:30:00'),
  (null, '2', '1', '2023-08-08 20:30:00'),
  (null, '2', '3', '2023-09-20 20:30:00'),
  (null, '2', '4', '2023-10-05 20:30:00'),
  (null, '3', '1', '2023-08-12 20:00:00'),
  (null, '3', '2', '2023-10-20 20:00:00'),
  (null, '3', '4', '2023-05-11 20:30:00'),
  (null, '4', '7', '2023-09-15 19:00:00'),
  (null, '4', '4', '2023-05-10 19:00:00'),
  (null, '4', '3', '2023-06-12 19:00:00');

  DELIMITER //
CREATE TRIGGER showUpdate 
  AFTER date_time UPDATE OR DELETE ON schedule
  FOR EACH ROW
  BEGIN
    INSERT INTO canceled_postponed 
      (showID, artistID, venueID, originalDate, newDate, canceled)
    VALUES
      ("15", "4", "3", "2023-04-04", "2023-08-27", false());
  END; //
DELIMITER ;


SELECT showID, date_time, IF(date_time<date)
FROM schedule
THEN
    ADD showID, date_time TO past_shows
END IF;

-- canceled_postponed  table ------------------------------------------
CREATE TABLE IF NOT EXISTS canceled_postponed (
    showID INT NOT NULL,
    artistID INT NOT NULL,
    venueID INT NOT NULL,
    origionalDate DATE NOT NULL,
    newDate DATE,
    canceled VARCHAR(255) NOT NULL,
    FOREIGN KEY (showID)
    REFERENCES canceled_postponed(schedule)
    ON UPDATE CASCADE 
);
INSERT INTO canceled_postponed
  (showID, artistID, venueID, origionalDate, newDate, canceled)
VALUES 
  (5, '2', '3', '2023-06-11', '2023-09-20', 'false'),
  (13, '3', '5', '2023-08-28', 'NULL', 'true'),
  (10, '4', '7', '2023-06-17', '2023-09-15', 'false'),
  (14, '1', '3', '2023-09-20', '2023-09-20', 'false');

  -- past_shows table ------------------------------------------
CREATE TABLE IF NOT EXISTS past_shows (
    showID INT PRIMARY KEY AUTO_INCREMENT,
    date_time DATETIME
);
  INSERT INTO past_shows
  (showID, date_time)
VALUES 
  ("15", '2022-04-20');

  -- past_shows function ------------------------------------------
DELIMITER //
CREATE FUNCTION pastShow (
showID INT,
date_time DATETIME 
)
BEGIN
// if condition
IF (date_time > DATE)
  THEN
    INSERT showID, date_time INTO past_shows From schedule
END IF;
END; //
DELIMITER ;

  -- canceled_postponed view ------------------------------------------
CREATE VIEW postponed AS
SELECT fname, lname, venueName, newDate FROM canceled_postponed 
JOIN venue ON canceled_postponed.venueID = venue.venueID
JOIN artist ON canceled_postponed.artistID = artist.artistID

