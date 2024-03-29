const express = require('express');
const router = express.Router();
const connection = require('./db');

router.get('/:id', (req, res) => {
    var id = req.params.id;
    connection.query('SELECT CartDetails.ID as "ItemId",CartDetails.Quantity as "CartQuan", CartID,ProductID,CartDetails.Status as "CartStatus",CategoryID,ProductName,Image, Products.Quantity,Price, Products.Description,Products.Status as "ProStatus" FROM CartDetails,Products WHERE CartDetails.ProductID = Products.ID AND CartID = ?', [id], (error, results) => {
        if (error) {
            //return res.send(error.message);
            return res.status(500).json({ error: 'Internal server error' });
        }
        else {
            return res.json(results);
        }
    });
});

router.get('/userOf/:id', (req, res) => {
    try {
        var id = req.params.id;
        connection.query('SELECT CartID FROM Carts WHERE UserID = ?;', [id], (error, results) => {
            if (error) {
                //return res.send(error.message);
                return res.status(500).json({ error: 'Internal server error' });
            }
            else if (results.length) {
                return res.status(200).json(results[0].CartID);
            }
            return res.status(404).json({ error: "Not found" });
        });
    } catch (E) {
        res.status(500).send("Error");
        console.log("Error")
    }
});

router.put('/:number', (req, res) => {
    try {
        var num = req.params.number;
        var { id } = req.body;
        connection.query('UPDATE `CartDetails` SET `Quantity` = ? WHERE (`ID` = ?);', [num, id], (error, results) => {
            if (error) {
                return res.send(error.message);
                //return res.status(500).json({ error: 'Internal server error' });
            }
            else {
                return res.status(200).json({ status: "success", num: num, id: id });
            }
        });
    } catch (E) {
        res.status(500).send("Error");
        console.log("Error");
    }
});

//create new Cart
router.post('/:userid', (req, res) => {
    var id = req.params.userid;
    getMaxidCart().then((rs) => {
        var idcart = rs + 1;
        connection.query('INSERT INTO `Carts` ( `UserID`, `Status`) VALUES ( ?, 1);', [id], (error, results) => {
            if (error) {
                //return res.send(error.message);
                return res.status(500).json({ error: 'Internal server error' });
            }
            return res.status(200).json({ results: "success" });
        });
    }).catch((err) => {
        var msg = err.message;
        res.status(500).json({ error: 'Internal server error' });
    });
});


router.post('/', (req, res) => {
    var id = req.body.idc;
    var idpro = req.body.idpro;
    var quan = req.body.quan;
    Promise.all([getMaxid(), isExist(idpro, id)]).then((results) => {
        console.log("=========>")
        if (results.length == 2 && !results[1]) {
            console.log("=========>thanh cong")
            return addItemCart(idpro, id, quan);
        } else if (results[1]) {
            console.log("=========>da tồn tại")
            res.status(400).json({ error: 'Đã tồn tại sản phẩm trong giỏ' });
        } else {
            console.log("=========>faile")
            res.status(500).json({ error: 'Internal server error' });
        }
    }).then((results) => {
        if (results) {
            console.log("=========>thanh cong222222")

            res.status(200).json({ status: "Success" });
        }
    }).catch((error) => {
        res.status(500).json({ error: 'Internal server error' });
    });
});

function addItemCart(idpro, idc, quan) {
    return new Promise((resolve, reject) => {
        console.log(idpro,idc,quan)
        
        connection.query('INSERT INTO `CartDetails` ( `CartID`, `ProductID`, `Quantity`, `Status`) VALUES ( ?, ?, ?, 1);', [ idc, idpro, quan, 1], (error, results) => {
            if (error) {
                reject('Internal server error');
            }
            else {
                resolve(true);
            }
        });
    })
}

function isExist(idpro, id) {
    return new Promise((resolve, reject) => {
        connection.query('SELECT ID FROM CartDetails where CartID =? AND ProductID = ?;', [id, idpro], (error, results) => {
            if (error) {
                reject('Internal server error');
            }
            else {
                var rs = results.length != 0 ? true : false;
                resolve(rs);
            }
        });
    })
}

function getMaxidCart() {
    return new Promise((resolve, reject) => {
        connection.query('SELECT max(CartID) as maxid FROM Carts;', (error, results) => {
            if (error) {
                //return res.send(error.message);
                reject('Internal server error');
            }
            else {
                var maxid = results[0].maxid ?? 0;
                resolve(maxid);
            }
        });
    });
}

function getMaxid() {
    return new Promise((resolve, reject) => {
        connection.query('SELECT max(ID) as maxid FROM CartDetails;', (error, results) => {
            if (error) {
                //return res.send(error.message);
                reject('Internal server error');
            }
            else {
                var maxid = results[0].maxid ?? 0;
                resolve(maxid);
            }
        });
    });
}

router.delete('/:id', (req, res) => {
    var id = req.params.id;
    connection.query('DELETE FROM `CartDetails` WHERE (`ID` = ?);', [id], (error, results) => {
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
    var { id } = req.body;
    connection.query('DELETE FROM `CartDetails` WHERE CartID = ?;', [id], (error, results) => {
        if (error) {
            return res.send(error.message);
            //return res.status(500).json({ error: 'Internal server error' });
        }
        else {
            return res.status(200).json({ status: "success" });
        }
    });
});

module.exports = router;