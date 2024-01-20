const express = require('express');
const router = express.Router();
const connection = require('./db');
const bcrypt = require('bcrypt');


router.get('/', (req, res) => {
    connection.query('SELECT * FROM Users WHERE status=1', (error, results) => {
        if (error) {
            return res.status(500).json({ error: 'Internal server error' });
        }
        else {
            return res.json(results);
        }
    });
});

router.post('/login', async (req, res) => {
    try {
        const { username, password } = req.body;
        console.log(req.body);
        const query = 'SELECT * FROM Users WHERE Email = ? || Phone=?';
        connection.query(query, [username, username], async (err, results) => {
            if (err) {
                console.error('Error executing MySQL query:', err);
                res.status(500).send('Internal Server Error');
            } else {
                if (results.length > 0) {
                    const user = results[0];
                    const match = await bcrypt.compare(password, user.Password);
                    console.log(password + " " + user.Password);

                    if (match) {
                        res.json({ ID:user.ID,Fullname:user.FullName,PhoneNumber:user.PhoneNumber,Email:user.Email,Password:user.Password,success: true, message: 'Login successful' });
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

router.post('/register', async (req, res) => {
    try {
        const { email, password, fullName, phoneNumber, status } = req.body;
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
            const hashedPassword = await bcrypt.hash(password, 10);

            const addUserQuery = `
    INSERT INTO Users (Email, Password, FullName, Phone,  Status)
    VALUES (?, ?, ?, ?, ?)
  `;

            connection.query(addUserQuery, [email, password, fullName, phoneNumber, status], (err) => {
                if (err) {
                    console.error('Error executing MySQL query:', err);
                    res.status(500).send('Internal Server Error');
                } else {
                    res.json({
                        Fullname: fullName,
                        Email: email,
                        Phone: phoneNumber,
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
router.put('/update/AddressID', async (req, res) => {
    try {
        const { id,address } = req.body;

        const checkUserQuery = 'SELECT * FROM Users WHERE ID = ?';
        const userExists = await new Promise((resolve, reject) => {
            connection.query(checkUserQuery, [id], (err, results) => {
                if (err) {
                    reject(err);
                } else {
                    resolve(results.length > 0);
                }
            });
        });

        if (userExists) {
            const updateUserQuery = `
                UPDATE Users
                SET AddressID=?
                WHERE ID=?
            `;

            connection.query(updateUserQuery, [ address, id], (err) => {
                if (err) {
                    console.error('Error executing MySQL query:', err);
                    res.status(500).send('Internal Server Error');
                } else {
                    res.json({
                        AddressID:address
                    });
                }
            });
        } else {
            res.status(404).json({ success: false, message: 'User not found' });
        }
    } catch (error) {
        console.error('Error in update route:', error);
        res.status(500).send('Internal Server Error');
    }
});


module.exports = router;