import { Component, inject, input, signal, OnInit } from '@angular/core';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatChipsModule } from '@angular/material/chips';
import { MatProgressBarModule } from '@angular/material/progress-bar';
import { MatPaginatorModule, PageEvent } from '@angular/material/paginator';
import { MatSlideToggleModule } from '@angular/material/slide-toggle';
import { DatePipe } from '@angular/common';
import { ProductService } from '../../core/services/product.service';
import { ReviewSummaryDto, ReviewDto } from '../../core/models';
import { VehicleState } from '../../core/state/vehicle.state';

@Component({
  selector: 'app-product-reviews',
  standalone: true,
  imports: [MatCardModule, MatIconModule, MatButtonModule, MatChipsModule, MatProgressBarModule, MatPaginatorModule, MatSlideToggleModule, DatePipe],
  template: `
    <div class="reviews-section">
      <div class="reviews-header">
        <h2>Customer Reviews</h2>
        @if (vehicleState.selectedVehicle()) {
          <mat-slide-toggle
            [checked]="filterByVehicle()"
            (change)="toggleVehicleFilter($event.checked)">
            Show only reviews for my vehicle
          </mat-slide-toggle>
        }
      </div>

      @if (summary()) {
        <div class="rating-overview">
          <div class="avg-rating">
            <span class="rating-number">{{ summary()!.averageRating }}</span>
            <div class="stars">
              @for (star of [1,2,3,4,5]; track star) {
                <mat-icon [class.filled]="star <= summary()!.averageRating">
                  {{ star <= summary()!.averageRating ? 'star' : 'star_border' }}
                </mat-icon>
              }
            </div>
            <span class="total-count">{{ summary()!.totalReviews }} reviews</span>
          </div>
          <div class="rating-bars">
            @for (rating of [5,4,3,2,1]; track rating) {
              <div class="bar-row">
                <span class="bar-label">{{ rating }}</span>
                <mat-progress-bar mode="determinate"
                  [value]="getBarPercent(rating)">
                </mat-progress-bar>
                <span class="bar-count">{{ summary()!.ratingDistribution[rating] || 0 }}</span>
              </div>
            }
          </div>
        </div>

        <div class="review-list">
          @for (review of reviews(); track review.id) {
            <mat-card class="review-card" appearance="outlined">
              <mat-card-content>
                <div class="review-header-row">
                  <div class="reviewer">
                    <strong>{{ review.reviewerName }}</strong>
                    @if (review.verifiedPurchase) {
                      <mat-chip class="verified-chip">Verified Purchase</mat-chip>
                    }
                  </div>
                  <span class="review-date">{{ review.createdAt | date:'mediumDate' }}</span>
                </div>
                <div class="review-stars">
                  @for (star of [1,2,3,4,5]; track star) {
                    <mat-icon class="star-sm" [class.filled]="star <= review.rating">
                      {{ star <= review.rating ? 'star' : 'star_border' }}
                    </mat-icon>
                  }
                </div>
                <h4 class="review-title">{{ review.title }}</h4>
                <p class="review-body">{{ review.body }}</p>
                @if (review.vehicleDescription) {
                  <span class="vehicle-tag">
                    <mat-icon>directions_car</mat-icon> {{ review.vehicleDescription }}
                  </span>
                }
              </mat-card-content>
            </mat-card>
          } @empty {
            <p class="no-reviews">No reviews yet for this product.</p>
          }
        </div>

        @if (summary()!.totalReviews > 10) {
          <mat-paginator
            [length]="summary()!.totalReviews"
            [pageSize]="10"
            (page)="onPageChange($event)"
            showFirstLastButtons />
        }
      }
    </div>
  `,
  styles: [`
    .reviews-section { margin-top: 32px; }
    .reviews-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px; flex-wrap: wrap; gap: 8px; }
    .reviews-header h2 { margin: 0; }
    .rating-overview { display: flex; gap: 32px; margin-bottom: 24px; padding: 16px; background: #f5f5f5; border-radius: 12px; }
    .avg-rating { text-align: center; min-width: 120px; }
    .rating-number { font-size: 3rem; font-weight: 700; color: var(--fs-navy); }
    .stars mat-icon { color: #ffc107; }
    .stars mat-icon.filled { color: #ffc107; }
    .total-count { font-size: 0.85rem; color: #666; }
    .rating-bars { flex: 1; display: flex; flex-direction: column; gap: 4px; justify-content: center; }
    .bar-row { display: flex; align-items: center; gap: 8px; }
    .bar-label { width: 16px; font-size: 0.85rem; text-align: right; }
    .bar-count { width: 32px; font-size: 0.85rem; color: #666; }
    mat-progress-bar { flex: 1; }
    .review-card { margin-bottom: 12px; border-radius: 8px; }
    .review-header-row { display: flex; justify-content: space-between; align-items: center; }
    .reviewer { display: flex; align-items: center; gap: 8px; }
    .verified-chip { font-size: 0.7rem; }
    .review-date { font-size: 0.8rem; color: #888; }
    .review-stars mat-icon, .star-sm { font-size: 16px; width: 16px; height: 16px; color: #ffc107; }
    .review-title { margin: 8px 0 4px; }
    .review-body { color: #444; line-height: 1.5; }
    .vehicle-tag { display: inline-flex; align-items: center; gap: 4px; font-size: 0.8rem; color: #666; margin-top: 8px; }
    .vehicle-tag mat-icon { font-size: 16px; width: 16px; height: 16px; }
    .no-reviews { text-align: center; color: #888; padding: 24px; }
    @media (max-width: 768px) { .rating-overview { flex-direction: column; } }
  `]
})
export class ProductReviewsComponent implements OnInit {
  productId = input.required<number>();
  vehicleState = inject(VehicleState);
  private productService = inject(ProductService);

  summary = signal<ReviewSummaryDto | null>(null);
  reviews = signal<ReviewDto[]>([]);
  filterByVehicle = signal(false);

  ngOnInit(): void {
    this.loadReviews();
  }

  toggleVehicleFilter(checked: boolean): void {
    this.filterByVehicle.set(checked);
    this.loadReviews();
  }

  onPageChange(event: PageEvent): void {
    this.loadReviews(event.pageIndex + 1);
  }

  getBarPercent(rating: number): number {
    const s = this.summary();
    if (!s || s.totalReviews === 0) return 0;
    return ((s.ratingDistribution[rating] || 0) / s.totalReviews) * 100;
  }

  private loadReviews(page = 1): void {
    const vehicleId = this.filterByVehicle() ? this.vehicleState.selectedVehicle()?.id : undefined;
    this.productService.getReviews(this.productId(), vehicleId, page).subscribe({
      next: summary => {
        this.summary.set(summary);
        this.reviews.set(summary.reviews.items);
      }
    });
  }
}
