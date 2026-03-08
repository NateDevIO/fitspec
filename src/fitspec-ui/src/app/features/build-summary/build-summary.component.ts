import { Component, inject, signal, computed } from '@angular/core';
import { MatSidenavModule } from '@angular/material/sidenav';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatBadgeModule } from '@angular/material/badge';
import { MatDividerModule } from '@angular/material/divider';
import { CurrencyPipe } from '@angular/common';
import { RouterLink } from '@angular/router';
import { BuildState } from '../../core/state/build.state';
import { BuildExportService, BuildExportItem } from '../../core/services/build-export.service';
import { VehicleState } from '../../core/state/vehicle.state';

@Component({
  selector: 'app-build-summary',
  standalone: true,
  imports: [MatSidenavModule, MatCardModule, MatIconModule, MatButtonModule, MatBadgeModule, MatDividerModule, CurrencyPipe, RouterLink],
  template: `
    <div class="build-sidebar" [class.open]="isOpen()">
      <div class="build-header">
        <h3>
          <mat-icon>build</mat-icon> My Build
          <span class="item-count">({{ buildState.totalItems() }})</span>
        </h3>
        <button mat-icon-button (click)="toggle()">
          <mat-icon>{{ isOpen() ? 'chevron_right' : 'chevron_left' }}</mat-icon>
        </button>
      </div>

      @if (isOpen()) {
        <div class="build-content">
          @if (buildState.items().length === 0) {
            <div class="empty-build">
              <mat-icon>shopping_cart</mat-icon>
              <p>No items in your build yet</p>
            </div>
          } @else {
            @for (entry of categoryEntries(); track entry[0]) {
              <div class="category-group">
                <h4 class="cat-label">{{ entry[0] }}</h4>
                @for (item of entry[1]; track item.product.id) {
                  <div class="build-item">
                    <div class="item-info">
                      <span class="item-name">{{ item.product.name }}</span>
                      <span class="item-price">{{ item.product.price | currency }}</span>
                    </div>
                    <button mat-icon-button (click)="buildState.removeItem(item.product.id)" class="remove-btn">
                      <mat-icon>close</mat-icon>
                    </button>
                  </div>
                }
              </div>
              <mat-divider></mat-divider>
            }

            <div class="build-total">
              <span>Total</span>
              <span class="total-price">{{ buildState.totalPrice() | currency }}</span>
            </div>

            <button mat-flat-button class="checkout-btn" routerLink="/checkout" (click)="toggle()">
              <mat-icon>shopping_cart_checkout</mat-icon> Proceed to Checkout
            </button>

            <button mat-flat-button class="export-btn" (click)="exportPdf()">
              <mat-icon>picture_as_pdf</mat-icon> Export PDF
            </button>

            <button mat-flat-button color="warn" (click)="buildState.clearBuild()" class="clear-btn">
              <mat-icon>delete</mat-icon> Clear Build
            </button>
          }
        </div>
      }
    </div>

    <button mat-fab class="build-fab" [matBadge]="buildState.totalItems()" matBadgeColor="warn"
      [matBadgeHidden]="buildState.totalItems() === 0" (click)="toggle()">
      <mat-icon>build</mat-icon>
    </button>
  `,
  styles: [`
    .build-sidebar {
      position: fixed;
      right: 0;
      top: 64px;
      bottom: 0;
      width: 320px;
      background: white;
      box-shadow: -4px 0 16px rgba(0,0,0,0.1);
      transform: translateX(100%);
      transition: transform 0.3s ease;
      z-index: 100;
      display: flex;
      flex-direction: column;
      overflow-y: auto;
    }
    .build-sidebar.open { transform: translateX(0); }
    .build-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 16px;
      background: var(--fs-gradient-navy);
      color: white;
    }
    .build-header h3 { margin: 0; display: flex; align-items: center; gap: 8px; font-size: 1rem; }
    .build-header mat-icon { color: var(--fs-amber); }
    .item-count { font-weight: 400; color: rgba(255,255,255,0.7); }
    .build-content { padding: 16px; flex: 1; }
    .empty-build { text-align: center; padding: 32px 0; color: #999; }
    .empty-build mat-icon { font-size: 48px; width: 48px; height: 48px; }
    .category-group { margin-bottom: 8px; }
    .cat-label { font-size: 0.75rem; text-transform: uppercase; color: #888; letter-spacing: 0.5px; margin: 8px 0 4px; }
    .build-item { display: flex; align-items: center; justify-content: space-between; padding: 4px 0; }
    .item-info { display: flex; flex-direction: column; flex: 1; }
    .item-name { font-size: 0.85rem; font-weight: 500; }
    .item-price { font-size: 0.8rem; color: var(--fs-navy); font-weight: 600; }
    .remove-btn { color: #999; }
    .build-total {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 16px 0;
      font-size: 1.1rem;
      font-weight: 600;
    }
    .total-price { color: var(--fs-navy); font-size: 1.3rem; }
    .checkout-btn {
      width: 100%;
      margin-top: 8px;
      background: var(--fs-gradient-amber) !important;
      color: #263238 !important;
      font-weight: 600;
    }
    .export-btn {
      width: 100%;
      margin-top: 8px;
      background: var(--fs-gradient-navy);
      color: white;
    }
    .clear-btn { width: 100%; margin-top: 8px; }
    .build-fab {
      position: fixed;
      bottom: 24px;
      right: 24px;
      z-index: 99;
      background: #1a237e !important;
      color: white !important;
    }
    @media (max-width: 768px) {
      .build-sidebar { width: 100%; }
    }
  `]
})
export class BuildSummaryComponent {
  buildState = inject(BuildState);
  private exportService = inject(BuildExportService);
  private vehicleState = inject(VehicleState);
  isOpen = signal(false);

  categoryEntries = computed(() =>
    Array.from(this.buildState.itemsByCategory().entries())
  );

  toggle(): void {
    this.isOpen.update(v => !v);
  }

  exportPdf(): void {
    const items: BuildExportItem[] = this.buildState.items().map(i => ({
      productId: i.product.id,
      quantity: i.quantity
    }));
    const v = this.vehicleState.selectedVehicle();
    const vehicleName = v ? `${v.year} ${v.make} ${v.model}` : undefined;
    this.exportService.exportPdf(items, vehicleName);
  }
}
