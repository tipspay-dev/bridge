export default function LockForm({ onSubmit }) {
  const [amount, setAmount] = useState("");
  const [tronAddress, setTronAddress] = useState("");

  return (
    <div>
      <h2>Bridge BSC → TRON</h2>

      <input
        placeholder="Amount"
        value={amount}
        onChange={e => setAmount(e.target.value)}
      />

      <input
        placeholder="TRON Address"
        value={tronAddress}
        onChange={e => setTronAddress(e.target.value)}
      />

      <button onClick={() => onSubmit(amount, tronAddress)}>
        Lock Tokens
      </button>
    </div>
  );
}
