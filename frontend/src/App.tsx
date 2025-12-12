import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Welcome from './components/Welcome';
import Register from './components/Register';
import ProfileRegistration from './components/ProfileRegistration';

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Welcome />} />
        <Route path="/register" element={<Register />} />
        <Route path="/profile" element={<ProfileRegistration />} />
      </Routes>
    </Router>
  );
}

export default App;
