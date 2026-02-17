// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// OpenZeppelin tarzı sade bir ERC20 implementasyonu
interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }
}

contract BTCBR_BEP20 is Context, IERC20 {
    string public name = "Bitcoin Bridged";
    string public symbol = "BTCBR";
    uint8 public decimals = 8;

    uint256 private _totalSupply;
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    address public owner;
    address public bridge; // BSC bridge kontrat adresi

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event BridgeUpdated(address indexed oldBridge, address indexed newBridge);

    modifier onlyOwner() {
        require(_msgSender() == owner, "Not owner");
        _;
    }

    modifier onlyBridge() {
        require(_msgSender() == bridge, "Not bridge");
        _;
    }

    constructor(address _owner, address _bridge) {
        require(_owner != address(0), "Owner zero");
        owner = _owner;
        bridge = _bridge;
        emit OwnershipTransferred(address(0), _owner);
        emit BridgeUpdated(address(0), _bridge);
    }

    // --- ERC20 core ---

    function totalSupply() external view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) external view override returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) external override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function allowance(address _owner, address spender) external view override returns (uint256) {
        return _allowances[_owner][spender];
    }

    function approve(address spender, uint256 amount) external override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) external override returns (bool) {
        uint256 currentAllowance = _allowances[sender][_msgSender()];
        require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");
        _approve(sender, _msgSender(), currentAllowance - amount);
        _transfer(sender, recipient, amount);
        return true;
    }

    function _transfer(address from, address to, uint256 amount) internal {
        require(from != address(0), "from zero");
        require(to != address(0), "to zero");
        uint256 fromBal = _balances[from];
        require(fromBal >= amount, "balance too low");
        unchecked {
            _balances[from] = fromBal - amount;
        }
        _balances[to] += amount;
        emit Transfer(from, to, amount);
    }

    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "mint to zero");
        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);
    }

    function _burn(address account, uint256 amount) internal {
        require(account != address(0), "burn from zero");
        uint256 bal = _balances[account];
        require(bal >= amount, "burn > balance");
        unchecked {
            _balances[account] = bal - amount;
        }
        _totalSupply -= amount;
        emit Transfer(account, address(0), amount);
    }

    function _approve(address _owner, address spender, uint256 amount) internal {
        require(_owner != address(0), "owner zero");
        require(spender != address(0), "spender zero");
        _allowances[_owner][spender] = amount;
        emit Approval(_owner, spender, amount);
    }

    // --- Admin / Bridge controls ---

    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "newOwner zero");
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }

    function setBridge(address newBridge) external onlyOwner {
        require(newBridge != address(0), "bridge zero");
        emit BridgeUpdated(bridge, newBridge);
        bridge = newBridge;
    }

    /// @notice Bridge kontratı BSC tarafında mint eder (TRON -> BSC lock/mint flow)
    function bridgeMint(address to, uint256 amount) external onlyBridge {
        _mint(to, amount);
    }

    /// @notice Bridge kontratı BSC tarafında burn eder (BSC -> TRON burn/release flow)
    function bridgeBurn(address from, uint256 amount) external onlyBridge {
        _burn(from, amount);
    }
}

