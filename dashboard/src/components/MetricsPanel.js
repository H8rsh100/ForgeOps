import React from 'react';

const mockMetrics = [
  { label: 'Cluster CPU Utilization', value: '14.8%', color: '#10b981', status: 'Optimal' },
  { label: 'Memory Limit Consumed', value: '46.2%', color: '#06b6d4', status: 'Optimal' },
  { label: 'Active Workload Pods', value: '12 / 12', color: '#8b5cf6', status: 'Healthy' },
  { label: 'OPA Policy Enforcement', value: 'Active', color: '#10b981', status: 'Enforcing' }
];

export default function MetricsPanel() {
  return (
    <div className="panel-card" style={{
      background: 'rgba(30, 41, 59, 0.75)',
      border: '1px solid rgba(255, 255, 255, 0.12)',
      borderRadius: '12px',
      padding: '1.5rem',
      backdropFilter: 'blur(12px)'
    }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.2rem' }}>
        <h3 style={{ margin: 0, color: '#8b5cf6', fontSize: '1.25rem' }}>
          📊 Cluster Telemetry (Prometheus)
        </h3>
        <span style={{ fontSize: '0.8rem', color: '#94a3b8' }}>Live Scrape: 15s</span>
      </div>
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(2, 1fr)', gap: '1rem' }}>
        {mockMetrics.map((m, idx) => (
          <div key={idx} style={{
            background: 'rgba(15, 23, 42, 0.65)',
            padding: '1rem',
            borderRadius: '8px',
            border: '1px solid rgba(255, 255, 255, 0.06)'
          }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: '0.8rem', color: '#94a3b8', marginBottom: '0.4rem' }}>
              <span>{m.label}</span>
              <span style={{ color: m.color, fontWeight: 600 }}>{m.status}</span>
            </div>
            <div style={{ fontSize: '1.6rem', fontWeight: 700, color: m.color }}>{m.value}</div>
          </div>
        ))}
      </div>
    </div>
  );
}
