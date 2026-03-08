import { Component, inject, OnInit, signal } from '@angular/core';
import { MatTableModule } from '@angular/material/table';
import { MatPaginatorModule, PageEvent } from '@angular/material/paginator';
import { MatInputModule } from '@angular/material/input';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatSortModule } from '@angular/material/sort';
import { FormsModule } from '@angular/forms';
import { CurrencyPipe } from '@angular/common';
import { AdminService, AdminProduct, ProductCreate } from '../../core/services/admin.service';

@Component({
  selector: 'app-admin-products',
  standalone: true,
  imports: [
    MatTableModule, MatPaginatorModule, MatInputModule,
    MatIconModule, MatButtonModule, MatSortModule, FormsModule, CurrencyPipe
  ],
  template: `
    <div class="products-container">
      <div class="page-header">
        <h1 class="page-title">Products</h1>
        <button mat-flat-button class="add-btn" (click)="showAddForm()">
          <mat-icon>add</mat-icon> Add Product
        </button>
      </div>

      <!-- Search -->
      <div class="search-row">
        <mat-icon class="search-icon">search</mat-icon>
        <input class="search-input"
          [(ngModel)]="searchQuery"
          (input)="onSearchChange()"
          placeholder="Search products by name, brand, or SKU...">
      </div>

      @if (loading()) {
        <div class="loading-center">
          <mat-icon class="spin-icon">sync</mat-icon>
          <span>Loading products...</span>
        </div>
      } @else {
        <!-- Table -->
        <div class="table-wrapper">
          <table mat-table [dataSource]="products()" matSort class="products-table">
            <!-- ID -->
            <ng-container matColumnDef="id">
              <th mat-header-cell *matHeaderCellDef mat-sort-header>ID</th>
              <td mat-cell *matCellDef="let p">{{ p.id }}</td>
            </ng-container>

            <!-- Name -->
            <ng-container matColumnDef="name">
              <th mat-header-cell *matHeaderCellDef mat-sort-header>Name</th>
              <td mat-cell *matCellDef="let p" class="name-cell">{{ p.name }}</td>
            </ng-container>

            <!-- Brand -->
            <ng-container matColumnDef="brand">
              <th mat-header-cell *matHeaderCellDef mat-sort-header>Brand</th>
              <td mat-cell *matCellDef="let p">{{ p.brand }}</td>
            </ng-container>

            <!-- SKU -->
            <ng-container matColumnDef="sku">
              <th mat-header-cell *matHeaderCellDef mat-sort-header>SKU</th>
              <td mat-cell *matCellDef="let p" class="sku-cell">{{ p.sku }}</td>
            </ng-container>

            <!-- Price -->
            <ng-container matColumnDef="price">
              <th mat-header-cell *matHeaderCellDef mat-sort-header>Price</th>
              <td mat-cell *matCellDef="let p" class="price-cell">{{ p.price | currency }}</td>
            </ng-container>

            <!-- Category -->
            <ng-container matColumnDef="category">
              <th mat-header-cell *matHeaderCellDef mat-sort-header>Category</th>
              <td mat-cell *matCellDef="let p">{{ p.categoryName }}</td>
            </ng-container>

            <!-- Verified -->
            <ng-container matColumnDef="verified">
              <th mat-header-cell *matHeaderCellDef>Verified</th>
              <td mat-cell *matCellDef="let p">
                <mat-icon [class]="p.isVerified ? 'verified-icon' : 'unverified-icon'">
                  {{ p.isVerified ? 'check_circle' : 'remove_circle_outline' }}
                </mat-icon>
              </td>
            </ng-container>

            <!-- Fitment Count -->
            <ng-container matColumnDef="fitmentCount">
              <th mat-header-cell *matHeaderCellDef mat-sort-header>Fitments</th>
              <td mat-cell *matCellDef="let p">{{ p.fitmentCount }}</td>
            </ng-container>

            <!-- Actions -->
            <ng-container matColumnDef="actions">
              <th mat-header-cell *matHeaderCellDef>Actions</th>
              <td mat-cell *matCellDef="let p">
                <button mat-icon-button class="edit-btn" (click)="editProduct(p)" title="Edit">
                  <mat-icon>edit</mat-icon>
                </button>
                <button mat-icon-button class="delete-btn" (click)="deleteProduct(p)" title="Delete">
                  <mat-icon>delete</mat-icon>
                </button>
              </td>
            </ng-container>

            <tr mat-header-row *matHeaderRowDef="displayedColumns"></tr>
            <tr mat-row *matRowDef="let row; columns: displayedColumns;"></tr>
          </table>
        </div>

        <mat-paginator
          [length]="totalCount()"
          [pageSize]="pageSize"
          [pageSizeOptions]="[10, 20, 50]"
          (page)="onPageChange($event)"
          showFirstLastButtons>
        </mat-paginator>
      }

      <!-- Edit / Add Form -->
      @if (editingProduct()) {
        <div class="edit-section">
          <h3 class="edit-title">{{ isAdding ? 'Add New Product' : 'Edit Product #' + editingProduct()!.id }}</h3>
          <div class="edit-form">
            <div class="form-field">
              <label>Name</label>
              <input [(ngModel)]="editForm.name" placeholder="Product name">
            </div>
            <div class="form-field">
              <label>Brand</label>
              <input [(ngModel)]="editForm.brand" placeholder="Brand">
            </div>
            <div class="form-field">
              <label>SKU</label>
              <input [(ngModel)]="editForm.sku" placeholder="SKU">
            </div>
            <div class="form-field">
              <label>Price</label>
              <input type="number" [(ngModel)]="editForm.price" placeholder="0.00">
            </div>
            <div class="form-field">
              <label>Image URL</label>
              <input [(ngModel)]="editForm.imageUrl" placeholder="https://...">
            </div>
            <div class="form-field full-width">
              <label>Description</label>
              <textarea [(ngModel)]="editForm.description" rows="3" placeholder="Product description"></textarea>
            </div>
          </div>
          <div class="edit-actions">
            <button mat-flat-button class="save-btn" (click)="saveProduct()">
              <mat-icon>save</mat-icon> Save
            </button>
            <button mat-stroked-button (click)="cancelEdit()">Cancel</button>
          </div>
        </div>
      }
    </div>
  `,
  styles: [`
    .products-container { animation: fadeInUp 0.4s ease-out; }
    .page-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
    }
    .page-title {
      font-size: 1.6rem;
      font-weight: 700;
      color: var(--fs-navy);
      margin: 0;
    }
    .add-btn {
      background: linear-gradient(135deg, #1a237e, #283593);
      color: white;
      border-radius: 8px;
    }
    .search-row {
      display: flex;
      align-items: center;
      gap: 10px;
      background: white;
      border: 1px solid #ddd;
      border-radius: 10px;
      padding: 10px 16px;
      margin-bottom: 20px;
      max-width: 420px;
      transition: border-color 0.2s;
    }
    .search-row:focus-within { border-color: var(--fs-navy); }
    .search-icon { color: #999; font-size: 20px; width: 20px; height: 20px; }
    .search-input {
      flex: 1;
      border: none;
      outline: none;
      font-size: 0.9rem;
      font-family: inherit;
      background: transparent;
    }
    .loading-center {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 12px;
      padding: 48px;
      color: #888;
    }
    .spin-icon {
      animation: spin 1.5s linear infinite;
      color: var(--fs-navy);
    }
    .table-wrapper {
      overflow-x: auto;
      border: 1px solid #e0e0e0;
      border-radius: 12px;
      background: white;
    }
    .products-table { width: 100%; }
    :host ::ng-deep .mat-mdc-header-cell {
      font-weight: 600;
      font-size: 0.78rem;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      color: #555;
    }
    :host ::ng-deep .mat-mdc-cell {
      font-size: 0.85rem;
      color: #333;
    }
    .name-cell { font-weight: 500; max-width: 220px; }
    .sku-cell { font-family: monospace; font-size: 0.8rem; color: #888; }
    .price-cell { font-weight: 600; color: var(--fs-navy); }
    .verified-icon { color: #4caf50; font-size: 20px; width: 20px; height: 20px; }
    .unverified-icon { color: #ccc; font-size: 20px; width: 20px; height: 20px; }
    .edit-btn { color: var(--fs-navy); }
    .delete-btn { color: #999; }
    .delete-btn:hover { color: #f44336; }

    /* Edit Form */
    .edit-section {
      margin-top: 28px;
      background: white;
      border: 1px solid #e0e0e0;
      border-radius: 12px;
      padding: 24px;
    }
    .edit-title {
      font-size: 1.1rem;
      font-weight: 600;
      color: var(--fs-navy);
      margin: 0 0 20px;
    }
    .edit-form {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 16px;
      margin-bottom: 20px;
    }
    .full-width { grid-column: 1 / -1; }
    .form-field label {
      display: block;
      font-size: 0.8rem;
      font-weight: 600;
      color: #555;
      margin-bottom: 6px;
      text-transform: uppercase;
      letter-spacing: 0.3px;
    }
    .form-field input,
    .form-field textarea {
      width: 100%;
      padding: 10px 14px;
      border: 1px solid #ddd;
      border-radius: 8px;
      font-size: 0.9rem;
      font-family: inherit;
      outline: none;
      transition: border-color 0.2s;
      box-sizing: border-box;
    }
    .form-field input:focus,
    .form-field textarea:focus { border-color: var(--fs-navy); }
    .edit-actions {
      display: flex;
      gap: 10px;
    }
    .save-btn {
      background: linear-gradient(135deg, #1a237e, #283593);
      color: white;
      border-radius: 8px;
    }

    @media (max-width: 768px) {
      .edit-form { grid-template-columns: 1fr; }
    }
  `]
})
export class AdminProductsComponent implements OnInit {
  private adminService = inject(AdminService);

  products = signal<AdminProduct[]>([]);
  totalCount = signal(0);
  loading = signal(true);
  page = signal(1);
  search = signal('');
  editingProduct = signal<AdminProduct | null>(null);

  searchQuery = '';
  pageSize = 20;
  isAdding = false;

  editForm: ProductCreate = {
    sku: '', name: '', description: null, brand: '',
    price: 0, imageUrl: null, categoryId: 0, isVerified: false, weight: null
  };

  displayedColumns = ['id', 'name', 'brand', 'sku', 'price', 'category', 'verified', 'fitmentCount', 'actions'];

  private searchTimeout: ReturnType<typeof setTimeout> | null = null;

  ngOnInit(): void {
    this.loadProducts();
  }

  loadProducts(): void {
    this.loading.set(true);
    const searchVal = this.search() || undefined;
    this.adminService.getProducts(this.page(), this.pageSize, searchVal).subscribe({
      next: result => {
        this.products.set(result.items);
        this.totalCount.set(result.totalCount);
        this.loading.set(false);
      },
      error: () => this.loading.set(false)
    });
  }

  onSearchChange(): void {
    if (this.searchTimeout) clearTimeout(this.searchTimeout);
    this.searchTimeout = setTimeout(() => {
      this.search.set(this.searchQuery);
      this.page.set(1);
      this.loadProducts();
    }, 400);
  }

  onPageChange(event: PageEvent): void {
    this.page.set(event.pageIndex + 1);
    this.pageSize = event.pageSize;
    this.loadProducts();
  }

  showAddForm(): void {
    this.isAdding = true;
    this.editForm = {
      sku: '', name: '', description: null, brand: '',
      price: 0, imageUrl: null, categoryId: 1, isVerified: false, weight: null
    };
    this.editingProduct.set({ id: 0 } as AdminProduct);
  }

  editProduct(product: AdminProduct): void {
    this.isAdding = false;
    this.editingProduct.set(product);
    this.editForm = {
      sku: product.sku,
      name: product.name,
      description: product.description,
      brand: product.brand,
      price: product.price,
      imageUrl: product.imageUrl,
      categoryId: product.categoryId,
      isVerified: product.isVerified,
      weight: product.weight
    };
  }

  deleteProduct(product: AdminProduct): void {
    if (!window.confirm(`Are you sure you want to delete "${product.name}"?`)) return;
    this.adminService.deleteProduct(product.id).subscribe({
      next: () => this.loadProducts()
    });
  }

  saveProduct(): void {
    if (this.isAdding) {
      this.adminService.createProduct(this.editForm).subscribe({
        next: () => {
          this.cancelEdit();
          this.loadProducts();
        }
      });
    } else {
      const id = this.editingProduct()!.id;
      this.adminService.updateProduct(id, this.editForm).subscribe({
        next: () => {
          this.cancelEdit();
          this.loadProducts();
        }
      });
    }
  }

  cancelEdit(): void {
    this.editingProduct.set(null);
    this.isAdding = false;
  }
}
