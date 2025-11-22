import { Controller } from "@hotwired/stimulus"
import React from 'react';
import ReactDOM from 'react-dom/client';
import LoginPage from '../components/login';
import reportWebVitals from '../components/reportWebVitals';
// Connects to data-controller="react"
export default class extends Controller {
  connect() {
   console.log("login controller connected");
   const root = ReactDOM.createRoot(this.element);
    root.render(
      <React.StrictMode>
        <LoginPage />
      </React.StrictMode>
    );
    reportWebVitals();
  }
}
