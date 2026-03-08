import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, map } from 'rxjs';
import { ApiResponse } from '../models';

export interface InventoryStatus {
  productId: number;
  stockQuantity: number;
  status: 'in_stock' | 'low_stock' | 'out_of_stock';
}

@Injectable({ providedIn: 'root' })
export class InventoryService {
  private http = inject(HttpClient);

  getInventoryStatus(productIds: number[]): Observable<InventoryStatus[]> {
    const params = productIds.map(id => `productIds=${id}`).join('&');
    return this.http.get<ApiResponse<InventoryStatus[]>>(
      `/api/v1/inventory?${params}`
    ).pipe(map(r => r.data ?? []));
  }

  getProductInventory(productId: number): Observable<InventoryStatus> {
    return this.http.get<ApiResponse<InventoryStatus>>(
      `/api/v1/inventory/${productId}`
    ).pipe(map(r => r.data!));
  }
}
