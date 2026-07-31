import React from 'react';
import './App.css';
import DeployStatusPanel from './components/DeployStatusPanel';

function App() {
  return (
    <div className="dashboard-container">
      <header className="header">
        <div className="header-title">
          <h1>ForgeOps Developer Platform</h1>
          <p>Self-Hosted Internal Developer Platform (IDP) Operational Control Plane</p>
        </div>
        <div className="status-badge">
          <span className="badge-dot"></span>
          Cluster Active (Kind)
        </div>
      </header>

      <main style={{ marginTop: '2rem' }}>
        <DeployStatusPanel />
      </main>
    </div>
  );
}

export default App;
