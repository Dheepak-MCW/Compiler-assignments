#include <stdio.h>
#include <time.h>

#define N 512
#define TILE 64

static int A[N][N];
static int B[N][N];
static int C[N][N];

/*
 * Initialize the input matrices with deterministic values.
 */
static void initialize_matrices(void)
{
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            A[i][j] = (i + j) % 10;
            B[i][j] = (i + j) % 10;
        }
    }
}

/*
 * Reset the result matrix before every multiplication.
 */
static void clear_result(void)
{
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            C[i][j] = 0;
        }
    }
}

/*
 * Copy the current result matrix.
 */
static void copy_result(int destination[N][N])
{
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            destination[i][j] = C[i][j];
        }
    }
}

/*
 * Verify that two matrices contain the same result.
 */
static int verify_result(const int expected[N][N])
{
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            if (C[i][j] != expected[i][j]) {
                return 0;
            }
        }
    }

    return 1;
}

/*
 * Naive matrix multiplication.
 *
 * Loop order: i -> j -> k
 */
static void multiply_naive(void)
{
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            for (int k = 0; k < N; ++k) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }
}

/*
 * Loop interchange.
 *
 * Original order:
 *     i -> j -> k
 *
 * Changed order:
 *     i -> k -> j
 *
 * This improves memory access to rows of B and C.
 */
static void multiply_interchange(void)
{
    for (int i = 0; i < N; ++i) {
        for (int k = 0; k < N; ++k) {
            int aik = A[i][k];

            for (int j = 0; j < N; ++j) {
                C[i][j] += aik * B[k][j];
            }
        }
    }
}

/*
 * Loop tiling.
 *
 * The matrices are processed in smaller TILE x TILE blocks
 * to improve cache locality.
 */
static void multiply_tiling(void)
{
    for (int ii = 0; ii < N; ii += TILE) {
        for (int kk = 0; kk < N; kk += TILE) {
            for (int jj = 0; jj < N; jj += TILE) {

                int i_end = (ii + TILE < N) ? ii + TILE : N;
                int k_end = (kk + TILE < N) ? kk + TILE : N;
                int j_end = (jj + TILE < N) ? jj + TILE : N;

                for (int i = ii; i < i_end; ++i) {
                    for (int k = kk; k < k_end; ++k) {

                        int aik = A[i][k];

                        for (int j = jj; j < j_end; ++j) {
                            C[i][j] += aik * B[k][j];
                        }
                    }
                }
            }
        }
    }
}

/*
 * Loop unrolling.
 *
 * Four iterations of the innermost loop are processed together
 * to reduce loop-control overhead.
 */
static void multiply_unrolling(void)
{
    for (int i = 0; i < N; ++i) {
        for (int k = 0; k < N; ++k) {

            int aik = A[i][k];
            int j = 0;

            for (; j + 3 < N; j += 4) {
                C[i][j]     += aik * B[k][j];
                C[i][j + 1] += aik * B[k][j + 1];
                C[i][j + 2] += aik * B[k][j + 2];
                C[i][j + 3] += aik * B[k][j + 3];
            }

            /* Handle any remaining elements. */
            for (; j < N; ++j) {
                C[i][j] += aik * B[k][j];
            }
        }
    }
}

int main(void)
{
    /*
     * Static is important here.
     *
     * A 512 x 512 int matrix is approximately 1 MB.
     * Keeping this array static prevents a Windows stack overflow.
     */
    static int reference[N][N];

    initialize_matrices();

    printf("Matrix size %d x %d, tile size %d\n\n",
           N, N, TILE);

    /*
     * ---------------------------------------------------------
     * Naive multiplication
     * ---------------------------------------------------------
     */
    clear_result();

    clock_t start = clock();

    multiply_naive();

    clock_t end = clock();

    double naive_time =
        (double)(end - start) / CLOCKS_PER_SEC;

    copy_result(reference);

    printf("Naive         %.4f s   1.00x\n",
           naive_time);

    /*
     * ---------------------------------------------------------
     * Loop interchange
     * ---------------------------------------------------------
     */
    clear_result();

    start = clock();

    multiply_interchange();

    end = clock();

    double interchange_time =
        (double)(end - start) / CLOCKS_PER_SEC;

    printf("Interchange   %.4f s   %.2fx   %s\n",
           interchange_time,
           naive_time / interchange_time,
           verify_result(reference) ? "ok" : "FAILED");

    /*
     * ---------------------------------------------------------
     * Loop tiling
     * ---------------------------------------------------------
     */
    clear_result();

    start = clock();

    multiply_tiling();

    end = clock();

    double tiling_time =
        (double)(end - start) / CLOCKS_PER_SEC;

    printf("Tiling        %.4f s   %.2fx   %s\n",
           tiling_time,
           naive_time / tiling_time,
           verify_result(reference) ? "ok" : "FAILED");

    /*
     * ---------------------------------------------------------
     * Loop unrolling
     * ---------------------------------------------------------
     */
    clear_result();

    start = clock();

    multiply_unrolling();

    end = clock();

    double unrolling_time =
        (double)(end - start) / CLOCKS_PER_SEC;

    printf("Unrolling     %.4f s   %.2fx   %s\n",
           unrolling_time,
           naive_time / unrolling_time,
           verify_result(reference) ? "ok" : "FAILED");

    return 0;
}
