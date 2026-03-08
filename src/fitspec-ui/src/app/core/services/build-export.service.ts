import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';

export interface BuildExportItem {
  productId: number;
  quantity: number;
}

@Injectable({ providedIn: 'root' })
export class BuildExportService {
  private http = inject(HttpClient);

  exportPdf(items: BuildExportItem[], vehicleName?: string): void {
    this.http.post('/api/v1/builds/export-pdf',
      { items, vehicleName },
      { responseType: 'text' }
    ).subscribe(html => {
      const printWindow = window.open('', '_blank');
      if (printWindow) {
        printWindow.document.write(html);
        printWindow.document.close();
        setTimeout(() => printWindow.print(), 500);
      }
    });
  }
}
