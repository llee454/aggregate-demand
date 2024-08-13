(library (amina math basic (1 0 0))
  (export factorial square)
  (import (rnrs (6)) (amina math constants))

  (define (square x) (* x x))

  (define (factorial x)
    (if (= x 0) 1
      (* x (factorial (- x 1)))))
)