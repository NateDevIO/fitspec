import { Component } from '@angular/core';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';

@Component({
  selector: 'app-admin-reviews',
  standalone: true,
  imports: [MatCardModule, MatIconModule],
  template: `
    <div class="reviews-container">
      <h1 class="page-title">Reviews</h1>

      <mat-card class="empty-state-card" appearance="outlined">
        <mat-card-content>
          <div class="empty-state">
            <div class="icon-wrap">
              <mat-icon>rate_review</mat-icon>
            </div>
            <h2 class="empty-title">Review Moderation Coming Soon</h2>
            <p class="empty-description">
              The review moderation panel is currently under development.
              You will be able to approve, reject, and manage customer reviews from this page.
            </p>
            <div class="feature-list">
              <div class="feature-item">
                <mat-icon>check_circle</mat-icon>
                <span>Approve or reject pending reviews</span>
              </div>
              <div class="feature-item">
                <mat-icon>flag</mat-icon>
                <span>Flag inappropriate content</span>
              </div>
              <div class="feature-item">
                <mat-icon>analytics</mat-icon>
                <span>Review analytics and sentiment tracking</span>
              </div>
              <div class="feature-item">
                <mat-icon>reply</mat-icon>
                <span>Respond to customer reviews</span>
              </div>
            </div>
          </div>
        </mat-card-content>
      </mat-card>
    </div>
  `,
  styles: [`
    .reviews-container { animation: fadeInUp 0.4s ease-out; }
    .page-title {
      font-size: 1.6rem;
      font-weight: 700;
      color: var(--fs-navy);
      margin: 0 0 24px;
    }
    .empty-state-card {
      border-radius: 16px;
      max-width: 600px;
    }
    .empty-state {
      text-align: center;
      padding: 48px 32px;
    }
    .icon-wrap {
      width: 80px;
      height: 80px;
      border-radius: 20px;
      background: linear-gradient(135deg, rgba(26, 35, 126, 0.08), rgba(26, 35, 126, 0.04));
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 20px;
    }
    .icon-wrap mat-icon {
      font-size: 40px;
      width: 40px;
      height: 40px;
      color: var(--fs-navy);
    }
    .empty-title {
      font-size: 1.3rem;
      font-weight: 700;
      color: #263238;
      margin: 0 0 12px;
    }
    .empty-description {
      font-size: 0.9rem;
      color: #777;
      line-height: 1.6;
      margin: 0 0 28px;
      max-width: 440px;
      margin-left: auto;
      margin-right: auto;
    }
    .feature-list {
      display: flex;
      flex-direction: column;
      gap: 14px;
      text-align: left;
      max-width: 360px;
      margin: 0 auto;
    }
    .feature-item {
      display: flex;
      align-items: center;
      gap: 12px;
      font-size: 0.88rem;
      color: #555;
    }
    .feature-item mat-icon {
      font-size: 20px;
      width: 20px;
      height: 20px;
      color: #4caf50;
      flex-shrink: 0;
    }
  `]
})
export class AdminReviewsComponent {}
