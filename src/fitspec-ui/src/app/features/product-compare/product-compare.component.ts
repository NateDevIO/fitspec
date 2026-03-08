import { Component, inject, OnInit, signal } from '@angular/core';
import { Router } from '@angular/router';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { CurrencyPipe, DecimalPipe } from '@angular/common';
import { ProductService } from '../../core/services/product.service';
import { ProductDetailDto } from '../../core/models';
import { CompareState } from '../../core/state/compare.state';

@Component({
  selector: 'app-product-compare',
  standalone: true,
  imports: [MatCardModule, MatIconModule, MatButtonModule, CurrencyPipe, DecimalPipe],
  template: `
    <div class="compare-container">
      <div class="compare-header">
        <button mat-button (click)="backToBrowsing()">
          <mat-icon>arrow_back</mat-icon> Back to browsing
        </button>
        <h2>Product Comparison</h2>
      </div>

      @if (loading()) {
        <div class="loading-center">
          <mat-icon class="spin-icon">sync</mat-icon>
          <span>Loading comparison...</span>
        </div>
      } @else if (products().length === 0) {
        <mat-card class="empty-card" appearance="outlined">
          <mat-card-content>
            <mat-icon>compare_arrows</mat-icon>
            <p>No products to compare. Select products from the catalog first.</p>
            <button mat-flat-button color="primary" (click)="backToBrowsing()">Browse Products</button>
          </mat-card-content>
        </mat-card>
      } @else {
        <div class="compare-table">
          <!-- Image Row -->
          <div class="compare-row">
            <div class="row-label">Image</div>
            @for (p of products(); track p.id) {
              <div class="compare-cell image-cell">
                @if (p.imageUrl) {
                  <img [src]="p.imageUrl" [alt]="p.name">
                } @else {
                  <div class="placeholder-thumb">
                    <mat-icon>inventory_2</mat-icon>
                  </div>
                }
              </div>
            }
          </div>

          <!-- Name Row -->
          <div class="compare-row alt-row">
            <div class="row-label">Name</div>
            @for (p of products(); track p.id) {
              <div class="compare-cell name-cell">
                <strong>{{ p.name }}</strong>
              </div>
            }
          </div>

          <!-- Brand Row -->
          <div class="compare-row">
            <div class="row-label">Brand</div>
            @for (p of products(); track p.id) {
              <div class="compare-cell">{{ p.brand }}</div>
            }
          </div>

          <!-- Price Row -->
          <div class="compare-row alt-row">
            <div class="row-label">Price</div>
            @for (p of products(); track p.id) {
              <div class="compare-cell" [class.cheapest]="isCheapest(p.price)">
                <strong>{{ p.price | currency }}</strong>
                @if (isCheapest(p.price)) {
                  <mat-icon class="best-icon">thumb_up</mat-icon>
                }
              </div>
            }
          </div>

          <!-- Category Row -->
          <div class="compare-row">
            <div class="row-label">Category</div>
            @for (p of products(); track p.id) {
              <div class="compare-cell">{{ p.categoryName }}</div>
            }
          </div>

          <!-- Weight Row -->
          <div class="compare-row alt-row">
            <div class="row-label">Weight</div>
            @for (p of products(); track p.id) {
              <div class="compare-cell">
                {{ p.weight !== null ? (p.weight | number:'1.1-1') + ' lbs' : 'N/A' }}
              </div>
            }
          </div>

          <!-- Verified Row -->
          <div class="compare-row">
            <div class="row-label">Verified Fit</div>
            @for (p of products(); track p.id) {
              <div class="compare-cell">
                @if (p.isVerified) {
                  <mat-icon class="verified-icon">verified</mat-icon>
                  <span class="verified-text">Verified</span>
                } @else {
                  <mat-icon class="unverified-icon">remove_circle_outline</mat-icon>
                }
              </div>
            }
          </div>
        </div>
      }
    </div>
  `,
  styles: [`
    .compare-container {
      max-width: 1100px;
      margin: 24px auto;
      padding: 0 24px;
      animation: fadeInUp 0.4s ease-out;
    }
    .compare-header {
      display: flex;
      align-items: center;
      gap: 16px;
      margin-bottom: 24px;
    }
    .compare-header h2 {
      font-size: 1.5rem;
      font-weight: 700;
      color: var(--fs-navy);
      margin: 0;
    }
    .compare-header button { color: var(--fs-navy); }
    .loading-center {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 12px;
      padding: 48px;
      color: #888;
    }
    .spin-icon {
      animation: spin 1.5s linear infinite;
      color: var(--fs-navy);
    }
    .empty-card { text-align: center; padding: 48px; }
    .empty-card mat-icon { font-size: 48px; width: 48px; height: 48px; color: #ccc; }
    .empty-card p { color: #888; margin: 12px 0 20px; }
    .compare-table {
      border: 1px solid #e0e0e0;
      border-radius: 12px;
      overflow: hidden;
    }
    .compare-row {
      display: grid;
      grid-template-columns: 140px repeat(auto-fit, minmax(0, 1fr));
      min-height: 56px;
      border-bottom: 1px solid #eee;
    }
    .compare-row:last-child { border-bottom: none; }
    .alt-row { background: #fafafa; }
    .row-label {
      display: flex;
      align-items: center;
      padding: 12px 16px;
      font-weight: 600;
      font-size: 0.85rem;
      color: #555;
      background: #f5f5f5;
      border-right: 1px solid #eee;
    }
    .compare-cell {
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 12px 16px;
      font-size: 0.9rem;
      color: #333;
      text-align: center;
      border-right: 1px solid #eee;
      transition: background 0.2s;
      gap: 6px;
    }
    .compare-cell:last-child { border-right: none; }
    .cheapest {
      background: rgba(76, 175, 80, 0.1);
      color: #2e7d32;
    }
    .cheapest strong { color: #2e7d32; }
    .best-icon {
      font-size: 16px;
      width: 16px;
      height: 16px;
      color: #4caf50;
    }
    .image-cell {
      padding: 16px;
      min-height: 120px;
    }
    .image-cell img {
      width: 100%;
      max-width: 160px;
      height: 100px;
      object-fit: cover;
      border-radius: 8px;
    }
    .placeholder-thumb {
      width: 100px;
      height: 100px;
      background: linear-gradient(135deg, #1a237e 0%, #263238 100%);
      border-radius: 8px;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .placeholder-thumb mat-icon {
      font-size: 36px; width: 36px; height: 36px; color: #ffc107;
    }
    .name-cell { font-size: 0.9rem; }
    .verified-icon { color: #4caf50; font-size: 20px; width: 20px; height: 20px; }
    .verified-text { font-size: 0.8rem; color: #4caf50; font-weight: 500; }
    .unverified-icon { color: #ccc; }

    @media (max-width: 768px) {
      .compare-container { padding: 0 12px; margin: 16px auto; }
      .compare-header { gap: 8px; margin-bottom: 16px; }
      .compare-header h2 { font-size: 1.1rem; }
      .compare-table { overflow-x: auto; display: block; }
      .compare-row {
        grid-template-columns: 80px repeat(auto-fit, minmax(100px, 1fr));
        min-width: max-content;
      }
      .row-label { font-size: 0.7rem; padding: 8px; min-width: 80px; }
      .compare-cell { padding: 8px; font-size: 0.75rem; min-width: 100px; }
      .image-cell { min-height: 80px; padding: 8px; }
      .image-cell img { max-width: 80px; height: 60px; }
      .placeholder-thumb { width: 60px; height: 60px; }
    }
  `]
})
export class ProductCompareComponent implements OnInit {
  private compareState = inject(CompareState);
  private productService = inject(ProductService);
  private router = inject(Router);

  products = signal<ProductDetailDto[]>([]);
  loading = signal(true);

  ngOnInit(): void {
    const ids = this.compareState.selectedIds();
    if (ids.length === 0) {
      this.loading.set(false);
      return;
    }

    this.productService.compareProducts(ids).subscribe({
      next: data => {
        this.products.set(data);
        this.loading.set(false);
      },
      error: () => this.loading.set(false)
    });
  }

  isCheapest(price: number): boolean {
    const prices = this.products().map(p => p.price);
    return prices.length > 1 && price === Math.min(...prices);
  }

  backToBrowsing(): void {
    this.router.navigate(['/']);
  }
}
