CREATE TABLE User (
  id INTEGER PRIMARY KEY, 
  karma INTEGER,
  created INTEGER,
);

CREATE TABLE UserSubmitted (
  id INTEGER PRIMARY KEY, 
  submitted INTEGER
  userId INTEGER,
  FOREIGN KEY(userId) REFERENCES User(id)  
);

CREATE TABLE Story (
  id INTEGER PRIMARY KEY,
  descendants INTEGER,
  title TEXT,
  score INTEGER, 
  commentTime INTEGER,
  type TEXT,
  url TEXT,
  userId INTEGER,
  FOREIGN KEY(userId) REFERENCES User(id)  
);

CREATE TABLE FavoriteStory (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
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