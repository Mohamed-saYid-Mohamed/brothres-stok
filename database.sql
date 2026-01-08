-- Create the database if it doesn't exist (though the user said it exists)
-- CREATE DATABASE IF NOT EXISTS brothres_stok;
-- USE brothres_stok;

-- Create products table
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    image_url VARCHAR(500),
    category VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Seed initial data
INSERT INTO products (name, description, price, image_url, category) VALUES
('Brother Pro Laptop', 'High performance laptop for business and creative work.', 1299.99, 'https://placeholder.com/150', 'Electronics'),
('Smart Business Watch', 'Stay connected and track your productivity.', 199.99, 'https://placeholder.com/150', 'Electronics'),
('Premium Leather Bag', 'Executive leather bag for professionals.', 89.99, 'https://placeholder.com/150', 'Accessories'),
('Wireless Noise Cancelling Headphones', 'Focus on your work with premium sound.', 249.99, 'https://placeholder.com/150', 'Electronics');
