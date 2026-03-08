import { Component, inject, computed } from '@angular/core';
import { Router } from '@angular/router';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { CompareState } from '../../core/state/compare.state';

@Component({
  selector: 'app-compare-tray',
  standalone: true,
  imports: [MatIconModule, MatButtonModule],
  template: `
    @if (isVisible()) {
      <div class="compare-tray">
        <div class="tray-content">
          <div class="tray-items">
            @for (product of compareState.selectedProducts(); track product.id) {
              <div class="tray-item">
                <div class="item-thumbnail">
                  @if (product.imageUrl) {
                    <img [src]="product.imageUrl" [alt]="product.name">
                  } @else {
                    <mat-icon>inventory_2</mat-icon>
                  }
                </div>
                <span class="item-name">{{ product.name }}</span>
                <button mat-icon-button class="remove-btn" (click)="remove(product.id)">
                  <mat-icon>close</mat-icon>
                </button>
              </div>
            }
            @if (emptySlots().length > 0) {
              @for (slot of emptySlots(); track slot) {
                <div class="tray-item empty-slot">
                  <div class="item-thumbnail placeholder">
                    <mat-icon>add</mat-icon>
                  </div>
                  <span class="item-name placeholder-text">Add product</span>
                </div>
              }
            }
          </div>
          <div class="tray-actions">
            <button mat-flat-button class="compare-btn" (click)="compareNow()"
              [disabled]="compareState.selectedProducts().length < 2">
              <mat-icon>compare_arrows</mat-icon>
              Compare Now
            </button>
            <button mat-button class="clear-btn" (click)="clearAll()">
              Clear All
            </button>
          </div>
        </div>
      </div>
    }
  `,
  styles: [`
    .compare-tray {
      position: fixed;
      bottom: 0;
      left: 0;
      right: 0;
      z-index: 1000;
      background: rgba(0, 0, 0, 0.92);
      background-image: linear-gradient(135deg, rgba(26, 35, 126, 0.95) 0%, rgba(0, 0, 0, 0.95) 100%);
      backdrop-filter: blur(12px);
      border-top: 1px solid rgba(255, 193, 7, 0.3);
      padding: 12px 24px;
      animation: slideUp 0.3s ease-out;
      box-shadow: 0 -4px 24px rgba(0, 0, 0, 0.4);
    }

    @keyframes slideUp {
      from {
        transform: translateY(100%);
        opacity: 0;
      }
      to {
        transform: translateY(0);
        opacity: 1;
      }
    }

    .tray-content {
      max-width: 1200px;
      margin: 0 auto;
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 24px;
    }

    .tray-items {
      display: flex;
      align-items: center;
      gap: 16px;
      flex: 1;
    }

    .tray-item {
      display: flex;
      align-items: center;
      gap: 10px;
      background: rgba(255, 255, 255, 0.08);
      border-radius: 10px;
      padding: 6px 10px;
      min-width: 180px;
      max-width: 240px;
      border: 1px solid rgba(255, 255, 255, 0.1);
    }

    .tray-item.empty-slot {
      border-style: dashed;
      border-color: rgba(255, 255, 255, 0.2);
      background: rgba(255, 255, 255, 0.03);
    }

    .item-thumbnail {
      width: 48px;
      height: 48px;
      border-radius: 8px;
      overflow: hidden;
      flex-shrink: 0;
      display: flex;
      align-items: center;
      justify-content: center;
      background: rgba(255, 255, 255, 0.1);
    }

    .item-thumbnail img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    .item-thumbnail mat-icon {
      color: rgba(255, 255, 255, 0.5);
    }

    .item-thumbnail.placeholder {
      background: rgba(255, 255, 255, 0.05);
    }

    .item-thumbnail.placeholder mat-icon {
      color: rgba(255, 255, 255, 0.2);
    }

    .item-name {
      flex: 1;
      color: white;
      font-size: 0.8rem;
      font-weight: 500;
      line-height: 1.3;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .placeholder-text {
      color: rgba(255, 255, 255, 0.3);
      font-style: italic;
    }

    .remove-btn {
      flex-shrink: 0;
      width: 28px !important;
      height: 28px !important;
      line-height: 28px;
    }

    .remove-btn mat-icon {
      font-size: 16px;
      width: 16px;
      height: 16px;
      color: rgba(255, 255, 255, 0.5);
    }

    .remove-btn:hover mat-icon {
      color: #ff5252;
    }

    .tray-actions {
      display: flex;
      align-items: center;
      gap: 12px;
      flex-shrink: 0;
    }

    .compare-btn {
      background: linear-gradient(135deg, #ffc107 0%, #ffab00 100%) !important;
      color: var(--fs-navy) !important;
      font-weight: 600 !important;
      border-radius: 8px !important;
      padding: 0 20px !important;
      height: 42px !important;
      font-size: 0.85rem !important;
      letter-spacing: 0.3px;
    }

    .compare-btn:disabled {
      opacity: 0.5 !important;
    }

    .compare-btn mat-icon {
      font-size: 18px;
      width: 18px;
      height: 18px;
      margin-right: 6px;
    }

    .clear-btn {
      color: rgba(255, 255, 255, 0.6) !important;
      font-size: 0.8rem !important;
    }

    .clear-btn:hover {
      color: white !important;
    }
  `]
})
export class CompareTrayComponent {
  readonly compareState = inject(CompareState);
  private router = inject(Router);

  readonly isVisible = computed(() => this.compareState.selectedProducts().length > 0);
  readonly emptySlots = computed(() => {
    const count = 3 - this.compareState.selectedProducts().length;
    return count > 0 ? Array.from({ length: count }, (_, i) => i) : [];
  });

  remove(id: number): void {
    this.compareState.removeFromCompare(id);
  }

  clearAll(): void {
    this.compareState.clear();
  }

  compareNow(): void {
    this.router.navigate(['/compare']);
  }
}
