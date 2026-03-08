import { Injectable, signal, computed } from '@angular/core';
import { ProductSummaryDto } from '../../core/models';

@Injectable({ providedIn: 'root' })
export class CompareState {
  private static readonly MAX_ITEMS = 3;

  // Signals
  readonly selectedIds = signal<number[]>([]);
  readonly selectedProducts = signal<ProductSummaryDto[]>([]);

  // Computed
  readonly canAddMore = computed(() => this.selectedIds().length < CompareState.MAX_ITEMS);

  isSelected(id: number): boolean {
    return this.selectedIds().includes(id);
  }

  addToCompare(product: ProductSummaryDto): void {
    if (!this.canAddMore() || this.isSelected(product.id)) {
      return;
    }
    this.selectedIds.update(ids => [...ids, product.id]);
    this.selectedProducts.update(products => [...products, product]);
  }

  removeFromCompare(id: number): void {
    this.selectedIds.update(ids => ids.filter(i => i !== id));
    this.selectedProducts.update(products => products.filter(p => p.id !== id));
  }

  clear(): void {
    this.selectedIds.set([]);
    this.selectedProducts.set([]);
  }
}
