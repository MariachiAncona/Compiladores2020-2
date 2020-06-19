#ifndef PARSER1_H
#define PARSER1_H

#define ID 1
#define COMA 2
#define PYC 3
#define INT 4
#define FLOAT 5

int token;

void error();
void decl();
int type();
void list(int);
void list_prima();
#endif