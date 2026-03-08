import { PagedResult } from './api-response.model';

export interface ProductSummaryDto {
  id: number;
  sku: string;
  name: string;
  brand: string;
  price: number;
  imageUrl: string | null;
  categoryName: string;
  installDifficulty: number;
  isVerified: boolean;
  averageRating: number | null;
}

export interface ProductDetailDto {
  id: number;
  sku: string;
  name: string;
  description: string | null;
  brand: string;
  price: number;
  imageUrl: string | null;
  categoryId: number;
  categoryName: string;
  isVerified: boolean;
  weight: number | null;
  createdAt: string;
  extendedSpecs: Record<string, unknown> | null;
}

export interface ProductFilterParams {
  categoryId?: number;
  brand?: string;
  minPrice?: number;
  maxPrice?: number;
  maxDifficulty?: number;
  verifiedOnly?: boolean;
  sort?: string;
  page?: number;
  pageSize?: number;
}

export interface CompatibilityCheckDto {
  isCompatible: boolean;
  installDifficulty: number | null;
  fitmentNotes: string | null;
  isVerified: boolean;
}

export interface ProductRecommendationDto {
  productId: number;
  name: string;
  brand: string;
  price: number;
  imageUrl: string | null;
  categoryName: string;
  score: number;
}

export interface ReviewDto {
  id: string;
  productId: number;
  reviewerName: string;
  rating: number;
  title: string;
  body: string;
  verifiedPurchase: boolean;
  createdAt: string;
  vehicleDescription: string | null;
}

export interface ReviewSummaryDto {
  averageRating: number;
  totalReviews: number;
  ratingDistribution: Record<number, number>;
  reviews: PagedResult<ReviewDto>;
}

export interface ProductQuestionDto {
  id: string;
  productId: number;
  question: string;
  askerName: string;
  createdAt: string;
  answers: ProductAnswerDto[];
}

export interface ProductAnswerDto {
  id: string;
  answer: string;
  responderName: string;
  createdAt: string;
}
