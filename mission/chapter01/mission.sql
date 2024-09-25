-- Users table
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    points INT DEFAULT 0
);

-- Regions table
CREATE TABLE regions (
    region_id INT PRIMARY KEY AUTO_INCREMENT,
    region_name VARCHAR(50) NOT NULL
);

-- Stores table
CREATE TABLE stores (
    store_id INT PRIMARY KEY AUTO_INCREMENT,
    region_id INT,
    store_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

-- Missions table
CREATE TABLE missions (
    mission_id INT PRIMARY KEY AUTO_INCREMENT,
    store_id INT,
    mission_description TEXT NOT NULL,
    points INT NOT NULL,
    FOREIGN KEY (store_id) REFERENCES stores(store_id)
);

-- User_missions table (attribute, mtom)
CREATE TABLE user_missions (
    user_mission_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    mission_id INT,
    status ENUM('ongoing', 'completed', 'reviewed') DEFAULT 'ongoing',
    completed_at TIMESTAMP NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (mission_id) REFERENCES missions(mission_id)
);

-- Reviews table
CREATE TABLE reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    mission_id INT,
    store_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (mission_id) REFERENCES missions(mission_id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id)
);

-- Notifications table
CREATE TABLE notifications (
    notification_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    notification_type ENUM('new_mission', 'review_request'),
    content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_read BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
