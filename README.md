# BSC ↔ TRON Bridge (Full Stack Monorepo)

Bu repo, BSC ve TRON arasında çalışan güvenilir (trusted) bir köprü için:

- Akıllı kontratlar
- Relayer servisleri
- Next.js UI
- Teknik dokümantasyon
- Docker deployment

içeren tam üretim‑hazır bir monorepo yapısıdır.

## 🔧 Bileşenler

### 1. Contracts
- `BscBridge.sol`
- `TronBridgeToken.sol`
- `RelayerRegistry.sol`

### 2. Relayer Services
- `relayer-bsc-to-tron-final.js`
- `relayer-tron-to-bsc-final.js`

### 3. UI (Next.js)
- Lock → Mint
- Burn → Release
- Status tracking

### 4. Docs
- Architecture
- Security model
- Risk disclosure
- Deployment guide

## 🚀 Deployment

### Relayer
