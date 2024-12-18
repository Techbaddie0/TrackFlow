# Supply Chain Tracking Smart Contract

## Overview
This Clarity smart contract provides a comprehensive solution for tracking product provenance, logistics, and inventory management on the Stacks blockchain.

## Features
- Product Creation
- Location Tracking
- Ownership Transfer
- Immutable Product History
- Manufacturer Product Counting

### Contract Functions

#### `create-product`
- Creates a new product in the supply chain
- Parameters:
  - `name`: Product name (string)
  - `manufacturer`: Manufacturer name (string)
- Returns: Product ID

#### `update-product-location`
- Updates the current location and status of a product
- Parameters:
  - `product-id`: Unique identifier of the product
  - `new-location`: Current location of the product
  - `new-status`: Current status of the product
- Requires: Sender must be the current product owner

#### `transfer-product`
- Transfers product ownership to a new owner
- Parameters:
  - `product-id`: Unique identifier of the product
  - `new-owner`: Principal (address) of the new owner
- Requires: Sender must be the current product owner

### Read Functions

#### `get-product-details`
- Retrieves current product details
- Parameter: `product-id`

#### `get-product-history`
- Retrieves complete product movement history
- Parameter: `product-id`

## Error Codes
- `err-unauthorized` (u100): Action not permitted
- `err-product-not-found` (u101): Product does not exist
- `err-invalid-status` (u102): Invalid product status

## Use Cases
1. Pharmaceutical Tracking
2. Luxury Goods Authentication
3. Food Supply Chain Monitoring
4. Electronic Component Traceability

## Getting Started
1. Deploy the contract on Stacks blockchain
2. Use `create-product` to initialize products
3. Track products using `update-product-location`
4. Transfer ownership with `transfer-product`

## Security Considerations
- Only product owners can update location
- Immutable history prevents tampering
- Transparent tracking mechanism

## Example Workflow
1. Manufacturer creates a product
2. Product moves through logistics checkpoints
3. Each movement is recorded with location and status
4. Ownership can be transferred securely

## Future Improvements
- Add role-based access control
- Implement more complex status transitions
- Add batch/bulk product management



# Supply Chain Tracking Smart Contract

## Overview
This Clarity smart contract provides a comprehensive solution for tracking product provenance, logistics, and inventory management on the Stacks blockchain.

## Features
- Product Creation
- Location Tracking
- Ownership Transfer
- Immutable Product History
- Manufacturer Product Counting

### Contract Functions

#### `create-product`
- Creates a new product in the supply chain
- Parameters:
  - `name`: Product name (string)
  - `manufacturer`: Manufacturer name (string)
- Returns: Product ID

#### `update-product-location`
- Updates the current location and status of a product
- Parameters:
  - `product-id`: Unique identifier of the product
  - `new-location`: Current location of the product
  - `new-status`: Current status of the product
- Requires: Sender must be the current product owner

#### `transfer-product`
- Transfers product ownership to a new owner
- Parameters:
  - `product-id`: Unique identifier of the product
  - `new-owner`: Principal (address) of the new owner
- Requires: Sender must be the current product owner

### Read Functions

#### `get-product-details`
- Retrieves current product details
- Parameter: `product-id`

#### `get-product-history`
- Retrieves complete product movement history
- Parameter: `product-id`

## Error Codes
- `err-unauthorized` (u100): Action not permitted
- `err-product-not-found` (u101): Product does not exist
- `err-invalid-status` (u102): Invalid product status

## Use Cases
1. Pharmaceutical Tracking
2. Luxury Goods Authentication
3. Food Supply Chain Monitoring
4. Electronic Component Traceability

## Getting Started
1. Deploy the contract on Stacks blockchain
2. Use `create-product` to initialize products
3. Track products using `update-product-location`
4. Transfer ownership with `transfer-product`

## Security Considerations
- Only product owners can update location
- Immutable history prevents tampering
- Transparent tracking mechanism

## Example Workflow
1. Manufacturer creates a product
2. Product moves through logistics checkpoints
3. Each movement is recorded with location and status
4. Ownership can be transferred securely

## Future Improvements
- Add role-based access control
- Implement more complex status transitions
- Add batch/bulk product management

## License
MIT License

## Contributors
- [Your Name/Organization]

## Support
For issues or improvements, please open a GitHub issue.