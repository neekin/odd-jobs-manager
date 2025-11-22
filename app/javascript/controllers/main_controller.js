import { Controller } from "@hotwired/stimulus"
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from '../components/app';
import reportWebVitals from '../components/reportWebVitals';
// Connects to data-controller="react"
export default class extends Controller {
  connect() {
   const root = ReactDOM.createRoot(document.getElementById('app'));
    root.render(
      <React.StrictMode>
        <App />
      </React.StrictMode>
    );
    reportWebVitals();
  }
}
