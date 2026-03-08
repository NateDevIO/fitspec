import { Component, inject, signal, ElementRef, ViewChild } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { AssistantService, ChatMessage } from '../../core/services/assistant.service';
import { VehicleState } from '../../core/state/vehicle.state';

@Component({
  selector: 'app-fitment-assistant',
  standalone: true,
  imports: [FormsModule, MatIconModule, MatButtonModule],
  template: `
    <!-- Floating Action Button -->
    <button class="fab-trigger" (click)="togglePanel()" [class.hidden]="isOpen()">
      <mat-icon>smart_toy</mat-icon>
    </button>

    <!-- Chat Panel -->
    @if (isOpen()) {
      <div class="chat-panel">
        <!-- Header -->
        <div class="chat-header">
          <div class="header-left">
            <mat-icon>smart_toy</mat-icon>
            <span class="header-title">FitSpec AI Assistant</span>
          </div>
          <button mat-icon-button class="close-btn" (click)="togglePanel()">
            <mat-icon>close</mat-icon>
          </button>
        </div>

        <!-- Messages -->
        <div class="chat-messages" #messagesContainer>
          @if (messages().length === 0) {
            <div class="welcome">
              <mat-icon class="welcome-icon">waving_hand</mat-icon>
              <p>Hi! I can help you find the right parts for your vehicle. Ask me anything about fitment or compatibility.</p>
            </div>
          }
          @for (msg of messages(); track $index) {
            <div class="msg" [class.msg-user]="msg.role === 'user'" [class.msg-assistant]="msg.role === 'assistant'">
              <div class="bubble">{{ msg.content }}</div>
            </div>
          }
          @if (isLoading()) {
            <div class="msg msg-assistant">
              <div class="bubble typing">
                <span class="dot"></span>
                <span class="dot"></span>
                <span class="dot"></span>
              </div>
            </div>
          }
        </div>

        <!-- Input Row -->
        <div class="chat-input-row">
          <input
            class="chat-input"
            [(ngModel)]="userInput"
            (keydown.enter)="send()"
            placeholder="Ask about fitment..."
            [disabled]="isLoading()" />
          <button mat-icon-button class="send-btn" (click)="send()" [disabled]="!userInput.trim() || isLoading()">
            <mat-icon>send</mat-icon>
          </button>
        </div>
      </div>
    }
  `,
  styles: [`
    .fab-trigger {
      position: fixed;
      bottom: 64px;
      right: 64px;
      z-index: 1000;
      width: 56px;
      height: 56px;
      border-radius: 50%;
      border: none;
      background: linear-gradient(135deg, #1a237e, #283593);
      color: white;
      cursor: pointer;
      box-shadow: 0 6px 24px rgba(26, 35, 126, 0.4);
      display: flex;
      align-items: center;
      justify-content: center;
      transition: transform 0.2s ease, box-shadow 0.2s ease;
    }
    .fab-trigger:hover {
      transform: scale(1.1);
      box-shadow: 0 8px 32px rgba(26, 35, 126, 0.5);
    }
    .fab-trigger.hidden { display: none; }
    .fab-trigger mat-icon { font-size: 28px; width: 28px; height: 28px; }

    .chat-panel {
      position: fixed;
      bottom: 64px;
      right: 64px;
      width: 380px;
      height: 480px;
      background: #fff;
      border-radius: 16px;
      box-shadow: 0 12px 48px rgba(0, 0, 0, 0.2);
      z-index: 1001;
      display: flex;
      flex-direction: column;
      overflow: hidden;
      animation: slideUp 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
    }
    @keyframes slideUp {
      from { opacity: 0; transform: translateY(20px) scale(0.9); }
      to { opacity: 1; transform: translateY(0) scale(1); }
    }

    .chat-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 14px 12px 14px 16px;
      background: linear-gradient(135deg, #0d1147, #1a237e);
      color: white;
      flex-shrink: 0;
    }
    .header-left {
      display: flex;
      align-items: center;
      gap: 10px;
    }
    .header-title { font-weight: 600; font-size: 0.95rem; }
    .close-btn { color: rgba(255,255,255,0.8); }
    .close-btn:hover { color: white; }

    .chat-messages {
      flex: 1;
      overflow-y: auto;
      padding: 16px;
      display: flex;
      flex-direction: column;
      gap: 10px;
    }
    .welcome {
      text-align: center;
      padding: 24px 12px;
      color: #777;
      font-size: 0.85rem;
      line-height: 1.5;
    }
    .welcome-icon {
      font-size: 32px; width: 32px; height: 32px;
      color: #ffc107;
      margin-bottom: 8px;
    }

    .msg { max-width: 82%; animation: bubbleIn 0.2s ease-out; }
    @keyframes bubbleIn {
      from { opacity: 0; transform: translateY(6px); }
      to { opacity: 1; transform: translateY(0); }
    }
    .msg-user { align-self: flex-end; }
    .msg-user .bubble {
      background: var(--fs-navy);
      color: white;
      border-radius: 16px 16px 4px 16px;
      padding: 10px 14px;
      font-size: 0.85rem;
      line-height: 1.4;
    }
    .msg-assistant { align-self: flex-start; }
    .msg-assistant .bubble {
      background: #eeeeee;
      color: #333;
      border-radius: 16px 16px 16px 4px;
      padding: 10px 14px;
      font-size: 0.85rem;
      line-height: 1.4;
    }

    .typing {
      display: flex;
      align-items: center;
      gap: 5px;
      padding: 12px 18px;
    }
    .dot {
      width: 8px;
      height: 8px;
      border-radius: 50%;
      background: #999;
      animation: bounce 1.2s infinite ease-in-out;
    }
    .dot:nth-child(2) { animation-delay: 0.2s; }
    .dot:nth-child(3) { animation-delay: 0.4s; }
    @keyframes bounce {
      0%, 80%, 100% { transform: scale(0.6); opacity: 0.4; }
      40% { transform: scale(1); opacity: 1; }
    }

    .chat-input-row {
      display: flex;
      align-items: center;
      gap: 6px;
      padding: 10px 12px;
      border-top: 1px solid #eee;
      flex-shrink: 0;
      background: #fafafa;
    }
    .chat-input {
      flex: 1;
      border: 1px solid #ddd;
      border-radius: 24px;
      padding: 10px 16px;
      font-size: 0.85rem;
      outline: none;
      transition: border-color 0.2s;
      font-family: inherit;
    }
    .chat-input:focus { border-color: var(--fs-navy); }
    .chat-input:disabled { background: #f5f5f5; }
    .send-btn { color: var(--fs-navy); }
    .send-btn:disabled { color: #ccc; }

    @media (max-width: 480px) {
      .chat-panel {
        width: calc(100vw - 16px);
        height: calc(100vh - 100px);
        bottom: 8px;
        right: 8px;
      }
      .fab-trigger { bottom: 24px; right: 24px; }
    }
  `]
})
export class FitmentAssistantComponent {
  private assistantService = inject(AssistantService);
  private vehicleState = inject(VehicleState);

  @ViewChild('messagesContainer') messagesContainer!: ElementRef;

  messages = signal<ChatMessage[]>([]);
  isOpen = signal(false);
  isLoading = signal(false);
  userInput = '';

  togglePanel(): void {
    this.isOpen.update(v => !v);
  }

  send(): void {
    const text = this.userInput.trim();
    if (!text || this.isLoading()) return;

    const userMsg: ChatMessage = { role: 'user', content: text };
    this.messages.update(msgs => [...msgs, userMsg]);
    this.userInput = '';
    this.isLoading.set(true);
    this.scrollToBottom();

    const vehicleId = this.vehicleState.selectedVehicle()?.id;

    this.assistantService.chat(text, vehicleId, undefined, this.messages()).subscribe({
      next: response => {
        const reply: ChatMessage = { role: 'assistant', content: response.message };
        this.messages.update(msgs => [...msgs, reply]);
        this.isLoading.set(false);
        this.scrollToBottom();
      },
      error: () => {
        const errMsg: ChatMessage = {
          role: 'assistant',
          content: 'Sorry, I encountered an error. Please try again.'
        };
        this.messages.update(msgs => [...msgs, errMsg]);
        this.isLoading.set(false);
        this.scrollToBottom();
      }
    });
  }

  private scrollToBottom(): void {
    setTimeout(() => {
      if (this.messagesContainer) {
        const el = this.messagesContainer.nativeElement;
        el.scrollTop = el.scrollHeight;
      }
    }, 50);
  }
}
