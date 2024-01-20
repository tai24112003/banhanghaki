const express = require('express');
const cors = require('cors');
const ngrok = require('ngrok');;
const usersRoute = require('./api/users');
const addressesRoute = require('./api/addresses');
const oderRoute = require('./api/orders');
const orderDetailsRoute = require('./api/ordersdetail');
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
app.use('/api/users', usersRoute);
app.use('/api/addresses', addressesRoute);
app.use(oderRoute);
app.use(orderDetailsRoute);

app.use('/api/product', productsRoute);
