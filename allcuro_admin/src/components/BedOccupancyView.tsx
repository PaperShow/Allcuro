import React from 'react';
import {
  Users,
  ShieldCheck,
  CheckCircle2,
  AlertCircle,
  Calendar,
} from 'lucide-react';
import { mockBedCentres } from '../data/mockData';

export const BedOccupancyView: React.FC = () => {
  return (
    <div className="bed-occupancy-layout">
      <div className="view-header-row">
        <div>
          <h1 className="view-title">Care Centres & Bed Occupancy Matrix</h1>
          <p className="view-subtitle">
            Live bed inventory, verified staff-to-patient ratios & field audit compliance
          </p>
        </div>

        <div className="bed-summary-pill">
          <span>Overall Occupancy: 1,890 / 2,240 Beds (84.3%)</span>
        </div>
      </div>

      <div className="centres-matrix-grid">
        {mockBedCentres.map((centre) => {
          const occupancyPct = Math.round(
            (centre.occupiedBeds / centre.totalBeds) * 100
          );
          return (
            <div key={centre.id} className="centre-matrix-card">
              <div className="matrix-top-row">
                <div>
                  <span className="centre-id">{centre.id}</span>
                  <h3 className="centre-name">{centre.name}</h3>
                  <span className="centre-locality">
                    📍 {centre.locality}, {centre.city}
                  </span>
                </div>

                <div className="price-tag-wrap">
                  <span className="price-bold">₹{centre.pricePerDay.toLocaleString()}</span>
                  <span className="price-sub">/ day starting</span>
                </div>
              </div>

              {/* Bed Occupancy Visual Progress Bar */}
              <div className="occupancy-progress-section">
                <div className="progress-labels-row">
                  <span className="occ-label">Occupancy Status</span>
                  <span className="occ-pct">
                    {centre.occupiedBeds} / {centre.totalBeds} Beds ({occupancyPct}%)
                  </span>
                </div>
                <div className="progress-track">
                  <div
                    className="progress-fill"
                    style={{ width: `${occupancyPct}%` }}
                  />
                </div>
                <div className="available-beds-pill">
                  {centre.availableBeds > 0 ? (
                    <span className="text-emerald-700 font-semibold">
                      ● {centre.availableBeds} beds currently vacant for admission
                    </span>
                  ) : (
                    <span className="text-rose-600 font-semibold">● 100% Full (Waitlist Only)</span>
                  )}
                </div>
              </div>

              {/* Legitimacy & Trust Signals (Staff ratio, fire NOC, waste management) */}
              <div className="centre-trust-meta-grid">
                <div className="trust-cell">
                  <Users size={14} className="icon-emerald" />
                  <div>
                    <div className="trust-title">Staff Ratio</div>
                    <div className="trust-val">{centre.staffToPatientRatio}</div>
                  </div>
                </div>

                <div className="trust-cell">
                  <ShieldCheck size={14} className="icon-emerald" />
                  <div>
                    <div className="trust-title">Field Audit</div>
                    <div className="trust-val">
                      {centre.fieldAuditStatus === 'Passed' ? 'Inspected & Live' : 'Renewal Due'}
                    </div>
                  </div>
                </div>

                <div className="trust-cell">
                  <CheckCircle2 size={14} className="icon-emerald" />
                  <div>
                    <div className="trust-title">Biomedical Waste</div>
                    <div className="trust-val">PCB Clearance Active</div>
                  </div>
                </div>

                <div className="trust-cell">
                  <AlertCircle size={14} className="icon-amber" />
                  <div>
                    <div className="trust-title">Fire NOC Expiry</div>
                    <div className="trust-val">{centre.fireNocExpiry}</div>
                  </div>
                </div>
              </div>

              {/* Bottom Actions */}
              <div className="centre-card-bottom-actions">
                <button className="btn-manage-beds">
                  <Calendar size={13} /> View Bed Layout
                </button>
                <button className="btn-audit-report">
                  View Field Audit Photos
                </button>
              </div>
            </div>
          );
        })}
      </div>
    </div>
  );
};
