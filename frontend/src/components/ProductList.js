import React, { useState, useEffect } from 'react';
import axios from 'axios';

const ProductList = () => {
  const [items, setItems] = useState([]);

  useEffect(() => {
    // Fetch all items from the API
    axios.get('http://localhost:4000/api/items')
      .then(response => {
        setItems(response.data);
      })
      .catch(error => {
        console.error('Error fetching items:', error);
      });
  }, []);

  const handleAddToCart = (item) => {
    // Add item to cart logic
    console.log('Item added to cart:', item);
  };

  return (
    <div className="product-grid">
      {items.map(item => (
        <div key={item.item_id} className="product-item">
          <div className="description">{item.description}</div>
          <div className="stock">Stock: {item.stock}</div>
          <button onClick={() => handleAddToCart(item)}>Add to Cart</button>
        </div>
      ))}
    </div>
  );
};

export default ProductList;