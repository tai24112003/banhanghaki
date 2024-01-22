const express = require('express');
const router = express.Router();
const connection = require('./db');
const bcrypt = require('bcrypt');
const fs = require('fs');


router.get('/search-history/:id_user', function (req, res) {
  const id_user = req.params.id_user;
  const query = 'SELECT * FROM `searchhistory` WHERE UserID = ?';
  connection.query(query, [id_user], (err, rows, fields) => {
    if (err) {
      console.error('Error executing query:', err);
      res.sendStatus(500).json({ error: 'Internal Server Error' });
    }
    res.json(rows);
  });
});
router.get('/search', (req, res) => {
  const searchTerm = req.query.searchTerm;
  const query = 'SELECT * FROM products WHERE ProductName LIKE ?';
  const searchValue = `%${searchTerm}%`;

  connection.query(query, [searchValue], (err, rows, fields) => {
    if (err) {
      console.error('Error executing query:', err);
      res.status(500).json({ error: 'Internal Server Error' });
    }

    res.json(rows);
  });
});
router.post('/add-history', function (req, res) {
  const { ID, Content, UserId } = req.body;

  if (Content === null || UserId === null) {
    console.error('Error: content or userId is null');
    res.status(400).json({ error: 'Bad Request' });
    return;
  }

  const query = 'INSERT INTO searchhistory (ID,Content, UserID) VALUES (?, ?, ?)';
  connection.query(query, [ID, Content, UserId], (err, result) => {
    if (err) {
      console.error('Error executing query:', err);
      res.status(500).json({ error: 'Internal Server Error' });
    } else {
      // Thêm thành công, thực hiện các thao tác khác nếu cần
      res.sendStatus(200);
    }
  });
});
router.delete('/delete-history/:id', function (req, res) {
  const id = req.params.id;
  const query = 'DELETE FROM searchhistory WHERE ID = ?';
  connection.query(query, [id], (err, result) => {
    if (err) {
      console.error('Error executing query:', err);
      res.status(500).json({ error: 'Internal Server Error' });
    } else {
      // Xóa thành công, thực hiện các thao tác khác nếu cần
      res.sendStatus(200);
    }
  });
});
module.exports = router;