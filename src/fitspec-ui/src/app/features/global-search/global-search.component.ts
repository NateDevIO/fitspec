import { Component, inject, OnInit, signal } from '@angular/core';
import { FormControl, ReactiveFormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { MatAutocompleteModule } from '@angular/material/autocomplete';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatIconModule } from '@angular/material/icon';
import { AsyncPipe, CurrencyPipe } from '@angular/common';
import { Observable, of } from 'rxjs';
import { debounceTime, distinctUntilChanged, switchMap } from 'rxjs/operators';
import { SearchService, SearchResult } from '../../core/services/search.service';

@Component({
  selector: 'app-global-search',
  standalone: true,
  imports: [
    ReactiveFormsModule, MatAutocompleteModule, MatFormFieldModule,
    MatInputModule, MatIconModule, AsyncPipe, CurrencyPipe
  ],
  template: `
    <div class="search-wrapper">
      <mat-form-field class="search-field" appearance="outline" subscriptSizing="dynamic">
        <mat-icon matPrefix>search</mat-icon>
        <input matInput
          [formControl]="searchControl"
          [matAutocomplete]="auto"
          placeholder="Search products..."
          autocomplete="off">
        <mat-autocomplete #auto="matAutocomplete"
          (optionSelected)="onOptionSelected($event.option.value)"
          class="search-autocomplete">
          @for (result of (results$ | async) ?? []; track result.id) {
            <mat-option [value]="result">
              <div class="result-row">
                <div class="result-thumb">
                  @if (result.imageUrl) {
                    <img [src]="result.imageUrl" [alt]="result.title">
                  } @else {
                    <mat-icon class="thumb-placeholder">inventory_2</mat-icon>
                  }
                </div>
                <div class="result-info">
                  <span class="result-title">{{ result.title }}</span>
                  @if (result.subtitle) {
                    <span class="result-subtitle">{{ result.subtitle }}</span>
                  }
                </div>
                @if (result.price !== null) {
                  <span class="result-price">{{ result.price | currency }}</span>
                }
              </div>
            </mat-option>
          }
        </mat-autocomplete>
      </mat-form-field>
    </div>
  `,
  styles: [`
    .search-wrapper {
      display: flex;
      align-items: center;
    }
    .search-field {
      width: 280px;
      font-size: 0.85rem;
    }
    :host ::ng-deep .search-field .mat-mdc-text-field-wrapper {
      background: rgba(255,255,255,0.15) !important;
      border-radius: 8px;
    }
    :host ::ng-deep .search-field .mdc-notched-outline__leading,
    :host ::ng-deep .search-field .mdc-notched-outline__notch,
    :host ::ng-deep .search-field .mdc-notched-outline__trailing {
      border-color: rgba(255,255,255,0.3) !important;
    }
    :host ::ng-deep .search-field input.mat-mdc-input-element,
    :host ::ng-deep .search-field .mat-mdc-input-element {
      color: white !important;
      caret-color: #ffc107;
    }
    :host ::ng-deep .search-field input::placeholder,
    :host ::ng-deep .search-field .mat-mdc-input-element::placeholder {
      color: rgba(255,255,255,0.6) !important;
    }
    :host ::ng-deep .search-field .mat-mdc-form-field-icon-prefix mat-icon {
      color: rgba(255,255,255,0.7) !important;
    }
    :host ::ng-deep .search-field .mdc-floating-label {
      color: rgba(255,255,255,0.6) !important;
    }
    .result-row {
      display: flex;
      align-items: center;
      gap: 10px;
      padding: 4px 0;
    }
    .result-thumb {
      width: 36px;
      height: 36px;
      border-radius: 6px;
      overflow: hidden;
      flex-shrink: 0;
      background: #f0f2f5;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .result-thumb img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
    .thumb-placeholder {
      font-size: 18px;
      width: 18px;
      height: 18px;
      color: #aaa;
    }
    .result-info {
      flex: 1;
      display: flex;
      flex-direction: column;
      min-width: 0;
    }
    .result-title {
      font-size: 0.85rem;
      font-weight: 500;
      color: #263238;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }
    .result-subtitle {
      font-size: 0.72rem;
      color: #888;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }
    .result-price {
      font-size: 0.85rem;
      font-weight: 600;
      color: var(--fs-navy);
      white-space: nowrap;
    }
    @media (max-width: 600px) {
      .search-field { width: 180px; }
    }
  `]
})
export class GlobalSearchComponent implements OnInit {
  private searchService = inject(SearchService);
  private router = inject(Router);

  searchControl = new FormControl('');
  results$!: Observable<SearchResult[]>;

  ngOnInit(): void {
    this.results$ = this.searchControl.valueChanges.pipe(
      debounceTime(300),
      distinctUntilChanged(),
      switchMap(query => {
        if (!query || typeof query !== 'string' || query.trim().length < 2) {
          return of([]);
        }
        return this.searchService.search(query.trim());
      })
    );
  }

  onOptionSelected(result: SearchResult): void {
    this.router.navigate(['/products', result.id]);
    this.searchControl.setValue('');
  }
}
