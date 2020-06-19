# Tarea 5

## Ramírez Ancona Simón Eduardo

### __Gramática 2__

__S → ( L ) | a__  
__L → L , S | S__  
  
#### Factorizar o eliminar recursividad izquierda

No se puede factorizar.

Eliminando recursividad.

__S → ( L ) | a__  
__L → S L'__  
__L' → , S L' | €__  
