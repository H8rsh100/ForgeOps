import React from 'react';
import './App.css';
import DeployStatusPanel from './components/DeployStatusPanel';
import MetricsPanel from './components/MetricsPanel';

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

      <main style={{ marginTop: '2rem', display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1.5rem' }}>
        <DeployStatusPanel />
        <MetricsPanel />
      </main>
    </div>
  );
}

export default App;
