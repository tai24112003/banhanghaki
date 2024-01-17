const express = require('express');
const cors = require('cors');
const bcrypt = require('bcrypt');
const app = express();
const mysql = require('mysql');
const ngrok = require('ngrok')
app.use(cors());

app.use(express.json());

const PORT = 3000;




app.listen(PORT, async () => {
    console.log('Server Listening on PORT:', PORT);
    const ngrokUrl = await ngrok.connect(PORT);
    console.log('Ngrok tunnel is live at:', ngrokUrl);

    const connection = mysql.createConnection({
        host: "localhost",
        user: 'root',
        password: '',
        database: 'hakistore',
        port: 3306,
    });

    connection.connect((err) => {
        if (err) {
            console.error('Error connecting to MySQL:', err);
            return;
        }
        console.log('Connected to MySQL');
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

            const query = 'SELECT * FROM Users WHERE Username = ?';
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
            console.log(req.body);
            console.log(email);
            const checkUserQuery = 'SELECT * FROM Users WHERE Email = ?';
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
        INSERT INTO Users (Email, Password, FullName, PhoneNumber, Address, Status)
        VALUES (?, ?, ?, ?, ?, ?)
      `;

                connection.query(addUserQuery, [email, password, fullName, phoneNumber, address, status], (err) => {
                    if (err) {
                        console.error('Error executing MySQL query:', err);
                        res.status(500).send('Internal Server Error');
                    } else {
                        res.json({
                            Fullname: fullName,
                            Email: email,
                            Phone: phoneNumber,
                            address: address,
                            Password: password
                        });
                    }
                });
            }
        } catch (error) {
            console.error('Error in register route:', error);
            res.status(500).send('Internal Server Error');
        }
    });
    app.get('/api/product/chair', function (req, res) {
        const query = 'SELECT * FROM products where CategoryID = 1';
        connection.query(query, (err, rows, fields) =>{
            if (err) {
                console.error('Error executing query:', err);
                res.sendStatus(500).json({ error: 'Internal Server Error' });
            }
            res.json(rows);
        });
        });
    app.get('/api/product/table', function (req, res) {
        const query = 'SELECT * FROM products where CategoryID = 2';
        connection.query(query, (err, rows, fields) =>{
            if (err) {
                console.error('Error executing query:', err);
                res.sendStatus(500).json({ error: 'Internal Server Error' });
            }
            res.json(rows);
        });
        });
    app.get('/api/product/armchair', function (req, res) {
        const query = 'SELECT * FROM products where CategoryID = 3';
        connection.query(query, (err, rows, fields) =>{
            if (err) {
                console.error('Error executing query:', err);
                res.sendStatus(500).json({ error: 'Internal Server Error' });
            }
            res.json(rows);
        });
        });
    app.get('/api/product/bed', function (req, res) {
        const query = 'SELECT * FROM products where CategoryID = 4';
        connection.query(query, (err, rows, fields) =>{
            if (err) {
                console.error('Error executing query:', err);
                res.sendStatus(500).json({ error: 'Internal Server Error' });
            }
            res.json(rows);
        });
        });
    app.get('/api/product/lamp', function (req, res) {
        const query = 'SELECT * FROM products where CategoryID = 5';
        connection.query(query, (err, rows, fields) =>{
            if (err) {
                console.error('Error executing query:', err);
                res.sendStatus(500).json({ error: 'Internal Server Error' });
            }
            res.json(rows);
        });
        });
    app.get('/api/product/:id', function (req, res) {
        const productId = req.params.id;
        const query = `SELECT * FROM products WHERE ID = ${productId}`;
        
        connection.query(query, (err, rows, fields) => {
            if (err) {
            console.error('Error executing query:', err);
            res.status(500).json({ error: 'Internal Server Error' });
            } else if (rows.length === 0) {
            res.status(404).json({ error: 'Product not found' });
            } else {
            res.json(rows[0]);
            }
        });
        });
        app.post('/api/add_Product', (req, res) => {
            const product = req.body;
          
            const query = `INSERT INTO products (ID, CategoryID, ProductName, Image, Quantity, UnitPrice, Color, Description, Status)
                           VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`;
          
            connection.query(
              query,
              [
                product.ID,
                product.CategoryID,
                product.ProductName,
                product.Image,
                product.Quantity,
                product.UnitPrice,
                product.Color,
                product.Description,
                product.Status,
              ],
              (error, results, fields) => {
                if (error) {
                  console.error('Lỗi thêm sản phẩm: ', error);
                  res.status(500).json({ error: 'Lỗi thêm sản phẩm' });
                  return;
                }
          
                console.log('Sản phẩm đã được thêm thành công');
                res.status(200).json({ message: 'Sản phẩm đã được thêm thành công' });
              }
            );
          });
    app.put('/api/update/product/:id', (req, res) => {
  const id = parseInt(req.params.id);
  const { categoryID, productName, image, quantity, unitPrice, color, description } = req.body;

  const sql = 'UPDATE products SET categoryID = ?, productName = ?, image = ?, quantity = ?, unitPrice = ?, color = ?, description = ? WHERE id = ?';
  const values = [categoryID, productName, image, quantity, unitPrice, color, description, id];

  connection.query(sql, values, (err, result) => {
    if (err) {
      console.error(err);
      res.status(500).json({ message: 'Error updating product' });
    } else if (result.affectedRows === 0) {
      res.status(404).json({ message: 'Product not found' });
    } else {
      res.status(200).json({ message: 'Product updated successfully' });
    }
  });
});

});

