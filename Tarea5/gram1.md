# Tarea 5

## Ramírez Ancona Simón Eduardo

### __Gramática 1__

__S  → S + T  | T__  
__T → T F | F__  
__F → ( S ) | S * | a__
  
#### Factorizar o eliminar recursividad izquierda

No se puede factorizar.

Eliminando recursividad.

__S  → T S'__  
__S' → + T S' | €__  
__T → F T'__  
__T' → F T' | €__  
__F → ( S ) | S * | a__ *Sigue siendo recursiva*  
__> F → ( S ) | F * | a__

Se elimina también la recursividad en F

__S  → T S'__  
__S' → + T S' | €__  
__T → F T'__  
__T' → F T' | €__  
__F → ( S ) F' | a F'__  
__F' → * S | €__
