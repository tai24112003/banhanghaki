const express = require('express');
const router = express.Router();
const connection = require('./db');

router.post('/', (req, res) => {
    const { Name, Content, NotificationType, UserID } = req.body;
    connection.query('INSERT INTO `notifications`( `Name`, `Content`, `NotificationType`, `UserID`) VALUES (?,?,?,?)', [Name, Content, NotificationType, UserID], (error, results) => {
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
    connection.query("Select * from notifications where userid=? || notificationType=?", [req.params.id, "Public"], (error, results) => {
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