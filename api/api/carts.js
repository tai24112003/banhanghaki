const express = require('express');
const router = express.Router();
const connection = require('./db');

router.get('/:id', (req, res) => {
    var id = req.params.id;
    connection.query('SELECT CartDetails.ID as "ItemId",CartDetails.Quantity as "CartQuan", CartID,ProductID,CartDetails.Status as "CartStatus",CategoryID,ProductName,Image, Products.Quantity,Price, Products.Description,Products.Status as "ProStatus" FROM CartDetails,Products WHERE CartDetails.ProductID = Products.ID AND CartID = ?',[id], (error, results) => {
        if (error) {
            //return res.send(error.message);
            return res.status(500).json({ error: 'Internal server error' });
        }
        else {
            return res.json(results);
        }
    });
});

router.put('/:number', (req, res) => {
    var num = req.params.number;
    var {id} = req.body;
    connection.query('UPDATE `CartDetails` SET `Quantity` = ? WHERE (`ID` = ?);',[num,id], (error, results) => {
        if (error) {
            return res.send(error.message);
            //return res.status(500).json({ error: 'Internal server error' });
        }
        else {
            return res.status(200).json({status:"success",num:num,id:id});
        }
    });
});

router.delete('/:id', (req, res) => {
    var id = req.params.id;
    connection.query('DELETE FROM `CartDetails` WHERE (`ID` = ?);',[id], (error, results) => {
        if (error) {
            //return res.send(error.message);
            return res.status(500).json({ error: 'Internal server error' });
        }
        else {
            return res.status(200).json({ results: "success" });
        }
    });
});


router.put('/', (req, res) => {
    var {id} = req.body;
    connection.query('DELETE FROM `CartDetails` WHERE CartID = ?;',[id], (error, results) => {
        if (error) {
            return res.send(error.message);
            //return res.status(500).json({ error: 'Internal server error' });
        }
        else {
            return res.status(200).json({status:"success"});
        }
    });
});

module.exports = router;