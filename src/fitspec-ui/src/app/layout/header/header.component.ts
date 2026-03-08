import { Component, inject } from '@angular/core';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatTooltipModule } from '@angular/material/tooltip';
import { Router, RouterLink } from '@angular/router';
import { VehicleState } from '../../core/state/vehicle.state';
import { ProductState } from '../../core/state/product.state';
import { ThemeState } from '../../core/state/theme.state';
import { GlobalSearchComponent } from '../../features/global-search/global-search.component';
import { GarageComponent } from '../../features/garage/garage.component';

@Component({
  selector: 'app-header',
  standalone: true,
  imports: [MatToolbarModule, MatIconModule, MatButtonModule, MatTooltipModule, RouterLink, GlobalSearchComponent, GarageComponent],
  template: `
    <mat-toolbar class="header">
      <a class="logo" (click)="goHome()">
        <span class="logo-icon-wrap">
          <mat-icon>build</mat-icon>
        </span>
        <span class="logo-text-group">
          <span class="logo-text">FitSpec</span>
          <span class="logo-tagline">Vehicle Parts Finder</span>
        </span>
      </a>

      <app-global-search />

      <span class="spacer"></span>

      <button mat-icon-button (click)="themeState.toggle()" matTooltip="Toggle dark mode" class="icon-btn">
        <mat-icon>{{ themeState.isDark() ? 'light_mode' : 'dark_mode' }}</mat-icon>
      </button>

      <app-garage />

      <button mat-icon-button routerLink="/admin" matTooltip="Admin dashboard" class="icon-btn">
        <mat-icon>admin_panel_settings</mat-icon>
      </button>

      <button mat-button class="nav-btn" (click)="goHome()">
        <mat-icon class="nav-icon">directions_car</mat-icon>
        Vehicle Selector
      </button>
    </mat-toolbar>
  `,
  styles: [`
    .header {
      background: linear-gradient(135deg, #0d1147 0%, #1a237e 40%, #263238 100%);
      color: white;
      position: sticky;
      top: 0;
      z-index: 1000;
      border-bottom: 3px solid #ffc107;
      box-shadow: 0 2px 16px rgba(0,0,0,0.3);
      gap: 8px;
    }
    .logo {
      display: flex;
      align-items: center;
      gap: 10px;
      text-decoration: none;
      color: white;
      cursor: pointer;
    }
    .logo-icon-wrap {
      width: 36px;
      height: 36px;
      background: #ffc107;
      border-radius: 8px;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .logo-icon-wrap mat-icon {
      color: var(--fs-navy);
      font-size: 20px;
      width: 20px;
      height: 20px;
    }
    .logo-text-group {
      display: flex;
      flex-direction: column;
      line-height: 1.1;
    }
    .logo-text {
      font-size: 1.4rem;
      font-weight: 700;
      letter-spacing: 1px;
    }
    .logo-tagline {
      font-size: 0.6rem;
      text-transform: uppercase;
      letter-spacing: 1.5px;
      color: rgba(255,255,255,0.6);
    }
    .spacer { flex: 1; }
    .icon-btn {
      color: rgba(255,255,255,0.8) !important;
    }
    .icon-btn:hover {
      color: #ffc107 !important;
    }
    .nav-btn {
      color: white !important;
      border: 1px solid rgba(255,255,255,0.2);
      border-radius: 8px;
      transition: all 0.2s ease;
    }
    .nav-btn:hover {
      background: rgba(255,255,255,0.1);
      border-color: rgba(255,193,7,0.5);
      box-shadow: 0 0 12px rgba(255,193,7,0.2);
    }
    .nav-icon {
      color: #ffc107 !important;
      margin-right: 4px;
    }
    @media (max-width: 768px) {
      .nav-btn span { display: none; }
      app-global-search { display: none; }
    }
  `]
})
export class HeaderComponent {
  private router = inject(Router);
  private vehicleState = inject(VehicleState);
  private productState = inject(ProductState);
  themeState = inject(ThemeState);

  goHome(): void {
    this.vehicleState.reset();
    this.productState.resetFilters();
    this.router.navigate(['/']);
  }
}
