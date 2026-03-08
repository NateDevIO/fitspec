import { Component, inject, signal, output, effect } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { VehicleService } from '../../core/services/vehicle.service';
import { VehicleState } from '../../core/state/vehicle.state';
import { VinDecodeResultDto } from '../../core/models';

@Component({
  selector: 'app-vin-decoder',
  standalone: true,
  imports: [FormsModule, MatCardModule, MatIconModule, MatButtonModule, MatFormFieldModule, MatInputModule, MatProgressSpinnerModule],
  template: `
    <div class="vin-decoder">
      <div class="vin-input-row">
        <mat-form-field appearance="outline" class="vin-field">
          <mat-label>Enter VIN</mat-label>
          <input matInput [(ngModel)]="vinInput"
            maxlength="17"
            placeholder="e.g. 1HGBH41JXMN109186"
            (keydown.enter)="decode()"
            class="vin-text-input">
          <mat-icon matPrefix class="vin-prefix-icon">pin</mat-icon>
        </mat-form-field>
        <button mat-flat-button class="decode-btn"
          [disabled]="vinInput.trim().length !== 17 || decoding()"
          (click)="decode()">
          @if (decoding()) {
            <mat-spinner diameter="20"></mat-spinner>
          } @else {
            Decode
          }
        </button>
      </div>

      @if (errorMsg()) {
        <div class="error-msg">
          <mat-icon>error_outline</mat-icon>
          {{ errorMsg() }}
        </div>
      }

      @if (result(); as r) {
        <div class="result-card">
          <div class="result-header">
            <mat-icon class="result-icon">directions_car</mat-icon>
            <span class="result-title">Decoded Vehicle</span>
          </div>
          <div class="result-details">
            @if (r.year) {
              <div class="result-row"><span class="rl">Year</span><span class="rv">{{ r.year }}</span></div>
            }
            @if (r.make) {
              <div class="result-row"><span class="rl">Make</span><span class="rv">{{ r.make }}</span></div>
            }
            @if (r.model) {
              <div class="result-row"><span class="rl">Model</span><span class="rv">{{ r.model }}</span></div>
            }
            @if (r.trim) {
              <div class="result-row"><span class="rl">Trim</span><span class="rv">{{ r.trim }}</span></div>
            }
            @if (r.bodyStyle) {
              <div class="result-row"><span class="rl">Body</span><span class="rv">{{ r.bodyStyle }}</span></div>
            }
            @if (r.driveType) {
              <div class="result-row"><span class="rl">Drive</span><span class="rv">{{ r.driveType }}</span></div>
            }
          </div>
          @if (r.matchedVehicleId) {
            <button mat-flat-button class="select-btn" (click)="selectVehicle(r.matchedVehicleId!)">
              <mat-icon>check_circle</mat-icon>
              Select This Vehicle
            </button>
          } @else {
            <div class="no-match">
              <mat-icon>info</mat-icon>
              <span>Vehicle not found in our database</span>
            </div>
          }
        </div>
      }
    </div>
  `,
  styles: [`
    .vin-decoder { max-width: 500px; margin: 0 auto; }
    .vin-input-row { display: flex; gap: 8px; align-items: flex-start; }
    .vin-field { flex: 1; }
    .vin-text-input {
      text-transform: uppercase;
      letter-spacing: 1.5px;
      font-family: monospace;
      font-size: 0.95rem;
    }
    :host ::ng-deep .vin-field .mat-mdc-text-field-wrapper {
      background: rgba(255,255,255,0.95) !important;
      border-radius: 8px;
    }
    :host ::ng-deep .vin-field .mdc-text-field--outlined .mdc-notched-outline__leading,
    :host ::ng-deep .vin-field .mdc-text-field--outlined .mdc-notched-outline__notch,
    :host ::ng-deep .vin-field .mdc-text-field--outlined .mdc-notched-outline__trailing {
      border-color: rgba(0,0,0,0.18) !important;
    }
    :host ::ng-deep .vin-field .mdc-text-field--outlined:not(.mdc-text-field--disabled).mdc-text-field--focused .mdc-notched-outline__leading,
    :host ::ng-deep .vin-field .mdc-text-field--outlined:not(.mdc-text-field--disabled).mdc-text-field--focused .mdc-notched-outline__notch,
    :host ::ng-deep .vin-field .mdc-text-field--outlined:not(.mdc-text-field--disabled).mdc-text-field--focused .mdc-notched-outline__trailing {
      border-color: #ffc107 !important;
      border-width: 2px !important;
    }
    :host ::ng-deep .vin-field .mdc-floating-label { color: #555 !important; }
    :host ::ng-deep .vin-field .mat-mdc-select-value,
    :host ::ng-deep .vin-field input.mat-mdc-input-element { color: #263238 !important; }
    .vin-prefix-icon { color: #888; font-size: 18px; width: 18px; height: 18px; }
    .decode-btn {
      background-color: #ffc107 !important;
      color: #263238 !important;
      font-weight: 600;
      height: 56px;
      border-radius: 8px;
      min-width: 90px;
    }
    .error-msg {
      display: flex;
      align-items: center;
      gap: 6px;
      color: #f44336;
      font-size: 0.85rem;
      margin-top: -8px;
      margin-bottom: 8px;
    }
    .error-msg mat-icon { font-size: 18px; width: 18px; height: 18px; }
    .result-card {
      background: rgba(255,255,255,0.95);
      border-radius: 12px;
      padding: 16px;
      margin-top: 4px;
      border: 1px solid rgba(0,0,0,0.1);
    }
    .result-header {
      display: flex;
      align-items: center;
      gap: 8px;
      margin-bottom: 12px;
    }
    .result-icon { color: var(--fs-navy); }
    .result-title { font-weight: 600; color: #263238; font-size: 0.95rem; }
    .result-details { display: flex; flex-direction: column; gap: 4px; }
    .result-row { display: flex; justify-content: space-between; padding: 4px 0; }
    .rl { color: #888; font-size: 0.85rem; }
    .rv { font-weight: 500; color: #263238; font-size: 0.85rem; }
    .select-btn {
      margin-top: 12px;
      width: 100%;
      background-color: #4caf50 !important;
      color: white !important;
      font-weight: 600;
    }
    .select-btn mat-icon { margin-right: 6px; font-size: 18px; width: 18px; height: 18px; }
    .no-match {
      display: flex;
      align-items: center;
      gap: 6px;
      margin-top: 12px;
      color: #999;
      font-size: 0.85rem;
    }
    .no-match mat-icon { font-size: 18px; width: 18px; height: 18px; color: #ccc; }
  `]
})
export class VinDecoderComponent {
  vehicleMatched = output<number>();

  private vehicleService = inject(VehicleService);
  private vehicleState = inject(VehicleState);

  vinInput = '';
  result = signal<VinDecodeResultDto | null>(null);
  decoding = signal(false);
  errorMsg = signal<string | null>(null);

  constructor() {
    // Clear VIN decoder state when vehicle selection is reset
    effect(() => {
      if (!this.vehicleState.selectedVehicle()) {
        this.result.set(null);
        this.vinInput = '';
        this.errorMsg.set(null);
      }
    });
  }

  decode(): void {
    const vin = this.vinInput.trim().toUpperCase();
    if (vin.length !== 17) return;

    this.decoding.set(true);
    this.errorMsg.set(null);
    this.result.set(null);

    this.vehicleService.decodeVin(vin).subscribe({
      next: r => {
        this.result.set(r);
        this.decoding.set(false);
      },
      error: () => {
        this.errorMsg.set('Failed to decode VIN. Please check and try again.');
        this.decoding.set(false);
      }
    });
  }

  selectVehicle(vehicleId: number): void {
    this.vehicleMatched.emit(vehicleId);
  }
}
