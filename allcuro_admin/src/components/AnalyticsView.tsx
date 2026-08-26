import React from 'react';
import {
  MapPin,
} from 'lucide-react';

export const AnalyticsView: React.FC = () => {
  return (
    <div className="analytics-view-layout">
      <div className="view-header-row">
        <div>
          <h1 className="view-title">City Demand Heatmap & Retention Analytics</h1>
          <p className="view-subtitle">
            Hyperlocal demand concentration, repeat customer rates & growth across Bengaluru, NCR, Mumbai & Hyderabad
          </p>
        </div>
      </div>

      <div className="analytics-grid">
        {/* City Clusters Heatmap Table */}
        <div className="white-card-box">
          <div className="box-header-title">
            <span>Hyperlocal Cluster Demand</span>
            <span className="count-tag">Top 4 Cities</span>
          </div>

          <div className="cluster-list">
            <div className="cluster-item">
              <div className="cluster-name-flex">
                <MapPin size={16} className="text-emerald-700" />
                <div>
                  <div className="cluster-city">Bengaluru (Indiranagar, Koramangala, Whitefield, HSR)</div>
                  <div className="cluster-meta">612 Active Shifts · 94 Beds Occupied</div>
                </div>
              </div>
              <div className="cluster-stats">
                <span className="cluster-gmv">₹3,180,450 GMV</span>
                <span className="cluster-share">60.1% of Platform</span>
              </div>
            </div>

            <div className="cluster-item">
              <div className="cluster-name-flex">
                <MapPin size={16} className="text-blue-600" />
                <div>
                  <div className="cluster-city">Delhi-NCR (South Delhi, Gurgaon DLF Phase 1-5, Noida)</div>
                  <div className="cluster-meta">148 Active Shifts · 32 Beds Occupied</div>
                </div>
              </div>
              <div className="cluster-stats">
                <span className="cluster-gmv">₹1,124,300 GMV</span>
                <span className="cluster-share">21.2% of Platform</span>
              </div>
            </div>

            <div className="cluster-item">
              <div className="cluster-name-flex">
                <MapPin size={16} className="text-purple-600" />
                <div>
                  <div className="cluster-city">Mumbai (Bandra West, Juhu, Powai, South Bombay)</div>
                  <div className="cluster-meta">82 Active Shifts · 22 Beds Occupied</div>
                </div>
              </div>
              <div className="cluster-stats">
                <span className="cluster-gmv">₹685,010 GMV</span>
                <span className="cluster-share">13.0% of Platform</span>
              </div>
            </div>
          </div>
        </div>

        {/* Retention & LTV Metrics */}
        <div className="white-card-box">
          <div className="box-header-title">
            <span>Customer Retention & LTV</span>
            <span className="count-tag">High Loyalty</span>
          </div>

          <div className="retention-stats-grid">
            <div className="retention-stat-box">
              <span className="stat-label">Repeat Booking Rate</span>
              <div className="stat-value">68.4%</div>
              <span className="stat-sub">Families re-book nurse within 30 days</span>
            </div>

            <div className="retention-stat-box">
              <span className="stat-label">Average Patient LTV</span>
              <div className="stat-value">₹24,800</div>
              <span className="stat-sub">Spanning nursing + equipment rental</span>
            </div>

            <div className="retention-stat-box">
              <span className="stat-label">Nurse Shift Fill Rate</span>
              <div className="stat-value">96.8%</div>
              <span className="stat-sub">Within 45 minutes of booking</span>
            </div>

            <div className="retention-stat-box">
              <span className="stat-label">Two-Way Rating Avg</span>
              <div className="stat-value">4.92 ★</div>
              <span className="stat-sub">Across 12,400+ completed visits</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};
