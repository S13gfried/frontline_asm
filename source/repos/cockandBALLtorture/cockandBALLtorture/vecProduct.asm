.code
vecProduct proc

;EAX - MULTIPLICATION
;EBX - ACCUMULATOR
;ECX - MULTIPLE
;EDX - MULTIPLICATION
;ESI - VEC1 POINTER
;EDI - VEC2 POINTER
;R8 - RESULT PTR

push rbx
mov rsi, rcx
mov rdi, rdx

mov eax, [rsi + 4]
mov ecx, [rdi + 8]
mul ecx
mov ebx, eax

mov eax, [rsi + 8]
mov ecx, [rdi + 4]
mul ecx
sub ebx, eax

mov [r8], ebx

mov eax, [rsi + 8]
mov ecx, [rdi]
mul ecx
mov ebx, eax

mov eax, [rsi]
mov ecx, [rdi + 8]
mul ecx
sub ebx, eax

mov[r8 + 4], ebx

mov eax, [rsi]
mov ecx, [rdi + 4]
mul ecx
mov ebx, eax

mov eax, [rsi + 4]
mov ecx, [rdi]
mul ecx
sub ebx, eax

mov[r8 + 8], ebx

mov eax, [r8]
mul eax
mov ebx, eax
mov eax, [r8 + 4]
mul eax
add ebx, eax
mov eax, [r8 + 8]
mul eax
add eax, ebx

pop rbx
ret

vecProduct endp
end