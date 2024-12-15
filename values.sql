
LOAD DATA
INFILE 'CSV/teams_data.csv'
INTO TABLE Teams
FIELDS TERMINATED BY ','
(player_id, team, country, logo);
