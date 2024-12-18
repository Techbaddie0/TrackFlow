;; Supply Chain Tracking Contract
;; Manages product provenance, logistics, and inventory

(define-map products
  { product-id: uint }
  {
    name: (string-utf8 100)
    manufacturer: (string-utf8 100)
    current-location: (string-utf8 100)
    owner: principal
    status: (string-utf8 50)
    timestamp: uint
  }
)

(define-map product-history
  { product-id: uint, history-index: uint }
  {
    location: (string-utf8 100)
    timestamp: uint
    status: (string-utf8 50)
    handler: principal
  }
)

(define-map product-count
  { manufacturer: (string-utf8 100) }
  { total-products: uint }
)

;; Store the next available product ID
(define-data-var next-product-id uint u0)

;; Error constants
(define-constant err-unauthorized (err u100))
(define-constant err-product-not-found (err u101))
(define-constant err-invalid-status (err u102))

;; Create a new product in the supply chain
(define-public (create-product 
  (name (string-utf8 100))
  (manufacturer (string-utf8 100))
)
  (let 
    (
      (product-id (var-get next-product-id))
      (current-count 
        (default-to 
          { total-products: u0 } 
          (map-get? product-count { manufacturer: manufacturer })
        )
      )
    )
    ;; Increment product ID
    (var-set next-product-id (+ product-id u1))
    
    ;; Create product entry
    (map-set products 
      { product-id: product-id }
      {
        name: name
        manufacturer: manufacturer
        current-location: manufacturer
        owner: tx-sender
        status: "CREATED"
        timestamp: block-height
      }
    )
    
    ;; Update product history
    (map-set product-history 
      { product-id: product-id, history-index: u0 }
      {
        location: manufacturer
        timestamp: block-height
        status: "CREATED"
        handler: tx-sender
      }
    )
    
    ;; Update manufacturer product count
    (map-set product-count 
      { manufacturer: manufacturer }
      { total-products: (+ (get total-products current-count) u1) }
    )
    
    (ok product-id)
)

;; Update product location and status
(define-public (update-product-location
  (product-id uint)
  (new-location (string-utf8 100))
  (new-status (string-utf8 50))
)
  (let 
    (
      (product (unwrap! (map-get? products { product-id: product-id }) err-product-not-found))
      (current-history-index 
        (default-to u0 
          (fold 
            (lambda (index accum)
              (if (is-some (map-get? product-history { product-id: product-id, history-index: index }))
                  (+ index u1)
                  index
              )
            )
            (list u0 u1 u2 u3 u4 u5 u6 u7 u8 u9)
            u0
          )
        )
    )
    )
    ;; Verify product ownership
    (asserts! (is-eq tx-sender (get owner product)) err-unauthorized)
    
    ;; Update product details
    (map-set products 
      { product-id: product-id }
      (merge product {
        current-location: new-location
        status: new-status
        timestamp: block-height
      })
    )
    
    ;; Add to product history
    (map-set product-history 
      { product-id: product-id, history-index: current-history-index }
      {
        location: new-location
        timestamp: block-height
        status: new-status
        handler: tx-sender
      }
    )
    
    (ok true)
)

;; Transfer product ownership
(define-public (transfer-product
  (product-id uint)
  (new-owner principal)
)
  (let 
    (
      (product (unwrap! (map-get? products { product-id: product-id }) err-product-not-found))
    )
    ;; Verify current owner
    (asserts! (is-eq tx-sender (get owner product)) err-unauthorized)
    
    ;; Update product ownership
    (map-set products 
      { product-id: product-id }
      (merge product { 
        owner: new-owner 
        status: "TRANSFERRED"
        timestamp: block-height
      })
    )
    
    (ok true)
)

;; Read product details
(define-read-only (get-product-details (product-id uint))
  (map-get? products { product-id: product-id })
)

;; Read product history
(define-read-only (get-product-history (product-id uint))
  (begin
    (fold 
      (lambda (index filtered-history)
        (match (map-get? product-history { product-id: product-id, history-index: index })
          entry (append filtered-history entry)
          filtered-history
        )
      )
      (list u0 u1 u2 u3 u4 u5 u6 u7 u8 u9)
      (list)
    )
  )
)