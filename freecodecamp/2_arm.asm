.global _start
_start:
    LDR R0, =list
    LDR R1 , [R0]
    LDR R2 , [R0, #4] ; return olarak değeri 4 artırır fakat r0 yu değiştirmez
    LDR R2 , [R0, #4]! ; önce R0 nun adresini 4 arttırır sonra okur

.data
list:
    .word 4, 5, -1, 2, 3, 1, 0, 7, 6, 8