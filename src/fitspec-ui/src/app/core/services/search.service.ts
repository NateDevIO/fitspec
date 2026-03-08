import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, map } from 'rxjs';
import { ApiResponse } from '../models';

export interface SearchResult {
  type: string;
  id: number;
  title: string;
  subtitle: string | null;
  imageUrl: string | null;
  price: number | null;
}

@Injectable({ providedIn: 'root' })
export class SearchService {
  private http = inject(HttpClient);

  search(query: string, limit = 10): Observable<SearchResult[]> {
    return this.http.get<ApiResponse<SearchResult[]>>(
      `/api/v1/search`, { params: { q: query, limit } }
    ).pipe(map(r => r.data ?? []));
  }
}
