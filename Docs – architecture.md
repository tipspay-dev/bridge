# Architecture Overview

## Components
- BscBridge (BSC)
- TronBridgeToken (TRON)
- RelayerRegistry (TRON)
- Relayer Services
- Next.js UI

## Flow: BSC → TRON
1. User calls lockTokens
2. BSC emits Locked event
3. Relayer mints on TRON
4. User receives TRON tokens

## Flow: TRON → BSC
1. User calls burnToBridge
2. TRON emits Burn event
3. Relayer releases on BSC
4. User receives BSC tokens
