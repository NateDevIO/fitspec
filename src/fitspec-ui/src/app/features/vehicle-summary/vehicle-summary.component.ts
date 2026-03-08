import { Component, inject } from '@angular/core';
import { Router } from '@angular/router';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatChipsModule } from '@angular/material/chips';
import { DecimalPipe } from '@angular/common';
import { VehicleState } from '../../core/state/vehicle.state';

@Component({
  selector: 'app-vehicle-summary',
  standalone: true,
  imports: [MatCardModule, MatIconModule, MatButtonModule, MatChipsModule, DecimalPipe],
  template: `
    @if (state.selectedVehicle(); as vehicle) {
      <div class="summary-container">
        <mat-card class="vehicle-card" appearance="outlined">
          <mat-card-content>
            <div class="vehicle-info">
              <div class="vehicle-icon">
                <mat-icon class="vehicle-type-icon">directions_car</mat-icon>
              </div>
              <div class="vehicle-details">
                <h2 class="vehicle-title">{{ vehicle.year }} {{ vehicle.make }} {{ vehicle.model }}</h2>
                <div class="vehicle-chips">
                  @if (vehicle.trim) {
                    <mat-chip-set>
                      <mat-chip>{{ vehicle.trim }}</mat-chip>
                    </mat-chip-set>
                  }
                  @if (vehicle.bodyStyle) {
                    <mat-chip-set>
                      <mat-chip>{{ vehicle.bodyStyle }}</mat-chip>
                    </mat-chip-set>
                  }
                  @if (vehicle.driveType) {
                    <mat-chip-set>
                      <mat-chip>{{ vehicle.driveType }}</mat-chip>
                    </mat-chip-set>
                  }
                </div>
              </div>
              <div class="vehicle-stats">
                @if (vehicle.towCapacityLbs) {
                  <div class="stat">
                    <mat-icon>local_shipping</mat-icon>
                    <span class="stat-value">{{ vehicle.towCapacityLbs | number }}</span>
                    <span class="stat-label">lbs tow capacity</span>
                  </div>
                }
              </div>
              <button mat-flat-button class="browse-btn" (click)="browseProducts(vehicle.id)">
                <mat-icon>search</mat-icon> Browse Parts
              </button>
              <button mat-icon-button (click)="state.saveVehicle(vehicle)" class="save-btn">
                <mat-icon>bookmark_border</mat-icon>
              </button>
            </div>
          </mat-card-content>
        </mat-card>
      </div>
    }
  `,
  styles: [`
    .summary-container {
      max-width: 900px;
      margin: -24px auto 24px;
      padding: 0 24px;
      position: relative;
      z-index: 1;
      animation: fadeInUp 0.4s ease-out;
    }
    .vehicle-card {
      border-radius: 16px;
      box-shadow: 0 4px 24px rgba(0,0,0,0.10);
      border: none;
    }
    .vehicle-info { display: flex; align-items: center; gap: 16px; padding: 8px 0; }
    .vehicle-icon {
      width: 72px; height: 72px;
      background: linear-gradient(135deg, #1a237e, #263238);
      border-radius: 14px;
      display: flex; align-items: center; justify-content: center;
      box-shadow: 0 4px 12px rgba(26,35,126,0.3);
      flex-shrink: 0;
    }
    .vehicle-type-icon { color: var(--fs-amber); font-size: 36px; width: 36px; height: 36px; }
    .vehicle-title { margin: 0; font-size: 1.4rem; font-weight: 600; color: var(--fs-navy); }
    .vehicle-chips { display: flex; gap: 4px; margin-top: 4px; pointer-events: none; }
    .vehicle-chips mat-chip { cursor: default; opacity: 0.85; font-size: 0.75rem; }
    .vehicle-stats { margin-left: auto; text-align: center; }
    .stat { display: flex; flex-direction: column; align-items: center; }
    .stat mat-icon { color: var(--fs-amber); }
    .stat-value { font-size: 1.2rem; font-weight: 700; color: var(--fs-navy); }
    .stat-label { font-size: 0.75rem; color: #666; }
    .browse-btn {
      background: linear-gradient(135deg, #1a237e, #263238);
      color: white;
      border-radius: 10px;
      margin-left: auto;
      white-space: nowrap;
    }
    .browse-btn:hover { box-shadow: 0 4px 12px rgba(26,35,126,0.35); }
    .browse-btn mat-icon { font-size: 18px; width: 18px; height: 18px; margin-right: 4px; }
    .save-btn { margin-left: 8px; }
    @media (max-width: 768px) {
      .vehicle-info { flex-wrap: wrap; }
      .vehicle-stats { margin-left: 0; width: 100%; }
      .stat { flex-direction: row; gap: 8px; }
    }
  `]
})
export class VehicleSummaryComponent {
  state = inject(VehicleState);
  private router = inject(Router);

  browseProducts(vehicleId: number): void {
    this.router.navigate(['/vehicles', vehicleId, 'products']);
  }
}
