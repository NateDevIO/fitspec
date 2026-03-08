import { Component, HostListener, inject, OnDestroy, OnInit, signal } from '@angular/core';
import { ActivatedRoute, Router, NavigationEnd } from '@angular/router';
import { Subscription, filter } from 'rxjs';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatChipsModule } from '@angular/material/chips';
import { MatDividerModule } from '@angular/material/divider';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';
import { CurrencyPipe, DecimalPipe } from '@angular/common';
import { ProductService } from '../../core/services/product.service';
import { ProductDetailDto, CompatibilityCheckDto } from '../../core/models';
import { VehicleState } from '../../core/state/vehicle.state';
import { BuildState } from '../../core/state/build.state';
import { ProductReviewsComponent } from '../product-reviews/product-reviews.component';
import { RecommendationsComponent } from '../recommendations/recommendations.component';
import { InstallBreakdownComponent } from '../install-breakdown/install-breakdown.component';
import { RequiredAccessoriesComponent } from '../required-accessories/required-accessories.component';
import { CostEstimatorComponent } from '../cost-estimator/cost-estimator.component';
import { ProductQAComponent } from '../product-qa/product-qa.component';
import { PriceAlertComponent } from '../price-alert/price-alert.component';

@Component({
  selector: 'app-product-detail',
  standalone: true,
  imports: [MatCardModule, MatIconModule, MatButtonModule, MatChipsModule, MatDividerModule, MatProgressSpinnerModule, MatSnackBarModule, CurrencyPipe, DecimalPipe, ProductReviewsComponent, RecommendationsComponent, InstallBreakdownComponent, RequiredAccessoriesComponent, CostEstimatorComponent, ProductQAComponent, PriceAlertComponent],
  template: `
    @if (loading()) {
      <div class="loading-center"><mat-spinner diameter="48"></mat-spinner></div>
    } @else if (product()) {
      <div class="detail-container">
        <!-- Hero: image + key info side by side -->
        <div class="product-hero">
          <div class="hero-image" (click)="product()!.imageUrl ? openLightbox() : null">
            @if (product()!.imageUrl && !imageFailed()) {
              <img [src]="product()!.imageUrl" [alt]="product()!.name"
                (error)="imageFailed.set(true)">
            } @else {
              <div class="placeholder-img">
                <div class="placeholder-icon-box">
                  <mat-icon>{{ getCategoryIcon(product()!.categoryName) }}</mat-icon>
                </div>
                <span class="placeholder-label">{{ product()!.categoryName }}</span>
              </div>
            }
          </div>
          <div class="hero-info">
            <span class="brand-label">{{ product()!.brand }}</span>
            <h1 class="product-title">{{ product()!.name }}</h1>
            <span class="sku-label">SKU: {{ product()!.sku }}</span>
            <div class="price-row">
              <span class="price">{{ product()!.price | currency }}</span>
              @if (compatibility()?.isVerified) {
                <mat-chip-set>
                  <mat-chip class="verified-chip">
                    <mat-icon>verified</mat-icon> Verified Fit
                  </mat-chip>
                </mat-chip-set>
              }
            </div>
            <button mat-flat-button class="add-to-build-btn" (click)="addToBuild()">
              <mat-icon>add_shopping_cart</mat-icon> Add to Build
            </button>
          </div>
        </div>

        <!-- Details below the hero -->
        @if (compatibility(); as compat) {
          <mat-card class="compat-card" appearance="outlined"
            [class.compatible]="compat.isCompatible"
            [class.incompatible]="!compat.isCompatible">
            <mat-card-content>
              <div class="compat-header">
                <mat-icon>{{ compat.isCompatible ? 'check_circle' : 'cancel' }}</mat-icon>
                <span>{{ compat.isCompatible ? 'Compatible with your vehicle' : 'Not compatible with your vehicle' }}</span>
              </div>
              @if (compat.isCompatible && compat.installDifficulty) {
                <app-install-breakdown
                  [difficulty]="compat.installDifficulty"
                  [fitmentNotes]="compat.fitmentNotes ?? null" />
              }
            </mat-card-content>
          </mat-card>
        }

        <mat-divider></mat-divider>

        @if (product()!.description) {
          <div class="description">
            <h3>Description</h3>
            <p>{{ product()!.description }}</p>
          </div>
        }

        <div class="specs">
          <h3>Specifications</h3>
          <div class="spec-row"><span class="spec-label">Category</span><span class="spec-value">{{ product()!.categoryName }}</span></div>
          @if (product()!.weight) {
            <div class="spec-row"><span class="spec-label">Weight</span><span class="spec-value">{{ product()!.weight | number:'1.1-1' }} lbs</span></div>
          }
        </div>

        <app-required-accessories [productId]="product()!.id" [vehicleId]="vehicleState.selectedVehicle()?.id" />

        @if (compatibility()?.installDifficulty; as diff) {
          <app-cost-estimator [difficulty]="diff" />
        }

        <div class="action-buttons">
          @if (vehicleState.selectedVehicle(); as v) {
            <button mat-stroked-button (click)="openInstallGuide()" [disabled]="generatingGuide()">
              @if (generatingGuide()) {
                <mat-spinner diameter="16"></mat-spinner> Generating...
              } @else {
                <mat-icon>menu_book</mat-icon> Install Guide
              }
            </button>
            @if (compatibility()?.isCompatible) {
              <button mat-stroked-button (click)="openFitmentCert()" [disabled]="generatingCert()">
                @if (generatingCert()) {
                  <mat-spinner diameter="16"></mat-spinner> Generating...
                } @else {
                  <mat-icon>verified</mat-icon> Fitment Certificate
                }
              </button>
            }
          }
          <button mat-stroked-button (click)="openSpecSheet()" [disabled]="generatingSpec()">
            @if (generatingSpec()) {
              <mat-spinner diameter="16"></mat-spinner> Generating...
            } @else {
              <mat-icon>description</mat-icon> Spec Sheet
            }
          </button>
        </div>
        <p class="gen-note"><mat-icon>info</mat-icon> Guides and certificates are AI-generated on demand and may take 15–20 seconds to load.</p>

        <app-price-alert [productId]="product()!.id" [productName]="product()!.name" [currentPrice]="product()!.price" />
        <app-recommendations [productId]="product()!.id" />
        <app-product-reviews [productId]="product()!.id" />
        <app-product-qa [productId]="product()!.id" />
      </div>

      @if (lightboxOpen()) {
        <div class="lightbox-backdrop" (click)="closeLightbox()">
          <button class="lightbox-close" (click)="closeLightbox()">&times;</button>
          <img class="lightbox-image" [src]="product()!.imageUrl" [alt]="product()!.name" (click)="$event.stopPropagation()">
        </div>
      }
    }
  `,
  styles: [`
    .loading-center { display: flex; justify-content: center; padding: 48px; }
    .detail-container { max-width: 1100px; margin: 24px auto; padding: 0 24px; animation: fadeInUp 0.4s ease-out; }

    /* Hero: image left, key info right */
    .product-hero { display: flex; gap: 32px; margin-bottom: 24px; align-items: flex-start; }
    .hero-image {
      flex: 0 0 420px;
      height: 380px;
      border-radius: 16px;
      overflow: hidden;
      box-shadow: 0 4px 20px rgba(0,0,0,0.08);
      background: #e8eaf6;
      cursor: pointer;
    }
    .hero-image img {
      width: 100%;
      height: 100%;
      object-fit: contain;
      display: block;
      background: #fff;
    }
    .hero-info { flex: 1; min-width: 0; }

    .placeholder-img {
      width: 100%;
      height: 100%;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      gap: 12px;
      background: var(--fs-gradient-navy);
    }
    .placeholder-icon-box {
      width: 96px; height: 96px;
      background: rgba(255,193,7,0.12);
      border-radius: 24px;
      display: flex; align-items: center; justify-content: center;
      border: 1px solid rgba(255,193,7,0.2);
    }
    .placeholder-icon-box mat-icon {
      font-size: 48px; width: 48px; height: 48px;
      color: var(--fs-amber);
    }
    .placeholder-label {
      font-size: 0.75rem;
      text-transform: uppercase;
      letter-spacing: 2px;
      color: rgba(255,255,255,0.4);
      font-weight: 500;
    }

    .brand-label { font-size: 0.85rem; color: #888; text-transform: uppercase; letter-spacing: 1px; }
    .product-title { font-size: 1.8rem; font-weight: 700; margin: 4px 0 4px; color: var(--fs-navy); }
    .sku-label { font-size: 0.8rem; color: #aaa; }
    .price-row {
      display: flex;
      align-items: center;
      gap: 16px;
      margin: 16px 0;
      padding: 12px 16px;
      background: linear-gradient(135deg, rgba(26,35,126,0.04), rgba(255,193,7,0.06));
      border-radius: 10px;
    }
    .price { font-size: 2rem; font-weight: 700; color: var(--fs-navy); }
    .verified-chip { background: #e8f5e9 !important; color: #2e7d32 !important; }
    .add-to-build-btn {
      width: 100%;
      background: var(--fs-gradient-navy) !important;
      color: white !important;
      font-weight: 600;
      font-size: 1rem;
      height: 48px;
      border-radius: 10px;
    }
    .add-to-build-btn mat-icon { margin-right: 6px; }

    .compat-card { margin: 16px 0; border-radius: 10px; }
    .compat-card.compatible {
      border-color: #4caf50;
      background: linear-gradient(135deg, rgba(76,175,80,0.04), rgba(76,175,80,0.02));
    }
    .compat-card.incompatible {
      border-color: #f44336;
      background: linear-gradient(135deg, rgba(244,67,54,0.04), rgba(244,67,54,0.02));
    }
    .compat-header { display: flex; align-items: center; gap: 8px; font-weight: 500; }
    .compatible .compat-header mat-icon { color: #4caf50; }
    .incompatible .compat-header mat-icon { color: #f44336; }
    .description { margin: 16px 0; }
    .description h3, .specs h3 { font-size: 1.1rem; margin-bottom: 8px; color: var(--fs-charcoal); font-weight: 600; }
    .description p { color: #555; line-height: 1.6; }
    .specs { margin-top: 16px; }
    .spec-row {
      display: flex;
      justify-content: space-between;
      padding: 10px 0;
      border-bottom: 1px solid #eee;
    }
    .spec-label { color: #888; font-size: 0.9rem; }
    .spec-value { font-weight: 500; color: #333; }
    .action-buttons {
      display: flex;
      gap: 12px;
      flex-wrap: wrap;
      margin: 16px 0;
    }
    .action-buttons button {
      border-color: var(--fs-navy);
      color: var(--fs-navy);
    }
    .gen-note {
      display: flex;
      align-items: center;
      gap: 6px;
      font-size: 0.78rem;
      color: #999;
      margin: 4px 0 16px;
    }
    .gen-note mat-icon { font-size: 16px; width: 16px; height: 16px; color: #bbb; }
    .action-buttons button mat-icon {
      margin-right: 4px;
      font-size: 18px;
      width: 18px;
      height: 18px;
    }
    .action-buttons button mat-spinner {
      display: inline-block;
      margin-right: 6px;
      vertical-align: middle;
    }

    .lightbox-backdrop {
      position: fixed; top: 0; left: 0;
      width: 100vw; height: 100vh;
      background: rgba(0,0,0,0.85);
      display: flex; align-items: center; justify-content: center;
      z-index: 10000;
      animation: lightboxFadeIn 0.25s ease-out;
    }
    @keyframes lightboxFadeIn {
      from { opacity: 0; }
      to { opacity: 1; }
    }
    .lightbox-image {
      max-width: 90vw; max-height: 90vh;
      object-fit: contain; border-radius: 8px;
      animation: lightboxScaleIn 0.25s ease-out;
    }
    @keyframes lightboxScaleIn {
      from { opacity: 0; transform: scale(0.9); }
      to { opacity: 1; transform: scale(1); }
    }
    .lightbox-close {
      position: fixed; top: 20px; right: 28px;
      background: none; border: none; color: white;
      font-size: 2.5rem; cursor: pointer; line-height: 1;
      z-index: 10001; opacity: 0.8; transition: opacity 0.2s;
    }
    .lightbox-close:hover { opacity: 1; }

    @media (max-width: 768px) {
      .product-hero { flex-direction: column; }
      .hero-image { flex: none; width: 100%; height: 280px; }
    }
  `]
})
export class ProductDetailComponent implements OnInit, OnDestroy {
  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private productService = inject(ProductService);
  private buildState = inject(BuildState);
  private snackBar = inject(MatSnackBar);
  vehicleState = inject(VehicleState);
  private routerSub?: Subscription;
  private currentProductId = 0;

  product = signal<ProductDetailDto | null>(null);
  compatibility = signal<CompatibilityCheckDto | null>(null);
  loading = signal(true);
  lightboxOpen = signal(false);
  imageFailed = signal(false);
  generatingGuide = signal(false);
  generatingCert = signal(false);
  generatingSpec = signal(false);

  openLightbox(): void {
    this.lightboxOpen.set(true);
  }

  closeLightbox(): void {
    this.lightboxOpen.set(false);
  }

  @HostListener('document:keydown.escape')
  onEscapeKey(): void {
    if (this.lightboxOpen()) {
      this.closeLightbox();
    }
  }

  getCategoryIcon(category: string): string {
    const map: Record<string, string> = {
      'Hitches': 'tow',
      'Lighting': 'lightbulb',
      'Roof Racks': 'luggage',
      'Floor Mats': 'grid_on',
      'Cargo Management': 'inventory_2',
      'Electronics': 'electrical_services',
      'Exterior': 'directions_car',
      'Performance': 'speed',
    };
    return map[category] || 'build';
  }

  ngOnInit(): void {
    // Load initial product
    this.loadProduct();

    // Listen for subsequent navigations to the same route with different params
    this.routerSub = this.router.events.pipe(
      filter((e): e is NavigationEnd => e instanceof NavigationEnd)
    ).subscribe(() => {
      const newId = Number(this.route.snapshot.paramMap.get('productId'));
      if (newId && newId !== this.currentProductId) {
        this.loadProduct();
      }
    });
  }

  ngOnDestroy(): void {
    this.routerSub?.unsubscribe();
  }

  private loadProduct(): void {
    const productId = Number(this.route.snapshot.paramMap.get('productId'));
    if (!productId) return;
    this.currentProductId = productId;
    this.product.set(null);
    this.compatibility.set(null);
    this.imageFailed.set(false);
    this.loading.set(true);
    window.scrollTo({ top: 0 });
    this.productService.getProduct(productId).subscribe({
      next: p => {
        this.product.set(p);
        this.loading.set(false);
        const vehicleId = this.vehicleState.selectedVehicle()?.id;
        if (vehicleId) {
          this.productService.checkCompatibility(productId, vehicleId).subscribe({
            next: c => this.compatibility.set(c)
          });
        }
      },
      error: () => this.loading.set(false)
    });
  }

  addToBuild(): void {
    const p = this.product();
    if (!p) return;
    this.buildState.addItem({
      id: p.id, sku: p.sku, name: p.name, brand: p.brand,
      price: p.price, imageUrl: p.imageUrl, categoryName: p.categoryName,
      installDifficulty: 0, isVerified: p.isVerified, averageRating: null
    });
    this.snackBar.open(`${p.name} added to build`, 'View', { duration: 3000 });
  }

  openInstallGuide(): void {
    const v = this.vehicleState.selectedVehicle();
    if (!v) return;
    this.generatingGuide.set(true);
    const w = window.open('', '_blank');
    if (!w) { this.generatingGuide.set(false); return; }
    w.document.write('<p>Loading install guide...</p>');
    this.productService.getInstallGuide(this.product()!.id, v.id).subscribe({
      next: html => {
        w.document.open();
        w.document.write(html);
        w.document.close();
        this.generatingGuide.set(false);
      },
      error: () => this.generatingGuide.set(false)
    });
  }

  openFitmentCert(): void {
    const v = this.vehicleState.selectedVehicle();
    if (!v) return;
    this.generatingCert.set(true);
    const w = window.open('', '_blank');
    if (!w) { this.generatingCert.set(false); return; }
    w.document.write('<p>Loading fitment certificate...</p>');
    this.productService.getFitmentCertificate(this.product()!.id, v.id).subscribe({
      next: html => {
        w.document.open();
        w.document.write(html);
        w.document.close();
        this.generatingCert.set(false);
      },
      error: () => this.generatingCert.set(false)
    });
  }

  openSpecSheet(): void {
    const v = this.vehicleState.selectedVehicle();
    this.generatingSpec.set(true);
    const w = window.open('', '_blank');
    if (!w) { this.generatingSpec.set(false); return; }
    w.document.write('<p>Loading spec sheet...</p>');
    this.productService.getSpecSheet(this.product()!.id, v?.id).subscribe({
      next: html => {
        w.document.open();
        w.document.write(html);
        w.document.close();
        this.generatingSpec.set(false);
      },
      error: () => this.generatingSpec.set(false)
    });
  }
}
