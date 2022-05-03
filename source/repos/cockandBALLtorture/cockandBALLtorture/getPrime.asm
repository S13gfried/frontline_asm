.code
getPrime proc
;EAX - ACCUMULATOR
;EBX - CURRENT NUMBER BEING TESTED
;ECX - ARGUMENT - PRIME NUMBER POSITION
;EDX - NO.OF PRIMES FOUND
;ESI - TEST DENOMINATOR
;EDI - DIVISBILITY CHECK LIMIT

push rbx

cmp ecx, 0
jle null

cmp ecx, 1
je two

mov ebx, 3
mov edx, 1
mov edi, 2

primeFound:
inc edx
cmp edx, ecx
je finish

next:
add ebx, 2
inc edi

mov esi, 1

testValue:
mov eax, ebx
add esi, 2
cmp esi, edi
ja primeFound

testDivisibility:
sub eax, esi
cmp eax, 0
jz next
jl testValue
jmp testDivisibility

finish:
mov eax, ebx
pop rbx
ret

two:
mov eax, 2
pop rbx
ret

null:
xor eax, eax
pop rbx
ret 

getPrime endp
end