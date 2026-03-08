import { Injectable, signal, effect } from '@angular/core';

const STORAGE_KEY = 'fitspec_dark_mode';

@Injectable({ providedIn: 'root' })
export class ThemeState {
  readonly isDark = signal<boolean>(this.loadFromStorage());

  constructor() {
    effect(() => {
      const dark = this.isDark();
      if (dark) {
        document.body.classList.add('dark-mode');
      } else {
        document.body.classList.remove('dark-mode');
      }
    });
  }

  toggle(): void {
    const next = !this.isDark();
    this.isDark.set(next);
    localStorage.setItem(STORAGE_KEY, JSON.stringify(next));
  }

  private loadFromStorage(): boolean {
    try {
      const stored = localStorage.getItem(STORAGE_KEY);
      return stored ? JSON.parse(stored) === true : false;
    } catch {
      return false;
    }
  }
}
