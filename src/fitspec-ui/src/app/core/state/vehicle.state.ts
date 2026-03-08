import { Injectable, inject, signal, computed, effect } from '@angular/core';
import { VehicleService } from '../services/vehicle.service';
import { MakeDto, ModelDto, VehicleYearDto, VehicleDetailDto, CategoryBreakdownDto } from '../models';

@Injectable({ providedIn: 'root' })
export class VehicleState {
  private vehicleService = inject(VehicleService);

  // Signals
  readonly makes = signal<MakeDto[]>([]);
  readonly models = signal<ModelDto[]>([]);
  readonly years = signal<VehicleYearDto[]>([]);
  readonly selectedMakeId = signal<number | null>(null);
  readonly selectedModelId = signal<number | null>(null);
  readonly selectedYear = signal<VehicleYearDto | null>(null);
  readonly selectedVehicle = signal<VehicleDetailDto | null>(null);
  readonly categoryBreakdown = signal<CategoryBreakdownDto[]>([]);
  readonly loadingMakes = signal(false);
  readonly loadingModels = signal(false);
  readonly loadingYears = signal(false);
  readonly loadingVehicle = signal(false);

  // Computed
  readonly hasCompleteSelection = computed(() =>
    this.selectedMakeId() !== null &&
    this.selectedModelId() !== null &&
    this.selectedYear() !== null
  );

  readonly selectedMakeName = computed(() => {
    const id = this.selectedMakeId();
    return this.makes().find(m => m.id === id)?.name ?? '';
  });

  readonly selectedModelName = computed(() => {
    const id = this.selectedModelId();
    return this.models().find(m => m.id === id)?.name ?? '';
  });

  // Saved vehicles from localStorage
  readonly savedVehicles = signal<VehicleDetailDto[]>(
    JSON.parse(localStorage.getItem('fitspec_saved_vehicles') ?? '[]')
  );

  constructor() {
    // Persist saved vehicles
    effect(() => {
      localStorage.setItem('fitspec_saved_vehicles', JSON.stringify(this.savedVehicles()));
    });

    this.loadMakes();
  }

  loadMakes(): void {
    this.loadingMakes.set(true);
    this.vehicleService.getMakes().subscribe({
      next: makes => {
        this.makes.set(makes);
        this.loadingMakes.set(false);
      },
      error: () => this.loadingMakes.set(false)
    });
  }

  selectMake(makeId: number): void {
    this.selectedMakeId.set(makeId);
    this.selectedModelId.set(null);
    this.selectedYear.set(null);
    this.selectedVehicle.set(null);
    this.categoryBreakdown.set([]);
    this.models.set([]);
    this.years.set([]);

    this.loadingModels.set(true);
    this.vehicleService.getModels(makeId).subscribe({
      next: models => {
        this.models.set(models);
        this.loadingModels.set(false);
      },
      error: () => this.loadingModels.set(false)
    });
  }

  selectModel(modelId: number): void {
    this.selectedModelId.set(modelId);
    this.selectedYear.set(null);
    this.selectedVehicle.set(null);
    this.categoryBreakdown.set([]);
    this.years.set([]);

    const makeId = this.selectedMakeId()!;
    this.loadingYears.set(true);
    this.vehicleService.getYears(makeId, modelId).subscribe({
      next: years => {
        this.years.set(years);
        this.loadingYears.set(false);
      },
      error: () => this.loadingYears.set(false)
    });
  }

  selectYear(yearEntry: VehicleYearDto): void {
    this.selectedYear.set(yearEntry);
    this.loadingVehicle.set(true);
    this.vehicleService.getVehicle(yearEntry.vehicleId).subscribe({
      next: vehicle => {
        this.selectedVehicle.set(vehicle);
        this.loadingVehicle.set(false);
        this.loadCategoryBreakdown(vehicle.id);
      },
      error: () => this.loadingVehicle.set(false)
    });
  }

  saveVehicle(vehicle: VehicleDetailDto): void {
    const current = this.savedVehicles();
    if (!current.some(v => v.id === vehicle.id)) {
      this.savedVehicles.set([...current, vehicle]);
    }
  }

  removeSavedVehicle(vehicleId: number): void {
    this.savedVehicles.set(this.savedVehicles().filter(v => v.id !== vehicleId));
  }

  selectVehicleById(vehicleId: number): void {
    this.loadingVehicle.set(true);
    this.vehicleService.getVehicle(vehicleId).subscribe({
      next: vehicle => {
        this.selectedVehicle.set(vehicle);
        this.loadingVehicle.set(false);
        this.loadCategoryBreakdown(vehicle.id);
      },
      error: () => this.loadingVehicle.set(false)
    });
  }

  reset(): void {
    this.selectedMakeId.set(null);
    this.selectedModelId.set(null);
    this.selectedYear.set(null);
    this.selectedVehicle.set(null);
    this.categoryBreakdown.set([]);
    this.models.set([]);
    this.years.set([]);
  }

  private loadCategoryBreakdown(vehicleId: number): void {
    this.vehicleService.getCategoryBreakdown(vehicleId).subscribe({
      next: breakdown => this.categoryBreakdown.set(breakdown)
    });
  }
}
