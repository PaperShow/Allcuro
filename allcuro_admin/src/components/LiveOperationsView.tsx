import React, { useState } from 'react';
import {
  AlertOctagon,
  PhoneCall,
  MapPin,
  Clock,
  UserCheck,
  RefreshCw,
  CheckCircle2,
} from 'lucide-react';
import { mockLiveShifts } from '../data/mockData';
import type { LiveBookingShift } from '../types/admin';

export const LiveOperationsView: React.FC = () => {
  const [shifts, setShifts] = useState<LiveBookingShift[]>(mockLiveShifts);
  const [activeSOS, setActiveSOS] = useState<boolean>(true);
  const [toastMsg, setToastMsg] = useState<string | null>(null);

  const handleResolveSOS = (id: string) => {
    setShifts((prev) =>
      prev.map((s) => (s.id === id ? { ...s, status: 'On-Duty' } : s))
    );
    setActiveSOS(false);
    showToast('Emergency SOS marked as RESOLVED after ALLCURO Ops contact.');
  };

  const handleReassign = (id: string) => {
    showToast(`Dispatched nearby backup ICU nurse for ${id}. Estimated arrival: 14 mins.`);
  };

  const showToast = (msg: string) => {
    setToastMsg(msg);
    setTimeout(() => setToastMsg(null), 4000);
  };

  return (
    <div className="live-ops-layout">
      {toastMsg && (
        <div className="success-toast-banner">
          <CheckCircle2 size={16} />
          <span>{toastMsg}</span>
        </div>
      )}

      {/* Emergency SOS High-Priority Alert Banner (Blueprint Section 04/06) */}
      {activeSOS && (
        <div className="sos-emergency-banner">
          <div className="sos-pulse-icon">
            <AlertOctagon size={24} />
          </div>
          <div className="sos-banner-content">
            <div className="sos-banner-title">
              LIVE SOS ALERT TRIGGERED · BK-78902 (HSR Layout Sector 7)
            </div>
            <div className="sos-banner-desc">
              Nurse Joel Mathew triggered in-app SOS during 24hr critical shift for Mr. Ramanathan (Age 84).
              Tracheostomy emergency protocol initiated.
            </div>
          </div>
          <div className="sos-banner-actions">
            <button
              className="btn-call-ops"
              onClick={() => showToast('Connecting direct masked bridge call to Nurse Joel Mathew...')}
            >
              <PhoneCall size={14} /> Call Nurse & Family
            </button>
            <button
              className="btn-resolve-sos"
              onClick={() => handleResolveSOS('BK-78902')}
            >
              Mark Resolved
            </button>
          </div>
        </div>
      )}

      <div className="view-header-row">
        <div>
          <h1 className="view-title">Live Booking Operations & Shift Dispatch</h1>
          <p className="view-subtitle">
            Real-time GPS geofenced check-ins, active in-home care shifts, and panic monitoring
          </p>
        </div>

        <div className="live-pulse-badge">
          <span className="live-dot" />
          <span>842 Active Shifts Across 4 Cities</span>
        </div>
      </div>

      {/* Shifts Feed */}
      <div className="shifts-feed-grid">
        {shifts.map((shift) => (
          <div
            key={shift.id}
            className={`shift-card-box ${shift.status === 'SOS Alert' ? 'sos-card' : ''}`}
          >
            <div className="shift-card-header">
              <div className="shift-id-tag">{shift.id}</div>
              <span
                className={`shift-status-pill ${
                  shift.status === 'On-Duty'
                    ? 'status-onduty'
                    : shift.status === 'SOS Alert'
                    ? 'status-sos'
                    : 'status-enroute'
                }`}
              >
                {shift.status}
              </span>
            </div>

            <div className="shift-patient-info">
              <h3 className="patient-name">{shift.patientName}</h3>
              <div className="patient-address">
                <MapPin size={14} className="icon-sub" />
                <span>{shift.patientAddress}</span>
              </div>
            </div>

            <div className="shift-service-pill">
              <span>{shift.serviceType}</span>
            </div>

            <div className="shift-provider-row">
              <div className="provider-avatar">
                <UserCheck size={16} />
              </div>
              <div>
                <div className="provider-name">{shift.providerName}</div>
                <div className="provider-timing">
                  <Clock size={12} /> {shift.shiftTime}
                </div>
              </div>
            </div>

            <div className="shift-gps-checkin-box">
              <div className="gps-status-text">
                <strong>GPS Status:</strong> {shift.gpsCheckIn}
              </div>
              <div className="emergency-contact-text">
                <strong>Emergency Family:</strong> {shift.emergencyContact}
              </div>
            </div>

            <div className="shift-footer-actions">
              <span className="shift-amount">₹{shift.amount.toLocaleString()}</span>
              <div className="shift-action-btns">
                <button
                  className="btn-sm-outline"
                  onClick={() => handleReassign(shift.id)}
                  title="Auto-assign backup nurse"
                >
                  <RefreshCw size={13} /> Re-assign
                </button>
                <button
                  className="btn-sm-primary"
                  onClick={() => showToast(`Calling ${shift.providerName}...`)}
                >
                  <PhoneCall size={13} /> Call
                </button>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};
