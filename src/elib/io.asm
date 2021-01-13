; eLibrary
; Input/Output subroutines

; Subroutine to print a string
print:
	pusha ; save current state of registers

	printLoop:
		; Char check
		mov al, [bx] ; load the char
		cmp al, ASCII_END ; check if end of string
		je return ; if al == ASCII_END then return end | lua is good psuedo-code


		; BIOS Printing
		mov ah, BIOS_MODE_TELETYPE ; enter tty mode
		int BIOS_INT ; interupt and print the char (from line 10)

		; Preperation for next iteration
		inc bx ; increment the pointer to get next char
		jmp printLoop ; repeat 

	return:
		popa ; restore all registers
		ret ; return to previous location

; Subroutine to print a string on a new line
newline:
	db ASCII_CARRIAGE_RETURN, ASCII_LINEBREAK

println:
	; Print the newline
	mov bx, newline
	call print
