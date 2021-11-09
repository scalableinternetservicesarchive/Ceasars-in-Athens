import logo from './logo.svg';
import './App.css';
import myRoutes from './pieces/Router';
import React from "react";
import {
  BrowserRouter as Router,
  Switch,
  Route,
  Link
} from "react-router-dom";

function App() {
  return (
    <>
      <myRoutes />
      <h1>Hello</h1>
    </>
  );
}

export default App;
