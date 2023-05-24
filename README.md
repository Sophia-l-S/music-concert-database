# music-concert-database
Database to keep track of live shows and events, including the time and venue of the shows. The purpose of this database and these tables is to help live music fans, to see at a simple glance when and where concerts will be happening and keep them up to date on any changes.

<img width="571" alt="image" src="https://github.com/Sophia-l-S/music-concert-database/assets/114260587/f45e2753-5ade-486a-9ff3-cf8b1a20c435">

The view displays the first name, last name, venue name, and new date of the concerts, from the artist, venue and canceled_postponed tables.

<img width="418" alt="image" src="https://github.com/Sophia-l-S/music-concert-database/assets/114260587/23866a43-88a7-4b9c-a16d-196cd1338eb5">

The original idea for my function was to have the date in my schedule table be compared to today’s date in an if statement, and if the date in the table was past the date of today it would move the row of data to the past_shows table.

<img width="330" alt="image" src="https://github.com/Sophia-l-S/music-concert-database/assets/114260587/03350aaf-b68f-4b0e-b1ee-f1d0f1efe3a5">

The trigger will happen if any of the data tables is edited or deleted, in the case of shows being canceled or postponed. And the trigger will take the edited/deleted show ID and add it to a specific table for canceled or postponed shows
<img width="448" alt="image" src="https://github.com/Sophia-l-S/music-concert-database/assets/114260587/cf198a7d-9a00-4079-83cb-206c0035484b">

