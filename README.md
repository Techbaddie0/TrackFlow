# TrackFlow Supply Chain Tracking Smart Contract

## Overview
TrackFlow is a robust Clarity smart contract designed for comprehensive product tracking on the Stacks blockchain. It provides a secure, transparent, and immutable solution for supply chain management.

## Features
- Detailed Product State Management
- Immutable Product Ownership History
- Secure Ownership Transfers
- Robust Input Validation
- Timestamp Tracking

## Product States
1. `STATE-CREATED` (u0): Initial product creation
2. `STATE-IN-PRODUCTION` (u1): Product in manufacturing
3. `STATE-IN-TRANSIT` (u2): Product in logistics
4. `STATE-DELIVERED` (u3): Product reached destination
5. `STATE-COMPLETED` (u4): Product lifecycle completed

## Contract Functions

### `create-product`
- Creates a new product in the supply chain
- Parameters:
  - `product-id`: Unique product identifier
  - `initial-location`: Starting location (max 100 characters)
  - `current-timestamp`: Timestamp of product creation
- Validates:
  - Unique product ID
  - Valid location length
  - Valid timestamp

### `update-product-status`
- Updates product state and location
- Parameters:
  - `product-id`: Product identifier
  - `new-state`: New product state
  - `new-location`: Updated location
  - `current-timestamp`: Timestamp of update
- Constraints:
  - State transitions must be sequential
  - Location and timestamp validated

### `transfer-product`
- Transfers product ownership
- Parameters:
  - `product-id`: Product identifier
  - `new-owner`: New owner's principal address
  - `current-timestamp`: Timestamp of transfer
- Features:
  - Only current owner can transfer
  - Maintains ownership history
  - Tracks total ownership transfers

## Read-Only Functions

### `get-product-details`
- Retrieves comprehensive product information
- Returns: Product details map

### `get-total-products`
- Returns total number of products created

## Error Codes
- `ERR-NOT-AUTHORIZED` (u100): Unauthorized action
- `ERR-INVALID-STATE-TRANSITION` (u101): Incorrect state change
- `ERR-PRODUCT-NOT-FOUND` (u102): Product doesn't exist
- `ERR-INVALID-INPUT` (u103): Invalid input parameters
- `ERR-LOCATION-TOO-LONG` (u104): Location exceeds max length
- `ERR-INVALID-TIMESTAMP` (u105): Timestamp out of valid range
- `ERR-INVALID-PRODUCT-ID` (u106): Invalid product identifier

## Use Cases
- Pharmaceutical Supply Chains
- Luxury Goods Tracking
- Food and Beverage Logistics
- Electronics Component Management

## Security Considerations
- Strict input validation
- Owner-only state modifications
- Immutable ownership history
- Timestamp-based tracking
- Sequential state transitions

## Getting Started
1. Deploy the contract on Stacks blockchain
2. Use `create-product` to initialize products
3. Track product movement with `update-product-status`
4. Transfer ownership using `transfer-product`

## Future Improvements
- Enhanced state transition rules
- Multi-party ownership tracking
- Batch product management
- Integration with external oracles
