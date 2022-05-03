.data

chars db "0123456789"

.code
stringConv proc
;EAX - POWER OF 10
;EBX - DIVISION RESULT
;ECX - 10 (CONSTANT)
;EDX - TEMP CHAR STORAGE
;ESI - COUNTER
;EDI - INTEGER : ARGUMENT
;R8 - BUFFER - WISE COUNTER
;R9 - BUFFER ADDRESS
;R10 - SAMPLE CHARS ADDRESS

push rbx
mov edi, edx
lea r10, chars
mov r9, rcx

mov eax, 1
mov rsi, 0
mov ecx, 10

cmp edi, 0
jg measure

mov dl, "-"
mov[r9], dl
inc r9
mov r11, rdi
mov rdi, 0
sub rdi, r11

measure: inc esi
				mul ecx
				cmp edi, eax
				jle m_done
				jmp measure
m_done:	
mov	r8, 0

digit:		mov edx, 0
				div ecx
				mov rbx, 0

				divide:		sub edi, eax
								jl d_done
								inc rbx
								jmp divide
				d_done:

				add edi, eax			
				mov dl, [r10 + rbx]
				mov [r9 + r8], dl
			
				inc r8
				dec esi
				je fin
				jmp digit

fin:			mov dl, 0
				mov [r9 + r8], dl
				mov rax, r8
				pop rbx
				ret

stringConv endp
end