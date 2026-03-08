import { Routes } from '@angular/router';

export const routes: Routes = [
  {
    path: '',
    loadComponent: () => import('./features/home/home.component').then(m => m.HomeComponent),
  },
  {
    path: 'vehicles/:vehicleId/products',
    loadComponent: () => import('./features/product-grid/product-grid.component').then(m => m.ProductGridComponent),
  },
  {
    path: 'products/:productId',
    loadComponent: () => import('./features/product-detail/product-detail.component').then(m => m.ProductDetailComponent),
  },
  {
    path: 'compare',
    loadComponent: () => import('./features/product-compare/product-compare.component').then(m => m.ProductCompareComponent),
  },
  {
    path: 'admin',
    loadComponent: () => import('./features/admin/admin-layout.component').then(m => m.AdminLayoutComponent),
    children: [
      { path: '', loadComponent: () => import('./features/admin/admin-dashboard.component').then(m => m.AdminDashboardComponent) },
      { path: 'products', loadComponent: () => import('./features/admin/admin-products.component').then(m => m.AdminProductsComponent) },
      { path: 'reviews', loadComponent: () => import('./features/admin/admin-reviews.component').then(m => m.AdminReviewsComponent) },
    ]
  },
  {
    path: 'checkout',
    loadComponent: () => import('./features/checkout/checkout.component').then(m => m.CheckoutComponent),
  },
  { path: '**', redirectTo: '' }
];
