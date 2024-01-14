const express = require('express');
const cors = require('cors');
const app = express();
const mysql = require('mysql');
app.use(cors());

app.use(express.json());

const PORT = 3000;

app.listen(PORT, () => {
  console.log('Server Listening on PORT:', PORT);
});
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'banhanghaki'
});
app.get('/api/_order/get', (request, response) => {
  

  const query = 'SELECT * FROM _order';

  connection.connect((err) => {
    if (err) {
      console.error('Error connecting to MySQL:', err);
      return response.status(500).json({ error: 'Internal Server Error' });
    }

    connection.query(query, (err, results, fields) => {
      if (err) {
        console.error('Error executing query:', err);
        connection.end();
        return response.status(500).json({ error: 'Internal Server Error' });
      }

      response.json(results);
      connection.end((err) => {
        if (err) {
          console.error('Error closing connection:', err);
        }
      });
    });
  });
});
