const express = require('express');
const cors = require('cors');
// const ngrok = require('ngrok');
const usersRoute = require('./api/users');
const oderRoute = require('./api/orders');
const orderDetailsRoute=require('./api/ordersdetail');
const cartsRoute = require('./api/carts');
const accountRoute = require('./api/account');

const PORT = 3000;
const app = express();
app.use(cors({ origin: '*' }));
app.use(express.json());
app.listen(PORT, async () => {
    console.log(`Server is running on port ${PORT}`);
    // const ngrokUrl = await ngrok.connect(PORT);
    // console.log(`Ngrok tunnel at: ${ngrokUrl}`)
});
app.use('/users', usersRoute);
app.use(oderRoute);
app.use(orderDetailsRoute);
app.use('/cart',cartsRoute);
app.use('/account',accountRoute);
