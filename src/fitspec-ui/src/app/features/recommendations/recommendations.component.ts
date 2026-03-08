import { Component, inject, input, signal, OnInit } from '@angular/core';
import { RouterLink } from '@angular/router';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { CurrencyPipe } from '@angular/common';
import { ProductService } from '../../core/services/product.service';
import { ProductRecommendationDto } from '../../core/models';

@Component({
  selector: 'app-recommendations',
  standalone: true,
  imports: [RouterLink, MatCardModule, MatIconModule, MatButtonModule, CurrencyPipe],
  template: `
    @if (recommendations().length > 0) {
      <div class="recs-section">
        <h2>Frequently Bought Together</h2>
        <div class="recs-row">
          @for (rec of recommendations(); track rec.productId) {
            <mat-card class="rec-card" appearance="outlined" [routerLink]="['/products', rec.productId]">
              <div class="rec-image">
                @if (rec.imageUrl) {
                  <img [src]="rec.imageUrl" [alt]="rec.name">
                } @else {
                  <div class="rec-placeholder">
                    <mat-icon>inventory_2</mat-icon>
                  </div>
                }
              </div>
              <mat-card-content>
                <span class="rec-category">{{ rec.categoryName }}</span>
                <h4 class="rec-name">{{ rec.name }}</h4>
                <span class="rec-brand">{{ rec.brand }}</span>
                <span class="rec-price">{{ rec.price | currency }}</span>
              </mat-card-content>
            </mat-card>
          }
        </div>
      </div>
    }
  `,
  styles: [`
    .recs-section { margin-top: 32px; }
    .recs-section h2 { margin: 0 0 16px; }
    .recs-row {
      display: flex;
      gap: 16px;
      overflow-x: auto;
      padding-bottom: 8px;
    }
    .rec-card {
      min-width: 200px;
      max-width: 220px;
      border-radius: 12px;
      cursor: pointer;
      transition: transform 0.2s;
      flex-shrink: 0;
    }
    .rec-card:hover { transform: translateY(-4px); }
    .rec-image { height: 120px; background: #f5f5f5; display: flex; align-items: center; justify-content: center; overflow: hidden; border-radius: 12px 12px 0 0; }
    .rec-image img { width: 100%; height: 100%; object-fit: cover; }
    .rec-placeholder mat-icon { font-size: 36px; width: 36px; height: 36px; color: #ccc; }
    .rec-category { font-size: 0.7rem; color: #888; text-transform: uppercase; letter-spacing: 0.5px; }
    .rec-name { font-size: 0.85rem; font-weight: 500; margin: 4px 0; line-height: 1.3; }
    .rec-brand { font-size: 0.75rem; color: #666; display: block; }
    .rec-price { font-size: 1rem; font-weight: 700; color: var(--fs-navy); display: block; margin-top: 4px; }
  `]
})
export class RecommendationsComponent implements OnInit {
  productId = input.required<number>();
  private productService = inject(ProductService);
  recommendations = signal<ProductRecommendationDto[]>([]);

  ngOnInit(): void {
    this.productService.getRecommendations(this.productId()).subscribe({
      next: recs => this.recommendations.set(recs)
    });
  }
}
