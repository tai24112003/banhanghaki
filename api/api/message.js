const express = require('express');
const router = express.Router();
const connection = require('./db');

router.get('/:id', (req, res) => {
    var id = req.params.id;
    connection.query('SELECT * FROM hakistore.Messages where ToID = ? OR FromID = ?;',[id,id], (error, results) => {
        if (error) {
            //return res.send(error.message);
            return res.status(500).json({ error: 'Internal server error' });
        }
        else {
            return res.status(200).json(results);
        }
    });
});

module.exports = router;