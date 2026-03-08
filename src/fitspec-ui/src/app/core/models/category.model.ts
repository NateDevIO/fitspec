export interface CategoryDto {
  id: number;
  name: string;
  slug: string;
  icon: string | null;
  parentCategoryId: number | null;
  children: CategoryDto[];
}

export interface CategoryBreakdownDto {
  categoryId: number;
  name: string;
  slug: string;
  icon: string | null;
  productCount: number;
}
