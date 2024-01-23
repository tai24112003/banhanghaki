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
    })
}

router.get('/', (req, res) => {
    connection.query('SELECT * FROM users WHERE status=1', (error, results) => {
        if (error) {
            return res.status(500).json({ error: 'Internal server error' });
        }
        else {
            console.log(results);
            return res.json(results);
        }
    });
});

router.put('/updateToken', async (req, res) => {
    try {
        const { UserID, deviceToken } = req.body;
        const query = 'update users set DVToken = ? Where ID=? ';
        const resultts = await executeQuery(query, [UserID, deviceToken]);
        if (resultts) {
            res.status(200).send("Update DeviceToken");
        }
        else {
            res.status(401).send("fail update");
        }
    } catch (error) {
        console.error('Error in /login route:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
})

// router.get('/', async (req, res) => {
//     try {
//         const results = await executeQuery('SELECT * FROM users WHERE status=1', []);
//         res.json(results);
//     } catch (error) {
//         console.error('Error in / route:', error);
//         res.status(500).json({ error: 'Internal Server Error' });
//     }
// });

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
        const checkUserQuery = 'SELECT * FROM Users WHERE Email = ? || PhoneNumber=?';
        const userExists = await executeQuery(checkUserQuery, [email, phoneNumber]);

        if (userExists.length > 0) {
            res.status(400).json({ success: false, message: 'Email or phone number is already registered' });
        } else {
            const saltRounds = 10;
            const hashedPassword = await bcrypt.hash(password, saltRounds);

            const addUserQuery = 'INSERT INTO Users (Email, Password, FullName, PhoneNumber, Status) VALUES (?, ?, ?, ?, ?)';

            await executeQuery(addUserQuery, [email, hashedPassword, fullName, phoneNumber, status]);
            const query = 'SELECT * FROM Users WHERE Email = ? || PhoneNumber=?';
            const results = await executeQuery(query, [email, phoneNumber]);

            const user = results[0];

            connection.query('INSERT INTO `Carts` ( `UserID`, `Status`) VALUES ( ?, 1);', [user.ID], (error, results) => {
                if (error) {
                    // return res.status(500).json({ error: 'Internal server error' });
                }
                // return res.status(200).json({ results: "success" });
            });
            res.json({
                Fullname: fullName,
                Email: email,
                Phone: phoneNumber,
                Password: password,
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
router.put('/updateUser', async (req, res) => {
    try {
        const { id, Fullname, email, phoneNumber } = req.body;

        const checkUserQuery = 'SELECT * FROM Users WHERE ID = ?';
        const userExists = await executeQuery(checkUserQuery, [id]);

        if (userExists.length > 0) {
            const updateUserQuery = `
                UPDATE Users
                SET FullName=?, Email=?, PhoneNumber=?
                WHERE ID=?
            `;

            await executeQuery(updateUserQuery, [Fullname, email, phoneNumber, id]);

            res.json({
                success: true,
                message: 'User updated successfully',
            });
        } else {
            res.status(404).json({ success: false, message: 'User not found' });
        }
    } catch (error) {
        console.error('Error in /updateUser route:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});
router.put('/updatePassWord', async (req, res) => {
    try {
        const { pass,id } = req.body;
        const hashedPassword = await bcrypt.hash(pass, 10);
        const checkUserQuery = 'SELECT * FROM Users WHERE ID = ?';
        const userExists = await executeQuery(checkUserQuery, [id]);

        if (userExists.length > 0) {
            const updateUserQuery = `
                UPDATE Users
                SET Password=?
                WHERE ID=?
            `;

            await executeQuery(updateUserQuery, [hashedPassword, id]);

            res.json({
                success: true,
                message: 'User updated successfully',
            });
        } else {
            res.status(404).json({ success: false, message: 'User not found' });
        }
    } catch (error) {
        console.error('Error in /updateUser route:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});


module.exports = router;
