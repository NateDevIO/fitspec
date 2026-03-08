import { Component, inject, signal, input, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { CurrencyPipe } from '@angular/common';
import { ProductService } from '../../core/services/product.service';
import { ProductSummaryDto } from '../../core/models';

@Component({
  selector: 'app-required-accessories',
  standalone: true,
  imports: [MatCardModule, MatIconModule, MatProgressSpinnerModule, CurrencyPipe],
  template: `
    @if (loading()) {
      <div class="loading"><mat-spinner diameter="24"></mat-spinner></div>
    } @else if (accessories().length) {
      <div class="accessories-section">
        <h3 class="section-title">
          <mat-icon>add_shopping_cart</mat-icon>
          Frequently Bought Together
        </h3>
        <div class="scroll-container">
          @for (item of accessories(); track item.id) {
            <div class="accessory-card" (click)="goToProduct(item.id)">
              <mat-card appearance="outlined" class="card-inner">
                <div class="card-image">
                  @if (item.imageUrl) {
                    <img [src]="item.imageUrl" [alt]="item.name">
                  } @else {
                    <div class="card-placeholder">
                      <mat-icon>build</mat-icon>
                    </div>
                  }
                </div>
                <div class="card-info">
                  <span class="card-brand">{{ item.brand }}</span>
                  <span class="card-name">{{ item.name }}</span>
                  <span class="card-category">{{ item.categoryName }}</span>
                  <span class="card-price">{{ item.price | currency }}</span>
                </div>
              </mat-card>
            </div>
          }
        </div>
      </div>
    }
  `,
  styles: [`
    .loading { display: flex; justify-content: center; padding: 16px; }
    .accessories-section { margin: 24px 0; }
    .section-title {
      display: flex;
      align-items: center;
      gap: 8px;
      font-size: 1.1rem;
      font-weight: 600;
      color: var(--fs-charcoal);
      margin-bottom: 12px;
    }
    .section-title mat-icon { color: var(--fs-navy); font-size: 22px; width: 22px; height: 22px; }
    .scroll-container {
      display: flex;
      gap: 12px;
      overflow-x: auto;
      padding-bottom: 8px;
      scroll-snap-type: x mandatory;
    }
    .scroll-container::-webkit-scrollbar { height: 6px; }
    .scroll-container::-webkit-scrollbar-track { background: #f5f5f5; border-radius: 3px; }
    .scroll-container::-webkit-scrollbar-thumb { background: #ccc; border-radius: 3px; }
    .scroll-container::-webkit-scrollbar-thumb:hover { background: #aaa; }
    .accessory-card {
      text-decoration: none;
      color: inherit;
      scroll-snap-align: start;
      flex-shrink: 0;
    }
    .card-inner {
      width: 180px;
      border-radius: 12px;
      overflow: hidden;
      transition: box-shadow 0.2s, transform 0.2s;
      cursor: pointer;
    }
    .card-inner:hover {
      box-shadow: 0 4px 16px rgba(0,0,0,0.12);
      transform: translateY(-2px);
    }
    .card-image { height: 100px; overflow: hidden; background: #f5f5f5; }
    .card-image img { width: 100%; height: 100%; object-fit: cover; }
    .card-placeholder {
      height: 100%;
      display: flex;
      align-items: center;
      justify-content: center;
      background: linear-gradient(135deg, #1a237e, #263238);
    }
    .card-placeholder mat-icon { color: rgba(255,193,7,0.5); font-size: 32px; width: 32px; height: 32px; }
    .card-info {
      padding: 10px;
      display: flex;
      flex-direction: column;
      gap: 2px;
    }
    .card-brand {
      font-size: 0.65rem;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      color: #888;
    }
    .card-name {
      font-size: 0.8rem;
      font-weight: 600;
      color: var(--fs-charcoal);
      line-height: 1.2;
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
      overflow: hidden;
    }
    .card-category {
      font-size: 0.7rem;
      color: #999;
    }
    .card-price {
      font-size: 0.9rem;
      font-weight: 700;
      color: var(--fs-navy);
      margin-top: 4px;
    }
  `]
})
export class RequiredAccessoriesComponent implements OnInit {
  productId = input.required<number>();
  vehicleId = input<number | undefined>();

  private productService = inject(ProductService);
  private router = inject(Router);

  accessories = signal<ProductSummaryDto[]>([]);
  loading = signal(false);

  ngOnInit(): void {
    this.loadAccessories();
  }

  goToProduct(id: number): void {
    this.router.navigate(['/products', id]);
  }

  private loadAccessories(): void {
    this.loading.set(true);
    this.productService.getRequiredAccessories(this.productId(), this.vehicleId()).subscribe({
      next: items => {
        this.accessories.set(items);
        this.loading.set(false);
      },
      error: () => this.loading.set(false)
    });
  }
}
