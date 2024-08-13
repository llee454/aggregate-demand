(library (amina math statistics (1 0 0))
  (export cdf_normal erf factorial)
  (import (rnrs (6)) (amina math basic) (amina math constants))

  (define erf
    (case-lambda
      [(prec x)
       (*
         (/ 2 (sqrt pi))
         (do
           [(k 0 (+ k 1))
            (acc 0
              (+ acc
                (/
                  (* (expt -1 k) (expt x (+ (* 2 k) 1)))
                  (* (factorial k)
                    (+ (* 2 k) 1)))))]
           [(= k prec) acc]))]
      [(x) (erf 50 x)]))

  (define (cdf_normal x)
    (* 0.5 (+ 1 (erf (/ x (sqrt 2))))))
)