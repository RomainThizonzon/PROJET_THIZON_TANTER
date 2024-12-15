CREATE USER ldc IDENTIFIED BY motdepasse;
GRANT ALL PRIVILEGES TO ldc;

CREATE TABLE Teams (
    team_id NUMBER PRIMARY KEY,
    team VARCHAR2(100) NOT NULL,
    country VARCHAR2(50),
    logo VARCHAR2(100)
);

CREATE TABLE Players (
    player_id NUMBER PRIMARY KEY,
    name VARCHAR2(50) NOT NULL,
    nationality VARCHAR2(30),
    field_position VARCHAR2(30),
    position VARCHAR2(30),
    weight NUMBER,
    height NUMBER,
    age NUMBER,
    player_image VARCHAR2(100),
    team_id NUMBER NOT NULL,
    CONSTRAINT fk_team FOREIGN KEY (team_id) REFERENCES Teams(team_id) ON DELETE CASCADE
);

CREATE TABLE Goals (
    player_id NUMBER NOT NULL PRIMARY KEY,
    inside_area NUMBER,
    outside_area NUMBER,
    right_foot NUMBER,
    left_foot NUMBER,
    head NUMBER,
    other NUMBER,
    penalties_scored NUMBER,
    goals_scored NUMBER DEFAULT 0,
    CONSTRAINT fk_player_goals FOREIGN KEY (player_id) REFERENCES Players(player_id) ON DELETE CASCADE
);

CREATE TABLE Goalkeeping (
    player_id NUMBER NOT NULL PRIMARY KEY,
    saves NUMBER,
    goals_conceded NUMBER,
    saves_on_penalty NUMBER,
    clean_sheets NUMBER,
    punches_made NUMBER,
    CONSTRAINT fk_player_goalkeeping FOREIGN KEY (player_id) REFERENCES Players(player_id) ON DELETE CASCADE
);

CREATE TABLE Attacking (
    player_id NUMBER NOT NULL PRIMARY KEY,
    assists NUMBER,
    corners_taken NUMBER,
    offsides NUMBER,
    dribbles NUMBER,
    CONSTRAINT fk_player_attacking FOREIGN KEY (player_id) REFERENCES Players(player_id) ON DELETE CASCADE
);

CREATE TABLE Defending (
    player_id NUMBER NOT NULL PRIMARY KEY,
    balls_recovered NUMBER,
    tackles NUMBER,
    tackles_won NUMBER,
    tackles_lost NUMBER,
    clearance_attempted NUMBER,
    CONSTRAINT fk_player_defending FOREIGN KEY (player_id) REFERENCES Players(player_id) ON DELETE CASCADE
);


