import { Component, input, computed } from '@angular/core';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { CurrencyPipe } from '@angular/common';

interface CostTier {
  label: string;
  minCost: number;
  maxCost: number;
  maxLabel: string;
  description: string;
  estimatedTime: string;
  icon: string;
  color: string;
}

const COST_TIERS: Record<number, CostTier> = {
  1: { label: 'DIY Friendly', minCost: 50, maxCost: 75, maxLabel: '$75', description: 'Simple bolt-on install with basic tools', estimatedTime: '30 min - 1 hr', icon: 'handyman', color: '#4caf50' },
  2: { label: 'Moderate DIY', minCost: 75, maxCost: 125, maxLabel: '$125', description: 'Straightforward install, some experience helpful', estimatedTime: '1 - 2 hrs', icon: 'build', color: '#8bc34a' },
  3: { label: 'Intermediate', minCost: 125, maxCost: 200, maxLabel: '$200', description: 'Moderate complexity, may need specialty tools', estimatedTime: '2 - 3 hrs', icon: 'construction', color: '#ffc107' },
  4: { label: 'Professional Recommended', minCost: 200, maxCost: 350, maxLabel: '$350', description: 'Complex install, professional shop recommended', estimatedTime: '3 - 5 hrs', icon: 'engineering', color: '#ff9800' },
  5: { label: 'Professional Required', minCost: 350, maxCost: 500, maxLabel: '$500+', description: 'Advanced install requiring specialized equipment', estimatedTime: '5+ hrs', icon: 'precision_manufacturing', color: '#f44336' },
};

@Component({
  selector: 'app-cost-estimator',
  standalone: true,
  imports: [MatCardModule, MatIconModule, CurrencyPipe],
  template: `
    @if (tier(); as t) {
      <mat-card appearance="outlined" class="cost-card">
        <div class="cost-header">
          <div class="cost-icon" [style.background]="t.color + '14'" [style.border-color]="t.color + '33'">
            <mat-icon [style.color]="t.color">{{ t.icon }}</mat-icon>
          </div>
          <div class="cost-info">
            <span class="cost-label">Estimated Install Cost</span>
            <span class="cost-range">{{ t.minCost | currency:'USD':'symbol':'1.0-0' }} - {{ t.maxLabel }}</span>
          </div>
        </div>
        <div class="cost-details">
          <div class="detail-row">
            <mat-icon class="detail-icon">speed</mat-icon>
            <span class="detail-label">Difficulty:</span>
            <span class="detail-value" [style.color]="t.color">{{ t.label }}</span>
          </div>
          <div class="detail-row">
            <mat-icon class="detail-icon">schedule</mat-icon>
            <span class="detail-label">Est. Time:</span>
            <span class="detail-value">{{ t.estimatedTime }}</span>
          </div>
          <p class="cost-description">{{ t.description }}</p>
        </div>
      </mat-card>
    }
  `,
  styles: [`
    .cost-card {
      border-radius: 12px;
      margin: 16px 0;
      padding: 16px;
    }
    .cost-header {
      display: flex;
      align-items: center;
      gap: 12px;
    }
    .cost-icon {
      width: 44px;
      height: 44px;
      border-radius: 12px;
      display: flex;
      align-items: center;
      justify-content: center;
      border: 1px solid;
      flex-shrink: 0;
    }
    .cost-icon mat-icon { font-size: 22px; width: 22px; height: 22px; }
    .cost-info { display: flex; flex-direction: column; }
    .cost-label {
      font-size: 0.75rem;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      color: #888;
      font-weight: 500;
    }
    .cost-range {
      font-size: 1.3rem;
      font-weight: 700;
      color: var(--fs-navy);
    }
    .cost-details {
      margin-top: 12px;
      padding-top: 12px;
      border-top: 1px solid #eee;
    }
    .detail-row {
      display: flex;
      align-items: center;
      gap: 6px;
      margin-bottom: 6px;
    }
    .detail-icon { font-size: 16px; width: 16px; height: 16px; color: #888; }
    .detail-label { font-size: 0.85rem; color: #666; }
    .detail-value { font-size: 0.85rem; font-weight: 600; }
    .cost-description {
      font-size: 0.8rem;
      color: #777;
      margin: 8px 0 0;
      line-height: 1.4;
    }
  `]
})
export class CostEstimatorComponent {
  difficulty = input.required<number>();

  tier = computed<CostTier | null>(() => {
    const d = this.difficulty();
    return COST_TIERS[d] ?? null;
  });
}
