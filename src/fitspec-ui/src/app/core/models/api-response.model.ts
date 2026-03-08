export interface ApiResponse<T> {
  success: boolean;
  data: T | null;
  meta: ApiMeta | null;
  errors: string[] | null;
}

export interface ApiMeta {
  page: number;
  pageSize: number;
  totalCount: number;
  totalPages: number;
}

export interface PagedResult<T> {
  items: T[];
  totalCount: number;
  page: number;
  pageSize: number;
  totalPages: number;
}
