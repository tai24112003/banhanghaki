const express = require('express');
const cors = require('cors');
const http = require('http');
const socketIo = require('socket.io');
const ngrok = require('ngrok');
const db = require('./api/db');
const usersRoute = require('./api/users');
const addressesRoute = require('./api/addresses');
const oderRoute = require('./api/orders');
const orderDetailsRoute = require('./api/ordersdetail');
const productsRoute = require('./api/products');
const cartsRoute = require('./api/carts');
const accountRoute = require('./api/account');
const notificationsRoute = require('./api/notifications');
const historysRoute = require('./api/historysearch');

const message = require('./api/message');



const app = express();
const server = http.createServer(app);
const io = socketIo(server);

var adMin = null;
var clientUsers = [];

app.use((req, res, next) => {
    req.db = db;
    next();
});

io.on('connection', (socket) => {
    console.log('Client connected:', socket.id);

    // Xử lý khi nhận tin nhắn từ client
    socket.on('message', async (data) => {
        try {
            // Sử dụng đối tượng kết nối từ middleware (đã thêm vào từ app.use((req, res, next) => ...))
            db.query('INSERT INTO `Messages` (`FromID`, `MessageText`, `ToID`) VALUES (?, ?, ?);', [data["from"], data["content"], data["to"]], (error, results) => {
                if (error) {
                    //return res.send(error.message);
                    console.error('Lỗi khi lưu tin nhắn vào cơ sở dữ liệu:', error.message);
                }
                else {
                    console.log('Tin nhắn đã được lưu vào cơ sở dữ liệu:', results);
                    let toUser = clientUsers.filter((user) => {
                        return user["from"] == data["to"];
                    })
                    console.log(toUser.length);
                    if (toUser.length != 0) {
                        toUser[0]["instance"].emit('message', { content: data });
                    }
                }
            });
        } catch (error) {
            console.error('Lỗi khi lưu tin nhắn vào cơ sở dữ liệu:', error.message);
        }
        console.log('Message from client:', data);


        //   console.log(toUser);
        // Gửi lại tin nhắn cho tất cả các client (bao gồm cả người gửi)
        //   if(adMin){
        //     adMin.emit('message', { content: data });
        //     let fr = data["from"];
        //     if(socket != adMin){
        //         clientUsers.push({"from":fr,"instance": socket})
        //     }
        //   }
        //   let toSocket = clientUsers.filter((e)=>{
        //     return e["from"] == data["to"];
        //   });
        //   if(toSocket.length > 0) {
        //     console.log(socket[0]["instance"]);
        //   }
        //   socket.emit('message', { content: data });
    });

    socket.on('admin', (data) => {
        console.log(data);
        console.log("admin");
        clientUsers.unshift({ "from": data["from"], "instance": socket });
    });
    socket.on('client', (data) => {
        console.log(data);
        console.log("client");
        clientUsers.push({ "from": data["from"], "instance": socket });
    });

    // Xử lý khi client ngắt kết nối
    socket.on('disconnect', () => {
        console.log("disconnect");
        clientUsers = clientUsers.filter((user) => {
            return user["instance"] != socket;
        })

    });
});

const PORT = 3000;

app.use(cors({ origin: '*' }));
app.use(express.json());
server.listen(PORT, async () => {
    console.log(`Server is running on port ${PORT}`);
    const ngrokUrl = await ngrok.connect(PORT);
    console.log(`Ngrok tunnel at: ${ngrokUrl}`)
});
app.use('/api/users', usersRoute);
app.use('/api/addresses', addressesRoute);
app.use(oderRoute);
app.use(orderDetailsRoute);

app.use('/api/product', productsRoute);
app.use(oderRoute);
app.use(orderDetailsRoute);
app.use('/cart', cartsRoute);
app.use('/account', accountRoute);
app.use('/api/notifications', notificationsRoute);
app.use('/api/history', historysRoute);

app.use('/message', message);
