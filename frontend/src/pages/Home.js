import React, { useState, useEffect } from 'react';
import axios from 'axios';
import ProductList from '../components/ProductList';

const Home = () => {
  const [items, setItems] = useState([]);
  const [searchQuery, setSearchQuery] = useState('');

  useEffect(() => {
    // Fetch all items from the API
    fetchItems();
  }, []);

  const fetchItems = () => {
    axios.get('http://localhost:4000/api/items')
      .then(response => {
        setItems(response.data);
      })
      .catch(error => {
        console.error('Error fetching items:', error);
      });
  };

  const handleSearch = () => {
    // Fetch items based on search query
    axios.get(`http://localhost:4000/api/items?search=${searchQuery}`)
      .then(response => {
        setItems(response.data);
      })
      .catch(error => {
        console.error('Error searching items:', error);
      });
  };

  const handleChange = (event) => {
    setSearchQuery(event.target.value);
  };

  return (
    <div>
      <ProductList items={items} />
    </div>
  );
};

export default Home;
