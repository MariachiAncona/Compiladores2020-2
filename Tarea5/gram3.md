# Tarea 5

## Ramírez Ancona Simón Eduardo

### __Gramática 3__

__G → P G | P__  
__P → id : R__  
__R → R id | €__  
  
#### Factorizar o eliminar recursividad izquierda

Eliminando recursividad y factorizando.

__G → P G'__  
__G' → G | €__  
__P → id : R__  
__R → R'__  
__R' → id R' | €__
