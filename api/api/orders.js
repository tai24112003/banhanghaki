const express = require('express');
const router = express.Router();
const connection = require('./db');

router.post('/api/order/get', async (req, res) => {
    try {
        const { id } = req.body;
        
        const query = 'SELECT * FROM Orders WHERE UserID = ?';
        connection.query(query, [id], async (err, results) => {
            if (err) {
                console.error('Error executing MySQL query:', err);
                res.status(500).send('Internal Server Error');
            } else {
                res.json(results); 
            }
        });
    } catch (error) {
        console.error('Error in login route:', error);
        res.status(500).send('Internal Server Error');
    }
});

module.exports = router;
