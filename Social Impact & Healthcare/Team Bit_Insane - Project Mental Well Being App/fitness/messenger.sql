-- Create users table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL, -- Store hashed passwords
    display_name VARCHAR(100),
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create messages table
CREATE TABLE messages (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT NOT NULL,
    receiver_id INT,
    group_id INT, -- NULL if the message is not in a group chat
    message_text TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES users(user_id),
    FOREIGN KEY (receiver_id) REFERENCES users(user_id),
    FOREIGN KEY (group_id) REFERENCES groups(group_id)
);

-- Create groups table
CREATE TABLE groups (
    group_id INT AUTO_INCREMENT PRIMARY KEY,
    group_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create group_members table
CREATE TABLE group_members (
    group_id INT,
    user_id INT,
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (group_id, user_id),
    FOREIGN KEY (group_id) REFERENCES groups(group_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Add indexes to messages table
ALTER TABLE messages ADD INDEX idx_sender_id (sender_id);
ALTER TABLE messages ADD INDEX idx_receiver_id (receiver_id);
ALTER TABLE messages ADD INDEX idx_group_id (group_id);

-- Add indexes to group_members table
ALTER TABLE group_members ADD INDEX idx_user_id (user_id);

-- Modify foreign key constraints in messages table
ALTER TABLE messages DROP FOREIGN KEY fk_sender_id;
ALTER TABLE messages DROP FOREIGN KEY fk_receiver_id;
ALTER TABLE messages DROP FOREIGN KEY fk_group_id;
ALTER TABLE messages ADD CONSTRAINT fk_sender_id FOREIGN KEY (sender_id) REFERENCES users(user_id) ON DELETE CASCADE;
ALTER TABLE messages ADD CONSTRAINT fk_receiver_id FOREIGN KEY (receiver_id) REFERENCES users(user_id) ON DELETE SET NULL;
ALTER TABLE messages ADD CONSTRAINT fk_group_id FOREIGN KEY (group_id) REFERENCES groups(group_id) ON DELETE SET NULL;
