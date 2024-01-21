
const express = require('express');
const router = express.Router();
const connection = require('./db');
router.post('/api/orderdetail/get', async (req, res) => {
    try {
        const { id } = req.body;
        const query = 'SELECT * FROM orderdetails WHERE OrderID = ?';
        connection.query(query, [id], async (err, results) => {
            if (err) {
                console.error('Error executing MySQL query:', err);
                res.status(500).send('Internal Server Error');
            } else {
                if (results.length > 0) {
                    res.json(results);
                }
            }
        });
    } catch (error) {
        console.error('Error in login route:', error);
        res.status(500).send('Internal Server Error');
    }
});
module.exports = router;