# Tipspay Bridge Architecture (Tipspay ↔ TRON/BSC)

## 1. Overview
- Source chain: Tipspay mainnet
- Target chains: TRON, BSC
- Model: Lock & Mint / Burn & Unlock

## 2. On-chain Components
- Tipspay: TipspayLockbox
- TRON: WrappedTPSC_TRC20
- BSC: WrappedTPSC_BEP20

## 3. Off-chain Components
- Listeners (Kaleido, TRON, BSC)
- Workers (mint, burn)
- Mapping & replay protection
- Block cursor management

## 4. Flows
- Deposit (Tipspay → TRON/BSC)
- Withdraw (TRON/BSC → Kaleido)

## 5. Security Model
- Bridge signer
- Replay protection (depositId/withdrawId)
- Rate limiting
- Monitoring & alerts

## 6. Extensibility
- New chain adapter pattern
- New token support
