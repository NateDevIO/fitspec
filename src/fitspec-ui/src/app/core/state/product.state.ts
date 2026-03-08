import { Injectable, inject, signal, computed } from '@angular/core';
import { ProductService } from '../services/product.service';
import { ProductSummaryDto, ProductFilterParams } from '../models';

@Injectable({ providedIn: 'root' })
export class ProductState {
  private productService = inject(ProductService);

  // Signals
  readonly vehicleId = signal<number>(0);
  readonly products = signal<ProductSummaryDto[]>([]);
  readonly totalCount = signal(0);
  readonly currentPage = signal(1);
  readonly pageSize = signal(12);
  readonly loading = signal(false);
  readonly filters = signal<ProductFilterParams>({});

  // Computed
  readonly totalPages = computed(() => Math.ceil(this.totalCount() / this.pageSize()));
  readonly hasProducts = computed(() => this.products().length > 0);

  setVehicleId(vehicleId: number): void {
    this.vehicleId.set(vehicleId);
  }

  updateFilters(filters: ProductFilterParams): void {
    this.filters.update(f => ({ ...f, ...filters }));
    if (filters.page !== undefined) {
      this.currentPage.set(filters.page);
    }
    if (filters.pageSize !== undefined) {
      this.pageSize.set(filters.pageSize);
    }
  }

  loadProducts(): void {
    const vehicleId = this.vehicleId();
    if (!vehicleId) return;

    this.loading.set(true);
    const params: ProductFilterParams = {
      ...this.filters(),
      page: this.currentPage(),
      pageSize: this.pageSize()
    };

    this.productService.getCompatibleProducts(vehicleId, params).subscribe({
      next: result => {
        this.products.set(result.items);
        this.totalCount.set(result.totalCount);
        this.loading.set(false);
      },
      error: () => {
        this.products.set([]);
        this.totalCount.set(0);
        this.loading.set(false);
      }
    });
  }

  resetFilters(): void {
    this.filters.set({});
    this.currentPage.set(1);
    this.pageSize.set(12);
  }
}
