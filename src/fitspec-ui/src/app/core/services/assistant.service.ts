import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, map } from 'rxjs';
import { ApiResponse } from '../models';

export interface ChatMessage {
  role: 'user' | 'assistant';
  content: string;
}

export interface ChatResponse {
  message: string;
  suggestedProductId: string | null;
}

@Injectable({ providedIn: 'root' })
export class AssistantService {
  private http = inject(HttpClient);

  chat(message: string, vehicleId?: number, productId?: number, history: ChatMessage[] = []): Observable<ChatResponse> {
    return this.http.post<ApiResponse<ChatResponse>>('/api/v1/assistant/chat', {
      message, vehicleId, productId, history
    }).pipe(map(r => r.data!));
  }
}
