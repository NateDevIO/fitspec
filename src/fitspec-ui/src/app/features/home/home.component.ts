import { Component, inject } from '@angular/core';
import { MatIconModule } from '@angular/material/icon';
import { VehicleSelectorComponent } from '../vehicle-selector/vehicle-selector.component';
import { VehicleSummaryComponent } from '../vehicle-summary/vehicle-summary.component';
import { CategoryNavComponent } from '../category-nav/category-nav.component';
import { CommunityBuildsComponent } from '../community-builds/community-builds.component';
import { VehicleState } from '../../core/state/vehicle.state';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [VehicleSelectorComponent, VehicleSummaryComponent, CategoryNavComponent, CommunityBuildsComponent, MatIconModule],
  template: `
    <app-vehicle-selector />
    <div class="main-content">
      <app-vehicle-summary />
      <app-category-nav />
      @if (vehicleState.selectedVehicle(); as v) {
        <app-community-builds [vehicleId]="v.id" />
      }
    </div>

    <footer class="site-footer">
      <div class="footer-content">
        <div class="footer-brand">
          <div class="footer-logo">
            <span class="footer-logo-icon">
              <mat-icon>build</mat-icon>
            </span>
            <span class="footer-logo-text">FitSpec</span>
          </div>
          <p class="footer-tagline">Precision vehicle parts fitment — find exactly what fits your ride.</p>
        </div>
        <div class="footer-stats">
          <div class="footer-stat">
            <span class="footer-stat-value">150+</span>
            <span class="footer-stat-label">Products</span>
          </div>
          <div class="footer-stat">
            <span class="footer-stat-value">30</span>
            <span class="footer-stat-label">Brands</span>
          </div>
          <div class="footer-stat">
            <span class="footer-stat-value">100%</span>
            <span class="footer-stat-label">Verified</span>
          </div>
        </div>
      </div>
      <div class="footer-bottom">
        <span>&copy; 2026 FitSpec. Built for automotive enthusiasts.</span>
      </div>
    </footer>
  `,
  styles: [`
    :host {
      display: flex;
      flex-direction: column;
      min-height: calc(100vh - 64px);
    }
    .main-content {
      flex: 1 0 auto;
    }
    .site-footer {
      flex-shrink: 0;
      background: linear-gradient(135deg, #0d1147 0%, #1a237e 40%, #263238 100%);
      color: white;
      margin-top: auto;
      border-top: 3px solid #ffc107;
    }
    .footer-content {
      max-width: 900px;
      margin: 0 auto;
      padding: 40px 24px 24px;
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      gap: 32px;
      flex-wrap: wrap;
    }
    .footer-brand { max-width: 400px; }
    .footer-logo {
      display: flex;
      align-items: center;
      gap: 10px;
      margin-bottom: 8px;
    }
    .footer-logo-icon {
      width: 32px; height: 32px;
      background: #ffc107;
      border-radius: 8px;
      display: flex; align-items: center; justify-content: center;
    }
    .footer-logo-icon mat-icon {
      color: var(--fs-navy);
      font-size: 18px; width: 18px; height: 18px;
    }
    .footer-logo-text {
      font-size: 1.3rem;
      font-weight: 700;
      letter-spacing: 1px;
    }
    .footer-tagline {
      color: rgba(255,255,255,0.5);
      font-size: 0.85rem;
      line-height: 1.5;
      margin: 0;
    }
    .footer-stats {
      display: flex;
      gap: 32px;
    }
    .footer-stat {
      display: flex;
      flex-direction: column;
      align-items: center;
    }
    .footer-stat-value {
      font-size: 1.3rem;
      font-weight: 700;
      color: var(--fs-amber);
    }
    .footer-stat-label {
      font-size: 0.7rem;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      color: rgba(255,255,255,0.4);
    }
    .footer-bottom {
      border-top: 1px solid rgba(255,255,255,0.1);
      text-align: center;
      padding: 16px 24px;
      font-size: 0.75rem;
      color: rgba(255,255,255,0.35);
    }
    @media (max-width: 600px) {
      .footer-content { flex-direction: column; align-items: center; text-align: center; gap: 20px; padding: 24px 16px 16px; }
      .footer-brand { max-width: 100%; }
      .footer-stats { gap: 20px; }
    }
  `]
})
export class HomeComponent {
  vehicleState = inject(VehicleState);
}
