const express = require('express');
const cors = require('cors');
const ngrok = require('ngrok');;
const usersRoute = require('./api/users');
const productsRoute = require('./api/products');

const PORT = process.env.PORT || 3000;
const app = express();
app.use(cors({ origin: '*' }));
app.use(express.json());
app.listen(PORT, async () => {
    console.log(`Server is running on port ${PORT}`);
    const ngrokUrl = await ngrok.connect(PORT);
    console.log(`Ngrok tunnel at: ${ngrokUrl}`)
});
app.use('/users', usersRoute);
app.use('/api/product', productsRoute);
