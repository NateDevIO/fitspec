import { Component, inject, input, signal } from '@angular/core';
import { RouterLink } from '@angular/router';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatChipsModule } from '@angular/material/chips';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';
import { CurrencyPipe } from '@angular/common';
import { ProductSummaryDto } from '../../core/models';
import { BuildState } from '../../core/state/build.state';
import { CompareState } from '../../core/state/compare.state';

@Component({
  selector: 'app-product-card',
  standalone: true,
  imports: [RouterLink, MatCardModule, MatIconModule, MatButtonModule, MatChipsModule, MatCheckboxModule, MatSnackBarModule, CurrencyPipe],
  template: `
    <mat-card class="product-card" appearance="outlined" [routerLink]="['/products', product().id]">
      <div class="card-image">
        @if (product().imageUrl && !imageFailed()) {
          <img [src]="product().imageUrl" [alt]="product().name" (error)="imageFailed.set(true)">
        } @else {
          <div class="placeholder-img">
            <div class="placeholder-icon-box">
              <mat-icon>{{ getCategoryIcon(product().categoryName) }}</mat-icon>
            </div>
            <span class="placeholder-label">{{ product().categoryName }}</span>
          </div>
        }
        @if (product().isVerified) {
          <span class="verified-badge">
            <mat-icon>verified</mat-icon> Verified Fit
          </span>
        }
        <span class="category-tag">{{ product().categoryName }}</span>
        <div class="compare-check" (click)="toggleCompare($event)">
          <mat-checkbox [checked]="compareState.isSelected(product().id)" color="accent"
            (click)="$event.stopPropagation()"></mat-checkbox>
        </div>
        <div class="zoom-hint">
          <mat-icon>search</mat-icon>
        </div>
      </div>
      <mat-card-content>
        <span class="product-brand">{{ product().brand }}</span>
        <h3 class="product-name">{{ product().name }}</h3>
        <div class="product-meta">
          <span class="product-price">{{ product().price | currency }}</span>
          <div class="difficulty">
            <span class="diff-label">Install:</span>
            @for (i of difficultyDots; track i) {
              <span class="dot" [class.active]="i <= product().installDifficulty"
                [class.hard]="i <= product().installDifficulty && product().installDifficulty >= 4"></span>
            }
          </div>
        </div>
        <button mat-stroked-button class="add-build-btn" (click)="addToBuild($event)">
          <mat-icon>add_shopping_cart</mat-icon> Add to Build
        </button>
      </mat-card-content>
    </mat-card>
  `,
  styles: [`
    .product-card {
      border-radius: 12px;
      cursor: pointer;
      transition: transform 0.25s ease, box-shadow 0.25s ease;
      overflow: hidden;
    }
    .product-card:hover {
      transform: translateY(-6px);
      box-shadow: 0 12px 32px rgba(0,0,0,0.15);
    }
    .card-image {
      height: 190px;
      background: #f0f2f5;
      display: flex;
      align-items: center;
      justify-content: center;
      position: relative;
      overflow: hidden;
    }
    .card-image img { width: 100%; height: 100%; object-fit: cover; }
    .placeholder-img {
      width: 100%;
      height: 100%;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      gap: 8px;
      background: var(--fs-gradient-navy);
      background-image:
        repeating-linear-gradient(135deg, transparent, transparent 20px, rgba(255,255,255,0.02) 20px, rgba(255,255,255,0.02) 40px),
        var(--fs-gradient-navy);
    }
    .placeholder-icon-box {
      width: 64px; height: 64px;
      background: rgba(255,193,7,0.15);
      border-radius: 16px;
      display: flex; align-items: center; justify-content: center;
      border: 1px solid rgba(255,193,7,0.25);
    }
    .placeholder-icon-box mat-icon {
      font-size: 32px; width: 32px; height: 32px;
      color: var(--fs-amber);
    }
    .placeholder-label {
      font-size: 0.7rem;
      text-transform: uppercase;
      letter-spacing: 1.5px;
      color: rgba(255,255,255,0.45);
      font-weight: 500;
    }
    .verified-badge {
      position: absolute;
      top: 8px;
      right: 8px;
      background: linear-gradient(135deg, #43a047, #2e7d32);
      color: white;
      padding: 4px 10px;
      border-radius: 6px;
      font-size: 0.7rem;
      font-weight: 500;
      display: flex;
      align-items: center;
      gap: 4px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.15);
    }
    .verified-badge mat-icon { font-size: 14px; width: 14px; height: 14px; }
    .category-tag {
      position: absolute;
      bottom: 8px;
      left: 8px;
      background: rgba(0,0,0,0.55);
      color: white;
      font-size: 0.65rem;
      font-weight: 500;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      padding: 3px 8px;
      border-radius: 4px;
      backdrop-filter: blur(4px);
    }
    .zoom-hint {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%) scale(0.8);
      width: 40px;
      height: 40px;
      background: rgba(0,0,0,0.55);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      opacity: 0;
      transition: opacity 0.25s ease, transform 0.25s ease;
      pointer-events: none;
      backdrop-filter: blur(4px);
    }
    .zoom-hint mat-icon { font-size: 20px; width: 20px; height: 20px; color: white; }
    .product-card:hover .zoom-hint {
      opacity: 1;
      transform: translate(-50%, -50%) scale(1);
    }
    .product-brand {
      font-size: 0.75rem;
      color: #888;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }
    .product-name {
      margin: 4px 0 10px;
      font-size: 0.95rem;
      font-weight: 600;
      line-height: 1.3;
      color: var(--fs-charcoal);
    }
    .product-meta {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 10px;
    }
    .product-price { font-size: 1.15rem; font-weight: 700; color: var(--fs-navy); }
    .difficulty { display: flex; align-items: center; gap: 3px; }
    .diff-label { font-size: 0.7rem; color: #888; margin-right: 3px; }
    .dot {
      width: 8px; height: 8px; border-radius: 50%;
      background: #e0e0e0;
      transition: background 0.2s;
    }
    .dot.active { background: #ffc107; }
    .dot.hard { background: #ff8f00; }
    .add-build-btn {
      width: 100%;
      margin-top: 4px;
      font-size: 0.8rem;
      color: var(--fs-navy);
      border-color: var(--fs-navy);
      border-radius: 8px;
    }
    .add-build-btn:hover {
      background: rgba(26,35,126,0.06);
    }
    .add-build-btn mat-icon { font-size: 16px; width: 16px; height: 16px; margin-right: 4px; }
    .compare-check {
      position: absolute;
      top: 8px;
      left: 8px;
      z-index: 2;
      opacity: 0;
      transition: opacity 0.2s;
    }
    .product-card:hover .compare-check { opacity: 1; }
    .compare-check mat-checkbox { --mdc-checkbox-selected-icon-color: var(--fs-amber); --mdc-checkbox-selected-hover-icon-color: var(--fs-amber); }
    @media (max-width: 480px) {
      .card-image { height: 140px; }
      .product-name { font-size: 0.85rem; }
      .product-price { font-size: 1rem; }
      .compare-check { opacity: 1; }
    }
  `]
})
export class ProductCardComponent {
  product = input.required<ProductSummaryDto>();
  vehicleId = input<number>();
  difficultyDots = [1, 2, 3, 4, 5];
  imageFailed = signal(false);

  private buildState = inject(BuildState);
  private snackBar = inject(MatSnackBar);
  compareState = inject(CompareState);

  getCategoryIcon(category: string): string {
    const map: Record<string, string> = {
      'Hitches': 'tow',
      'Lighting': 'lightbulb',
      'Roof Racks': 'luggage',
      'Floor Mats': 'grid_on',
      'Cargo Management': 'inventory_2',
      'Electronics': 'electrical_services',
      'Exterior': 'directions_car',
      'Performance': 'speed',
    };
    return map[category] || 'build';
  }

  addToBuild(event: Event): void {
    event.stopPropagation();
    this.buildState.addItem(this.product());
    this.snackBar.open(`${this.product().name} added to build`, 'View', { duration: 3000 });
  }

  toggleCompare(event: Event): void {
    event.stopPropagation();
    event.preventDefault();
    const p = this.product();
    if (this.compareState.isSelected(p.id)) {
      this.compareState.removeFromCompare(p.id);
    } else {
      this.compareState.addToCompare(p);
    }
  }
}
