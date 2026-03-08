import { Component, inject, OnInit, signal } from '@angular/core';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { CurrencyPipe, DecimalPipe } from '@angular/common';
import {
  AdminService,
  AdminOverview,
  OrdersByMonth,
  TopProduct
} from '../../core/services/admin.service';

@Component({
  selector: 'app-admin-dashboard',
  standalone: true,
  imports: [MatCardModule, MatIconModule, CurrencyPipe, DecimalPipe],
  template: `
    <div class="dashboard-container">
      <h1 class="page-title">Dashboard</h1>

      <!-- Stat Cards -->
      <div class="stats-grid">
        <mat-card class="stat-card" appearance="outlined">
          <mat-card-content>
            <div class="stat-icon-wrap products-bg">
              <mat-icon>inventory_2</mat-icon>
            </div>
            <div class="stat-info">
              <span class="stat-value">{{ overview()?.totalProducts | number }}</span>
              <span class="stat-label">Products</span>
            </div>
          </mat-card-content>
        </mat-card>

        <mat-card class="stat-card" appearance="outlined">
          <mat-card-content>
            <div class="stat-icon-wrap orders-bg">
              <mat-icon>shopping_cart</mat-icon>
            </div>
            <div class="stat-info">
              <span class="stat-value">{{ overview()?.totalOrders | number }}</span>
              <span class="stat-label">Orders</span>
            </div>
          </mat-card-content>
        </mat-card>

        <mat-card class="stat-card" appearance="outlined">
          <mat-card-content>
            <div class="stat-icon-wrap revenue-bg">
              <mat-icon>attach_money</mat-icon>
            </div>
            <div class="stat-info">
              <span class="stat-value">{{ overview()?.totalRevenue | currency:'USD':'symbol':'1.0-0' }}</span>
              <span class="stat-label">Revenue</span>
            </div>
          </mat-card-content>
        </mat-card>

        <mat-card class="stat-card" appearance="outlined">
          <mat-card-content>
            <div class="stat-icon-wrap vehicles-bg">
              <mat-icon>directions_car</mat-icon>
            </div>
            <div class="stat-info">
              <span class="stat-value">{{ overview()?.totalVehicles | number }}</span>
              <span class="stat-label">Vehicles</span>
            </div>
          </mat-card-content>
        </mat-card>
      </div>

      <!-- Revenue Chart -->
      <mat-card class="chart-card" appearance="outlined">
        <mat-card-content>
          <h2 class="section-title">Monthly Revenue</h2>
          @if (monthlyData().length > 0) {
            <div class="chart-container">
              @for (month of monthlyData(); track month.month) {
                <div class="chart-bar-group">
                  <div class="chart-bar-wrapper">
                    <div class="chart-bar" [style.height.%]="getBarHeight(month.revenue)">
                      <span class="bar-tooltip">{{ month.revenue | currency:'USD':'symbol':'1.0-0' }}</span>
                    </div>
                  </div>
                  <span class="bar-label">{{ formatMonth(month.month) }}</span>
                </div>
              }
            </div>
          } @else {
            <div class="chart-empty">
              <mat-icon>bar_chart</mat-icon>
              <p>No revenue data available</p>
            </div>
          }
        </mat-card-content>
      </mat-card>

      <!-- Top Products Table -->
      <mat-card class="table-card" appearance="outlined">
        <mat-card-content>
          <h2 class="section-title">Top Products</h2>
          @if (topProducts().length > 0) {
            <div class="table-wrapper">
              <table class="products-table">
                <thead>
                  <tr>
                    <th class="th-rank">#</th>
                    <th class="th-name">Product</th>
                    <th class="th-brand">Brand</th>
                    <th class="th-orders">Orders</th>
                    <th class="th-revenue">Revenue</th>
                  </tr>
                </thead>
                <tbody>
                  @for (product of topProducts(); track product.productId; let i = $index) {
                    <tr>
                      <td class="td-rank">{{ i + 1 }}</td>
                      <td class="td-name">{{ product.name }}</td>
                      <td class="td-brand">{{ product.brand }}</td>
                      <td class="td-orders">{{ product.orderCount | number }}</td>
                      <td class="td-revenue">{{ product.revenue | currency }}</td>
                    </tr>
                  }
                </tbody>
              </table>
            </div>
          } @else {
            <div class="chart-empty">
              <mat-icon>inventory_2</mat-icon>
              <p>No product data available</p>
            </div>
          }
        </mat-card-content>
      </mat-card>
    </div>
  `,
  styles: [`
    .dashboard-container { animation: fadeInUp 0.4s ease-out; }
    .page-title {
      font-size: 1.6rem;
      font-weight: 700;
      color: var(--fs-navy);
      margin: 0 0 24px;
    }

    /* Stat Cards */
    .stats-grid {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 20px;
      margin-bottom: 28px;
    }
    .stat-card { border-radius: 12px; }
    .stat-card mat-card-content {
      display: flex;
      align-items: center;
      gap: 16px;
      padding: 20px;
    }
    .stat-icon-wrap {
      width: 52px;
      height: 52px;
      border-radius: 14px;
      display: flex;
      align-items: center;
      justify-content: center;
      flex-shrink: 0;
    }
    .stat-icon-wrap mat-icon {
      font-size: 26px;
      width: 26px;
      height: 26px;
      color: white;
    }
    .products-bg { background: linear-gradient(135deg, #1a237e, #3949ab); }
    .orders-bg { background: linear-gradient(135deg, #e65100, #ff9800); }
    .revenue-bg { background: linear-gradient(135deg, #2e7d32, #66bb6a); }
    .vehicles-bg { background: linear-gradient(135deg, #6a1b9a, #ab47bc); }
    .stat-info {
      display: flex;
      flex-direction: column;
    }
    .stat-value {
      font-size: 1.5rem;
      font-weight: 700;
      color: #263238;
      line-height: 1.2;
    }
    .stat-label {
      font-size: 0.8rem;
      color: #888;
      font-weight: 500;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      margin-top: 2px;
    }

    /* Chart */
    .chart-card {
      border-radius: 12px;
      margin-bottom: 28px;
    }
    .section-title {
      font-size: 1.1rem;
      font-weight: 600;
      color: #333;
      margin: 0 0 20px;
    }
    .chart-container {
      display: flex;
      align-items: flex-end;
      gap: 10px;
      height: 240px;
      padding: 0 8px;
    }
    .chart-bar-group {
      flex: 1;
      display: flex;
      flex-direction: column;
      align-items: center;
      height: 100%;
    }
    .chart-bar-wrapper {
      flex: 1;
      width: 100%;
      display: flex;
      align-items: flex-end;
      justify-content: center;
    }
    .chart-bar {
      width: 70%;
      max-width: 48px;
      background: linear-gradient(180deg, #1a237e, #3f51b5);
      border-radius: 6px 6px 0 0;
      min-height: 4px;
      position: relative;
      transition: height 0.5s ease-out;
      cursor: pointer;
    }
    .chart-bar:hover {
      background: linear-gradient(180deg, #ffc107, #ffca28);
    }
    .bar-tooltip {
      position: absolute;
      top: -24px;
      left: 50%;
      transform: translateX(-50%);
      font-size: 0.65rem;
      color: #666;
      white-space: nowrap;
      opacity: 0;
      transition: opacity 0.2s;
      font-weight: 600;
    }
    .chart-bar:hover .bar-tooltip { opacity: 1; }
    .bar-label {
      margin-top: 8px;
      font-size: 0.7rem;
      color: #888;
      text-align: center;
      font-weight: 500;
    }
    .chart-empty {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      padding: 40px;
      color: #ccc;
    }
    .chart-empty mat-icon { font-size: 40px; width: 40px; height: 40px; }
    .chart-empty p { color: #aaa; margin-top: 8px; font-size: 0.85rem; }

    /* Table */
    .table-card { border-radius: 12px; }
    .table-wrapper { overflow-x: auto; }
    .products-table {
      width: 100%;
      border-collapse: collapse;
    }
    .products-table th {
      text-align: left;
      padding: 10px 14px;
      font-size: 0.75rem;
      font-weight: 600;
      color: #888;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      border-bottom: 2px solid #eee;
    }
    .products-table td {
      padding: 12px 14px;
      font-size: 0.85rem;
      color: #333;
      border-bottom: 1px solid #f0f0f0;
    }
    .products-table tr:hover td {
      background: rgba(26, 35, 126, 0.02);
    }
    .td-rank {
      font-weight: 700;
      color: var(--fs-navy);
      width: 40px;
    }
    .td-name { font-weight: 500; }
    .td-brand { color: #666; }
    .td-orders { text-align: right; }
    .td-revenue { text-align: right; font-weight: 600; color: #2e7d32; }
    .th-orders, .th-revenue { text-align: right; }

    @media (max-width: 1024px) {
      .stats-grid { grid-template-columns: repeat(2, 1fr); }
    }
    @media (max-width: 500px) {
      .stats-grid { grid-template-columns: 1fr; }
      .chart-container { height: 160px; gap: 6px; }
    }
  `]
})
export class AdminDashboardComponent implements OnInit {
  private adminService = inject(AdminService);

  overview = signal<AdminOverview | null>(null);
  monthlyData = signal<OrdersByMonth[]>([]);
  topProducts = signal<TopProduct[]>([]);

  private maxRevenue = 0;

  ngOnInit(): void {
    this.adminService.getOverview().subscribe({
      next: data => this.overview.set(data)
    });

    this.adminService.getOrdersByMonth().subscribe({
      next: data => {
        this.monthlyData.set(data);
        this.maxRevenue = Math.max(...data.map(d => d.revenue), 1);
      }
    });

    this.adminService.getTopProducts().subscribe({
      next: data => this.topProducts.set(data)
    });
  }

  getBarHeight(revenue: number): number {
    if (this.maxRevenue === 0) return 0;
    return Math.max((revenue / this.maxRevenue) * 100, 2);
  }

  formatMonth(month: string): string {
    const parts = month.split('-');
    if (parts.length >= 2) {
      const monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      const idx = parseInt(parts[1], 10) - 1;
      return monthNames[idx] ?? month;
    }
    return month;
  }
}
