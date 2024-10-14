CREATE SCHEMA app;

CREATE TABLE app.user
(
    id       UUID NOT NULL,
    username VARCHAR(255),
    name     VARCHAR(255),
    email    VARCHAR(255),
    CONSTRAINT pk_user PRIMARY KEY (id),
    CONSTRAINT unq_username UNIQUE (username)
);

CREATE TABLE app.category
(
    id   UUID not null,
    name VARCHAR(255),
    constraint pk_category PRIMARY KEY (id)
);

CREATE TABLE app.channel
(
    id          UUID         NOT NULL,
    author_id   UUID         NOT NULL,
    category_id UUID         NOT NULL,
    created_at TIMESTAMP NOT NULL ,
    name        VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    language    VARCHAR(10)  NOT NULL,
    avatar      TEXT,
    CONSTRAINT pk_channel PRIMARY KEY (id),
    CONSTRAINT fk_channel_on_author FOREIGN KEY (author_id) REFERENCES app.user (id),
    CONSTRAINT fk_channel_on_category FOREIGN KEY (category_id) REFERENCES app.category (id),
    CONSTRAINT unq_channel_name UNIQUE (name)
);


CREATE TABLE app.user_channel
(
    user_id    UUID NOT NULL,
    channel_id UUID NOT NULL,
    CONSTRAINT pk_user_channel PRIMARY KEY (user_id, channel_id),
    CONSTRAINT fk_userchannel_on_channel FOREIGN KEY (channel_id) REFERENCES app.channel (id),
    CONSTRAINT fk_userchannel_on_user FOREIGN KEY (user_id) REFERENCES app.user (id)
);












