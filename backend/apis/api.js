const express = require('express');
const mysql = require('mysql2');

const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'root',
    database: 'whepto'
});

connection.connect((err) => {
    if (err) {
        console.log('Error connecting to Db');
        console.log(err.message);
        return;
    }
    else {
        console.log('MySQL Connection established');
    }
});

const router = express.Router();

router.get('/items', (req, res) => {
    connection.execute('SELECT * FROM item', (err, results, fields) => {
        if (err) {
            console.log(err.message);
            res.status(500).send('Internal Server Error');
            return;
        }
        res.status(200).json(results);
    });
});

router.get('/items/:id', (req, res) => {
    connection.execute('SELECT * FROM item WHERE item_id = ?', [req.params.id], (err, results, fields) => {
        if (err) {
            console.log(err.message);
            res.status(500).send('Internal Server Error');
            return;
        }
        if (results.length === 0) {
            res.status(404).send('Item not found');
            return;
        }
        res.status(200).json(results[0]);
    });
});

router.get('/items/search/:query', (req, res) => {
    connection.execute('SELECT * FROM item WHERE description LIKE ?', ['%' + req.params.query + '%'], (err, results, fields) => {
        if (err) {
            console.log(err.message);
            res.status(500).send('Internal Server Error');
            return;
        }
        res.status(200).json(results);
    });
});

router.post('/items', (req, res) => {
    let category = 1;
    connection.execute(
        'SELECT category_id FROM category WHERE name = ?', [req.body.category], (err, results, fields) => {
            if (err) {
                console.log(err.message);
                res.status(500).send('Internal Server Error');
                return;
            }
            category = results[0].category_id;
        }
    );
    connection.execute('INSERT INTO item (stock, price, description, image, category) VALUES (?, ?, ?, ?, ?)', [req.body.stock, req.body.price, req.body.description, req.body.image, category], (err, results, fields) => {
        if (err) {
            console.log(err.message);
            res.status(500).send('Internal Server Error');
            return;
        }
        res.status(201).send('Item added successfully');
    });
});

router.delete('/items/:id', (req, res) => {
    connection.execute('DELETE FROM item WHERE item_id = ?', [req.params.id], (err, results, fields) => {
        if (err) {
            console.log(err.message);
            res.status(500).send('Internal Server Error');
            return;
        }
        res.status(200).send('Item deleted successfully');
    });
});

router.patch('/items/:id', (req, res) => {
    let category = 1;
    connection.execute(
        'SELECT category_id FROM category WHERE name = ?', [req.body.category], (err, results, fields) => {
            if (err) {
                console.log(err.message);
                res.status(500).send('Internal Server Error');
                return;
            }
            category = results[0].category_id;
        }
    );
    connection.execute('UPDATE item SET stock = ?, price = ?, description = ?, image = ?, category = ? WHERE item_id = ?', [req.body.stock, req.body.price, req.body.description, req.body.image, category, req.params.id], (err, results, fields) => {
        if (err) {
            console.log(err.message);
            res.status(500).send('Internal Server Error');
            return;
        }
        res.status(200).send('Item updated successfully');
    });
});

router.patch('/items/:id/stock', (req, res) => {
    connection.execute('UPDATE item SET stock = ? WHERE item_id = ?', [req.body.stock, req.params.id], (err, results, fields) => {
        if (err) {
            console.log(err.message);
            res.status(500).send('Internal Server Error');
            return;
        }
        res.status(200).send('Stock updated successfully');
    });
});

router.patch('/items/:id/price', (req, res) => {
    connection.execute('UPDATE item SET price = ? WHERE item_id = ?', [req.body.price, req.params.id], (err, results, fields) => {
        if (err) {
            console.log(err.message);
            res.status(500).send('Internal Server Error');
            return;
        }
        res.status(200).send('Price updated successfully');
    });
});

router.post('/auth', (req, res) => {
    if (!req.body || !req.body.email || !req.body.password) {
        res.status(400).send('Bad Request');
        return;
    }
    connection.execute('SELECT * FROM customer WHERE email = ? AND password = ?', [req.body.email, req.body.password], (err, results, fields) => {
        if (err) {
            console.log(err.message);
            res.status(500).send('Internal Server Error');
            return;
        }
        if (results.length === 0) {
            res.status(401).send('Unauthorized');
            return;
        }
        res.status(200).json(results[0]);
    });
});

router.post('/auth/signup', (req, res) => {
    connection.execute('SELECT * FROM customer WHERE email = ?', [req.body.email], (err, results, fields) => {
        if (err) {
            console.log(err.message);
            res.status(500).send('Internal Server Error');
            return;
        }
        if (results.length !== 0) {
            res.status(409).send('User already exists');
            return;
        }
    });

    let cart_id = 1;

    connection.execute('INSERT INTO cart VALUES ()' , (err, results, fields) => {
        if (err) {
            console.log(err.message);
            res.status(500).send('Internal Server Error');
            return;
        }
        
        cart_id = results.insertId;

        if (!cart_id) {
            res.status(500).send('Internal Server Error');
            return;
        }

        connection.execute('INSERT INTO customer (first_name, last_name, email, password, cart) VALUES (?, ?, ?, ?, ?)', [req.body.first_name, req.body.last_name, req.body.email, req.body.password, cart_id], (err, results, fields) => {
            if (err) {
                console.log(err.message);
                res.status(500).send('Internal Server Error');
                return;
            }
            res.status(201).send('User added successfully');
        });
    });
});

router.get('/address/:id', (req, res) => {
    connection.execute('SELECT * FROM address WHERE customer = ?', [req.params.id], (err, results, fields) => {
        if (err) {
            console.log(err.message);
            res.status(500).send('Internal Server Error');
            return;
        }
        res.status(200).json(results);
    });
});

router.post('/address', (req, res) => {
    connection.execute('INSERT INTO address (customer, street1, street2, city, state, phone_number1, phone_number2) VALUES (?, ?, ?, ?, ?, ?, ?)', [req.body.customer, req.body.street1, req.body.street2, req.body.city, req.body.state, req.body.phone_number1, req.body.phone_number2], (err, results, fields) => {
        if (err) {
            console.log(err.message);
            res.status(500).send('Internal Server Error');
            return;
        }
        res.status(201).send('Address added successfully');
    });
});

router.delete('/address/:id', (req, res) => {
    connection.execute('DELETE FROM address WHERE address_id = ?', [req.params.id], (err, results, fields) => {
        if (err) {
            console.log(err.message);
            res.status(500).send('Internal Server Error');
            return;
        }
        res.status(200).send('Address deleted successfully');
    });
});

router.get('/cart/:id', (req, res) => {
    connection.execute('SELECT * FROM cart_item WHERE cart = ?', [req.params.id], (err, results, fields) => {
        if (err) {
            console.log(err.message);
            res.status(500).send('Internal Server Error');
            return;
        }
        res.status(200).json(results);
    });
});

router.post('/cart', (req, res) => {
    connection.execute('INSERT INTO cart_item (cart, item, quantity) VALUES (?, ?, ?)', [req.body.cart, req.body.item, req.body.quantity], (err, results, fields) => {
        if (err) {
            console.log(err.message);
            res.status(500).send('Internal Server Error');
            return;
        }
        res.status(201).send('Item added to cart successfully');
    });
});

router.delete('/cart/:id', (req, res) => {
    connection.execute('DELETE FROM cart_item WHERE cart_item_id = ? AND item = ?', [req.params.cart_id, req.params.item_id], (err, results, fields) => {
        if (err) {
            console.log(err.message);
            res.status(500).send('Internal Server Error');
            return;
        }
        res.status(200).send('Item deleted from cart successfully');
    });
});

router.patch('/cart/:id', (req, res) => {
    connection.execute('UPDATE cart_item SET quantity = ? WHERE cart = ? AND item = ?', [req.body.quantity, req.params.cart_id, req.params.item_id], (err, results, fields) => {
        if (err) {
            console.log(err.message);
            res.status(500).send('Internal Server Error');
            return;
        }
        res.status(200).send('Quantity updated successfully');
    });
});

router.get('/order/:id', (req, res) => {
    connection.execute('SELECT * FROM transaction WHERE customer_id = ?', [req.params.id], (err, results, fields) => {
        if (err) {
            console.log(err.message);
            res.status(500).send('Internal Server Error');
            return;
        }
        res.status(200).json(results);
    });
});

router.post('/order', (req, res) => {
    connection.execute('INSERT INTO transaction (status, customer_id, address_id, cart_id, coupon_id) VALUES (-1, ?, ?, ?, ?)', [req.body.customer_id, req.body.address_id, req.body.cart_id, req.body.coupon_id], (err, results, fields) => {
        if (err) {
            console.log(err.message);
            res.status(500).send('Internal Server Error');
            return;
        }

        res.status(201).send('Order placed successfully');
    });
});

router.patch('/order', (req, res) => {
    connection.execute('UPDATE transaction SET status = ? WHERE transaction_id = ?', [req.body.status, req.body.transaction_id], (err, results, fields) => {
        if (err) {
            console.log(err.message);
            res.status(500).send('Internal Server Error');
            return;
        }

        if (req.body.status == 1) {
            connection.execute('INSERT INTO cart VALUES ()' , (err, results, fields) => {
                if (err) {
                    console.log(err.message);
                    res.status(500).send('Internal Server Error');
                    return;
                }
                
                cart_id = results.insertId;
        
                if (!cart_id) {
                    res.status(500).send('Internal Server Error');
                    return;
                }
        
                connection.execute('UPDATE customer SET cart = ? WHERE customer_id = ?', [cart_id, req.body.customer_id], (err, results, fields) => {
                    if (err) {
                        console.log(err.message);
                        res.status(500).send('Internal Server Error');
                        return;
                    }
                });
            });
        }

        res.status(200).send('Order updated successfully');
    });
});

router.get('/coupon/:id', (req, res) => {
    connection.execute('SELECT * FROM coupon WHERE coupon_id = ?', [req.params.id], (err, results, fields) => {
        if (err) {
            console.log(err.message);
            res.status(500).send('Internal Server Error');
            return;
        }
        res.status(200).json(results[0]);
    });
});

module.exports = router;