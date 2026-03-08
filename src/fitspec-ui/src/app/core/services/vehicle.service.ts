import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, map } from 'rxjs';
import { ApiResponse, MakeDto, ModelDto, VehicleYearDto, VehicleDetailDto, CategoryBreakdownDto, VinDecodeResultDto } from '../models';

@Injectable({ providedIn: 'root' })
export class VehicleService {
  private http = inject(HttpClient);
  private baseUrl = '/api/v1/vehicles';

  getMakes(): Observable<MakeDto[]> {
    return this.http.get<ApiResponse<MakeDto[]>>(`${this.baseUrl}/makes`)
      .pipe(map(r => r.data ?? []));
  }

  getModels(makeId: number): Observable<ModelDto[]> {
    return this.http.get<ApiResponse<ModelDto[]>>(`${this.baseUrl}/makes/${makeId}/models`)
      .pipe(map(r => r.data ?? []));
  }

  getYears(makeId: number, modelId: number): Observable<VehicleYearDto[]> {
    return this.http.get<ApiResponse<VehicleYearDto[]>>(`${this.baseUrl}/makes/${makeId}/models/${modelId}/years`)
      .pipe(map(r => r.data ?? []));
  }

  getVehicle(vehicleId: number): Observable<VehicleDetailDto> {
    return this.http.get<ApiResponse<VehicleDetailDto>>(`${this.baseUrl}/${vehicleId}`)
      .pipe(map(r => r.data!));
  }

  getCategoryBreakdown(vehicleId: number): Observable<CategoryBreakdownDto[]> {
    return this.http.get<ApiResponse<CategoryBreakdownDto[]>>(`${this.baseUrl}/${vehicleId}/categories`)
      .pipe(map(r => r.data ?? []));
  }

  decodeVin(vin: string): Observable<VinDecodeResultDto> {
    return this.http.get<ApiResponse<VinDecodeResultDto>>(`/api/v1/vin/${vin}/decode`)
      .pipe(map(r => r.data!));
  }
}
