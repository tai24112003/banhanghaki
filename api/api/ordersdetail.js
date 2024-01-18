
const express = require('express');
const router = express.Router();
const connection = require('./db');
router.get('/api/orderdetails/get', (request, response) => {
    const query = 'SELECT * FROM orderdetails';

    connection.query(query, (err, results, fields) => {
        if (err) {
            console.error('Error executing query:', err);
            return response.status(500).json({ error: 'Internal Server Error' });
        }

        response.json(results);
    });
});

module.exports = router;