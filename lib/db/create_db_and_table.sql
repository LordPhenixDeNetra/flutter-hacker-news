-- Table pour stocker les utilisateurs
CREATE TABLE User (
    id INT PRIMARY KEY,                     -- Identifiant unique de l'utilisateur
    username VARCHAR(255) NOT NULL,         -- Nom d'utilisateur
    karma INT,                              -- Le karma de l'utilisateur
    about TEXT,                             -- Description de l'utilisateur
    created_at DATETIME                     -- Date de création du compte
);

-- Table pour stocker les histoires
CREATE TABLE Story (
    id INT PRIMARY KEY,                     -- Identifiant unique de l'histoire
    title VARCHAR(255) NOT NULL,            -- Titre de l'histoire
    author_id INT,                          -- Identifiant de l'auteur de l'histoire
    url VARCHAR(255),                       -- URL de l'histoire
    score INT,                              -- Score de l'histoire
    time DATETIME,                          -- Date et heure de l'histoire
    comments_count INT,                     -- Nombre de commentaires sur l'histoire
    FOREIGN KEY (author_id) REFERENCES User(id) -- Clé étrangère liée à l'auteur de l'histoire
);

-- Table pour stocker les commentaires
CREATE TABLE Comment (
    id INT PRIMARY KEY,                     -- Identifiant unique du commentaire
    author_id INT,                          -- Identifiant de l'auteur du commentaire
    story_id INT,                           -- Identifiant de l'histoire associée au commentaire
    text TEXT NOT NULL,                     -- Contenu du commentaire
    time DATETIME,                          -- Date et heure du commentaire
    parent_id INT,                          -- Identifiant du commentaire parent (le cas échéant)
    FOREIGN KEY (author_id) REFERENCES User(id),     -- Clé étrangère liée à l'auteur du commentaire
    FOREIGN KEY (story_id) REFERENCES Story(id),     -- Clé étrangère liée à l'histoire associée
    FOREIGN KEY (parent_id) REFERENCES Comment(id)   -- Clé étrangère liée au commentaire parent
);

-- Table pour stocker les sondages
CREATE TABLE Poll (
    id INT PRIMARY KEY,                     -- Identifiant unique du sondage
    title VARCHAR(255) NOT NULL,            -- Titre du sondage
    author_id INT,                          -- Identifiant de l'auteur du sondage
    score INT,                              -- Score du sondage
    time DATETIME,                          -- Date et heure du sondage
    comments_count INT,                     -- Nombre de commentaires sur le sondage
    FOREIGN KEY (author_id) REFERENCES User(id) -- Clé étrangère liée à l'auteur du sondage
);























































































































































































































































































































































-- Table pour stocker les options de vote dans un sondage
CREATE TABLE PollOption (
    id INT PRIMARY KEY,                     -- Identifiant unique de l'option de vote
    poll_id INT,                            -- Identifiant du sondage associé à l'option
    option_text VARCHAR(255) NOT NULL,      -- Texte de l'option de vote
    votes INT,                              -- Nombre de votes pour cette option
    FOREIGN KEY (poll_id) REFERENCES Poll(id) -- Clé étrangère liée au sondage associé
);

-- Table pour stocker les étiquettes ou tags
CREATE TABLE Tag (
    id INT PRIMARY KEY,                     -- Identifiant unique du tag
    name VARCHAR(255) NOT NULL             -- Nom du tag
);

-- Table pour stocker les signets (bookmarks)
CREATE TABLE Bookmark (
    id INT PRIMARY KEY,                     -- Identifiant unique du signet
    user_id INT,                            -- Identifiant de l'utilisateur ayant créé le signet
    story_id INT,                           -- Identifiant de l'histoire associée au signet
    time DATETIME,                          -- Date et heure du signet
    FOREIGN KEY (user_id) REFERENCES User(id),       -- Clé étrangère liée à l'utilisateur
    FOREIGN KEY (story_id) REFERENCES Story(id)      -- Clé étrangère liée à l'histoire associée
);

-- Table pour stocker les notifications
CREATE TABLE Notification (
    id INT PRIMARY KEY,                     -- Identifiant unique de la notification
    user_id INT,                            -- Identifiant de l'utilisateur concerné par la notification
    type VARCHAR(255) NOT NULL,             -- Type de notification
    message TEXT NOT NULL,                  -- Message de la notification
    time DATETIME,                          -- Date et heure de la notification
    is_read BOOLEAN,                        -- Indique si la notification a été lue ou non
    FOREIGN KEY (user_id) REFERENCES User(id) -- Clé étrangère liée à l'utilisateur
);

-- Table pour stocker les actions de modération
CREATE TABLE ModerationAction (
    id INT PRIMARY KEY,                     -- Identifiant unique de l'action de modération
    moderator_id INT,                       -- Identifiant du modérateur ayant effectué l'action
    action_type VARCHAR(255) NOT NULL,      -- Type d'action de modération
    target_id INT,                          -- Identifiant de l'élément ciblé par l'action
    time DATETIME,                          -- Date et heure de l'action
    FOREIGN KEY (moderator_id) REFERENCES User(id),   -- Clé étrangère liée au modérateur
    FOREIGN KEY (target_id) REFERENCES Story(id) ON DELETE CASCADE,   -- Clé étrangère liée à l'élément ciblé
    FOREIGN KEY (target_id) REFERENCES Comment(id) ON DELETE CASCADE   -- Clé étrangère liée à l'élément ciblé
);

-- Table pour stocker les communautés
CREATE TABLE Community (
    id INT PRIMARY KEY,                     -- Identifiant unique de la communauté
    name VARCHAR(255) NOT NULL,             -- Nom de la communauté
    description TEXT,                       -- Description de la communauté
    members_count INT,                      -- Nombre de membres dans la communauté
    moderator_id INT,                       -- Identifiant du modérateur de la communauté
    FOREIGN KEY (moderator_id) REFERENCES User(id)   -- Clé étrangère liée au modérateur de la communauté
);

-- Table pour stocker les annonces
CREATE TABLE Announcement (
    id INT PRIMARY KEY,                     -- Identifiant unique de l'annonce
    title VARCHAR(255) NOT NULL,            -- Titre de l'annonce
    content TEXT NOT NULL,                  -- Contenu de l'annonce
    author_id INT,                          -- Identifiant de l'auteur de l'annonce
    time DATETIME,                          -- Date et heure de l'annonce
    comments_count INT,                     -- Nombre de commentaires sur l'annonce
    FOREIGN KEY (author_id) REFERENCES User(id) -- Clé étrangère liée à l'auteur de l'annonce
);

-- Table pour stocker les votes dans un sondage
CREATE TABLE PollVote (
    id INT PRIMARY KEY,                     -- Identifiant unique du vote
    user_id INT,                            -- Identifiant de l'utilisateur ayant voté
    poll_option_id INT,                     -- Identifiant de l'option de vote choisie
    time DATETIME,                          -- Date et heure du vote
    FOREIGN KEY (user_id) REFERENCES User(id),          -- Clé étrangère liée à l'utilisateur
    FOREIGN KEY (poll_option_id) REFERENCES PollOption(id) -- Clé étrangère liée à l'option de vote
);

-- Table pour stocker les abonnements aux tags
CREATE TABLE Subscription (
    id INT PRIMARY KEY,                     -- Identifiant unique de l'abonnement
    user_id INT,                            -- Identifiant de l'utilisateur abonné
    tag_id INT,                             -- Identifiant du tag auquel l'utilisateur est abonné
    time DATETIME,                          -- Date et heure de l'abonnement
    FOREIGN KEY (user_id) REFERENCES User(id),  -- Clé étrangère liée à l'utilisateur
    FOREIGN KEY (tag_id) REFERENCES Tag(id)     -- Clé étrangère liée au tag
);

-- Table pour stocker les badges
CREATE TABLE Badge (
    id INT PRIMARY KEY,                     -- Identifiant unique du badge
    name VARCHAR(255) NOT NULL,             -- Nom du badge
    description TEXT                        -- Description du badge
);
