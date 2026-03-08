import { Component, computed, input } from '@angular/core';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatIconModule } from '@angular/material/icon';

interface DifficultyInfo {
  label: string;
  time: string;
  tools: string;
  skill: string;
}

const DIFFICULTY_MAP: Record<number, DifficultyInfo> = {
  1: {
    label: 'Bolt-On',
    time: '15-30 min',
    tools: 'Basic hand tools (socket set, wrenches)',
    skill: 'Beginner friendly \u2014 no prior experience needed',
  },
  2: {
    label: 'Easy',
    time: '30-60 min',
    tools: 'Basic hand tools (socket set, wrenches)',
    skill: 'DIY friendly \u2014 basic mechanical knowledge',
  },
  3: {
    label: 'Moderate',
    time: '1-2 hours',
    tools: 'Hand tools, jack stands, torque wrench',
    skill: 'Intermediate \u2014 comfortable working under the vehicle',
  },
  4: {
    label: 'Advanced',
    time: '2-4 hours',
    tools: 'Power tools, vehicle lift recommended, specialized hardware',
    skill: 'Advanced \u2014 significant automotive experience required',
  },
  5: {
    label: 'Professional',
    time: '4+ hours / Shop recommended',
    tools: 'Professional shop tools, welding equipment, alignment equipment',
    skill: 'Expert \u2014 professional installation recommended',
  },
};

@Component({
  selector: 'app-install-breakdown',
  standalone: true,
  imports: [MatExpansionModule, MatIconModule],
  template: `
    <div class="install-breakdown">
      <div class="gauge-row">
        <span class="gauge-label">Difficulty</span>
        <div class="gauge-segments">
          @for (seg of segments; track seg) {
            <div
              class="segment"
              [class.active]="seg <= difficulty()"
              [style.background]="seg <= difficulty() ? segmentColor(seg) : '#e0e0e0'"
            ></div>
          }
        </div>
        <span class="gauge-value">{{ info().label }}</span>
      </div>

      <mat-accordion>
        <mat-expansion-panel class="details-panel">
          <mat-expansion-panel-header>
            <mat-panel-title>
              <mat-icon class="panel-icon">handyman</mat-icon>
              Installation Details
            </mat-panel-title>
          </mat-expansion-panel-header>

          <div class="detail-rows">
            <div class="detail-row">
              <div class="detail-icon-col">
                <mat-icon>signal_cellular_alt</mat-icon>
              </div>
              <div class="detail-content">
                <span class="detail-heading">Difficulty Level</span>
                <span class="detail-value">{{ info().label }} ({{ difficulty() }}/5)</span>
              </div>
            </div>

            <div class="detail-row">
              <div class="detail-icon-col">
                <mat-icon>timer</mat-icon>
              </div>
              <div class="detail-content">
                <span class="detail-heading">Estimated Time</span>
                <span class="detail-value">{{ info().time }}</span>
              </div>
            </div>

            <div class="detail-row">
              <div class="detail-icon-col">
                <mat-icon>build</mat-icon>
              </div>
              <div class="detail-content">
                <span class="detail-heading">Tools Required</span>
                <span class="detail-value">{{ info().tools }}</span>
              </div>
            </div>

            <div class="detail-row">
              <div class="detail-icon-col">
                <mat-icon>school</mat-icon>
              </div>
              <div class="detail-content">
                <span class="detail-heading">Skill Level</span>
                <span class="detail-value">{{ info().skill }}</span>
              </div>
            </div>

            @if (fitmentNotes()) {
              <div class="detail-row fitment-row">
                <div class="detail-icon-col">
                  <mat-icon>info</mat-icon>
                </div>
                <div class="detail-content">
                  <span class="detail-heading">Fitment Notes</span>
                  <span class="detail-value fitment-text">{{ fitmentNotes() }}</span>
                </div>
              </div>
            }
          </div>
        </mat-expansion-panel>
      </mat-accordion>
    </div>
  `,
  styles: [`
    .install-breakdown {
      margin: 12px 0;
    }

    .gauge-row {
      display: flex;
      align-items: center;
      gap: 10px;
      margin-bottom: 8px;
    }

    .gauge-label {
      font-size: 0.8rem;
      font-weight: 500;
      color: #666;
      min-width: 56px;
    }

    .gauge-segments {
      display: flex;
      gap: 4px;
      flex: 1;
    }

    .segment {
      height: 8px;
      flex: 1;
      border-radius: 4px;
      background: #e0e0e0;
      transition: background 0.3s ease;
    }

    .gauge-value {
      font-size: 0.8rem;
      font-weight: 600;
      color: #263238;
      min-width: 80px;
      text-align: right;
    }

    .details-panel {
      border-radius: 10px !important;
      box-shadow: none !important;
      border: 1px solid #e0e0e0;
    }

    .panel-icon {
      font-size: 20px;
      width: 20px;
      height: 20px;
      margin-right: 8px;
      color: var(--fs-navy);
    }

    ::ng-deep .details-panel .mat-expansion-panel-header-title {
      align-items: center;
      font-weight: 500;
      font-size: 0.9rem;
      color: #263238;
    }

    .detail-rows {
      display: flex;
      flex-direction: column;
      gap: 0;
    }

    .detail-row {
      display: flex;
      align-items: flex-start;
      gap: 12px;
      padding: 10px 0;
      border-bottom: 1px solid #f0f0f0;
    }

    .detail-row:last-child {
      border-bottom: none;
    }

    .detail-icon-col {
      width: 32px;
      height: 32px;
      min-width: 32px;
      background: rgba(26, 35, 126, 0.06);
      border-radius: 8px;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .detail-icon-col mat-icon {
      font-size: 18px;
      width: 18px;
      height: 18px;
      color: var(--fs-navy);
    }

    .detail-content {
      display: flex;
      flex-direction: column;
      gap: 2px;
    }

    .detail-heading {
      font-size: 0.75rem;
      font-weight: 500;
      color: #888;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    .detail-value {
      font-size: 0.875rem;
      color: #333;
      line-height: 1.4;
    }

    .fitment-row .detail-icon-col {
      background: rgba(255, 152, 0, 0.08);
    }

    .fitment-row .detail-icon-col mat-icon {
      color: #f57c00;
    }

    .fitment-text {
      font-style: italic;
      color: #555;
    }
    @media (max-width: 480px) {
      .gauge-label { min-width: 44px; font-size: 0.7rem; }
      .gauge-value { min-width: 60px; font-size: 0.7rem; }
    }
  `]
})
export class InstallBreakdownComponent {
  difficulty = input.required<number>();
  fitmentNotes = input<string | null>();

  segments = [1, 2, 3, 4, 5];

  info = computed<DifficultyInfo>(() => {
    const d = this.difficulty();
    return DIFFICULTY_MAP[d] ?? DIFFICULTY_MAP[3];
  });

  segmentColor(index: number): string {
    if (index <= 2) return '#4caf50';
    if (index === 3) return '#ffc107';
    if (index === 4) return '#ff9800';
    return '#f44336';
  }
}
