import { Component, inject } from '@angular/core';
import { MatSelectModule } from '@angular/material/select';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { VehicleState } from '../../core/state/vehicle.state';
import { VinDecoderComponent } from '../vin-decoder/vin-decoder.component';

@Component({
  selector: 'app-vehicle-selector',
  standalone: true,
  imports: [MatSelectModule, MatFormFieldModule, MatCardModule, MatIconModule, MatProgressSpinnerModule, VinDecoderComponent],
  template: `
    <div class="selector-hero">
      <div class="hero-glow hero-glow-1"></div>
      <div class="hero-glow hero-glow-2"></div>
      <div class="hero-content">
        <span class="hero-badge">VEHICLE FITMENT SEARCH</span>
        <h1 class="hero-title">Find Parts That <span class="title-accent">Fit</span></h1>
        <p class="hero-subtitle">Select your vehicle to browse compatible accessories</p>

        <div class="selector-card">
          <div class="selector-row">
            <mat-form-field appearance="outline" class="selector-field">
              <mat-label>Make</mat-label>
              <mat-select
                [value]="state.selectedMakeId()"
                (selectionChange)="state.selectMake($event.value)">
                @for (make of state.makes(); track make.id) {
                  <mat-option [value]="make.id">{{ make.name }}</mat-option>
                }
              </mat-select>
              @if (state.loadingMakes()) {
                <mat-spinner matSuffix diameter="20"></mat-spinner>
              }
            </mat-form-field>

            <mat-form-field appearance="outline" class="selector-field">
              <mat-label>Model</mat-label>
              <mat-select
                [value]="state.selectedModelId()"
                [disabled]="!state.selectedMakeId()"
                (selectionChange)="state.selectModel($event.value)">
                @for (model of state.models(); track model.id) {
                  <mat-option [value]="model.id">{{ model.name }}</mat-option>
                }
              </mat-select>
              @if (state.loadingModels()) {
                <mat-spinner matSuffix diameter="20"></mat-spinner>
              }
            </mat-form-field>

            <mat-form-field appearance="outline" class="selector-field">
              <mat-label>Year / Trim</mat-label>
              <mat-select
                [disabled]="!state.selectedModelId()"
                (selectionChange)="state.selectYear($event.value)">
                @for (year of state.years(); track year.vehicleId) {
                  <mat-option [value]="year">
                    {{ year.year }}{{ year.trim ? ' - ' + year.trim : '' }}{{ year.bodyStyle ? ' (' + year.bodyStyle + ')' : '' }}
                  </mat-option>
                }
              </mat-select>
              @if (state.loadingYears()) {
                <mat-spinner matSuffix diameter="20"></mat-spinner>
              }
            </mat-form-field>
          </div>
        </div>

        <div class="vin-section">
          <span class="vin-divider-text">or decode your VIN</span>
          <app-vin-decoder (vehicleMatched)="onVinVehicleMatched($event)" />
        </div>

        <div class="hero-stats">
          <div class="stat-item">
            <span class="stat-value">30</span>
            <span class="stat-label">Brands</span>
          </div>
          <div class="stat-divider"></div>
          <div class="stat-item">
            <span class="stat-value">180+</span>
            <span class="stat-label">Vehicles</span>
          </div>
          <div class="stat-divider"></div>
          <div class="stat-item">
            <span class="stat-value">100%</span>
            <span class="stat-label">Verified Fitment</span>
          </div>
        </div>
      </div>
    </div>
  `,
  styles: [`
    .selector-hero {
      background:
        repeating-linear-gradient(
          135deg,
          transparent,
          transparent 40px,
          rgba(255,255,255,0.015) 40px,
          rgba(255,255,255,0.015) 80px
        ),
        linear-gradient(135deg, #0d1147 0%, #1a237e 40%, #37474f 100%);
      padding: 32px 24px 28px;
      text-align: center;
      position: relative;
      overflow: hidden;
    }
    .hero-glow {
      position: absolute;
      border-radius: 50%;
      filter: blur(80px);
      pointer-events: none;
    }
    .hero-glow-1 {
      width: 400px; height: 400px;
      background: rgba(255,193,7,0.08);
      top: -100px; right: -100px;
    }
    .hero-glow-2 {
      width: 300px; height: 300px;
      background: rgba(26,35,126,0.15);
      bottom: -80px; left: -60px;
    }
    .hero-content {
      max-width: 900px;
      margin: 0 auto;
      position: relative;
      z-index: 1;
    }
    .hero-badge {
      display: inline-block;
      background: rgba(255,193,7,0.15);
      color: #ffd54f;
      font-size: 0.7rem;
      font-weight: 600;
      letter-spacing: 2px;
      padding: 6px 16px;
      border-radius: 20px;
      border: 1px solid rgba(255,193,7,0.3);
      margin-bottom: 16px;
    }
    .hero-title {
      color: #ffffff;
      font-size: 2.5rem;
      font-weight: 700;
      margin: 0 0 8px;
      text-shadow: 0 2px 8px rgba(0,0,0,0.4);
    }
    .title-accent {
      color: #ffc107;
      -webkit-text-fill-color: #ffc107;
    }
    .hero-subtitle {
      color: #cfd8dc;
      font-size: 1.1rem;
      margin: 0 0 32px;
      text-shadow: 0 1px 4px rgba(0,0,0,0.3);
    }
    .selector-card {
      background: rgba(255,255,255,0.88);
      backdrop-filter: blur(16px);
      -webkit-backdrop-filter: blur(16px);
      border: 1px solid rgba(255,255,255,0.4);
      border-radius: 16px;
      padding: 24px 24px 8px;
      max-width: 860px;
      margin: 0 auto;
      box-shadow: 0 8px 32px rgba(0,0,0,0.15);
    }
    .selector-row {
      display: flex;
      gap: 16px;
      justify-content: center;
      flex-wrap: wrap;
    }
    .selector-field {
      flex: 1;
      min-width: 200px;
      max-width: 280px;
    }

    /* Form field styling on light card */
    :host ::ng-deep .selector-field .mat-mdc-text-field-wrapper {
      background: white !important;
      border-radius: 8px;
    }
    :host ::ng-deep .selector-field .mdc-text-field--outlined .mdc-floating-label {
      color: #555 !important;
    }
    :host ::ng-deep .selector-field .mdc-text-field--outlined .mdc-floating-label--float-above {
      color: #1a237e !important;
    }
    :host ::ng-deep .selector-field .mdc-text-field--outlined .mdc-notched-outline__leading,
    :host ::ng-deep .selector-field .mdc-text-field--outlined .mdc-notched-outline__notch,
    :host ::ng-deep .selector-field .mdc-text-field--outlined .mdc-notched-outline__trailing {
      border-color: rgba(0,0,0,0.18) !important;
    }
    :host ::ng-deep .selector-field .mdc-text-field--outlined:not(.mdc-text-field--disabled).mdc-text-field--focused .mdc-notched-outline__leading,
    :host ::ng-deep .selector-field .mdc-text-field--outlined:not(.mdc-text-field--disabled).mdc-text-field--focused .mdc-notched-outline__notch,
    :host ::ng-deep .selector-field .mdc-text-field--outlined:not(.mdc-text-field--disabled).mdc-text-field--focused .mdc-notched-outline__trailing {
      border-color: #1a237e !important;
      border-width: 2px !important;
    }
    :host ::ng-deep .selector-field .mat-mdc-select-value {
      color: #263238 !important;
    }
    :host ::ng-deep .selector-field .mat-mdc-select-arrow {
      color: #888 !important;
    }

    .vin-section {
      margin-top: 20px;
      text-align: center;
    }
    .vin-divider-text {
      display: inline-block;
      color: rgba(255,255,255,0.5);
      font-size: 0.85rem;
      text-transform: uppercase;
      letter-spacing: 1px;
      margin-bottom: 12px;
    }
    .hero-stats {
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 24px;
      margin-top: 28px;
    }
    .stat-item {
      display: flex;
      flex-direction: column;
      align-items: center;
    }
    .stat-value {
      color: #ffc107;
      font-size: 1.3rem;
      font-weight: 700;
    }
    .stat-label {
      color: rgba(255,255,255,0.5);
      font-size: 0.75rem;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }
    .stat-divider {
      width: 1px;
      height: 28px;
      background: rgba(255,255,255,0.15);
    }
    @media (max-width: 768px) {
      .hero-title { font-size: 1.8rem; }
      .selector-row { flex-direction: column; align-items: center; }
      .selector-field { max-width: 100%; width: 100%; }
      .selector-card { padding: 16px 16px 4px; }
    }
  `]
})
export class VehicleSelectorComponent {
  state = inject(VehicleState);

  onVinVehicleMatched(vehicleId: number): void {
    this.state.selectVehicleById(vehicleId);
  }
}
