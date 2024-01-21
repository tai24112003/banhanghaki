const express = require('express');
const router = express.Router();
const connection = require('./db');

router.post('/api/order/get', async (req, res) => {
    try {
        const { id } = req.body;
        
        const query = 'SELECT * FROM Orders WHERE UserID = ?';
        connection.query(query, [id], async (err, results) => {
            if (err) {
                console.error('Error executing MySQL query:', err);
                res.status(500).send('Internal Server Error');
            } else {
                res.json(results); 
            }
        });
    } catch (error) {
        console.error('Error in login route:', error);
        res.status(500).send('Internal Server Error');
    }
});

//Lấy danh sách đơn hàng chờ xác nhận (thay đổi Status là trạng thái quy định)
router.get('/api/order/stt-xn', async (req, res) => {
    try {
        const query = 'SELECT * FROM Orders WHERE Status = 1';
        connection.query(query, async (err, results) => {
            if (err) {
                console.error('Error executing MySQL query:', err);
                res.status(500).send('Internal Server Error');
            } else {
                res.status(200).json(results); 
            }
        });
    } catch (error) {
        console.error('Error in login route:', error);
        res.status(500).send('Internal Server Error');
    }
});

//Cập nhật đơn hàng chờ xác nhận -> đang xử lý
router.put('/api/order/:id', async (req, res) => {
    var idOrder = req.params.id;
    try {
        const query = 'UPDATE `hakistore`.`Orders` SET `Status` = 2 WHERE (`ID` = ?);';
        connection.query(query,[idOrder],async (err, results) => {
            if (err) {
                console.error('Error executing MySQL query:', err);
                res.status(500).send('Internal Server Error');
            } else {
                res.status(200).send("Update successful"); 
            }
        });
    } catch (error) {
        console.error('Error in login route:', error);
        res.status(500).send('Internal Server Error');
    }
});

module.exports = router;
