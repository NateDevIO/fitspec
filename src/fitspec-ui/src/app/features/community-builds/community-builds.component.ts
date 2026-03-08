import { Component, inject, input, OnInit, signal } from '@angular/core';
import { RouterLink } from '@angular/router';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { CurrencyPipe } from '@angular/common';
import { CommunityService, PopularProduct } from '../../core/services/community.service';

@Component({
  selector: 'app-community-builds',
  standalone: true,
  imports: [RouterLink, MatCardModule, MatIconModule, CurrencyPipe],
  template: `
    @if (products().length > 0) {
      <div class="community-section">
        <h3 class="section-title">
          <mat-icon>group</mat-icon>
          Popular With This Vehicle
        </h3>

        <div class="scroll-row">
          @for (product of products(); track product.productId) {
            <mat-card class="product-mini-card" appearance="outlined" [routerLink]="['/products', product.productId]">
              <div class="card-image">
                @if (product.imageUrl) {
                  <img [src]="product.imageUrl" [alt]="product.name">
                } @else {
                  <div class="placeholder-img">
                    <mat-icon>inventory_2</mat-icon>
                  </div>
                }
                <span class="install-badge">
                  <mat-icon>build</mat-icon>
                  {{ product.installCount }} installs
                </span>
              </div>
              <mat-card-content>
                <span class="product-brand">{{ product.brand }}</span>
                <p class="product-name">{{ product.name }}</p>
                <span class="product-price">{{ product.price | currency }}</span>
              </mat-card-content>
            </mat-card>
          }
        </div>
      </div>
    }
  `,
  styles: [`
    .community-section {
      margin-top: 24px;
    }
    .section-title {
      display: flex;
      align-items: center;
      gap: 8px;
      font-size: 1.1rem;
      font-weight: 600;
      color: var(--fs-charcoal);
      margin: 0 0 16px;
    }
    .section-title mat-icon {
      font-size: 22px;
      width: 22px;
      height: 22px;
      color: var(--fs-navy);
    }
    .scroll-row {
      display: flex;
      gap: 16px;
      overflow-x: auto;
      padding-bottom: 8px;
      scroll-snap-type: x mandatory;
      -webkit-overflow-scrolling: touch;
    }
    .scroll-row::-webkit-scrollbar {
      height: 6px;
    }
    .scroll-row::-webkit-scrollbar-track {
      background: #f0f0f0;
      border-radius: 3px;
    }
    .scroll-row::-webkit-scrollbar-thumb {
      background: #ccc;
      border-radius: 3px;
    }
    .product-mini-card {
      min-width: 200px;
      max-width: 200px;
      border-radius: 12px;
      overflow: hidden;
      scroll-snap-align: start;
      cursor: pointer;
      transition: transform 0.2s ease, box-shadow 0.2s ease;
      flex-shrink: 0;
    }
    .product-mini-card:hover {
      transform: translateY(-4px);
      box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
    }
    .card-image {
      height: 120px;
      background: #f0f2f5;
      position: relative;
      overflow: hidden;
    }
    .card-image img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
    .placeholder-img {
      width: 100%;
      height: 100%;
      display: flex;
      align-items: center;
      justify-content: center;
      background: linear-gradient(135deg, #1a237e, #263238);
    }
    .placeholder-img mat-icon {
      font-size: 32px;
      width: 32px;
      height: 32px;
      color: var(--fs-amber);
    }
    .install-badge {
      position: absolute;
      bottom: 6px;
      right: 6px;
      display: flex;
      align-items: center;
      gap: 4px;
      background: rgba(0, 0, 0, 0.7);
      color: white;
      font-size: 0.68rem;
      font-weight: 500;
      padding: 3px 8px;
      border-radius: 6px;
      backdrop-filter: blur(4px);
    }
    .install-badge mat-icon {
      font-size: 12px;
      width: 12px;
      height: 12px;
    }
    .product-mini-card mat-card-content {
      padding: 12px;
    }
    .product-brand {
      font-size: 0.7rem;
      color: #888;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }
    .product-name {
      font-size: 0.82rem;
      font-weight: 600;
      color: var(--fs-charcoal);
      margin: 4px 0 8px;
      line-height: 1.3;
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
      overflow: hidden;
    }
    .product-price {
      font-size: 1rem;
      font-weight: 700;
      color: var(--fs-navy);
    }
  `]
})
export class CommunityBuildsComponent implements OnInit {
  vehicleId = input.required<number>();

  private communityService = inject(CommunityService);

  products = signal<PopularProduct[]>([]);

  ngOnInit(): void {
    this.communityService.getPopularProducts(this.vehicleId()).subscribe({
      next: data => this.products.set(data)
    });
  }
}
