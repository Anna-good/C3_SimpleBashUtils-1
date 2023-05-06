#ifndef SRC_COMMON_S21_GETLINE_H_
#define SRC_COMMON_S21_GETLINE_H_

#include <stdint.h>
#include <stdio.h>

//  if typedef doesn't exist (msvc, blah)
typedef intptr_t ssize_t;

ssize_t s21_getline_allocate(char **line, size_t *allocated_size, FILE *stream);

#endif  //  SRC_COMMON_S21_GETLINE_H_
