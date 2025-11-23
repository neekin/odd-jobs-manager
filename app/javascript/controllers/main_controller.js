import { Controller } from "@hotwired/stimulus"
import React from 'react';
import ReactDOM from 'react-dom/client';
// import DashboardPage from '../components/dashboard';
import reportWebVitals from '../components/reportWebVitals';
// Connects to data-controller="react"
import { RouterProvider } from "react-router/dom";
import router from '../routes';

export default class extends Controller {
  connect() {
   const root = ReactDOM.createRoot(this.element);
    root.render(
      <React.StrictMode>
          <RouterProvider router={router} />
      </React.StrictMode>
    );
    reportWebVitals();
  }
}
