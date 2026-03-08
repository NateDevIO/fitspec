import { Component, inject, signal, input } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { CurrencyPipe } from '@angular/common';
import { ProductService } from '../../core/services/product.service';

@Component({
  selector: 'app-price-alert',
  standalone: true,
  imports: [FormsModule, MatCardModule, MatIconModule, MatButtonModule, MatFormFieldModule, MatInputModule, MatProgressSpinnerModule, CurrencyPipe],
  template: `
    <mat-card appearance="outlined" class="alert-card">
      @if (subscribed()) {
        <div class="success-state">
          <mat-icon class="success-icon">notifications_active</mat-icon>
          <div class="success-text">
            <span class="success-title">Price Alert Set!</span>
            <span class="success-desc">We'll email you when <strong>{{ productName() }}</strong> drops below {{ currentPrice() | currency }}.</span>
          </div>
        </div>
      } @else if (expanded()) {
        <div class="expanded-state">
          <div class="alert-header">
            <mat-icon class="bell-icon">notifications</mat-icon>
            <span class="alert-title">Get notified when the price drops</span>
          </div>
          <div class="alert-form">
            <mat-form-field appearance="outline" class="email-field">
              <mat-label>Email address</mat-label>
              <input matInput [(ngModel)]="email" type="email" placeholder="you@example.com">
              <mat-icon matPrefix class="email-prefix">mail</mat-icon>
            </mat-form-field>
            <button mat-flat-button class="subscribe-btn"
              [disabled]="!isValidEmail() || submitting()"
              (click)="subscribe()">
              @if (submitting()) {
                <mat-spinner diameter="18"></mat-spinner>
              } @else {
                Notify Me
              }
            </button>
            <button mat-icon-button class="close-btn" (click)="expanded.set(false)">
              <mat-icon>close</mat-icon>
            </button>
          </div>
        </div>
      } @else {
        <button mat-stroked-button class="trigger-btn" (click)="expanded.set(true)">
          <mat-icon>notifications_none</mat-icon>
          Get Price Drop Alert
        </button>
      }
    </mat-card>
  `,
  styles: [`
    .alert-card {
      border-radius: 12px;
      padding: 12px 16px;
      margin: 16px 0;
    }
    .trigger-btn {
      border-color: #ffc107 !important;
      color: #263238 !important;
      font-weight: 500;
    }
    .trigger-btn mat-icon {
      color: #ffc107;
      margin-right: 6px;
      font-size: 20px;
      width: 20px;
      height: 20px;
    }
    .expanded-state {}
    .alert-header {
      display: flex;
      align-items: center;
      gap: 8px;
      margin-bottom: 10px;
    }
    .bell-icon { color: #ffc107; font-size: 22px; width: 22px; height: 22px; }
    .alert-title { font-weight: 600; color: #263238; font-size: 0.9rem; }
    .alert-form { display: flex; align-items: flex-start; gap: 8px; }
    .email-field { flex: 1; }
    .email-prefix { color: #888; font-size: 18px; width: 18px; height: 18px; }
    .subscribe-btn {
      background-color: #ffc107 !important;
      color: #263238 !important;
      font-weight: 600;
      height: 56px;
    }
    .close-btn { color: #999; }
    .success-state {
      display: flex;
      align-items: center;
      gap: 12px;
    }
    .success-icon { color: #4caf50; font-size: 28px; width: 28px; height: 28px; }
    .success-text { display: flex; flex-direction: column; }
    .success-title { font-weight: 600; color: #4caf50; font-size: 0.95rem; }
    .success-desc { font-size: 0.8rem; color: #666; }
  `]
})
export class PriceAlertComponent {
  productId = input.required<number>();
  productName = input<string>('');
  currentPrice = input<number>(0);

  private productService = inject(ProductService);

  expanded = signal(false);
  submitting = signal(false);
  subscribed = signal(false);
  email = '';

  isValidEmail(): boolean {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(this.email);
  }

  subscribe(): void {
    if (!this.isValidEmail()) return;
    this.submitting.set(true);
    this.productService.subscribePriceAlert(this.productId(), this.email).subscribe({
      next: () => {
        this.subscribed.set(true);
        this.submitting.set(false);
      },
      error: () => this.submitting.set(false)
    });
  }
}
