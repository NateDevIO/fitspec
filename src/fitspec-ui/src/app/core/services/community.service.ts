import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, map } from 'rxjs';
import { ApiResponse } from '../models';

export interface PopularProduct {
  productId: number;
  name: string;
  brand: string;
  price: number;
  imageUrl: string | null;
  categoryName: string;
  installCount: number;
}

@Injectable({ providedIn: 'root' })
export class CommunityService {
  private http = inject(HttpClient);

  getPopularProducts(vehicleId: number, count = 8): Observable<PopularProduct[]> {
    return this.http.get<ApiResponse<PopularProduct[]>>(
      `/api/v1/vehicles/${vehicleId}/community/popular-products`, { params: { count } }
    ).pipe(map(r => r.data ?? []));
  }
}
