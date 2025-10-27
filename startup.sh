#!/bin/bash

# Install dependencies
npm ci --production

# Build the Next.js application
npm run build

# Start the application
node server.js
