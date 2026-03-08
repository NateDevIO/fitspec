import { Component, inject, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { MatPaginatorModule, PageEvent } from '@angular/material/paginator';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatIconModule } from '@angular/material/icon';
import { ProductCardComponent } from '../product-card/product-card.component';
import { FilterSidebarComponent } from '../filter-sidebar/filter-sidebar.component';
import { ProductState } from '../../core/state/product.state';
import { ProductFilterParams } from '../../core/models';

@Component({
  selector: 'app-product-grid',
  standalone: true,
  imports: [ProductCardComponent, FilterSidebarComponent, MatPaginatorModule, MatProgressSpinnerModule, MatIconModule],
  template: `
    <div class="grid-layout">
      <aside class="sidebar">
        <app-filter-sidebar
          [vehicleId]="productState.vehicleId()"
          (filtersChanged)="onFiltersChanged($event)" />
      </aside>
      <main class="main-content">
        @if (productState.loading()) {
          <div class="loading-center">
            <mat-spinner diameter="48"></mat-spinner>
          </div>
        } @else {
          <div class="product-grid">
            @for (product of productState.products(); track product.id) {
              <app-product-card [product]="product" [vehicleId]="productState.vehicleId()" />
            } @empty {
              <div class="empty-state">
                <mat-icon class="empty-icon">search_off</mat-icon>
                <p class="empty-text">No products found matching your criteria.</p>
                <p class="empty-hint">Try adjusting your filters or selecting a different category.</p>
              </div>
            }
          </div>
          @if (productState.totalCount() > 0) {
            <mat-paginator
              [length]="productState.totalCount()"
              [pageSize]="productState.pageSize()"
              [pageIndex]="productState.currentPage() - 1"
              [pageSizeOptions]="[12, 24, 48]"
              (page)="onPageChange($event)"
              showFirstLastButtons />
          }
        }
      </main>
    </div>
  `,
  styles: [`
    .grid-layout { display: flex; gap: 24px; max-width: 1200px; margin: 24px auto; padding: 0 24px; }
    .sidebar { width: 280px; flex-shrink: 0; }
    .main-content { flex: 1; }
    .product-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(270px, 1fr));
      gap: 20px;
    }
    .loading-center { display: flex; justify-content: center; padding: 48px; }
    .empty-state {
      grid-column: 1 / -1;
      text-align: center;
      padding: 56px 24px;
      border: 2px dashed #d0d5dd;
      border-radius: 12px;
      background: rgba(245,247,250,0.6);
    }
    .empty-icon {
      font-size: 48px; width: 48px; height: 48px;
      color: #bbb;
      margin-bottom: 8px;
    }
    .empty-text {
      font-size: 1rem;
      font-weight: 500;
      color: #555;
      margin: 0 0 4px;
    }
    .empty-hint {
      font-size: 0.85rem;
      color: #888;
      margin: 0;
    }
    @media (max-width: 768px) {
      .grid-layout { flex-direction: column; padding: 0 12px; margin: 16px auto; }
      .sidebar { width: 100%; }
      .product-grid { grid-template-columns: repeat(auto-fill, minmax(160px, 1fr)); gap: 12px; }
    }
  `]
})
export class ProductGridComponent implements OnInit {
  productState = inject(ProductState);
  private route = inject(ActivatedRoute);

  ngOnInit(): void {
    const vehicleId = Number(this.route.snapshot.paramMap.get('vehicleId'));
    const categoryId = this.route.snapshot.queryParamMap.get('categoryId');
    this.productState.resetFilters();
    this.productState.setVehicleId(vehicleId);
    if (categoryId) {
      this.productState.updateFilters({ categoryId: Number(categoryId) });
    }
    this.productState.loadProducts();
  }

  onFiltersChanged(filters: ProductFilterParams): void {
    this.productState.updateFilters(filters);
    this.productState.loadProducts();
  }

  onPageChange(event: PageEvent): void {
    this.productState.updateFilters({ page: event.pageIndex + 1, pageSize: event.pageSize });
    this.productState.loadProducts();
  }
}
