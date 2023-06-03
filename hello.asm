section .data
  mensagem db 'Hello, World!', 10
  msg equ $ - mensagem

section .text
  global _main

_main:
  mov rax, 1
  mov rdi, 1
  mov rsi, mensagem
  mov rdx, msg
  syscall

  mov rax, 60
  mov rdi, 0
  syscall
