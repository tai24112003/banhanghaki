const express = require('express');
const router = express.Router();
const connection = require('./db');

router.get('/', (req, res) => {
    connection.query('SELECT * FROM Users WHERE 1', (error, results) => {
        if (error) {
            //return res.send(error.message);
            return res.status(500).json({ error: 'Internal server error' });
        }
        else {
            return res.json(results);
        }
    });
});
router.get('/:id', (req, res) => {
    connection.query("UPDATE `Users` SET `Status` = CASE WHEN `Status` = 0 THEN 1 WHEN `Status` = 1 THEN 0 END WHERE (`ID` = ?);", [req.params.id], (error, results) => {
        if (error) {
            return res.send(error.message);
            //return res.status(500).json({ error: 'Internal server error' });
        }
        else {
            return res.send(results);
        }
    });
});
module.exports = router;