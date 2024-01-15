const express = require('express');
const cors = require('cors');
const app = express();
const mysql = require('mysql');
const ngrok = require('ngrok');
app.use(cors());

app.use(express.json());

const PORT = 3000;

app.listen(PORT, async () => {
  try {
    // Tạo đường hầm với Ngrok
    const ngrokUrl = await ngrok.connect(PORT);
    console.log('Ngrok tunnel is live at:', ngrokUrl);

    // Kết nối đến MySQL
    const connection = mysql.createConnection({
      host: 'localhost',
      port: '3306',
      user: 'root',
      password: '',
      database: 'banhanghaki'
    });

    connection.connect((err) => {
      if (err) {
        console.error('Error connecting to MySQL:', err);
        return;
      }
      console.log('Connected to MySQL');
    });

    // API endpoint
    app.get('/api/_order/get', (request, response) => {
      const query = 'SELECT * FROM _order';

      connection.query(query, (err, results, fields) => {
        if (err) {
          console.error('Error executing query:', err);
          return response.status(500).json({ error: 'Internal Server Error' });
        }

        response.json(results);
      });
    });
  } catch (error) {
    console.error('Error:', error);
  }
});
