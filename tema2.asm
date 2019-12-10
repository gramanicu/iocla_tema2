%include "include/io.inc"

extern atoi
extern printf
extern exit

; Functions to read/free/print the image.
; The image is passed in argv[1].
extern read_image
extern free_image
; void print_image(int* image, int width, int height);
extern print_image

; Get image's width and height.
; Store them in img_[width, height] variables.
extern get_image_width
extern get_image_height

section .data
	use_str db "Use with ./tema2 <task_num> [opt_arg1] [opt_arg2]", 10, 0
    bruteforce_word db "revient", 0

section .bss
    task:       resd 1
    img:        resd 1
    img_width:  resd 1
    img_height: resd 1

section .text
global main

;int bruteforce_singlebyte_xor(int* img)
bruteforce_singlebyte_xor:
    enter 0, 0
    pusha

    mov edx, DWORD [ebp + 8]
    xor ecx, ecx
    mov cl, 0xff

    mov ebx, edx

bruteforce_loop_start:
    push ecx
    add ebx, 4

    matrix_loop:
    mov ecx, [img_width]

    row_loop:
    pop eax
    xor [ebx], eax
    add ebx, 4
    push eax
    loop row_loop


    pop ecx
    dec cl
    cmp cl, 0x00
    jne bruteforce_loop_start

    popa
    leave

;void lsb_encode(int* img, char* msg, int byte_id)
lsb_encode:
    push ebp
    mov ebp, esp
    pusha
    mov ebx, DWORD [ebp + 12]
    mov ecx, DWORD [ebp + 16]

    ;convert the starting byte position to integer

    mov eax, ecx
    push eax
    call atoi
    add esp, 4
    mov ecx, eax
    dec ecx

    mov edx, DWORD [ebp + 8]
    mov edx, [edx]
    lea edx, [edx + ecx*4]

    mov esi, ebx
    xor ebx, ebx
    xor eax, eax
; go through each letter of the message
lsb_loop:
    ; get a char from the message

    lodsb
    cmp al, 0x0
    jz lsb_loop_exit

    ; loop through the char bits
    mov ecx, 0x8

bytes_loop:
    ; get a bit
    shl al, 1
    jc bit_unary

bit_null:
    mov ebx, 0x0
    not ebx
    shl ebx, 1
    and [edx], ebx
    jmp bit_end

bit_unary:
    mov ebx, 0x1
    or [edx], ebx

bit_end:
    lea edx, [edx + 4]
    loop bytes_loop

    jmp lsb_loop
lsb_loop_exit:
    popa
    
    leave
    ret
main:
    ; Prologue
    ; Do not modify!
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    cmp eax, 1
    jne not_zero_param

    push use_str
    call printf
    add esp, 4

    push -1
    call exit

not_zero_param:
    ; We read the image. You can thank us later! :)
    ; You have it stored at img variable's address.
    mov eax, [ebp + 12]
    push DWORD[eax + 4]
    call read_image
    add esp, 4
    mov [img], eax

    ; We saved the image's dimensions in the variables below.
    call get_image_width
    mov [img_width], eax

    call get_image_height
    mov [img_height], eax

    ; Let's get the task number. It will be stored at task variable's address.
    mov eax, [ebp + 12]
    push DWORD[eax + 8]
    call atoi
    add esp, 4
    mov [task], eax

    ; There you go! Have fun! :D
    mov eax, [task]
    cmp eax, 1
    je solve_task1
    cmp eax, 2
    je solve_task2
    cmp eax, 3
    je solve_task3
    cmp eax, 4
    je solve_task4
    cmp eax, 5
    je solve_task5
    cmp eax, 6
    je solve_task6
    jmp done

solve_task1:
    ; TODO Task1
    push img
    call bruteforce_singlebyte_xor
    add esp, 4
    jmp done
solve_task2:
    ; TODO Task2
    jmp done
solve_task3:
    ; TODO Task3
    jmp done
solve_task4:
    ;push byte_id
    mov eax, [ebp + 12]
    push DWORD [eax + 16]
    push DWORD [eax + 12]
    push img
    call lsb_encode
    add esp, 12

    ; void print_image(int* image, int width, int height)
    push DWORD [img_height]
    push DWORD [img_width]
    push DWORD [img]
    call print_image
    add esp, 12

    jmp done
solve_task5:
    ; TODO Task5
    jmp done
solve_task6:
    ; TODO Task6
    jmp done

    ; Free the memory allocated for the image.
done:
    push DWORD[img]
    call free_image
    add esp, 4

    ; Epilogue
    ; Do not modify!
    xor eax, eax
    leave
    ret
    
