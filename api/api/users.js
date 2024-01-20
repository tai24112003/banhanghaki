const express = require('express');
const router = express.Router();
const connection = require('./db');
const bcrypt = require('bcrypt');

// Handler for database query using async/await
const executeQuery = async (query, params) => {
    return new Promise((resolve, reject) => {
        connection.query(query, params, (err, results) => {
            if (err) {
                reject(err);
            } else {
                resolve(results);
            }
        });
    });
};

router.get('/', async (req, res) => {
    try {
        const results = await executeQuery('SELECT * FROM usersz WHERE status=1', []);
        res.json(results);
    } catch (error) {
        console.error('Error in / route:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

router.post('/login', async (req, res) => {
    try {
        const { username, password } = req.body;
        const query = 'SELECT * FROM Users WHERE Email = ? || PhoneNumber=?';
        const results = await executeQuery(query, [username, username]);

        if (results.length > 0) {
            const user = results[0];
            const match = await bcrypt.compare(password, user.Password);

            if (match) {
                res.json({
                    ID: user.ID,
                    Fullname: user.Fullname,
                    Email: user.Email,
                    Phone: user.PhoneNumber,
                    Address: user.Address,
                    Password: user.Password,
                    success: true,
                    message: 'Login successful',
                });
            } else {
                res.status(401).json({ success: false, message: 'Invalid password' });
            }
        } else {
            res.status(401).json({ success: false, message: 'Invalid username' });
        }
    } catch (error) {
        console.error('Error in /login route:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

router.post('/register', async (req, res) => {
    try {
        const { email, password, fullName, phoneNumber, status } = req.body;
        const checkUserQuery = 'SELECT * FROM Users WHERE Email = ?';
        const userExists = await executeQuery(checkUserQuery, [email]);

        if (userExists.length > 0) {
            res.status(400).json({ success: false, message: 'Email is already registered' });
        } else {
            const hashedPassword = await bcrypt.hash(password, 10);
            const addUserQuery = 'INSERT INTO Users (Email, Password, FullName, PhoneNumber, Status) VALUES (?, ?, ?, ?, ?)';

            await executeQuery(addUserQuery, [email, hashedPassword, fullName, phoneNumber, status]);

            res.json({
                Fullname: fullName,
                Email: email,
                Phone: phoneNumber,
                Password: hashedPassword,
            });
        }
    } catch (error) {
        console.error('Error in /register route:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

router.put('/updateAddressId', async (req, res) => {
    try {
        const { userId, addressId } = req.body;
        const updateAddressIdQuery = 'UPDATE Users SET addressID = ? WHERE ID = ?';

        await executeQuery(updateAddressIdQuery, [addressId, userId]);

        res.json({ success: true, message: 'AddressID updated successfully' });
    } catch (error) {
        console.error('Error in /updateAddressId route:', error);
        res.status(500).json({ error: 'Internal Server Error' });
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
