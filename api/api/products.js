const express = require('express');
const router = express.Router();
const connection = require('./db');
const bcrypt = require('bcrypt');
const fs = require('fs');

router.get('/:idCategory', function (req, res) {
  const idCategory = req.params.idCategory;
  const query = 'SELECT * FROM products WHERE CategoryID = ? AND status = 1';
  connection.query(query, [idCategory], (err, rows, fields) => {
    if (err) {
      console.error('Error executing query:', err);
      res.status(500).json({ error: 'Internal Server Error' });
    } else {
      res.json(rows);
    }
  });
});
router.get('/pro/:id', function (req, res) {
  const productId = req.params.id;
  const query = `SELECT * FROM products WHERE ID = ${productId}`;
  console.log(productId);
  connection.query(query, (err, rows, fields) => {
    if (err) {
      console.error('Error executing query:', err);
      res.status(500).json({ error: 'Internal Server Error' });
    } else if (rows.length === 0) {
      res.status(404).json({ error: 'Product not found' });
    } else {
      console.log(rows[0]);
      res.json(rows[0]);
    }
  });
});
router.post('/add_Product', (req, res) => {
  const product = req.body;
  const image = req.body.Image; // Assuming the image is sent as a base64 string

  // Convert base64 string to buffer
  const imageBuffer = Buffer.from(image, 'base64');

  // Save image to a file (optional, you can directly insert into the database)
  fs.writeFileSync('image.jpg', imageBuffer);

  const query = `INSERT INTO products (ID, CategoryID, ProductName, Image, Quantity, Price, Description, Status)
                     VALUES (?, ?, ?, ?, ?, ?, ?, 1)`;

  connection.query(
    query,
    [
      product.ID,
      product.CategoryID,
      product.ProductName,
      imageBuffer, // Use the image buffer
      product.Quantity,
      product.Price,
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
router.put('/update/:id', (req, res) => {
  const id = req.params.id;
  const updatedProduct = req.body;
  const updatedImage = req.body.Image; // Assuming the image is sent as a base64 string

  // Convert base64 string to buffer
  const imageBuffer = Buffer.from(updatedImage, 'base64');

  // Save image to a file (optional, you can directly update in the database)
  fs.writeFileSync('updated_image.jpg', imageBuffer);

  const query = `UPDATE products SET CategoryID = ?, ProductName = ?, Image = ?, Quantity = ?, Price = ?, Description = ?, Status = 1
                     WHERE ID = ?`;

  connection.query(
    query,
    [
      updatedProduct.CategoryID,
      updatedProduct.ProductName,
      imageBuffer, // Use the updated image buffer
      updatedProduct.Quantity,
      updatedProduct.Price,
      updatedProduct.Description,
      id,
    ],
    (error, results, fields) => {
      if (error) {
        console.error('Lỗi cập nhật sản phẩm: ', error);
        res.status(500).json({ error: 'Lỗi cập nhật sản phẩm' });
        return;
      }

      console.log('Sản phẩm đã được cập nhật thành công');
      res.status(200).json({ message: 'Sản phẩm đã được cập nhật thành công' });
    }
  );
});
router.put('/delete/:id', (req, res) => {
  const id = req.params.id;
  const updatedProduct = req.body;

  const query = `UPDATE products SET  Status = 0
                       WHERE ID = ${id}`;

  connection.query(
    query,
    [
    ],
    (error, results, fields) => {
      if (error) {
        console.error('Lỗi xóa sản phẩm: ', error);
        res.status(500).json({ error: 'Lỗi cập nhật sản phẩm' });
        return;
      }

      console.log('Sản phẩm đã được xóa thành công');
      res.status(200).json({ message: 'Sản phẩm đã được xóa thành công' });
    }
  );
});


module.exports = router;