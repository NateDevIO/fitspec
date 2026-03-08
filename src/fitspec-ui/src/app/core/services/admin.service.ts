import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable, map } from 'rxjs';
import { ApiResponse, PagedResult } from '../models';

export interface AdminOverview {
  totalProducts: number;
  totalOrders: number;
  totalRevenue: number;
  totalReviews: number;
  totalVehicles: number;
  totalFitmentMappings: number;
}

export interface OrdersByMonth {
  month: string;
  orderCount: number;
  revenue: number;
}

export interface TopProduct {
  productId: number;
  name: string;
  brand: string;
  orderCount: number;
  revenue: number;
}

export interface AdminProduct {
  id: number;
  sku: string;
  name: string;
  description: string | null;
  brand: string;
  price: number;
  imageUrl: string | null;
  categoryId: number;
  categoryName: string;
  isVerified: boolean;
  weight: number | null;
  createdAt: string;
  fitmentCount: number;
}

export interface ProductCreate {
  sku: string;
  name: string;
  description: string | null;
  brand: string;
  price: number;
  imageUrl: string | null;
  categoryId: number;
  isVerified: boolean;
  weight: number | null;
}

@Injectable({ providedIn: 'root' })
export class AdminService {
  private http = inject(HttpClient);

  getOverview(): Observable<AdminOverview> {
    return this.http.get<ApiResponse<AdminOverview>>('/api/v1/admin/overview')
      .pipe(map(r => r.data!));
  }

  getOrdersByMonth(months = 12): Observable<OrdersByMonth[]> {
    return this.http.get<ApiResponse<OrdersByMonth[]>>(
      '/api/v1/admin/analytics/orders-by-month', { params: { months } }
    ).pipe(map(r => r.data ?? []));
  }

  getTopProducts(count = 10): Observable<TopProduct[]> {
    return this.http.get<ApiResponse<TopProduct[]>>(
      '/api/v1/admin/analytics/top-products', { params: { count } }
    ).pipe(map(r => r.data ?? []));
  }

  getProducts(page = 1, pageSize = 20, search?: string): Observable<PagedResult<AdminProduct>> {
    let params = new HttpParams().set('page', page).set('pageSize', pageSize);
    if (search) params = params.set('search', search);
    return this.http.get<ApiResponse<PagedResult<AdminProduct>>>(
      '/api/v1/admin/products', { params }
    ).pipe(map(r => r.data!));
  }

  createProduct(product: ProductCreate): Observable<number> {
    return this.http.post<ApiResponse<number>>('/api/v1/admin/products', product)
      .pipe(map(r => r.data!));
  }

  updateProduct(id: number, product: ProductCreate): Observable<boolean> {
    return this.http.put<ApiResponse<boolean>>(`/api/v1/admin/products/${id}`, product)
      .pipe(map(r => r.data!));
  }

  deleteProduct(id: number): Observable<boolean> {
    return this.http.delete<ApiResponse<boolean>>(`/api/v1/admin/products/${id}`)
      .pipe(map(r => r.data!));
  }
}
