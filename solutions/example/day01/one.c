#include <stdio.h>
#include <stdlib.h>

// solving the problem in plain vanilla C
//
// denis schluppeck, 2025

#define MAX_LINE_LENGTH 1024
#define MAX_NUMBERS 4000

// https://stackoverflow.com/a/13445867
// need a compare function for qsort from stdlib.h
int compare_int( const void* a, const void* b )
{
    if( *(int*)a == *(int*)b ) return 0;
    return *(int*)a < *(int*)b ? -1 : 1;
}

/* -------------------------------------------------- */
// main program
/* -------------------------------------------------- */

int main(int argc, char *argv[]) {

    // for reading lines into buffer and parsing
    char buffer[MAX_LINE_LENGTH];
    int ar[MAX_NUMBERS] = {0}, br[MAX_NUMBERS] = {0};    /* arrays of MAXC doubles */
    int a, b;

    if (argc < 2) {
        printf("Uhoh, not enough arguments!\n");
        printf("Usage: %s <fname> \n", argv[0]);
        return 1;
    }

    const char *filename = argv[1];

    printf("using filename: %s\n", filename);
    
    FILE *file = fopen(filename, "r");
    if (file == NULL) {
        perror("Error opening file");
        return 1;
    } 
    
    /* do the file parsing and processing here
     - read in 2 numbers per row,
     - sort each column individually,
     - take their pairwise difference (abs value)
     - sum it up.
     */
    int index = 0;
    while(fgets(buffer, MAX_LINE_LENGTH, file)) {
        // printf("%s\n", buffer);   
        if ( 2 == sscanf(buffer, "%d %d", &a,&b)){
            // printf("a: %d   b: %d\n", a,b);
            ar[index] = a;
            br[index] = b;
            index++;
        }
        
    }
    printf("Read %d pairs of numbers in total.\n", index);
   
    // sort a
    qsort( ar, index, sizeof(int), compare_int );
    // and b
    qsort( br, index, sizeof(int), compare_int );
    
    // debug info show
    // first 10 elements
    for (int i = 0; i < 10; i++)     {
        printf(">> ar[%d]: %d\n", i, ar[i]);
    }

    // last 10 elements
    for (int i = 0; i < 10; i++)     {
        printf("<< ar[%d]: %d\n", index-1-i, ar[index-1-i]);
    }
    
    //
    printf("size of array: %zu\n", sizeof(ar)/sizeof(ar[0]) );

    // for all elements... compute sum of abs differce
    int sum = 0;
    for (int i = 0; i < index; i++)     {
        sum += abs(ar[i] - br[i]);
    }
    printf("Sum of absolute differences: %d\n", sum);

    // now close file and exit
    int err = fclose(file);
    if (err != 0) {
        perror("Error closing file");
        return 1;
    } else {
        printf("File closed successfully.\n");
    }
    return 0;
}