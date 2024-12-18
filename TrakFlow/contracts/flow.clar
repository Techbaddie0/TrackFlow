;; TrackFlow Supply Chain Tracking Smart Contract

;; Define constants for product states
(define-constant STATE-CREATED u0)
(define-constant STATE-IN-PRODUCTION u1)
(define-constant STATE-IN-TRANSIT u2)
(define-constant STATE-DELIVERED u3)
(define-constant STATE-COMPLETED u4)

;; Define error codes
(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-INVALID-STATE-TRANSITION (err u101))
(define-constant ERR-PRODUCT-NOT-FOUND (err u102))

;; Define a map to store product details
(define-map products 
  {product-id: uint} 
  {
    owner: principal,
    current-state: uint,
    current-location: (string-utf8 100),
    manufacturer: principal,
    created-at: uint,
    updated-at: uint
  }
)

;; Define a map to track product ownership history
(define-map product-ownership-history 
  {product-id: uint, owner-index: uint} 
  principal
)

;; Track the total number of products and ownership transfers
(define-data-var total-products uint u0)
(define-data-var total-ownership-transfers uint u0)

;; Create a new product in the supply chain
(define-public (create-product 
  (product-id uint) 
  (initial-location (string-utf8 100))
  (current-timestamp uint)
)
  (begin
    ;; Ensure product doesn't already exist
    (asserts! (is-none (map-get? products {product-id: product-id})) ERR-NOT-AUTHORIZED)
    
    ;; Create product entry
    (map-set products 
      {product-id: product-id}
      {
        owner: tx-sender,
        current-state: STATE-CREATED,
        current-location: initial-location,
        manufacturer: tx-sender,
        created-at: current-timestamp,
        updated-at: current-timestamp
      }
    )
    
    ;; Set initial ownership history
    (map-set product-ownership-history 
      {product-id: product-id, owner-index: u0} 
      tx-sender
    )
    
    ;; Increment total products
    (var-set total-products (+ (var-get total-products) u1))
    
    (ok true)
  )
)

;; Update product state and location
(define-public (update-product-status 
  (product-id uint) 
  (new-state uint)
  (new-location (string-utf8 100))
  (current-timestamp uint)
)
  (let 
    (
      (product (unwrap! 
        (map-get? products {product-id: product-id}) 
        ERR-PRODUCT-NOT-FOUND
      ))
      (current-state (get current-state product))
    )
    ;; Validate state transition
    (asserts! 
      (or 
        (is-eq new-state (+ current-state u1)) 
        (is-eq new-state current-state)
      ) 
      ERR-INVALID-STATE-TRANSITION
    )
    
    ;; Update product details
    (map-set products 
      {product-id: product-id}
      (merge product {
        current-state: new-state,
        current-location: new-location,
        updated-at: current-timestamp
      })
    )
    
    (ok true)
  )
)

;; Transfer product ownership
(define-public (transfer-product 
  (product-id uint) 
  (new-owner principal)
  (current-timestamp uint)
)
  (let 
    (
      (product (unwrap! 
        (map-get? products {product-id: product-id}) 
        ERR-PRODUCT-NOT-FOUND
      ))
      (current-owner (get owner product))
    )
    ;; Ensure only current owner can transfer
    (asserts! (is-eq tx-sender current-owner) ERR-NOT-AUTHORIZED)
    
    ;; Update ownership
    (map-set products 
      {product-id: product-id}
      (merge product {
        owner: new-owner,
        updated-at: current-timestamp
      })
    )
    
    ;; Track ownership history
    (map-set product-ownership-history 
      {
        product-id: product-id, 
        owner-index: (var-get total-ownership-transfers)
      } 
      new-owner
    )
    
    ;; Increment ownership transfers
    (var-set total-ownership-transfers 
      (+ (var-get total-ownership-transfers) u1)
    )
    
    (ok true)
  )
)

;; Read product details
(define-read-only (get-product-details (product-id uint))
  (map-get? products {product-id: product-id})
)

