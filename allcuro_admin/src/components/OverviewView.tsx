import React from 'react';
import {
  TrendingUp,
  ArrowUpRight,
  ChevronRight,
  Filter,
  Flame,
  Award,
  Sparkles,
  Building2,
  Stethoscope,
  Truck,
  HeartPulse,
} from 'lucide-react';
import { mockStats } from '../data/mockData';

export const OverviewView: React.FC = () => {
  return (
    <div className="overview-view-layout">
      {/* Title Bar */}
      <div className="overview-headline-row">
        <h1 className="report-main-title">Marketplace Overview</h1>
      </div>

      {/* Main Hero KPI Card */}
      <div className="hero-kpi-card">
        <div className="hero-kpi-top-row">
          <div className="kpi-left-stat">
            <span className="kpi-label-small">TOTAL MARKETPLACE GMV</span>
            <div className="kpi-amount-flex">
              <span className="kpi-big-number">{mockStats.totalGmv}</span>
              <span className="kpi-growth-pill">
                <ArrowUpRight size={14} /> {mockStats.gmvGrowth}
              </span>
              <span className="kpi-delta-tag">+₹27,335.09 today</span>
            </div>
            <span className="kpi-sub-comparison">
              vs prev. ₹4,631,900.00 Jun 1 – Aug 31, 2026 ▾
            </span>
          </div>

          <div className="kpi-right-cards-group">
            <div className="mini-stat-card">
              <span className="mini-card-title">Top Active Shifts</span>
              <div className="mini-card-val-row">
                <span className="mini-card-number">842</span>
                <span className="mini-avatar green">MA</span>
                <ChevronRight size={14} className="chevron" />
              </div>
            </div>

            <div className="mini-stat-card dark-card">
              <div className="dark-card-header">
                <span className="dark-card-title">Best Centre Deal</span>
                <span className="star-icon">★</span>
              </div>
              <div className="dark-card-val">₹68,000</div>
              <div className="dark-card-sub">
                <span>Aarogya Hospice</span>
                <ChevronRight size={14} className="chevron" />
              </div>
            </div>

            <div className="pill-stat-box">
              <span className="pill-stat-label">Bookings</span>
              <span className="pill-stat-val">1,256</span>
              <span className="pill-stat-sub">↓ 5 cancelled</span>
            </div>

            <div className="pill-stat-box highlight-pink">
              <span className="pill-stat-label">Nurses Value</span>
              <span className="pill-stat-val">₹2.8M</span>
              <span className="pill-stat-sub">↑ 14.8%</span>
            </div>

            <div className="pill-stat-box">
              <span className="pill-stat-label">SLA Rate</span>
              <span className="pill-stat-val">99.4%</span>
              <span className="pill-stat-sub">↑ 0.4%</span>
            </div>
          </div>
        </div>

        {/* Horizontal Provider Revenue Distribution Bar */}
        <div className="provider-distribution-bar-wrap">
          <div className="provider-segment seg-1">
            <span className="seg-avatar">AA</span>
            <span className="seg-amount">₹209,633</span>
            <span className="seg-pct">39.63%</span>
          </div>
          <div className="provider-segment seg-2">
            <span className="seg-avatar">MA</span>
            <span className="seg-amount">₹156,841</span>
            <span className="seg-pct">29.65%</span>
          </div>
          <div className="provider-segment seg-3">
            <span className="seg-avatar">EY</span>
            <span className="seg-amount">₹117,115</span>
            <span className="seg-pct">22.14%</span>
          </div>
          <div className="provider-segment seg-4">
            <span className="seg-avatar dark">ALL</span>
            <span className="seg-amount">₹45,386</span>
            <span className="seg-pct">8.58%</span>
          </div>
          <button className="details-pill-btn">Details</button>
        </div>
      </div>

      {/* Grid: Left Column Categories + Right Column Performance Table */}
      <div className="overview-two-col-grid">
        {/* Left Column */}
        <div className="grid-left-col">
          {/* Service Category Breakdown Card */}
          <div className="white-card-box">
            <div className="box-header-row">
              <div className="box-title-flex">
                <Building2 size={16} className="title-icon" />
                <span className="box-title">Revenue by Service Category</span>
              </div>
              <button className="filter-pill-btn">
                <Filter size={12} /> Filters ▾
              </button>
            </div>

            <div className="category-revenue-list">
              <div className="cat-row-item">
                <div className="cat-icon-badge pink-circle">
                  <Building2 size={15} />
                </div>
                <div className="cat-info">
                  <span className="cat-name">Home Care Centres (Beds)</span>
                  <span className="cat-sub">148 verified facilities</span>
                </div>
                <span className="cat-val">₹2,274,590</span>
                <span className="cat-pct-badge">43%</span>
              </div>

              <div className="cat-row-item">
                <div className="cat-icon-badge purple-circle">
                  <Stethoscope size={15} />
                </div>
                <div className="cat-info">
                  <span className="cat-name">In-House Nurses & Shifts</span>
                  <span className="cat-sub">1,420 registered nurses</span>
                </div>
                <span className="cat-val">₹1,428,230</span>
                <span className="cat-pct-badge">27%</span>
              </div>

              <div className="cat-row-item">
                <div className="cat-icon-badge blue-circle">
                  <Truck size={15} />
                </div>
                <div className="cat-info">
                  <span className="cat-name">Medical Equipment Rentals</span>
                  <span className="cat-sub">312 items on active rent</span>
                </div>
                <span className="cat-val">₹899,350</span>
                <span className="cat-pct-badge">17%</span>
              </div>

              <div className="cat-row-item">
                <div className="cat-icon-badge green-circle">
                  <HeartPulse size={15} />
                </div>
                <div className="cat-info">
                  <span className="cat-name">Specialised ICU / Palliative</span>
                  <span className="cat-sub">Critical care attendants</span>
                </div>
                <span className="cat-val">₹370,280</span>
                <span className="cat-pct-badge">7%</span>
              </div>
            </div>
          </div>

          {/* Volume by City Bar Chart */}
          <div className="white-card-box">
            <div className="box-header-row">
              <div className="box-title-flex">
                <TrendingUp size={16} className="title-icon" />
                <span className="box-title">Deals Volume by City Cluster</span>
              </div>
              <button className="filter-pill-btn">
                <Filter size={12} /> Filters ▾
              </button>
            </div>

            <div className="city-bars-visual">
              <div className="bar-col">
                <div className="bar-fill" style={{ height: '75%' }}>
                  <span className="bar-bubble">BLR</span>
                </div>
                <span className="bar-label">Bengaluru</span>
              </div>
              <div className="bar-col">
                <div className="bar-fill active-bar" style={{ height: '90%' }}>
                  <span className="bar-bubble highlight">NCR</span>
                </div>
                <span className="bar-label">Delhi-NCR</span>
              </div>
              <div className="bar-col">
                <div className="bar-fill" style={{ height: '60%' }}>
                  <span className="bar-bubble">MUM</span>
                </div>
                <span className="bar-label">Mumbai</span>
              </div>
              <div className="bar-col">
                <div className="bar-fill" style={{ height: '45%' }}>
                  <span className="bar-bubble">HYD</span>
                </div>
                <span className="bar-label">Hyderabad</span>
              </div>
            </div>
          </div>

          {/* Monthly Trend Banner */}
          <div className="monthly-metrics-banner">
            <div className="left-curved-stat">
              <span className="rot-label">Average Monthly</span>
              <div className="stat-content">
                <span className="sub-tag">Revenue</span>
                <span className="stat-big">₹1,855,200</span>
                <span className="sub-tag" style={{ marginTop: '6px' }}>
                  Total Shifts
                </span>
                <span className="stat-med">3,730 (97% filled)</span>
                <span className="sub-tag" style={{ marginTop: '6px' }}>
                  Repeat Rate
                </span>
                <span className="stat-badge">68% repeat family</span>
              </div>
            </div>

            <div className="right-timeline-bars">
              <div className="timeline-col">
                <span className="col-price-badge">₹6,901</span>
                <div className="stripes-bar" style={{ height: '65%' }} />
                <div className="col-avatar-icon">AA</div>
                <span className="col-month">Sep</span>
              </div>
              <div className="timeline-col">
                <span className="col-price-badge highlight">₹11,035</span>
                <div className="stripes-bar fill-green" style={{ height: '88%' }} />
                <div className="col-avatar-icon">EY</div>
                <span className="col-month">Oct</span>
              </div>
              <div className="timeline-col">
                <span className="col-price-badge">₹9,288</span>
                <div className="stripes-bar" style={{ height: '72%' }} />
                <div className="col-avatar-icon">MA</div>
                <span className="col-month">Nov</span>
              </div>
            </div>
          </div>
        </div>

        {/* Right Column: Performance Table & Trajectory Curve */}
        <div className="grid-right-col">
          <div className="white-card-box">
            <div className="table-header-grid">
              <span>Care Manager</span>
              <span>GMV Handled</span>
              <span>Leads</span>
              <span>KPI</span>
              <span>Fulfill</span>
            </div>

            {/* Row 1 */}
            <div className="table-row-item">
              <div className="manager-info">
                <span className="av-circle av-1">AA</span>
                <span className="manager-name">Armin A. (Ops)</span>
              </div>
              <span className="cell-val bold">₹209,633</span>
              <div className="leads-pill">
                <span className="black-badge">41</span>
                <span className="gray-sub">118</span>
              </div>
              <span className="cell-val">0.84</span>
              <div className="wl-pill">
                <span className="pct">31%</span>
                <span className="badge-circ">12</span>
                <span className="gray-circ">29</span>
              </div>
            </div>

            {/* Row 2 (Highlighted) */}
            <div className="table-row-item highlight-row">
              <div className="manager-info">
                <span className="av-circle av-2">MA</span>
                <span className="manager-name">Mikasa A. (Compliance)</span>
              </div>
              <span className="cell-val bold">₹156,841</span>
              <div className="leads-pill">
                <span className="black-badge">54</span>
                <span className="gray-sub">103</span>
              </div>
              <span className="cell-val">0.89</span>
              <div className="wl-pill">
                <span className="pct">39%</span>
                <span className="badge-circ">21</span>
                <span className="gray-circ">33</span>
                <span className="active-arrow-up">▲</span>
              </div>
            </div>

            {/* Praise Tags Row */}
            <div className="praise-tags-row">
              <span className="praise-pill">
                <Award size={13} /> Top compliance
              </span>
              <span className="praise-pill">
                <Flame size={13} /> 100% Shift Fill
              </span>
              <span className="praise-pill">
                <Sparkles size={13} /> Top customer review
              </span>
            </div>

            {/* Channel Performance Card */}
            <div className="channels-performance-wrap">
              <div className="channel-box">
                <div className="chan-head">
                  <span className="chan-title">Centres Bed Bookings</span>
                  <span className="chan-growth pink">↑ 3 · ₹156,841</span>
                </div>
                <div className="chan-big-pct">
                  45.3% <span className="chan-sub-val">₹71,048</span>
                </div>
              </div>

              {/* Dynamic Wave Chart */}
              <div className="sales-dynamic-chart-box">
                <div className="chart-title-row">
                  <span className="chart-label">Booking fulfillment trajectory</span>
                  <span className="weeks-sub">W1 – W11 ↗</span>
                </div>
                <div className="chart-curve-svg-wrap">
                  <svg viewBox="0 0 400 70" className="chart-svg">
                    <path
                      d="M 10,45 Q 60,60 110,35 T 210,45 T 310,25 T 390,38"
                      fill="none"
                      stroke="#E11D48"
                      strokeWidth="2.5"
                    />
                    <circle cx="110" cy="35" r="4" fill="#2563EB" />
                    <circle cx="210" cy="45" r="4" fill="#E11D48" />
                    <circle cx="310" cy="25" r="4" fill="#10B981" />
                  </svg>
                </div>
              </div>
            </div>

            {/* Row 3 */}
            <div className="table-row-item">
              <div className="manager-info">
                <span className="av-circle av-3">EY</span>
                <span className="manager-name">Eren Y. (Field Agent)</span>
              </div>
              <span className="cell-val bold">₹117,115</span>
              <div className="leads-pill">
                <span className="black-badge">22</span>
                <span className="gray-sub">84</span>
              </div>
              <span className="cell-val">0.79</span>
              <div className="wl-pill">
                <span className="pct">32%</span>
                <span className="badge-circ">7</span>
                <span className="gray-circ">15</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};
