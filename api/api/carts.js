const express = require('express');
const router = express.Router();
const connection = require('./db');

router.get('/:id', (req, res) => {
    connection.query('SELECT * FROM Products WHERE 1', (error, results) => {
        if (error) {
            return res.send(error.message);
            //return res.status(500).json({ error: 'Internal server error' });
        }
        else {
            return res.json(req.params.id);
        }
    });
});
module.exports = router;