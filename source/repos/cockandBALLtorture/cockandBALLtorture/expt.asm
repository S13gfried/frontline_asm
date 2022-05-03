.data
const_one dq 1.0
const_zero dq 0.0

.code
expt proc

;XMM0 - EXPONENT
;XMM1 - PRECISION
;XMM2 - CURRENT TERM
;XMM3 - SERIAL SUM
;XMM4 - COUNTER
;XMM5 - -PRECISION

movsd xmm2, mmword ptr [const_one]
movsd xmm3, mmword ptr [const_one]
movsd xmm4, mmword ptr [const_one]
xorps xmm5, xmm5
subsd xmm5, xmm1

series:		comisd xmm2, mmword ptr[const_zero]

				jbe belowzero
					comisd xmm2, xmm1
					jbe done
					jmp success
				belowzero:
					comisd xmm5, xmm2
					jbe done
				success:

				mulsd xmm2, xmm0
				divsd xmm2, xmm4

				addsd xmm3, xmm2
				addsd xmm4, mmword ptr[const_one]
				jmp series
done:

movsd xmm0, xmm3
ret

expt endp
end