
const express = require('express');
const router = express.Router();
const connection = require('./db');
router.post('/api/orderdetail/get', async (req, res) => {
    try {
        const { id } = req.body;
        const query = 'SELECT * FROM orderdetails WHERE OrderID = ?';
        connection.query(query, [id], async (err, results) => {
            if (err) {
                console.error('Error executing MySQL query:', err);
                res.status(500).send('Internal Server Error');
            } else {
                if (results.length > 0) {
                    console.log(results);
                    res.json(results);
                }
            }
        });
    } catch (error) {
        console.error('Error in login route:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.post('/api/orderdetail/', async (req, res) => {
    const { detailOrders, orderID } = req.body;
    console.log(detailOrders);
    try {
        const queryadd = 'INSERT INTO `orderdetails`(`OrderID`, `Quantity`, `ProductID`) VALUES (?, ?, ?)';
        const queyrdelete = 'DELETE FROM `cartdetails` WHERE ProductID=? &&CartID=?';

        await Promise.all(detailOrders.map(async (orderDetail) => {
            const { CartID, Product } = orderDetail;

            await new Promise((resolve, reject) => {
                connection.query(queryadd, [orderID, Product['Quantity'], Product['ID']], (err, results) => {
                    if (err) {
                        console.error('Error executing MySQL query:', err);
                        reject(err);
                    } else {
                        resolve(results);
                    }
                });
            });
            await new Promise((resolve, reject) => {
                connection.query(queyrdelete, [Product['ID'], CartID], (err, results) => {
                    if (err) {
                        console.error('Error executing MySQL query:', err);
                        reject(err);
                    } else {
                        resolve(results);
                    }
                });
            });
        }));

        res.status(200).json({
            OrderID: orderID
        });
    } catch (error) {
        console.error('Error in login route:', error);
        res.status(500).send('Internal Server Error');
    }
});

module.exports = router;