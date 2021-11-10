import './App.css';
import MyRoutes from './elements/navigation/Router';
import React from "react";
import BookingsProvider from './context/BookingsContext';
import UserProvider from './context/UserContext';


function App() {
  return (
    <UserProvider>
      <BookingsProvider>
        <MyRoutes/>
      </BookingsProvider>
    </UserProvider>
  );
}

export default App;
