.section .rodata
input_format:
    .string "%ld %ld"
output_format:
    .string "%ld\n"
input_error:
    .string "Eroare: introdu doua numere intregi.\n"
overflow_error:
    .string "Eroare: suma depaseste intervalul intregilor pe 64 de biti.\n"

.section .text
.globl main
.type main, @function
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp

    leaq -16(%rbp), %rsi
    leaq -8(%rbp), %rdx
    leaq input_format(%rip), %rdi
    xorl %eax, %eax
    call scanf@PLT

    cmpl $2, %eax
    jne .Linput_error

    movq -16(%rbp), %rax
    addq -8(%rbp), %rax
    jo .Loverflow_error

    movq %rax, %rsi
    leaq output_format(%rip), %rdi
    xorl %eax, %eax
    call printf@PLT

    xorl %eax, %eax
    leave
    ret

.Linput_error:
    leaq input_error(%rip), %rdi
    call puts@PLT
    movl $1, %eax
    leave
    ret

.Loverflow_error:
    leaq overflow_error(%rip), %rdi
    call puts@PLT
    movl $1, %eax
    leave
    ret

.size main, .-main
.section .note.GNU-stack,"",@progbits
