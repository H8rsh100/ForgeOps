import React from 'react';

const mockDeployments = [
  { id: 1, name: 'api-service-dev', env: 'dev', sync: 'Synced', health: 'Healthy', revision: 'ae23848', updated: '2 mins ago' },
  { id: 2, name: 'worker-service-dev', env: 'dev', sync: 'Synced', health: 'Healthy', revision: 'ae23848', updated: '2 mins ago' },
  { id: 3, name: 'api-service-prod', env: 'prod', sync: 'Synced', health: 'Healthy', revision: 'v1.0.0', updated: '10 mins ago' },
  { id: 4, name: 'worker-service-prod', env: 'prod', sync: 'Synced', health: 'Healthy', revision: 'v1.0.0', updated: '10 mins ago' }
];

export default function DeployStatusPanel() {
  return (
    <div className="panel-card" style={{
      background: 'rgba(30, 41, 59, 0.7)',
      border: '1px solid rgba(255, 255, 255, 0.1)',
      borderRadius: '12px',
      padding: '1.5rem',
      backdropFilter: 'blur(10px)'
    }}>
      <h3 style={{ margin: '0 0 1rem 0', color: '#06b6d4', fontSize: '1.2rem' }}>
        🚀 GitOps Deployment Status (ArgoCD)
      </h3>
      <div style={{ display: 'grid', gap: '1rem' }}>
        {mockDeployments.map(app => (
          <div key={app.id} style={{
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center',
            background: 'rgba(15, 23, 42, 0.6)',
            padding: '0.8rem 1.2rem',
            borderRadius: '8px',
            border: '1px solid rgba(255, 255, 255, 0.05)'
          }}>
            <div>
              <div style={{ fontWeight: 600, color: '#f8fafc' }}>{app.name}</div>
              <div style={{ fontSize: '0.8rem', color: '#94a3b8' }}>Revision: {app.revision} • {app.updated}</div>
            </div>
            <div style={{ display: 'flex', gap: '0.5rem' }}>
              <span style={{
                background: 'rgba(16, 185, 129, 0.2)',
                color: '#10b981',
                padding: '0.2rem 0.6rem',
                borderRadius: '4px',
                fontSize: '0.75rem',
                fontWeight: 600
              }}>{app.sync}</span>
              <span style={{
                background: 'rgba(6, 182, 212, 0.2)',
                color: '#06b6d4',
                padding: '0.2rem 0.6rem',
                borderRadius: '4px',
                fontSize: '0.75rem',
                fontWeight: 600
              }}>{app.health}</span>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
