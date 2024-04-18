from flask import Flask, render_template, request, make_response, redirect
import mysql.connector
import requests

app = Flask(__name__)

con = mysql.connector.connect(
    host = "localhost",
    user = "root",
    password = "root",
    database = "whepto"
)

@app.route('/')
def index():
    if (request.cookies.get('loggedin')) == None:
        return redirect('/login')
    
    return render_template('index.html')

@app.route('/search', methods = ['GET'])
def search():
    search = request.args.get('search')
    with con.cursor() as cur:
        cur.execute('SELECT cart FROM customer WHERE customer_id = {}'.format(request.cookies.get('loggedin')))
        cart = cur.fetchone()[0]
    with con.cursor() as cur:
        if search == None or search == '':
            cur.execute('SELECT * FROM item LEFT OUTER JOIN (SELECT * FROM cart_items WHERE cart = {}) cart_p ON cart_p.item = item.item_id'.format(cart))
        else:
            cur.execute('SELECT * FROM item LEFT OUTER JOIN (SELECT * FROM cart_items WHERE cart = {}) cart_p ON cart_p.item = item.item_id WHERE item.description LIKE "%{}%"'.format(cart, search))
        products = cur.fetchall()
    return products

@app.route('/profile')
def profile():
    return render_template('profile.html')

@app.route('/user')
def user():
    with con.cursor() as cur:
        cur.execute('SELECT first_name, last_name FROM customer WHERE customer_id = {}'.format(request.cookies.get('loggedin')))
        name = {"name": " ".join(cur.fetchone())}
    return name

@app.route('/address', methods = ['GET'])
def address_get():
    with con.cursor() as cur:
        cur.execute('SELECT * FROM address WHERE customer = {}'.format(request.cookies.get('loggedin')))
        address = cur.fetchall()
    return address

@app.route('/address', methods = ['POST'])
def address_post():
    street1 = request.form['street1']
    street2 = request.form['street2']
    city = request.form['city']
    state = request.form['state']
    phone1 = request.form['phone1']
    phone2 = request.form['phone2']
    query = 'INSERT INTO address (street1, street2, city, state, phone_number1, phone_number2, customer) VALUES ("{}", '.format(street1)
    if street2 == '':
        query += 'NULL, '
    else:
        query += '"{}", '.format(street2)
    query += '"{}", "{}", "{}", '.format(city, state, phone1)
    if phone2 == '':
        query += 'NULL, '
    else:
        query += '"{}", '.format(phone2)

    query += '{})'.format(request.cookies.get('loggedin'))

    with con.cursor() as cur:
        cur.execute(query)
    con.commit()
    return 'Address added'

@app.route('/address', methods = ['DELETE'])
def address_delete():
    address_id = request.args.get('address')
    with con.cursor() as cur:
        cur.execute('UPDATE address SET customer=NULL WHERE address_id = {}'.format(address_id))
    con.commit()
    return 'Address deleted'

@app.route('/cart', methods = ['GET'])
def cart():
    return render_template('cart.html')

@app.route('/cart', methods = ['DELETE'])
def cart_delete():
    item = request.args.get('item')
    with con.cursor() as cur:
        cur.execute('SELECT cart FROM customer WHERE customer_id = {}'.format(request.cookies.get('loggedin')))
        cart = cur.fetchone()[0]
        cur.execute('DELETE FROM cart_items WHERE cart = {} AND item = {}'.format(cart, item))
        con.commit()
    return 'Item removed from cart'

@app.route('/cart/add', methods = ['POST'])
def add_to_cart():
    item = request.get_json().get('item')
    quantity = request.get_json().get('quantity')
    with con.cursor() as cur:
        cur.execute('SELECT cart FROM customer WHERE customer_id = {}'.format(request.cookies.get('loggedin')))
        cart = cur.fetchone()[0]
        cur.execute('INSERT INTO cart_items (cart, item, quantity) VALUES ({}, {}, {})'.format(cart, item, quantity))
        con.commit()
    return 'Added to cart'

@app.route('/cart/update', methods = ['POST'])
def update_cart():
    item = request.get_json().get('item')
    quantity = request.get_json().get('quantity')
    with con.cursor() as cur:
        cur.execute('SELECT cart FROM customer WHERE customer_id = {}'.format(request.cookies.get('loggedin')))
        cart = cur.fetchone()[0]
        cur.execute('UPDATE cart_items SET quantity = {} WHERE cart = {} AND item = {}'.format(quantity, cart, item))
        con.commit()
    return 'Cart updated'

@app.route('/cart/items', methods = ['GET'])
def cart_get():
    with con.cursor() as cur:
        cur.execute('SELECT * FROM cart_items JOIN item ON cart_items.item=item.item_id WHERE cart = (SELECT cart FROM customer WHERE customer_id = {})'.format(request.cookies.get('loggedin')))
        items = cur.fetchall()
    return items

@app.route('/order', methods = ['POST'])
def order():
    address_id = request.json.get('address')
    coupon = request.json.get('coupon')
    with con.cursor() as cur:
        cur.execute('SELECT cart FROM customer WHERE customer_id = {}'.format(request.cookies.get('loggedin')))
        cart = cur.fetchone()[0]
        if (coupon != None):
            cur.execute('INSERT INTO transaction (status, customer_id, address_id, cart_id, coupon_id) VALUES (-1, {}, {}, {}, {})'.format(request.cookies.get('loggedin'), address_id, cart, coupon))
        else:
            cur.execute('INSERT INTO transaction (status, customer_id, address_id, cart_id) VALUES (-1, {}, {}, {})'.format(request.cookies.get('loggedin'), address_id, cart))

        transaction_id = cur.lastrowid
    return [transaction_id]

@app.route('/order/complete', methods = ['POST'])
def order_complete():
    transaction_id = request.json.get('transaction')
    complete = request.json.get('complete')
    with con.cursor() as cur:
        cur.execute('UPDATE transaction SET status = {} WHERE transaction_id = {}'.format(complete, transaction_id))
    con.commit()
    return 'updated'

@app.route('/order', methods = ['GET'])
def order_get():
    orderId = request.args.get('order')
    if not orderId:
        with con.cursor() as cur:
            cur.execute('SELECT * FROM transaction JOIN address ON transaction.address_id=address.address_id WHERE customer_id = {} ORDER BY timestamp DESC'.format(request.cookies.get('loggedin')))
            orders = cur.fetchall()
        return orders
    
    with con.cursor() as cur:
        cur.execute('SELECT * FROM transaction WHERE transaction_id = {}'.format(orderId))
        order = cur.fetchone()
        cart = order[5]
        cur.execute('SELECT * FROM cart_items JOIN item ON cart_items.item=item.item_id WHERE cart = {}'.format(cart))
        details = cur.fetchall()
        return details

@app.route('/coupon', methods = ['GET'])
def coupon():
    couponCode = request.args.get('code')
    with con.cursor() as cur:
        cur.execute('SELECT * FROM coupon WHERE coupon_code = "{}"'.format(couponCode))
        coupon = cur.fetchall()

    print(coupon)
    if coupon:
        return coupon
    return "Coupon not found", 404

@app.route('/login', methods = ['GET'])
def login():
    return render_template('login.html')

@app.route('/login', methods = ['POST'])
def login_post():
    username = request.form['username']
    password = request.form['password']

    with con.cursor() as cur:
        cur.execute('SELECT * FROM customer WHERE email = "{}" AND password = "{}"'.format(username, password))
        user = cur.fetchone()
        if user:
            response = make_response(redirect('/'))
            response.set_cookie('loggedin', str(user[0]))
        else:
            response = render_template('login.html', error='Invalid username or password')

    return response

@app.route('/signup', methods = ['GET'])
def signup():
    return render_template('signup.html')

@app.route('/signup', methods = ['POST'])
def signup_post():
    firstname = request.form['first-name']
    lastname = request.form['last-name']
    email = request.form['email']
    password = request.form['password']
    confirm_password = request.form['confirm-password']

    if password != confirm_password:
        return render_template('signup.html', error='Passwords do not match')
    
    with con.cursor() as cur:
    
        cur.execute('INSERT INTO customer (first_name, last_name, email, password) VALUES ("{}", "{}", "{}", "{}")'.format(firstname, lastname, email, password))

        con.commit()

    response = make_response(redirect('/'))
    response.set_cookie('loggedin', str(cur.lastrowid))

    return response

@app.route('/logout')
def logout():
    response = make_response(redirect('/'))
    response.set_cookie('loggedin', '', expires=0)
    return response

if __name__ == '__main__':
    app.run(debug=True)