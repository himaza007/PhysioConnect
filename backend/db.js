const mysql = require('mysql2');
require('dotenv').config();

// Create connection configuration
const connectionConfig = {
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
};

// Create the connection pool
const pool = mysql.createPool(connectionConfig);

// Create a promise wrapper for the pool
const promisePool = pool.promise();

// Test the connection
promisePool.getConnection()
    .then((connection) => {
        console.log('Database connection successful');
        connection.release(); // Always release the connection
    })
    .catch((error) => {
        console.error('Database connection failed:', error);
        console.log('Connection Config:', {
            host: process.env.DB_HOST,
            user: process.env.DB_USER,
            database: process.env.DB_NAME
        });
    });

module.exports = promisePool;