# Ejercicio 1 -- Recorrer un arreglo "a mano" (sin ciclos todavía)
# Instrucciones: lw, sw (+ las de la Etapa 1)
#
#   int A[4] = {5, -3, 12, 7};      // en 0x200
#   int suma;                       // en 0x210
#   suma = A[0] + A[1] + A[2] + A[3];
#   intercambiar A[0] y A[3];
#
# 1. Ponga en $s0 la dirección base de A.
# 2. Calcule la suma en registros y guárdela en la variable SUMA (con sw).
# 3. Intercambie A[0] y A[3] EN MEMORIA.
#
# Preguntas: ¿qué desplazamiento usó para A[3] y por qué? Use "m A" en la interfaz para
# ver el arreglo antes y después. ¿Qué pasa si usa lw $t0, 2($s0)?
#
# Complete ej1_arreglo.esperado y verifique con:
#   ./sim -t programas/etapa_2/ej1_arreglo.asm
.data
A:      .word 5, -3, 12, 7
SUMA:   .word 0
.text
# escriba aquí su código

addi $s0, $zero, A     #base a
lw $t0, 0($s0)         #A[0]
lw $t1, 4($s0)         #A[1]
lw $t2, 8($s0)         #A[2]
lw $t3, 12($s0)        #A[3]
add $t4, $t0, $t1
add $t4, $t4, $t2
add $t4, $t4, $t3      # 21
sw $t4, SUMA($zero)
sw $t3, 0($s0)         #A[0] = 7
sw $t0, 12($s0)        #A[3] = 5
