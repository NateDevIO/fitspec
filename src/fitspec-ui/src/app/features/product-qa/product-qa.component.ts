import { Component, inject, signal, input, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatDividerModule } from '@angular/material/divider';
import { DatePipe } from '@angular/common';
import { ProductService } from '../../core/services/product.service';
import { ProductQuestionDto } from '../../core/models';

@Component({
  selector: 'app-product-qa',
  standalone: true,
  imports: [FormsModule, MatCardModule, MatIconModule, MatButtonModule, MatFormFieldModule, MatInputModule, MatProgressSpinnerModule, MatDividerModule, DatePipe],
  template: `
    <div class="qa-section">
      <h3 class="section-title">
        <mat-icon>forum</mat-icon>
        Questions & Answers
      </h3>

      @if (loading()) {
        <div class="loading"><mat-spinner diameter="24"></mat-spinner></div>
      } @else {
        <!-- Ask a Question Form -->
        <mat-card appearance="outlined" class="ask-card">
          <h4 class="ask-title">Ask a Question</h4>
          <div class="ask-form">
            <mat-form-field appearance="outline" class="full-width">
              <mat-label>Your question</mat-label>
              <textarea matInput [(ngModel)]="newQuestion" rows="2" placeholder="What would you like to know about this product?"></textarea>
            </mat-form-field>
            <mat-form-field appearance="outline">
              <mat-label>Your name</mat-label>
              <input matInput [(ngModel)]="askerName" placeholder="Display name">
            </mat-form-field>
            <button mat-flat-button color="primary" class="ask-btn"
              [disabled]="!newQuestion.trim() || !askerName.trim() || submitting()"
              (click)="submitQuestion()">
              @if (submitting()) {
                <mat-spinner diameter="18"></mat-spinner>
              } @else {
                <mat-icon>send</mat-icon> Ask
              }
            </button>
          </div>
        </mat-card>

        @if (!questions().length) {
          <div class="empty-state">
            <mat-icon>help_outline</mat-icon>
            <p>No questions yet. Be the first to ask!</p>
          </div>
        }

        <!-- Questions List -->
        @for (q of questions(); track q.id) {
          <mat-card appearance="outlined" class="question-card">
            <div class="question-header">
              <mat-icon class="q-icon">help</mat-icon>
              <div class="question-content">
                <p class="question-text">{{ q.question }}</p>
                <span class="question-meta">{{ q.askerName }} &middot; {{ q.createdAt | date:'mediumDate' }}</span>
              </div>
            </div>

            <!-- Answers -->
            @for (a of q.answers; track a.id) {
              <div class="answer-row">
                <mat-icon class="a-icon">subdirectory_arrow_right</mat-icon>
                <div class="answer-content">
                  <p class="answer-text">{{ a.answer }}</p>
                  <span class="answer-meta">{{ a.responderName }} &middot; {{ a.createdAt | date:'mediumDate' }}</span>
                </div>
              </div>
            }

            <!-- Reply Form Toggle -->
            @if (replyingTo() === q.id) {
              <div class="reply-form">
                <mat-form-field appearance="outline" class="full-width">
                  <mat-label>Your answer</mat-label>
                  <textarea matInput [(ngModel)]="replyText" rows="2" placeholder="Share your knowledge..."></textarea>
                </mat-form-field>
                <div class="reply-actions">
                  <mat-form-field appearance="outline">
                    <mat-label>Your name</mat-label>
                    <input matInput [(ngModel)]="responderName">
                  </mat-form-field>
                  <button mat-flat-button color="primary"
                    [disabled]="!replyText.trim() || !responderName.trim() || submittingReply()"
                    (click)="submitAnswer(q.id)">
                    @if (submittingReply()) {
                      <mat-spinner diameter="18"></mat-spinner>
                    } @else {
                      Submit
                    }
                  </button>
                  <button mat-stroked-button (click)="cancelReply()">Cancel</button>
                </div>
              </div>
            } @else {
              <button mat-stroked-button class="reply-btn" (click)="startReply(q.id)">
                <mat-icon>reply</mat-icon> Answer
              </button>
            }
          </mat-card>
        }
      }
    </div>
  `,
  styles: [`
    .qa-section { margin: 32px 0; }
    .section-title {
      display: flex;
      align-items: center;
      gap: 8px;
      font-size: 1.1rem;
      font-weight: 600;
      color: var(--fs-charcoal);
      margin-bottom: 16px;
    }
    .section-title mat-icon { color: var(--fs-navy); font-size: 22px; width: 22px; height: 22px; }
    .loading { display: flex; justify-content: center; padding: 16px; }
    .ask-card {
      border-radius: 12px;
      padding: 16px;
      margin-bottom: 16px;
      background: linear-gradient(135deg, rgba(26,35,126,0.02), rgba(255,193,7,0.03));
    }
    .ask-title { font-size: 0.95rem; font-weight: 600; color: var(--fs-navy); margin: 0 0 12px; }
    .ask-form { display: flex; flex-wrap: wrap; gap: 12px; align-items: flex-start; }
    .full-width { flex: 1; min-width: 250px; }
    .ask-btn {
      background-color: var(--fs-navy) !important;
      color: white !important;
      height: 56px;
    }
    .ask-btn mat-icon { margin-right: 4px; font-size: 18px; width: 18px; height: 18px; }
    .empty-state {
      text-align: center;
      padding: 32px;
      color: #999;
    }
    .empty-state mat-icon { font-size: 40px; width: 40px; height: 40px; color: #ccc; }
    .empty-state p { margin: 8px 0 0; }
    .question-card {
      border-radius: 12px;
      padding: 16px;
      margin-bottom: 12px;
    }
    .question-header { display: flex; gap: 10px; align-items: flex-start; }
    .q-icon { color: var(--fs-navy); flex-shrink: 0; margin-top: 2px; }
    .question-content { flex: 1; }
    .question-text { margin: 0; font-weight: 500; color: var(--fs-charcoal); line-height: 1.4; }
    .question-meta { font-size: 0.75rem; color: #999; }
    .answer-row {
      display: flex;
      gap: 10px;
      align-items: flex-start;
      margin-top: 12px;
      padding-left: 24px;
    }
    .a-icon { color: #4caf50; flex-shrink: 0; margin-top: 2px; font-size: 20px; width: 20px; height: 20px; }
    .answer-content { flex: 1; }
    .answer-text {
      margin: 0;
      color: #444;
      line-height: 1.4;
      font-size: 0.9rem;
      background: #f9f9f9;
      padding: 10px 14px;
      border-radius: 8px;
      border-left: 3px solid #4caf50;
    }
    .answer-meta { font-size: 0.7rem; color: #aaa; }
    .reply-btn {
      margin-top: 12px;
      margin-left: 34px;
      border-color: var(--fs-navy) !important;
      color: var(--fs-navy) !important;
      font-size: 0.8rem;
    }
    .reply-btn mat-icon { font-size: 16px; width: 16px; height: 16px; margin-right: 4px; }
    .reply-form {
      margin-top: 12px;
      padding-left: 34px;
    }
    .reply-actions { display: flex; gap: 8px; align-items: flex-start; flex-wrap: wrap; }
    .reply-actions button { height: 56px; }
    @media (max-width: 600px) {
      .full-width { min-width: 0; }
      .ask-form { flex-direction: column; }
      .ask-btn { width: 100%; }
      .reply-form { padding-left: 12px; }
      .answer-row { padding-left: 8px; }
      .reply-btn { margin-left: 8px; }
    }
  `]
})
export class ProductQAComponent implements OnInit {
  productId = input.required<number>();

  private productService = inject(ProductService);

  questions = signal<ProductQuestionDto[]>([]);
  loading = signal(false);
  submitting = signal(false);
  submittingReply = signal(false);
  replyingTo = signal<string | null>(null);

  newQuestion = '';
  askerName = '';
  replyText = '';
  responderName = '';

  ngOnInit(): void {
    this.loadQuestions();
  }

  private loadQuestions(): void {
    this.loading.set(true);
    this.productService.getQuestions(this.productId()).subscribe({
      next: qs => {
        this.questions.set(qs);
        this.loading.set(false);
      },
      error: () => this.loading.set(false)
    });
  }

  submitQuestion(): void {
    if (!this.newQuestion.trim() || !this.askerName.trim()) return;
    this.submitting.set(true);
    this.productService.askQuestion(this.productId(), this.newQuestion.trim(), this.askerName.trim()).subscribe({
      next: q => {
        this.questions.update(qs => [q, ...qs]);
        this.newQuestion = '';
        this.submitting.set(false);
      },
      error: () => this.submitting.set(false)
    });
  }

  startReply(questionId: string): void {
    this.replyingTo.set(questionId);
    this.replyText = '';
  }

  cancelReply(): void {
    this.replyingTo.set(null);
    this.replyText = '';
  }

  submitAnswer(questionId: string): void {
    if (!this.replyText.trim() || !this.responderName.trim()) return;
    this.submittingReply.set(true);
    this.productService.answerQuestion(this.productId(), questionId, this.replyText.trim(), this.responderName.trim()).subscribe({
      next: updated => {
        this.questions.update(qs => qs.map(q => q.id === questionId ? updated : q));
        this.replyingTo.set(null);
        this.replyText = '';
        this.submittingReply.set(false);
      },
      error: () => this.submittingReply.set(false)
    });
  }
}
