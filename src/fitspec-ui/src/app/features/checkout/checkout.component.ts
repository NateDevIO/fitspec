import { Component, inject, signal, computed } from '@angular/core';
import { Router, RouterLink } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { CurrencyPipe } from '@angular/common';
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatDividerModule } from '@angular/material/divider';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';
import { BuildState } from '../../core/state/build.state';

const US_STATES = [
  'AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN','IA',
  'KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ',
  'NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT',
  'VA','WA','WV','WI','WY'
];

@Component({
  selector: 'app-checkout',
  standalone: true,
  imports: [
    FormsModule, CurrencyPipe, RouterLink,
    MatCardModule, MatButtonModule, MatIconModule, MatFormFieldModule,
    MatInputModule, MatSelectModule, MatDividerModule, MatSnackBarModule,
  ],
  template: `
    <!-- Demo Banner -->
    <div class="demo-banner">
      <mat-icon>info</mat-icon>
      <div>
        <strong>Demo Checkout - For Demonstration Purposes Only</strong>
        <span>No real transactions will be processed. This is a portfolio project showcase.</span>
      </div>
    </div>

    <div class="checkout-container">
      @if (buildState.items().length === 0 && !orderPlaced()) {
        <div class="empty-cart">
          <mat-icon>remove_shopping_cart</mat-icon>
          <h2>Your build is empty</h2>
          <p>Add some parts to your build before checking out.</p>
          <a mat-flat-button routerLink="/" class="shop-btn">
            <mat-icon>arrow_back</mat-icon> Continue Shopping
          </a>
        </div>
      } @else {
        <h1 class="page-title">
          <mat-icon>shopping_cart_checkout</mat-icon>
          Checkout
        </h1>

        <div class="checkout-grid">
          <!-- Left Column: Forms -->
          <div class="forms-column">
            <!-- Shipping Information -->
            <mat-card class="checkout-card">
              <mat-card-header>
                <mat-icon mat-card-avatar class="section-icon">local_shipping</mat-icon>
                <mat-card-title>Shipping Information</mat-card-title>
                <mat-card-subtitle>Demo - no real data is collected</mat-card-subtitle>
              </mat-card-header>
              <mat-card-content>
                <div class="form-grid">
                  <mat-form-field appearance="outline" class="full-width">
                    <mat-label>Full Name</mat-label>
                    <input matInput [(ngModel)]="shippingName" placeholder="John Doe">
                    <mat-icon matPrefix>person</mat-icon>
                  </mat-form-field>

                  <mat-form-field appearance="outline" class="full-width">
                    <mat-label>Street Address</mat-label>
                    <input matInput [(ngModel)]="shippingAddress" placeholder="123 Main St">
                    <mat-icon matPrefix>home</mat-icon>
                  </mat-form-field>

                  <div class="form-row">
                    <mat-form-field appearance="outline" class="city-field">
                      <mat-label>City</mat-label>
                      <input matInput [(ngModel)]="shippingCity" placeholder="Springfield">
                    </mat-form-field>

                    <mat-form-field appearance="outline" class="state-field">
                      <mat-label>State</mat-label>
                      <mat-select [(ngModel)]="shippingState">
                        @for (state of states; track state) {
                          <mat-option [value]="state">{{ state }}</mat-option>
                        }
                      </mat-select>
                    </mat-form-field>

                    <mat-form-field appearance="outline" class="zip-field">
                      <mat-label>ZIP Code</mat-label>
                      <input matInput [(ngModel)]="shippingZip" placeholder="62704" maxlength="5">
                    </mat-form-field>
                  </div>
                </div>
              </mat-card-content>
            </mat-card>

            <!-- Payment Information -->
            <mat-card class="checkout-card payment-card">
              <mat-card-header>
                <mat-icon mat-card-avatar class="section-icon">credit_card</mat-icon>
                <mat-card-title>Payment Information</mat-card-title>
                <mat-card-subtitle>Demo only - do NOT enter real payment details</mat-card-subtitle>
              </mat-card-header>
              <mat-card-content>
                <div class="demo-payment-warning">
                  <mat-icon>warning</mat-icon>
                  <span>This is a demo form. No payment processing occurs. Do not enter real card information.</span>
                </div>

                <div class="form-grid">
                  <mat-form-field appearance="outline" class="full-width">
                    <mat-label>Card Number</mat-label>
                    <input matInput [(ngModel)]="cardNumber" placeholder="4242 4242 4242 4242" maxlength="19">
                    <mat-icon matPrefix>credit_card</mat-icon>
                  </mat-form-field>

                  <div class="form-row">
                    <mat-form-field appearance="outline" class="expiry-field">
                      <mat-label>Expiration</mat-label>
                      <input matInput [(ngModel)]="cardExpiry" placeholder="MM/YY" maxlength="5">
                      <mat-icon matPrefix>date_range</mat-icon>
                    </mat-form-field>

                    <mat-form-field appearance="outline" class="cvv-field">
                      <mat-label>CVV</mat-label>
                      <input matInput [(ngModel)]="cardCvv" placeholder="123" maxlength="4" type="password">
                      <mat-icon matPrefix>lock</mat-icon>
                    </mat-form-field>
                  </div>
                </div>
              </mat-card-content>
            </mat-card>
          </div>

          <!-- Right Column: Order Summary -->
          <div class="summary-column">
            <mat-card class="checkout-card summary-card">
              <mat-card-header>
                <mat-icon mat-card-avatar class="section-icon">receipt_long</mat-icon>
                <mat-card-title>Order Summary</mat-card-title>
                <mat-card-subtitle>{{ buildState.totalItems() }} item(s)</mat-card-subtitle>
              </mat-card-header>
              <mat-card-content>
                <div class="order-items">
                  @for (item of buildState.items(); track item.product.id) {
                    <div class="order-item">
                      <div class="item-image">
                        @if (item.product.imageUrl) {
                          <img [src]="item.product.imageUrl" [alt]="item.product.name">
                        } @else {
                          <div class="no-image">
                            <mat-icon>image</mat-icon>
                          </div>
                        }
                      </div>
                      <div class="item-details">
                        <span class="item-name">{{ item.product.name }}</span>
                        <span class="item-brand">{{ item.product.brand }}</span>
                        <span class="item-unit-price">{{ item.product.price | currency }} each</span>
                      </div>
                      <div class="item-controls">
                        <div class="quantity-controls">
                          <button mat-icon-button (click)="decrementQty(item.product.id, item.quantity)" class="qty-btn">
                            <mat-icon>remove</mat-icon>
                          </button>
                          <span class="qty-value">{{ item.quantity }}</span>
                          <button mat-icon-button (click)="incrementQty(item.product.id, item.quantity)" class="qty-btn">
                            <mat-icon>add</mat-icon>
                          </button>
                        </div>
                        <span class="item-total">{{ item.product.price * item.quantity | currency }}</span>
                        <button mat-icon-button (click)="buildState.removeItem(item.product.id)" class="remove-btn" title="Remove item">
                          <mat-icon>delete_outline</mat-icon>
                        </button>
                      </div>
                    </div>
                  }
                </div>

                <mat-divider></mat-divider>

                <div class="price-breakdown">
                  <div class="price-line">
                    <span>Subtotal</span>
                    <span>{{ subtotal() | currency }}</span>
                  </div>
                  <div class="price-line">
                    <span>Estimated Tax (8.25%)</span>
                    <span>{{ tax() | currency }}</span>
                  </div>
                  <div class="price-line shipping">
                    <span>Shipping</span>
                    <span class="free-shipping">FREE</span>
                  </div>
                  <mat-divider></mat-divider>
                  <div class="price-line total-line">
                    <span>Total</span>
                    <span>{{ total() | currency }}</span>
                  </div>
                </div>

                <button mat-flat-button class="place-order-btn" (click)="placeOrder()">
                  <mat-icon>storefront</mat-icon>
                  Place Order (Demo)
                </button>

                <p class="demo-note">
                  <mat-icon>info</mat-icon>
                  This button simulates placing an order. No real transaction occurs.
                </p>
              </mat-card-content>
            </mat-card>
          </div>
        </div>
      }
    </div>
  `,
  styles: [`
    .demo-banner {
      background: linear-gradient(135deg, #e65100, #ff8f00);
      color: white;
      padding: 16px 24px;
      display: flex;
      align-items: center;
      gap: 16px;
      font-size: 0.95rem;
    }
    .demo-banner mat-icon {
      font-size: 32px;
      width: 32px;
      height: 32px;
      flex-shrink: 0;
    }
    .demo-banner strong {
      display: block;
      font-size: 1.1rem;
      margin-bottom: 2px;
    }
    .demo-banner span {
      opacity: 0.9;
      font-size: 0.85rem;
    }

    .checkout-container {
      max-width: 1200px;
      margin: 0 auto;
      padding: 24px;
    }

    .page-title {
      display: flex;
      align-items: center;
      gap: 12px;
      font-size: 1.8rem;
      color: var(--fs-navy);
      margin-bottom: 24px;
      font-weight: 700;
    }
    .page-title mat-icon {
      font-size: 32px;
      width: 32px;
      height: 32px;
      color: var(--fs-amber);
    }

    .empty-cart {
      text-align: center;
      padding: 64px 24px;
    }
    .empty-cart mat-icon {
      font-size: 72px;
      width: 72px;
      height: 72px;
      color: #ccc;
    }
    .empty-cart h2 {
      color: var(--fs-charcoal);
      margin: 16px 0 8px;
    }
    .empty-cart p {
      color: #666;
      margin-bottom: 24px;
    }
    .shop-btn {
      background: var(--fs-gradient-navy) !important;
      color: white !important;
    }

    .checkout-grid {
      display: grid;
      grid-template-columns: 1fr 420px;
      gap: 24px;
      align-items: start;
    }

    .checkout-card {
      border-radius: 12px;
      margin-bottom: 24px;
      overflow: hidden;
    }
    .checkout-card mat-card-header {
      background: var(--fs-gradient-navy);
      color: white;
      padding: 16px;
    }
    .checkout-card mat-card-header mat-card-title {
      color: white;
      font-size: 1.1rem;
    }
    .checkout-card mat-card-header mat-card-subtitle {
      color: rgba(255, 255, 255, 0.7);
    }
    .section-icon {
      background: rgba(255, 193, 7, 0.2);
      color: var(--fs-amber) !important;
      border-radius: 8px;
    }
    .checkout-card mat-card-content {
      padding: 24px;
    }

    .form-grid {
      display: flex;
      flex-direction: column;
      gap: 4px;
    }
    .full-width {
      width: 100%;
    }
    .form-row {
      display: flex;
      gap: 12px;
    }
    .city-field { flex: 2; }
    .state-field { flex: 1; }
    .zip-field { flex: 1; }
    .expiry-field { flex: 1; }
    .cvv-field { flex: 1; }

    .demo-payment-warning {
      background: #fff3e0;
      border: 1px solid #ff9800;
      border-radius: 8px;
      padding: 12px 16px;
      display: flex;
      align-items: center;
      gap: 12px;
      margin-bottom: 20px;
      font-size: 0.85rem;
      color: #e65100;
    }
    .demo-payment-warning mat-icon {
      color: #ff9800;
      flex-shrink: 0;
    }

    /* Order Summary */
    .order-items {
      max-height: 400px;
      overflow-y: auto;
    }
    .order-item {
      display: flex;
      align-items: center;
      gap: 12px;
      padding: 12px 0;
      border-bottom: 1px solid #eee;
    }
    .order-item:last-child {
      border-bottom: none;
    }
    .item-image {
      width: 56px;
      height: 56px;
      border-radius: 8px;
      overflow: hidden;
      flex-shrink: 0;
      background: #f5f5f5;
    }
    .item-image img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
    .no-image {
      width: 100%;
      height: 100%;
      display: flex;
      align-items: center;
      justify-content: center;
      color: #ccc;
    }
    .item-details {
      flex: 1;
      display: flex;
      flex-direction: column;
      min-width: 0;
    }
    .item-name {
      font-weight: 600;
      font-size: 0.85rem;
      color: var(--fs-charcoal);
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }
    .item-brand {
      font-size: 0.75rem;
      color: #888;
    }
    .item-unit-price {
      font-size: 0.75rem;
      color: var(--fs-navy);
    }
    .item-controls {
      display: flex;
      flex-direction: column;
      align-items: flex-end;
      gap: 4px;
    }
    .quantity-controls {
      display: flex;
      align-items: center;
      gap: 4px;
      background: #f5f5f5;
      border-radius: 20px;
      padding: 0 4px;
    }
    .qty-btn {
      width: 28px !important;
      height: 28px !important;
      line-height: 28px !important;
    }
    .qty-btn mat-icon {
      font-size: 16px;
      width: 16px;
      height: 16px;
      color: var(--fs-navy);
    }
    .qty-value {
      font-weight: 600;
      font-size: 0.85rem;
      min-width: 20px;
      text-align: center;
    }
    .item-total {
      font-weight: 700;
      font-size: 0.9rem;
      color: var(--fs-navy);
    }
    .remove-btn {
      color: #e53935 !important;
      width: 28px !important;
      height: 28px !important;
      line-height: 28px !important;
    }
    .remove-btn mat-icon {
      font-size: 18px;
      width: 18px;
      height: 18px;
    }

    .price-breakdown {
      padding: 16px 0;
    }
    .price-line {
      display: flex;
      justify-content: space-between;
      padding: 6px 0;
      font-size: 0.9rem;
      color: #555;
    }
    .free-shipping {
      color: #2e7d32;
      font-weight: 600;
    }
    .total-line {
      font-size: 1.25rem;
      font-weight: 700;
      color: var(--fs-navy);
      padding-top: 12px;
    }

    .place-order-btn {
      width: 100%;
      padding: 12px;
      font-size: 1.05rem;
      font-weight: 600;
      margin-top: 16px;
      background: var(--fs-gradient-navy) !important;
      color: white !important;
      border-radius: 8px;
    }
    .place-order-btn mat-icon {
      margin-right: 8px;
    }

    .demo-note {
      display: flex;
      align-items: center;
      gap: 8px;
      font-size: 0.78rem;
      color: #999;
      margin-top: 12px;
      text-align: center;
      justify-content: center;
    }
    .demo-note mat-icon {
      font-size: 16px;
      width: 16px;
      height: 16px;
    }

    @media (max-width: 900px) {
      .checkout-grid {
        grid-template-columns: 1fr;
      }
      .summary-column {
        order: -1;
      }
      .form-row {
        flex-wrap: wrap;
      }
      .city-field, .state-field, .zip-field {
        flex: 1 1 100%;
      }
    }
    @media (max-width: 480px) {
      .checkout-container { padding: 12px; }
      .page-title { font-size: 1.3rem; margin-bottom: 16px; }
      .page-title mat-icon { font-size: 24px; width: 24px; height: 24px; }
      .checkout-card mat-card-content { padding: 16px; }
      .demo-banner { padding: 12px 16px; gap: 10px; }
      .demo-banner mat-icon { font-size: 24px; width: 24px; height: 24px; }
      .demo-banner strong { font-size: 0.9rem; }
      .expiry-field, .cvv-field { flex: 1 1 100%; }
    }
  `]
})
export class CheckoutComponent {
  readonly buildState = inject(BuildState);
  private readonly router = inject(Router);
  private readonly snackBar = inject(MatSnackBar);

  readonly states = US_STATES;

  // Shipping fields
  shippingName = '';
  shippingAddress = '';
  shippingCity = '';
  shippingState = '';
  shippingZip = '';

  // Payment fields
  cardNumber = '';
  cardExpiry = '';
  cardCvv = '';

  // Order state
  orderPlaced = signal(false);

  readonly TAX_RATE = 0.0825;

  readonly subtotal = computed(() => this.buildState.totalPrice());
  readonly tax = computed(() => this.subtotal() * this.TAX_RATE);
  readonly total = computed(() => this.subtotal() + this.tax());

  incrementQty(productId: number, current: number): void {
    this.buildState.updateQuantity(productId, current + 1);
  }

  decrementQty(productId: number, current: number): void {
    this.buildState.updateQuantity(productId, current - 1);
  }

  placeOrder(): void {
    this.orderPlaced.set(true);
    this.buildState.clearBuild();

    this.snackBar.open(
      'Demo order placed successfully! In a production app, this would process payment and create an order.',
      'OK',
      {
        duration: 8000,
        horizontalPosition: 'center',
        verticalPosition: 'top',
        panelClass: ['demo-snackbar'],
      }
    );

    setTimeout(() => {
      this.router.navigate(['/']);
    }, 3000);
  }
}
