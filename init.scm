(import (rnrs (6)))
(import (amina math basic))
(import (amina math vector))
(import (amina math matrix))
(import (amina math statistics))
(import (math minima))

(define-record-type distrib
  (fields
    (immutable mean)
    (immutable std)))

(define (distrib->list x)
  (list
    (distrib-mean x)
    (distrib-std x)))

(define-record-type factor
  (fields
    (immutable name)
    (immutable distrib)))

(define (factor->list x)
  (list
    (factor-name x)
    (distrib->list (factor-distrib x))))

(define factors
  (vector
    (make-factor "Price" (make-distrib -3 1))
    (make-factor "Power" (make-distrib -2 3))
    (make-factor "Performance" (make-distrib 4 3))
    (make-factor "Area" (make-distrib -1 2))))

(define-record-type product
  (fields
    (immutable name)
    (immutable data)))

(define (product->list f x)
  (list
    (product-name x)
    (f (product-data x))))

(define (get-product-score-mean product)
  (vector*
    (product-data product)
    (vector-map
      (lambda (x) (distrib-mean (factor-distrib x)))
      factors)))

(define (get-product-score-std product)
  (sqrt (vector*
    (vector-map square (product-data product))
    (vector-map
      (lambda (x) (square (distrib-std (factor-distrib x))))
      factors))))

; Returns a vector of products and their product score distributions.
(define (get-product-score-distribs products)
  (vector-map
    (lambda (x)
      (make-product
        (product-name x)
        (make-distrib
          (get-product-score-mean x)
          (get-product-score-std x))))
    products))

(define (get-relative-probabilities products)
  (let
    [(n (vector-length products))]
    (make-matrix
      (lambda (i j)
        (let
          [(p (vector-ref products i))
           (q (vector-ref products j))]
          (cdf_normal
            (/ (- (distrib-mean (product-data p))
                  (distrib-mean (product-data q)))
               (sqrt
                 (+ (square (distrib-std (product-data p)))
                    (square (distrib-std (product-data q)))))))))
      n n)))

(define (get-relative-ratios probs)
  (let-values
    ([(n m) (matrix-get-dims probs)])
    (assert (= n m))
    (make-matrix
      (lambda (i j) (/ (matrix-ref probs i j) (matrix-ref probs j i)))
      n n)))

(define (get-market-shares ratios)
  (vector-map
    (lambda (x) (expt x -1)) 
    (let*-values
      ([(n m) (matrix-get-dims ratios)]
       [(res) (make-vector m 0)])
      (do
        [(i 0 (+ i 1))]
        ((= i n) res)
        (set! res (vector+ res (vector-ref ratios i)))))))

; The number of processors (units) sold in the market.
(define num-units 1e7)

; Converts a price score into an absolute price amount.
(define (get-price-amount price) (* 5 (- (exp (* 1/10 price)) 1)))

; Calculate the gross earnings for each of the products given the market competition and unit demand.
(define (get-gross-earnings products)
  (vector-mapi
    (lambda (i x) 
      (* x num-units
        (get-price-amount (vector-ref (product-data (vector-ref products i)) 0))))
    (get-market-shares
      (get-relative-ratios
        (get-relative-probabilities
          (get-product-score-distribs products))))))

; Finds the optimal price for the second example processor in the example market. 
(define (get-best-price)
  (car (golden-section-search
    (lambda (price)
      (- (vector-ref
        (get-gross-earnings (get-products price))
        1)))
    0 50 1/1000)))
  
; Return the set of example products where the second product has the given price.
(define (get-products price)
  (vector
    (make-product "$A_0$" (vector 1 1 1 1))
    (make-product "$A_1$" (vector price 3 5 3))
    (make-product "$A_2$" (vector 2 2 3 2))))

; Returns a vector of products with their factor scores.
(define init-products (get-products 10))

(define init-products-scores
  (get-product-score-distribs init-products))

(define init-products-probs
  (get-relative-probabilities init-products-scores))

(define init-products-ratios
  (get-relative-ratios init-products-probs))

(define init-products-market-shares
  (get-market-shares init-products-ratios))

(define init-products-gross-earnings
  (get-gross-earnings init-products))
  
; Returns a vector of products with their factor scores.
(define modified-products (get-products (get-best-price)))

(define modified-products-scores
  (get-product-score-distribs modified-products))

(define modified-products-probs
  (get-relative-probabilities modified-products-scores))

(define modified-products-ratios
  (get-relative-ratios modified-products-probs))

(define modified-products-market-shares
  (get-market-shares modified-products-ratios))

(define modified-products-gross-earnings
  (get-gross-earnings modified-products))