; This library defines functions for performing vector calculations.
(library (amina math vector (1 0 0))
  (export vector-mapi vector-foldi vector-fold vector-sum vector-prod vector-forall? vector+ vector*)
  (import (rnrs (6)))

  ; Accepts two arguments: f, a function that accepts two arguments,
  ; a natural number and a value; and returns a value; and x, a
  ; vector; and returns a new vector of the same size as x where the
  ; ith element equals f i x[i].
  (define (vector-mapi f x)
    (let*
      ([n (vector-length x)]
       [res (make-vector n)])
      (do
        ([i 0 (+ i 1)])
        ((= i n) res)
        (vector-set! res i (f i (vector-ref x i))))))

  (assert (equal?
    (vector-mapi (lambda (i x) (* i x)) '#(1 2 3)) 
    '#(0 2 6)))

  ; Accepts three arguments: f, a function that accepts two arguments, a
  ; natural number and a value, and returns a value; init, a value; and x,
  ; a vector; and returns (f n (f 1 (f 0 init x0) x1) .. xn).
  (define (vector-foldi f init x)
    (let
      ([n (vector-length x)])
      (do
        ([i 0 (+ i 1)]
         [acc init])
        ((= i n) acc)
        (set! acc (f i acc (vector-ref x i))))))

  (assert (=
    (vector-foldi (lambda (i acc x) (+ (* (expt 2 i) x) acc)) 0 '#(1 2 3))
    (+ 1 4 12)))

  ; Accepts three arguments: f, a function that accepts two arguments, a
  ; natural number and a value, and returns a value; init, a value; and x,
  ; a vector; and returns (f (f (f init x0) x1) .. xn).
  (define (vector-fold f init x)
    (vector-foldi (lambda (i acc y) (f acc y)) init x))

  (assert (= (vector-fold + 0 '#(1 2 3)) 6))

  ; Accepts one argument: x, a vector; and returns the sum of all of the
  ; elements in x.
  (define (vector-sum x) (vector-fold + 0 x))

  (assert (= (vector-sum '#(1 2 3)) 6))

  ; Accepts one argument: x, a vector; and returns the product of all of the
  ; elements in x.
  (define (vector-prod x) (vector-fold * 1 x))

  (assert (= (vector-prod '#(1 2 3)) 6))

  ; Accepts two arguments: f, a function that accepts a value and
  ; returns a boolean; and x, a vector; and returns true iff f returns
  ; true for every value in x.
  (define (vector-forall? f x) (vector-fold (lambda (acc y) (and acc (f y))) #t x))

  (assert (vector-forall? even? '#(2 4 6)))
  (assert (not (vector-forall? even? '#(2 4 7))))

  (define (vector+ x y)
    (let*
      [(n (vector-length x))
       (z (make-vector n 0))]
      (assert (= n (vector-length y)))
      (do
        [(i 0 (+ i 1))]
        ((= i n) z)
        (vector-set! z i (+ (vector-ref x i) (vector-ref y i))))))
        
  (assert (equal? (vector+ '#(3 5 7) '#(7 11 13)) '#(10 16 20)))

  ; Returns the dot product of two vectors.
  (define (vector* x y)
    (vector-foldi (lambda (i acc z) (+ acc (* z (vector-ref y i)))) 0 x))

  (assert (= (vector* '#(3 5 7) '#(7 11 13)) 167))
)