import { Component, inject } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { HeaderComponent } from './layout/header/header.component';
import { BuildSummaryComponent } from './features/build-summary/build-summary.component';
import { CompareTrayComponent } from './features/compare-tray/compare-tray.component';
import { FitmentAssistantComponent } from './features/fitment-assistant/fitment-assistant.component';
import { ThemeState } from './core/state/theme.state';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, HeaderComponent, BuildSummaryComponent, CompareTrayComponent, FitmentAssistantComponent],
  template: `
    <app-header />
    <router-outlet />
    <app-build-summary />
    <app-compare-tray />
    <app-fitment-assistant />
  `,
  styles: [`
    :host {
      display: flex;
      flex-direction: column;
      min-height: 100vh;
    }
    :host > *:not(app-header):not(app-build-summary):not(app-compare-tray):not(app-fitment-assistant) {
      display: flex;
      flex-direction: column;
    }
  `]
})
export class AppComponent {
  private themeState = inject(ThemeState);
}
