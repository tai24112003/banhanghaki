const express = require('express');
const router = express.Router();
const connection = require('./db');


router.get('/:ID/UserID', (req, res) => {
    var id = req.params.ID;
    connection.query('SELECT * FROM Addresses WHERE UserID=?', [id], (error, results) => {
        if (error) {
            return res.status(500).json({ error: 'Internal server error' });
        }
        else {
            return res.json(results);
        }
    });
});

router.post('/', async (req, res) => {
    try {
        const { fullName, titleName, UserID } = req.body;

        const addAddressQuery = `
        INSERT INTO addresses(FullName, TitleName, UserID) 
    VALUES (?, ?, ?)
  `;

        connection.query(addAddressQuery, [fullName, titleName, UserID], (err) => {
            if (err) {
                console.error('Error executing MySQL query:', err);
                res.status(500).send('Internal Server Error');
            } else {
                res.json({
                    success: true
                });
            }
        });

    } catch (error) {
        console.error('Error in register route:', error);
        res.status(500).send('Internal Server Error');
    }
});


module.exports = router;