const express = require('express');
const cors = require('cors');
const bcrypt = require('bcrypt');
const app = express();
const mysql = require('mysql');
app.use(cors());

app.use(express.json());

const PORT = 3000;

// Thay đổi host trong connection
const connection = mysql.createConnection({
  host: "33af-2402-800-63b9-bf0b-5b1-576c-401f-87f2.ngrok-free.app",
  user: 'root',
  password: '',
  database: 'hakistore',
  port: 3006
});

app.listen(PORT, () => {
  console.log('Server Listening on PORT:', PORT);
});

app.get('/api/_order/', (request, response) => {
  const query = 'SELECT * FROM orders';

  connection.query(query, (err, results, fields) => {
    if (err) {
      console.error('Error executing query:', err);
      response.status(500).json({ error: 'Internal Server Error' });
    } else {
      response.json(results);
    }
  });
});

app.post('/api/login', async (req, res) => {
  try {
    const { username, password } = req.body;

    const query = 'SELECT * FROM Accounts WHERE Username = ?';
    connection.query(query, [username], async (err, results) => {
      if (err) {
        console.error('Error executing MySQL query:', err);
        res.status(500).send('Internal Server Error');
      } else {
        if (results.length > 0) {
          const user = results[0];
          const match = await bcrypt.compare(password, user.Password);

          if (match) {
            res.json({ success: true, message: 'Login successful' });
          } else {
            res.status(401).json({ success: false, message: 'Invalid password' });
          }
        } else {
          res.status(401).json({ success: false, message: 'Invalid username' });
        }
      }
    });
  } catch (error) {
    console.error('Error in login route:', error);
    res.status(500).send('Internal Server Error');
  }
});

app.post('/api/register', async (req, res) => {
  try {
    const { email, password, fullName, phoneNumber, address, status } = req.body;
    console.log(email);
    const checkUserQuery = 'SELECT * FROM Accounts WHERE Email = ?';
    const userExists = await new Promise((resolve, reject) => {
      connection.query(checkUserQuery, [email], (err, results) => {
        if (err) {
          reject(err);
        } else {
          resolve(results.length > 0);
        }
      });
    });

    if (userExists) {
      res.status(400).json({ success: false, message: 'Email is already registered' });
    } else {
      // const hashedPassword = await bcrypt.hash(password, 10);

      const addUserQuery = `
        INSERT INTO Accounts (Email, Password, FullName, PhoneNumber, Address, Status)
        VALUES (?, ?, ?, ?, ?, ?)
      `;

      connection.query(addUserQuery, [email, password, fullName, phoneNumber, address, status], (err) => {
        if (err) {
          console.error('Error executing MySQL query:', err);
          res.status(500).send('Internal Server Error');
        } else {
          res.json({ success: true, message: 'Registration successful' });
        }
      });
    }
  } catch (error) {
    console.error('Error in register route:', error);
    res.status(500).send('Internal Server Error');
  }
});

// Đảm bảo rằng kết nối được đóng sau mỗi yêu cầu
app.use((req, res, next) => {
  connection.end();
  next();
});
