CREATE TABLE User (
  id TEXT PRIMARY KEY, 
  karma INTEGER,
  created INTEGER,
);

CREATE TABLE UserSubmitted (
  id INTEGER PRIMARY KEY, 
  submitted INTEGER
  userId TEXT,
  FOREIGN KEY(userId) REFERENCES User(id)  
);

CREATE TABLE Story (
  id INTEGER PRIMARY KEY,
  descendants INTEGER,
  title TEXT,
  score INTEGER, 
  commentTime INTEGER,
  url TEXT,
  userId TEXT,
  FOREIGN KEY(userId) REFERENCES User(id)  
);

CREATE TABLE FavoriteStory (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  storyId TEXT,
  FOREIGN KEY(storyId) REFERENCES Story(id)  
);

CREATE TABLE Comment (
  id INTEGER PRIMARY KEY,
  texte TEXT,
  storyId INTEGER,
  userId INTEGER,
  commentTime INTEGER,
  FOREIGN KEY(storyId) REFERENCES Story(id),
  FOREIGN KEY(userId) REFERENCES User(id)
);

CREATE TABLE SubComment (
  id INTEGER PRIMARY KEY,
  commentId INTEGER,
  texte TEXT, 
  subCommentTime INTEGER, 
  FOREIGN KEY(commentId) REFERENCES Comment(id)
);