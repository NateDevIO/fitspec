import { Injectable, signal, computed, effect } from '@angular/core';
import { ProductSummaryDto } from '../models';

export interface BuildItem {
  product: ProductSummaryDto;
  quantity: number;
}

@Injectable({ providedIn: 'root' })
export class BuildState {
  readonly items = signal<BuildItem[]>(
    JSON.parse(localStorage.getItem('fitspec_build') ?? '[]')
  );

  readonly totalItems = computed(() =>
    this.items().reduce((sum, item) => sum + item.quantity, 0)
  );

  readonly totalPrice = computed(() =>
    this.items().reduce((sum, item) => sum + item.product.price * item.quantity, 0)
  );

  readonly itemsByCategory = computed(() => {
    const map = new Map<string, BuildItem[]>();
    for (const item of this.items()) {
      const cat = item.product.categoryName;
      if (!map.has(cat)) map.set(cat, []);
      map.get(cat)!.push(item);
    }
    return map;
  });

  constructor() {
    effect(() => {
      localStorage.setItem('fitspec_build', JSON.stringify(this.items()));
    });
  }

  addItem(product: ProductSummaryDto): void {
    this.items.update(items => {
      const existing = items.find(i => i.product.id === product.id);
      if (existing) {
        return items.map(i =>
          i.product.id === product.id ? { ...i, quantity: i.quantity + 1 } : i
        );
      }
      return [...items, { product, quantity: 1 }];
    });
  }

  removeItem(productId: number): void {
    this.items.update(items => items.filter(i => i.product.id !== productId));
  }

  updateQuantity(productId: number, quantity: number): void {
    if (quantity <= 0) {
      this.removeItem(productId);
      return;
    }
    this.items.update(items =>
      items.map(i =>
        i.product.id === productId ? { ...i, quantity } : i
      )
    );
  }

  clearBuild(): void {
    this.items.set([]);
  }
}
