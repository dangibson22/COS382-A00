#lang racket

(define (isPrimeLoop lower upper n)
  (cond ((> lower upper) #t)
        ((= (modulo n lower) 0)#f)
        (else (isPrimeLoop (+ lower 1) upper n))
  )
)

(define (isPrime n)
  (define nSqrt (exact-floor (sqrt n)))
  (if (<= n 1)
  #f
  (begin
    (isPrimeLoop 2 nSqrt n)
  )
  )
)

(define (primesInner a b pList)
  (define newList (list))
  (if (> a b) pList
    (begin
      (when (isPrime a)  (set! pList (append pList (list a))))
      (primesInner (+ a 1) b pList)
    )
  )
)

(define (primes a b) (primesInner a b (list)))

(define (primePartitionsInner n k lst)
  (cond ((= n 0)
          (for-each
            (lambda (i)
              (if (= i (car (reverse lst)))
                (begin
                  (display i)
                  (display "\n")
                )
                (begin
                  (display i)
                  (display " + ")
                )
              )
            )
            lst
          )
        )
        ((> n k)
          (for-each
            (lambda (p) (primePartitionsInner (- n p) p (append lst (list p))))
            (primes (+ k 1) n)
          )
        )
        (else (lambda () ""))
  )
)

(define (primePartitions n) (primePartitionsInner n 1 (list)))


(define (main)
  (display "Enter a number (Ctrl+C to quit): ")
  (primePartitions (read))
  (main)
)

(main)