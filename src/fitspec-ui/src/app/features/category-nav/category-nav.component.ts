import { Component, inject } from '@angular/core';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { MatBadgeModule } from '@angular/material/badge';
import { Router } from '@angular/router';
import { VehicleState } from '../../core/state/vehicle.state';
import { CategoryBreakdownDto } from '../../core/models';

@Component({
  selector: 'app-category-nav',
  standalone: true,
  imports: [MatCardModule, MatIconModule, MatBadgeModule],
  template: `
    @if (state.categoryBreakdown().length > 0) {
      <div class="category-container">
        <h2 class="section-title">Compatible Parts by Category</h2>
        <p class="section-subtitle">Browse parts verified to fit your vehicle</p>
        <div class="category-grid">
          @for (cat of state.categoryBreakdown(); track cat.categoryId; let i = $index) {
            <mat-card class="category-card" appearance="outlined"
              [style.animation-delay]="(i * 80) + 'ms'"
              (click)="navigateToProducts(cat)">
              <mat-card-content>
                <div class="cat-icon-wrap">
                  <mat-icon class="cat-icon">{{ cat.icon || 'category' }}</mat-icon>
                </div>
                <h3 class="cat-name">{{ cat.name }}</h3>
                <span class="cat-count">{{ cat.productCount }} products</span>
                <mat-icon class="cat-arrow">arrow_forward</mat-icon>
              </mat-card-content>
            </mat-card>
          }
        </div>
      </div>
    }
  `,
  styles: [`
    .category-container { max-width: 900px; margin: 0 auto; padding: 0 24px 48px; }
    .section-title { font-size: 1.5rem; font-weight: 600; margin: 0 0 4px; color: var(--fs-navy); }
    .section-subtitle { font-size: 0.9rem; color: #666; margin: 0 0 20px; }
    .category-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
      gap: 16px;
    }
    .category-card {
      cursor: pointer;
      border-radius: 12px;
      text-align: center;
      transition: transform 0.2s, box-shadow 0.2s, border-color 0.2s;
      animation: cardEntrance 0.4s ease-out both;
      position: relative;
      overflow: hidden;
      border-top: 3px solid transparent;
    }
    .category-card:hover {
      transform: translateY(-4px);
      box-shadow: 0 8px 28px rgba(0,0,0,0.14);
      border-top-color: var(--fs-amber);
    }
    .category-card:hover .cat-arrow {
      opacity: 1;
      transform: translateX(0);
    }
    .cat-icon-wrap {
      width: 56px; height: 56px;
      background: linear-gradient(135deg, #1a237e, #263238);
      border-radius: 14px;
      display: flex; align-items: center; justify-content: center;
      margin: 0 auto 12px;
      box-shadow: 0 4px 12px rgba(26,35,126,0.25);
    }
    .cat-icon { color: var(--fs-amber); font-size: 28px; width: 28px; height: 28px; }
    .cat-name { margin: 0 0 4px; font-size: 0.95rem; font-weight: 600; }
    .cat-count { font-size: 0.8rem; color: #666; }
    .cat-arrow {
      position: absolute;
      bottom: 12px;
      right: 12px;
      font-size: 18px;
      width: 18px;
      height: 18px;
      color: var(--fs-amber);
      opacity: 0;
      transform: translateX(-4px);
      transition: opacity 0.2s, transform 0.2s;
    }
  `]
})
export class CategoryNavComponent {
  state = inject(VehicleState);
  private router = inject(Router);

  navigateToProducts(category: CategoryBreakdownDto): void {
    const vehicleId = this.state.selectedVehicle()?.id;
    if (vehicleId) {
      this.router.navigate(['/vehicles', vehicleId, 'products'], {
        queryParams: { categoryId: category.categoryId }
      });
    }
  }
}
