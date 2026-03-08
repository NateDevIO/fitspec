import { Component } from '@angular/core';
import { RouterLink, RouterLinkActive, RouterOutlet } from '@angular/router';
import { MatIconModule } from '@angular/material/icon';

@Component({
  selector: 'app-admin-layout',
  standalone: true,
  imports: [RouterLink, RouterLinkActive, RouterOutlet, MatIconModule],
  template: `
    <div class="admin-shell">
      <nav class="sidebar">
        <div class="sidebar-brand">
          <mat-icon class="brand-icon">admin_panel_settings</mat-icon>
          <span class="brand-text">FitSpec Admin</span>
        </div>

        <div class="nav-links">
          <a class="nav-link"
             routerLink="/admin"
             routerLinkActive="active"
             [routerLinkActiveOptions]="{ exact: true }">
            <mat-icon>dashboard</mat-icon>
            <span>Dashboard</span>
          </a>
          <a class="nav-link"
             routerLink="/admin/products"
             routerLinkActive="active">
            <mat-icon>inventory_2</mat-icon>
            <span>Products</span>
          </a>
          <a class="nav-link"
             routerLink="/admin/reviews"
             routerLinkActive="active">
            <mat-icon>rate_review</mat-icon>
            <span>Reviews</span>
          </a>
        </div>
      </nav>

      <main class="main-content">
        <router-outlet />
      </main>
    </div>
  `,
  styles: [`
    .admin-shell {
      display: flex;
      min-height: 100vh;
    }
    .sidebar {
      width: 240px;
      background: linear-gradient(180deg, #0d1147 0%, #1a237e 100%);
      color: white;
      display: flex;
      flex-direction: column;
      flex-shrink: 0;
    }
    .sidebar-brand {
      display: flex;
      align-items: center;
      gap: 10px;
      padding: 20px 20px 28px;
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
      margin-bottom: 8px;
    }
    .brand-icon {
      font-size: 28px;
      width: 28px;
      height: 28px;
      color: var(--fs-amber);
    }
    .brand-text {
      font-size: 1.1rem;
      font-weight: 700;
      letter-spacing: 0.5px;
    }
    .nav-links {
      display: flex;
      flex-direction: column;
      padding: 8px 12px;
      gap: 4px;
    }
    .nav-link {
      display: flex;
      align-items: center;
      gap: 12px;
      padding: 12px 16px;
      border-radius: 10px;
      color: rgba(255, 255, 255, 0.7);
      text-decoration: none;
      font-size: 0.9rem;
      font-weight: 500;
      transition: background 0.2s, color 0.2s;
      cursor: pointer;
    }
    .nav-link:hover {
      background: rgba(255, 255, 255, 0.08);
      color: white;
    }
    .nav-link.active {
      background: rgba(255, 255, 255, 0.15);
      color: white;
    }
    .nav-link.active mat-icon {
      color: var(--fs-amber);
    }
    .nav-link mat-icon {
      font-size: 22px;
      width: 22px;
      height: 22px;
      transition: color 0.2s;
    }
    .main-content {
      flex: 1;
      padding: 24px;
      background: #f5f7fa;
      overflow-y: auto;
    }
    @media (max-width: 768px) {
      .admin-shell { flex-direction: column; }
      .sidebar {
        width: 100%;
        flex-shrink: 1;
      }
      .sidebar-brand { padding: 12px 16px 12px; margin-bottom: 0; }
      .nav-links {
        flex-direction: row;
        overflow-x: auto;
        padding: 4px 8px;
        gap: 2px;
      }
      .nav-link {
        padding: 8px 12px;
        font-size: 0.8rem;
        white-space: nowrap;
        gap: 6px;
      }
      .main-content { padding: 16px; }
    }
  `]
})
export class AdminLayoutComponent {}
