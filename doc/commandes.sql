-- avec root
CREATE DATABASE IF NOT EXISTS sandbox_api;
GRANT ALL PRIVILEGES ON sandbox_api.* TO 'user'@'%';
FLUSH PRIVILEGES;
