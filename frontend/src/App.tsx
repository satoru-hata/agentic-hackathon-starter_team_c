import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Welcome from './components/Welcome';
import StatusList from './components/StatusList';

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Welcome />} />
        <Route path="/status" element={<StatusList />} />
      </Routes>
    </Router>
  );
}

export default App;
