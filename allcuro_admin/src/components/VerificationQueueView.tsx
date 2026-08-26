import React, { useState } from 'react';
import {
  ShieldCheck,
  CheckCircle2,
  FileText,
  Building2,
  UserCheck,
  Eye,
  Calendar,
  Send,
} from 'lucide-react';
import { mockVerifications } from '../data/mockData';
import type { VerificationItem } from '../types/admin';

export const VerificationQueueView: React.FC = () => {
  const [items, setItems] = useState<VerificationItem[]>(mockVerifications);
  const [selectedItem, setSelectedItem] = useState<VerificationItem | null>(mockVerifications[0]);
  const [filterType, setFilterType] = useState<string>('All');
  const [notificationMsg, setNotificationMsg] = useState<string | null>(null);

  const filteredItems = items.filter((item) => {
    if (filterType === 'All') return true;
    if (filterType === 'Nurses') return item.type === 'Nurse';
    if (filterType === 'Centres') return item.type === 'Home Care Centre';
    return true;
  });

  const handleApprove = (id: string) => {
    setItems((prev) =>
      prev.map((it) => (it.id === id ? { ...it, status: 'Verified' } : it))
    );
    if (selectedItem?.id === id) {
      setSelectedItem((prev) => (prev ? { ...prev, status: 'Verified' } : null));
    }
    showToast(`Approved ${selectedItem?.applicantName}. Profile is now Verified & Live!`);
  };

  const handleScheduleVisit = (id: string) => {
    setItems((prev) =>
      prev.map((it) => (it.id === id ? { ...it, status: 'Site-Visit Scheduled' } : it))
    );
    if (selectedItem?.id === id) {
      setSelectedItem((prev) => (prev ? { ...prev, status: 'Site-Visit Scheduled' } : null));
    }
    showToast(`Physical Field Audit Scheduled for ${selectedItem?.applicantName}.`);
  };

  const handleRequestInfo = () => {
    showToast(`SMS & In-App Notification dispatched to applicant for document re-upload.`);
  };

  const showToast = (msg: string) => {
    setNotificationMsg(msg);
    setTimeout(() => setNotificationMsg(null), 4000);
  };

  return (
    <div className="verification-view-layout">
      {/* Top Action Notification Banner */}
      {notificationMsg && (
        <div className="success-toast-banner">
          <CheckCircle2 size={16} />
          <span>{notificationMsg}</span>
        </div>
      )}

      <div className="view-header-row">
        <div>
          <h1 className="view-title">Unified KYC & Verification Queue</h1>
          <p className="view-subtitle">
            Mandatory legitimacy filter before care providers & centre beds go live to customers
          </p>
        </div>

        {/* Filters */}
        <div className="filter-pill-group">
          <button
            className={`pill-btn ${filterType === 'All' ? 'active' : ''}`}
            onClick={() => setFilterType('All')}
          >
            All Pending ({items.length})
          </button>
          <button
            className={`pill-btn ${filterType === 'Nurses' ? 'active' : ''}`}
            onClick={() => setFilterType('Nurses')}
          >
            Nurses & Attendants
          </button>
          <button
            className={`pill-btn ${filterType === 'Centres' ? 'active' : ''}`}
            onClick={() => setFilterType('Centres')}
          >
            Home Care Centres
          </button>
        </div>
      </div>

      <div className="verification-split-grid">
        {/* Left Table: Pending Applications */}
        <div className="verification-list-box">
          <div className="box-header-title">
            <span>Pending Provider KYC Inbox</span>
            <span className="count-tag">{filteredItems.length} active</span>
          </div>

          <div className="verification-cards-list">
            {filteredItems.map((item) => {
              const isSelected = selectedItem?.id === item.id;
              return (
                <div
                  key={item.id}
                  className={`verification-inbox-card ${isSelected ? 'selected' : ''}`}
                  onClick={() => setSelectedItem(item)}
                >
                  <div className="card-top-flex">
                    <div className="applicant-avatar-wrap">
                      {item.type === 'Nurse' ? (
                        <div className="avatar-icon nurse-bg">
                          <UserCheck size={16} />
                        </div>
                      ) : (
                        <div className="avatar-icon centre-bg">
                          <Building2 size={16} />
                        </div>
                      )}
                      <div>
                        <div className="applicant-name">{item.applicantName}</div>
                        <div className="applicant-cat">{item.category}</div>
                      </div>
                    </div>

                    <span
                      className={`status-pill ${
                        item.status === 'Verified'
                          ? 'status-verified'
                          : item.status === 'Site-Visit Scheduled'
                          ? 'status-visit'
                          : item.status === 'Action Required'
                          ? 'status-flagged'
                          : 'status-pending'
                      }`}
                    >
                      {item.status}
                    </span>
                  </div>

                  <div className="card-mid-meta">
                    <span>📍 {item.city}</span>
                    <span>• {item.experienceOrBeds}</span>
                  </div>

                  <div className="card-bot-meta">
                    <span>Applied: {item.appliedDate}</span>
                    <span className="risk-tag">Risk: {item.riskScore}</span>
                  </div>
                </div>
              );
            })}
          </div>
        </div>

        {/* Right Drawer: Inspection & Document Viewer */}
        {selectedItem ? (
          <div className="verification-detail-drawer">
            <div className="drawer-header-row">
              <div>
                <span className="drawer-id-badge">{selectedItem.id}</span>
                <h2 className="drawer-title">{selectedItem.applicantName}</h2>
                <span className="drawer-meta-sub">
                  {selectedItem.type} · {selectedItem.city} · {selectedItem.phone}
                </span>
              </div>

              <div className="drawer-actions-top">
                <button
                  className="btn-outline-action"
                  onClick={handleRequestInfo}
                  title="Request Document Re-upload"
                >
                  <Send size={14} /> Request Info
                </button>
                {selectedItem.type === 'Home Care Centre' && (
                  <button
                    className="btn-visit-action"
                    onClick={() => handleScheduleVisit(selectedItem.id)}
                  >
                    <Calendar size={14} /> Schedule Field Visit
                  </button>
                )}
                <button
                  className="btn-approve-action"
                  onClick={() => handleApprove(selectedItem.id)}
                >
                  <CheckCircle2 size={15} /> Approve & Go Live
                </button>
              </div>
            </div>

            {/* Checklist Overview */}
            <div className="doc-checklist-section">
              <h3 className="section-subtitle">
                Mandatory Regulatory Documents & Trust Signals (
                {selectedItem.documents.filter((d) => d.status === 'Verified').length}/
                {selectedItem.documents.length} Passed)
              </h3>

              <div className="documents-grid">
                {selectedItem.documents.map((doc, idx) => (
                  <div key={idx} className="doc-item-card">
                    <div className="doc-left-flex">
                      <div className="doc-icon-circ">
                        <FileText size={16} />
                      </div>
                      <div>
                        <div className="doc-title">{doc.name}</div>
                        <div className="doc-type-code">{doc.type}</div>
                      </div>
                    </div>

                    <div className="doc-right-flex">
                      <span
                        className={`doc-status-badge ${
                          doc.status === 'Verified'
                            ? 'doc-pass'
                            : doc.status === 'Flagged'
                            ? 'doc-fail'
                            : 'doc-review'
                        }`}
                      >
                        {doc.status}
                      </span>
                      <button className="doc-view-btn" title="Inspect Document">
                        <Eye size={14} /> View
                      </button>
                    </div>
                  </div>
                ))}
              </div>
            </div>

            {/* Legitimacy Audit Criteria (from Blueprint) */}
            <div className="audit-criteria-box">
              <div className="audit-criteria-header">
                <ShieldCheck size={16} className="text-emerald-700" />
                <span>ALLCURO Three-Tier Legitimacy Checklist</span>
              </div>
              <ul className="audit-checklist-bullets">
                <li>
                  <strong>Police Verification API:</strong> Mandatory background clearance check completed.
                </li>
                <li>
                  <strong>Nursing Council / CEA License:</strong> Registration verified against state medical registry.
                </li>
                <li>
                  <strong>Biomedical Waste Authorisation:</strong> Certified clearance for sharps & contaminated clinical waste handling.
                </li>
                <li>
                  <strong>Physical On-Site Audit:</strong> Photos & room capacity verified by ALLCURO city operations officer.
                </li>
              </ul>
            </div>

            {/* Audit Trail Log */}
            <div className="audit-trail-log">
              <h4 className="log-title">Verification Audit Trail</h4>
              <div className="log-timeline">
                <div className="log-event">
                  <span className="log-dot" />
                  <span className="log-time">10:14 AM Today</span>
                  <span className="log-text">
                    Aadhaar face-match verified by automated vision API (98.4% confidence).
                  </span>
                </div>
                <div className="log-event">
                  <span className="log-dot" />
                  <span className="log-time">Yesterday</span>
                  <span className="log-text">
                    Bangalore City Police third-party API returned clean record.
                  </span>
                </div>
                <div className="log-event">
                  <span className="log-dot" />
                  <span className="log-time">16 Aug 2026</span>
                  <span className="log-text">
                    Applicant submitted sign-up form and uploaded registration certificates.
                  </span>
                </div>
              </div>
            </div>
          </div>
        ) : null}
      </div>
    </div>
  );
};
