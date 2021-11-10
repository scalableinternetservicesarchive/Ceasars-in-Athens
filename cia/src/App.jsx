// eslint-disable-next-line
import logo from './logo.svg';
import './App.css';
import MyRoutes from './elements/navigation/Router';
import React from "react";
import BookingsProvider from './context/BookingsContext';


function App() {
  return (
    <BookingsProvider>
      <MyRoutes/>
    </BookingsProvider>
  );
}

export default App;
