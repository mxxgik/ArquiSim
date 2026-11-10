# Programa 24 -- Reto: contar los negativos de un arreglo y mostrarlos en pantalla
#
#   int A[8] = {5, -3, 12, -7, 0, -1, 8, -20};
#   int NEGATIVOS;
#
#   int contar(int *p, int n) {          // $a0 = p, $a1 = n, retorno en $v0
#       int c = 0;
#       while (n != 0) { c += (*p < 0); p++; n--; }
#       return c;
#   }
#
#   NEGATIVOS = contar(A, 8);
#   for (x = 0; x < NEGATIVOS; x++) pantalla[0][x] = ROJO;
#
# Pantalla: píxel (x, y) en 0x400 + 32*y + x; en la fila 0 es simplemente 0x400 + x.
# Necesita: jal, jr, lw, sw, sb, slt, beq, j + pseudoinstrucciones li, la, clear

.data
A:          .word 5, -3, 12, -7, 0, -1, 8, -20     # 8 palabras: 4 negativas
NEGATIVOS:  .word 0                                 # resultado

.text
main:   la    $a0, A                # argumento 1: dirección del arreglo
        li    $a1, 8                # argumento 2: tamaño
        jal   CONTAR                # $v0 = cantidad de negativos
        sw    $v0, NEGATIVOS($zero) # guardar el resultado en .data

# Pintar un píxel rojo por cada negativo en la fila 0: x = 0 .. $v0-1
        clear $t0                   # x = 0
        li    $t1, 0x400            # base de la pantalla (fila 0)
        li    $t2, 1                # color rojo
PINTAR: beq   $t0, $v0, FIN
        add   $t3, $t1, $t0         # &píxel(x, 0) = 0x400 + x
        sb    $t2, 0($t3)
        addi  $t0, $t0, 1
        j     PINTAR

# ---------------- función CONTAR(p = $a0, n = $a1) -> $v0 ----------------
# Es una función hoja (no llama a otra), así que no necesita guardar $ra en la pila.
CONTAR: clear $v0                   # c = 0
CICLO:  beq   $a1, $zero, VOLVER    # mientras n != 0
        lw    $t0, 0($a0)           # t0 = *p
        slt   $t1, $t0, $zero       # t1 = (*p < 0) ? 1 : 0
        add   $v0, $v0, $t1         # c += t1
        addi  $a0, $a0, 4           # p++ (siguiente palabra)
        addi  $a1, $a1, -1          # n--
        j     CICLO
VOLVER: jr    $ra
FIN:
