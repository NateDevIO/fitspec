import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, map } from 'rxjs';
import { ApiResponse, CategoryDto } from '../models';

@Injectable({ providedIn: 'root' })
export class CategoryService {
  private http = inject(HttpClient);

  getCategories(): Observable<CategoryDto[]> {
    return this.http.get<ApiResponse<CategoryDto[]>>('/api/v1/categories')
      .pipe(map(r => r.data ?? []));
  }
}
