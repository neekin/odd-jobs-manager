import React from 'react'
import {Button } from 'antd'
function App() {
  return (
    <div className="App">
        <h1>Welcome to Odd Jobs Manager</h1>
        <Button type="primary" onClick={()=>{ window.location.href='/login' }}>Ant Design Button</Button>
    </div>
  );
}

export default App;
