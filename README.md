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

bridge-relayer/
│
├── contracts/
│   ├── bsc/
│   │   ├── BscBridge.sol
│   │   └── CanonicalToken.sol
│   │
│   ├── tron/
│   │   ├── TronBridgeToken.sol
│   │   └── RelayerRegistry.sol
│   │
│   └── README.md
│
├── relayer/
│   ├── bsc-to-tron/
│   │   ├── relayer-bsc-to-tron-final.js
│   │   ├── package.json
│   │   ├── README.md
│   │   └── logs/
│   │
│   ├── tron-to-bsc/
│   │   ├── relayer-tron-to-bsc-final.js
│   │   ├── package.json
│   │   ├── README.md
│   │   └── logs/
│   │
│   ├── shared/
│   │   ├── abi/
│   │   │   ├── BscBridge.json
│   │   │   ├── TronBridgeToken.json
│   │   │   └── RelayerRegistry.json
│   │   ├── utils/
│   │   │   ├── logger.js
│   │   │   ├── retry.js
│   │   │   └── blockCursor.js
│   │   └── README.md
│   │
│   └── .env.example
│
├── ui/
│   ├── nextjs/
│   │   ├── pages/
│   │   │   ├── index.js
│   │   │   ├── lock.js
│   │   │   ├── burn.js
│   │   │   └── status.js
│   │   ├── components/
│   │   │   ├── LockForm.jsx
│   │   │   ├── BurnForm.jsx
│   │   │   ├── StatusTracker.jsx
│   │   │   └── WalletConnect.jsx
│   │   ├── lib/
│   │   │   ├── bsc.js
│   │   │   ├── tron.js
│   │   │   └── api.js
│   │   ├── public/
│   │   ├── package.json
│   │   └── README.md
│
├── docs/
│   ├── architecture.md
│   ├── flow-bsc-to-tron.md
│   ├── flow-tron-to-bsc.md
│   ├── relayer-design.md
│   ├── security-model.md
│   ├── risk-disclosure.md
│   ├── api-spec.md
│   └── deployment.md
│
├── docker/
│   ├── docker-compose.yml
│   ├── relayer-bsc-to-tron.Dockerfile
│   ├── relayer-tron-to-bsc.Dockerfile
│   └── README.md
│
├── .gitignore
├── LICENSE
└── README.md
