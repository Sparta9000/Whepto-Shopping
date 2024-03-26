import React from 'react';
import { Link } from 'react-router-dom';
import Logo from './Logo';

const Navbar = () => {

  return (
    <nav className="navbar">
      <div className="left-section">
        <Link to="/" className="logo-link">
          <Logo />
        </Link>
      </div>
      <div className="middle-section">
        <input type="text" placeholder="Search..." className="search-bar" />
      </div>
      <div className="right-section">
        <ul>
          <li><Link to="/login">Login</Link></li>
          <li><Link to="/signup">Sign up</Link></li>
        </ul>
      </div>
    </nav>
  );
};

export default Navbar;
