import { Component, inject } from '@angular/core';
import { Router } from '@angular/router';
import { MatMenuModule } from '@angular/material/menu';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatDividerModule } from '@angular/material/divider';
import { VehicleState } from '../../core/state/vehicle.state';

@Component({
  selector: 'app-garage',
  standalone: true,
  imports: [MatMenuModule, MatIconModule, MatButtonModule, MatDividerModule],
  template: `
    <button mat-button [matMenuTriggerFor]="garageMenu" class="garage-trigger">
      <mat-icon>garage</mat-icon>
      <span class="trigger-label">My Garage</span>
      @if (vehicleState.savedVehicles().length > 0) {
        <span class="badge">{{ vehicleState.savedVehicles().length }}</span>
      }
    </button>

    <mat-menu #garageMenu="matMenu" class="garage-menu">
      @if (vehicleState.savedVehicles().length === 0) {
        <div class="empty-state">
          <mat-icon class="empty-icon">directions_car</mat-icon>
          <p class="empty-text">No saved vehicles yet.</p>
          <p class="empty-hint">Select a vehicle to add it to your garage.</p>
        </div>
      } @else {
        @for (vehicle of vehicleState.savedVehicles(); track vehicle.id) {
          <button mat-menu-item class="vehicle-item" (click)="selectVehicle(vehicle.id)">
            <div class="vehicle-info">
              @if (isActive(vehicle.id)) {
                <mat-icon class="active-check">check_circle</mat-icon>
              }
              <span class="vehicle-text">{{ vehicle.year }} {{ vehicle.make }} {{ vehicle.model }}</span>
            </div>
            <button mat-icon-button class="remove-btn" (click)="removeVehicle($event, vehicle.id)">
              <mat-icon>close</mat-icon>
            </button>
          </button>
        }
        <mat-divider></mat-divider>
        <button mat-menu-item class="clear-all-btn" (click)="clearAll()">
          <mat-icon>delete_sweep</mat-icon>
          <span>Clear All</span>
        </button>
      }
    </mat-menu>
  `,
  styles: [`
    .garage-trigger {
      display: flex;
      align-items: center;
      gap: 6px;
      color: white !important;
      font-weight: 500;
      font-size: 0.85rem;
    }
    .garage-trigger mat-icon {
      color: rgba(255,255,255,0.8) !important;
    }
    .garage-trigger:hover mat-icon {
      color: #ffc107 !important;
    }
    .trigger-label { margin-left: 2px; color: white !important; }
    .badge {
      background: #ffc107;
      color: #1a237e;
      font-size: 0.7rem;
      font-weight: 700;
      min-width: 20px;
      height: 20px;
      border-radius: 10px;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 0 6px;
    }
    .empty-state {
      padding: 24px 20px;
      text-align: center;
      min-width: 220px;
    }
    .empty-icon {
      font-size: 40px;
      width: 40px;
      height: 40px;
      color: #ccc;
    }
    .empty-text {
      margin: 8px 0 4px;
      font-weight: 600;
      color: #555;
      font-size: 0.9rem;
    }
    .empty-hint {
      margin: 0;
      font-size: 0.8rem;
      color: #999;
    }
    .vehicle-item {
      display: flex;
      align-items: center;
      justify-content: space-between;
      min-width: 220px;
    }
    .vehicle-info {
      display: flex;
      align-items: center;
      gap: 8px;
      flex: 1;
    }
    .active-check {
      color: #4caf50;
      font-size: 20px;
      width: 20px;
      height: 20px;
    }
    .vehicle-text {
      font-size: 0.85rem;
      font-weight: 500;
      color: #333;
    }
    .remove-btn {
      width: 28px;
      height: 28px;
      line-height: 28px;
    }
    .remove-btn mat-icon {
      font-size: 16px;
      width: 16px;
      height: 16px;
      color: #999;
    }
    .remove-btn:hover mat-icon { color: #f44336; }
    .clear-all-btn {
      color: #f44336;
      font-size: 0.85rem;
    }
    .clear-all-btn mat-icon {
      color: #f44336;
    }
  `]
})
export class GarageComponent {
  readonly vehicleState = inject(VehicleState);
  private router = inject(Router);

  isActive(vehicleId: number): boolean {
    return this.vehicleState.selectedVehicle()?.id === vehicleId;
  }

  selectVehicle(vehicleId: number): void {
    const vehicle = this.vehicleState.savedVehicles().find(v => v.id === vehicleId);
    if (vehicle) {
      this.vehicleState.selectedVehicle.set(vehicle);
      this.router.navigate(['/']);
    }
  }

  removeVehicle(event: Event, vehicleId: number): void {
    event.stopPropagation();
    this.vehicleState.removeSavedVehicle(vehicleId);
  }

  clearAll(): void {
    this.vehicleState.savedVehicles.set([]);
    this.vehicleState.selectedVehicle.set(null);
  }
}
