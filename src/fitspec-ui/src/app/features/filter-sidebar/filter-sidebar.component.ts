import { Component, input, output, signal, inject } from '@angular/core';
import { MatSelectModule } from '@angular/material/select';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatSliderModule } from '@angular/material/slider';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatCardModule } from '@angular/material/card';
import { VehicleState } from '../../core/state/vehicle.state';
import { ProductFilterParams } from '../../core/models';

@Component({
  selector: 'app-filter-sidebar',
  standalone: true,
  imports: [MatSelectModule, MatFormFieldModule, MatSliderModule, MatCheckboxModule, MatButtonModule, MatIconModule, MatCardModule],
  template: `
    <mat-card class="filter-card" appearance="outlined">
      <mat-card-header>
        <mat-card-title>
          <mat-icon>filter_list</mat-icon> Filters
        </mat-card-title>
      </mat-card-header>
      <mat-card-content>
        <mat-form-field appearance="outline" class="full-width">
          <mat-label>Category</mat-label>
          <mat-select (selectionChange)="updateFilter('categoryId', $event.value)">
            <mat-option [value]="null">All Categories</mat-option>
            @for (cat of vehicleState.categoryBreakdown(); track cat.categoryId) {
              <mat-option [value]="cat.categoryId">{{ cat.name }} ({{ cat.productCount }})</mat-option>
            }
          </mat-select>
        </mat-form-field>

        <mat-form-field appearance="outline" class="full-width">
          <mat-label>Sort By</mat-label>
          <mat-select (selectionChange)="updateFilter('sort', $event.value)" value="name">
            <mat-option value="name">Name</mat-option>
            <mat-option value="price_asc">Price: Low to High</mat-option>
            <mat-option value="price_desc">Price: High to Low</mat-option>
            <mat-option value="difficulty">Easiest Install</mat-option>
            <mat-option value="brand">Brand</mat-option>
          </mat-select>
        </mat-form-field>

        <div class="filter-section">
          <label class="filter-label">Max Install Difficulty</label>
          <mat-slider min="1" max="5" step="1" showTickMarks discrete>
            <input matSliderThumb value="5" (valueChange)="updateFilter('maxDifficulty', $event)">
          </mat-slider>
        </div>

        <mat-checkbox (change)="updateFilter('verifiedOnly', $event.checked)">
          Verified Fit Only
        </mat-checkbox>

        <button mat-stroked-button class="reset-btn" (click)="resetFilters()">
          <mat-icon>refresh</mat-icon> Reset Filters
        </button>
      </mat-card-content>
    </mat-card>
  `,
  styles: [`
    .filter-card { border-radius: 12px; }
    .full-width { width: 100%; }
    .filter-section { margin: 16px 0; }
    .filter-label { font-size: 0.85rem; color: #666; display: block; margin-bottom: 8px; }
    .reset-btn { width: 100%; margin-top: 16px; }
    mat-card-title { display: flex; align-items: center; gap: 8px; font-size: 1rem; }
  `]
})
export class FilterSidebarComponent {
  vehicleId = input<number>();
  filtersChanged = output<ProductFilterParams>();
  vehicleState = inject(VehicleState);

  private filters = signal<ProductFilterParams>({});

  updateFilter(key: string, value: unknown): void {
    this.filters.update(f => ({ ...f, [key]: value }));
    this.filtersChanged.emit(this.filters());
  }

  resetFilters(): void {
    this.filters.set({});
    this.filtersChanged.emit({});
  }
}
