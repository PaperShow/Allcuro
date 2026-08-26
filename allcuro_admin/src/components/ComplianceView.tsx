import React from 'react';
import {
  ShieldAlert,
  Send,
} from 'lucide-react';
import { mockComplianceAlerts } from '../data/mockData';

export const ComplianceView: React.FC = () => {
  return (
    <div className="compliance-view-layout">
      <div className="view-header-row">
        <div>
          <h1 className="view-title">Compliance & Regulatory Expiry Tracker</h1>
          <p className="view-subtitle">
            12-Month re-verification reminders, expiring nursing licenses & automated suspension triggers
          </p>
        </div>
      </div>

      <div className="compliance-alerts-list">
        {mockComplianceAlerts.map((alert) => (
          <div
            key={alert.id}
            className={`compliance-alert-card ${
              alert.severity === 'Critical'
                ? 'border-red'
                : alert.severity === 'Warning'
                ? 'border-amber'
                : 'border-blue'
            }`}
          >
            <div className="alert-left-flex">
              <div
                className={`alert-icon-wrap ${
                  alert.severity === 'Critical'
                    ? 'icon-red'
                    : alert.severity === 'Warning'
                    ? 'icon-amber'
                    : 'icon-blue'
                }`}
              >
                <ShieldAlert size={22} />
              </div>

              <div>
                <div className="alert-item-title">{alert.itemTitle}</div>
                <div className="alert-provider-name">
                  {alert.providerName} ({alert.providerType})
                </div>
                <div className="alert-auto-action">
                  <strong>Automated Rule:</strong> {alert.autoAction}
                </div>
              </div>
            </div>

            <div className="alert-right-flex">
              <div className="expiry-countdown-box">
                <span className="days-number">{alert.daysRemaining} days</span>
                <span className="expiry-date-sub">Expires {alert.expiryDate}</span>
              </div>

              <button className="btn-send-renewal">
                <Send size={13} /> Dispatch Renewal SMS
              </button>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};
