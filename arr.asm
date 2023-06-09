segment .data
    defesp: dq 1                      ; Define 1 quadbyte para defesp
    cont: dq 0                      ; Inicializa o contador
    fmtEntrada: dq "%d", 0          ; Define o formato de entrada
    fmtSaida: dq "%d ", 0           ; Define o formato de saída

segment .bss
    array resq 1                    ; Define o array onde será alocado os valores

segment .text
    global main                     ; Define a função global "main"
    extern printf                   ; Importa a função printf do C
    extern scanf                    ; Importa a função scanf do C

main:
    push RBP                        ; Inicia a pilha para as chamadas das calls

    mov RAX, 0                      ; Zera o registrador rax
    mov RCX, 0                      ; Zera o registrador rcx para fazer as comparações 
    mov RBX, 0                      ; Zera o registrador rbx

    PreencheArray:
        cmp RCX, 4                  ; Compara se rcx é igual a n posições do array
        je ChamaImpressaoReversa    ; Se for igual vai para a impressão
        
        mov RAX, 0                  ; Move o valor 0 para rax
        mov RDI, fmtEntrada         ; Informa o formato de entrada para o rdi
        mov RSI, defesp             ; Move o valor de defesp para o rsi
        call scanf                  ; Chama a função scaf do C
        mov RAX, [defesp]           ; move o endereço de a para rax
        mov [array+RCX*8], RAX      ; Move o valor de RAX para o array
        add RBX, [defesp]	        ; Adiciona o que está no endereço de a para rbx
        inc RCX	                    ; Incrementa o contador feito em rcx para comparar se já está no final
        jmp PreencheArray           ; Pula para o loop novamente

    ChamaImpressaoReversa:
        mov RCX, 4                  ; Coloca o "ponteiro" no fim do array
        jmp ImprimeReverso          ; Chamada para imprimir em ordem inversa
    
    ImprimeReverso:
        cmp RCX, 0                  ; Compara se o valor em rcx é 0
        je finaliza                 ; Se for igual a 0 em rcx finaliza o programa
        mov RAX, [array+(RCX-1)*8]  ; Move para a posição anterior do array
        dec RCX	                    ; Decrementa rcx para comparar
        mov RDI, fmtSaida           ; Indica o formato de saída
        call printf                 ; Chama a função printf do C para printar o elemento
        jmp ImprimeReverso

    finaliza:
        mov RAX, 0
        pop RBP                     ; Finaliza a pilha já que não teremos mais nenhum call de função do C
    ret