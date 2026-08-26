import React from 'react';
import {
  ArrowUpRight,
  CheckCircle2,
  FileSpreadsheet,
} from 'lucide-react';
import { mockPayouts } from '../data/mockData';

export const PayoutsLedgerView: React.FC = () => {
  return (
    <div className="payouts-ledger-layout">
      <div className="view-header-row">
        <div>
          <h1 className="view-title">Razorpay Route Split-Payouts Ledger</h1>
          <p className="view-subtitle">
            Automated split settlements: Customer payment $\rightarrow$ ALLCURO commission (10–15%) $\rightarrow$ Partner sub-account
          </p>
        </div>

        <button className="btn-export-ledger">
          <FileSpreadsheet size={15} /> Export GST Settlement Sheet
        </button>
      </div>

      {/* Split Payout Overview Metrics */}
      <div className="payouts-metric-cards-grid">
        <div className="payout-metric-card">
          <span className="payout-metric-label">Gross Collections (Razorpay)</span>
          <div className="payout-metric-val">₹5,289,760</div>
          <span className="payout-metric-sub">
            <ArrowUpRight size={13} /> 100% Escrow protected
          </span>
        </div>

        <div className="payout-metric-card highlight-green">
          <span className="payout-metric-label">ALLCURO Commission Retained</span>
          <div className="payout-metric-val">₹634,771</div>
          <span className="payout-metric-sub">Avg. 12.0% platform commission</span>
        </div>

        <div className="payout-metric-card">
          <span className="payout-metric-label">Disbursed to Care Partners</span>
          <div className="payout-metric-val">₹4,549,195</div>
          <span className="payout-metric-sub">
            <CheckCircle2 size={13} /> Auto-split via Razorpay Route
          </span>
        </div>

        <div className="payout-metric-card">
          <span className="payout-metric-label">Security Deposits Held</span>
          <div className="payout-metric-val">₹248,500</div>
          <span className="payout-metric-sub">Refunded upon equipment return</span>
        </div>
      </div>

      {/* Transactions Table */}
      <div className="payouts-table-box">
        <div className="box-header-title">
          <span>Recent Automated Split Settlements</span>
          <span className="count-tag">{mockPayouts.length} transactions</span>
        </div>

        <div className="table-responsive">
          <table className="custom-data-table">
            <thead>
              <tr>
                <th>Txn ID / Booking</th>
                <th>Customer Name</th>
                <th>Care Partner / Facility</th>
                <th>Gross Total</th>
                <th>ALLCURO Cut (10-15%)</th>
                <th>Partner Payout</th>
                <th>Status</th>
                <th>Razorpay Sub-Account</th>
              </tr>
            </thead>
            <tbody>
              {mockPayouts.map((tx) => (
                <tr key={tx.id}>
                  <td>
                    <div className="txn-id-bold">{tx.id}</div>
                    <div className="booking-ref-sub">{tx.bookingId}</div>
                  </td>
                  <td>{tx.customerName}</td>
                  <td>
                    <div className="partner-name-bold">{tx.partnerName}</div>
                    <div className="date-sub">{tx.date}</div>
                  </td>
                  <td className="bold-num">₹{tx.grossAmount.toLocaleString()}</td>
                  <td className="text-emerald-700 font-semibold">
                    +₹{tx.allcuroCommission.toLocaleString()}
                  </td>
                  <td className="bold-num text-slate-900">
                    ₹{tx.partnerPayout.toLocaleString()}
                  </td>
                  <td>
                    <span
                      className={`status-pill ${
                        tx.status === 'Settled' ? 'status-verified' : 'status-pending'
                      }`}
                    >
                      {tx.status}
                    </span>
                  </td>
                  <td>
                    <code className="code-subaccount">{tx.razorpayRouteSubAccount}</code>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};
