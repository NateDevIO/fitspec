export interface MakeDto {
  id: number;
  name: string;
  slug: string;
  logoUrl: string | null;
}

export interface ModelDto {
  id: number;
  name: string;
  slug: string;
}

export interface VehicleYearDto {
  vehicleId: number;
  year: number;
  trim: string | null;
  bodyStyle: string | null;
}

export interface VehicleDetailDto {
  id: number;
  year: number;
  make: string;
  model: string;
  trim: string | null;
  bodyStyle: string | null;
  driveType: string | null;
  towCapacityLbs: number | null;
}

export interface VinDecodeResultDto {
  vin: string;
  year: number | null;
  make: string | null;
  model: string | null;
  trim: string | null;
  bodyStyle: string | null;
  driveType: string | null;
  matchedVehicleId: number | null;
}
