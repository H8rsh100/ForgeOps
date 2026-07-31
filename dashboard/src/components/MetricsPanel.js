import React from 'react';

const mockMetrics = [
  { label: 'Cluster CPU Usage', value: '14.2%', color: '#10b981' },
  { label: 'Cluster Memory Usage', value: '48.5%', color: '#06b6d4' },
  { label: 'Active Pods', value: '12 / 12', color: '#8b5cf6' },
  { label: 'Prometheus Alerts', value: '0 Active', color: '#10b981' }
];

export default function MetricsPanel() {
  return (
    <div className="panel-card" style={{
      background: 'rgba(30, 41, 59, 0.7)',
      border: '1px solid rgba(255, 255, 255, 0.1)',
      borderRadius: '12px',
      padding: '1.5rem',
      backdropFilter: 'blur(10px)'
    }}>
      <h3 style={{ margin: '0 0 1rem 0', color: '#8b5cf6', fontSize: '1.2rem' }}>
        📊 Platform Telemetry & Metrics (Prometheus)
      </h3>
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(2, 1fr)', gap: '1rem' }}>
        {mockMetrics.map((m, idx) => (
          <div key={idx} style={{
            background: 'rgba(15, 23, 42, 0.6)',
            padding: '1rem',
            borderRadius: '8px',
            border: '1px solid rgba(255, 255, 255, 0.05)'
          }}>
            <div style={{ fontSize: '0.8rem', color: '#94a3b8', marginBottom: '0.4rem' }}>{m.label}</div>
            <div style={{ fontSize: '1.5rem', fontWeight: 700, color: m.color }}>{m.value}</div>
          </div>
        ))}
      </div>
    </div>
  );
}
