import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable, map } from 'rxjs';
import {
  ApiResponse, PagedResult, ProductSummaryDto, ProductDetailDto,
  ProductFilterParams, CompatibilityCheckDto, ProductRecommendationDto,
  ReviewSummaryDto, ProductQuestionDto
} from '../models';

@Injectable({ providedIn: 'root' })
export class ProductService {
  private http = inject(HttpClient);

  getCompatibleProducts(vehicleId: number, filters: ProductFilterParams): Observable<PagedResult<ProductSummaryDto>> {
    let params = new HttpParams();
    if (filters.categoryId) params = params.set('categoryId', filters.categoryId);
    if (filters.brand) params = params.set('brand', filters.brand);
    if (filters.minPrice) params = params.set('minPrice', filters.minPrice);
    if (filters.maxPrice) params = params.set('maxPrice', filters.maxPrice);
    if (filters.maxDifficulty) params = params.set('maxDifficulty', filters.maxDifficulty);
    if (filters.verifiedOnly) params = params.set('verifiedOnly', filters.verifiedOnly);
    if (filters.sort) params = params.set('sort', filters.sort);
    if (filters.page) params = params.set('page', filters.page);
    if (filters.pageSize) params = params.set('pageSize', filters.pageSize);

    return this.http.get<ApiResponse<PagedResult<ProductSummaryDto>>>(
      `/api/v1/vehicles/${vehicleId}/products`, { params }
    ).pipe(map(r => r.data!));
  }

  getProduct(productId: number): Observable<ProductDetailDto> {
    return this.http.get<ApiResponse<ProductDetailDto>>(`/api/v1/products/${productId}`)
      .pipe(map(r => r.data!));
  }

  checkCompatibility(productId: number, vehicleId: number): Observable<CompatibilityCheckDto> {
    return this.http.get<ApiResponse<CompatibilityCheckDto>>(
      `/api/v1/products/${productId}/compatibility/${vehicleId}`
    ).pipe(map(r => r.data!));
  }

  getReviews(productId: number, vehicleId?: number, page = 1, pageSize = 10): Observable<ReviewSummaryDto> {
    let params = new HttpParams()
      .set('page', page)
      .set('pageSize', pageSize);
    if (vehicleId) params = params.set('vehicleId', vehicleId);
    return this.http.get<ApiResponse<ReviewSummaryDto>>(
      `/api/v1/products/${productId}/reviews`, { params }
    ).pipe(map(r => r.data!));
  }

  getRecommendations(productId: number, topN = 4): Observable<ProductRecommendationDto[]> {
    return this.http.get<ApiResponse<ProductRecommendationDto[]>>(
      `/api/v1/products/${productId}/recommendations`, { params: { topN } }
    ).pipe(map(r => r.data ?? []));
  }

  compareProducts(ids: number[]): Observable<ProductDetailDto[]> {
    const params = ids.map(id => `ids=${id}`).join('&');
    return this.http.get<ApiResponse<ProductDetailDto[]>>(
      `/api/v1/products/compare?${params}`
    ).pipe(map(r => r.data ?? []));
  }

  getInstallGuide(productId: number, vehicleId: number): Observable<string> {
    return this.http.get(
      `/api/v1/products/${productId}/install-guide`,
      { params: { vehicleId }, responseType: 'text' }
    );
  }

  getRequiredAccessories(productId: number, vehicleId?: number): Observable<ProductSummaryDto[]> {
    let params = new HttpParams();
    if (vehicleId) params = params.set('vehicleId', vehicleId);
    return this.http.get<ApiResponse<ProductSummaryDto[]>>(
      `/api/v1/products/${productId}/required-accessories`, { params }
    ).pipe(map(r => r.data ?? []));
  }

  getFitmentCertificate(productId: number, vehicleId: number): Observable<string> {
    return this.http.get(
      `/api/v1/products/${productId}/fitment-certificate`,
      { params: { vehicleId }, responseType: 'text' }
    );
  }

  getSpecSheet(productId: number, vehicleId?: number): Observable<string> {
    let params = new HttpParams();
    if (vehicleId) params = params.set('vehicleId', vehicleId);
    return this.http.get(
      `/api/v1/products/${productId}/spec-sheet`, { params, responseType: 'text' }
    );
  }

  getQuestions(productId: number): Observable<ProductQuestionDto[]> {
    return this.http.get<ApiResponse<ProductQuestionDto[]>>(
      `/api/v1/products/${productId}/qa`
    ).pipe(map(r => r.data ?? []));
  }

  askQuestion(productId: number, question: string, askerName: string): Observable<ProductQuestionDto> {
    return this.http.post<ApiResponse<ProductQuestionDto>>(
      `/api/v1/products/${productId}/qa`,
      { question, askerName }
    ).pipe(map(r => r.data!));
  }

  answerQuestion(productId: number, questionId: string, answer: string, responderName: string): Observable<ProductQuestionDto> {
    return this.http.post<ApiResponse<ProductQuestionDto>>(
      `/api/v1/products/${productId}/qa/${questionId}/answer`,
      { answer, responderName }
    ).pipe(map(r => r.data!));
  }

  subscribePriceAlert(productId: number, email: string): Observable<string> {
    return this.http.post<ApiResponse<string>>(
      `/api/v1/products/${productId}/price-alerts`,
      { email }
    ).pipe(map(r => r.data ?? 'Subscribed'));
  }
}
