// SPDX-License-Identifier: MIT
pragma solidity ^0.5.10;

interface ITRC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address who) external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);

    function transfer(address to, uint256 value) external returns (bool);
    function approve(address spender, uint256 value) external returns (bool);
    function transferFrom(address from, address to, uint256 value) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract BTCBR_TRC20 is ITRC20 {
    string public name = "Bitcoin Bridged";
    string public symbol = "BTCBR";
    uint8 public decimals = 8;

    uint256 private _totalSupply;
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    address public owner;
    address public bridge; // TRON bridge kontrat adresi

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event BridgeUpdated(address indexed oldBridge, address indexed newBridge);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    modifier onlyBridge() {
        require(msg.sender == bridge, "Not bridge");
        _;
    }

    constructor(address _owner, address _bridge) public {
        require(_owner != address(0), "Owner zero");
        owner = _owner;
        bridge = _bridge;
        emit OwnershipTransferred(address(0), _owner);
        emit BridgeUpdated(address(0), _bridge);
    }

    // --- TRC20 core ---

    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address who) external view returns (uint256) {
        return _balances[who];
    }

    function allowance(address _owner, address spender) external view returns (uint256) {
        return _allowances[_owner][spender];
    }

    function transfer(address to, uint256 value) external returns (bool) {
        _transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) external returns (bool) {
        _approve(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) external returns (bool) {
        uint256 currentAllowance = _allowances[from][msg.sender];
        require(currentAllowance >= value, "allowance too low");
        _approve(from, msg.sender, currentAllowance - value);
        _transfer(from, to, value);
        return true;
    }

    function _transfer(address from, address to, uint256 value) internal {
        require(from != address(0), "from zero");
        require(to != address(0), "to zero");
        uint256 bal = _balances[from];
        require(bal >= value, "balance too low");
        _balances[from] = bal - value;
        _balances[to] += value;
        emit Transfer(from, to, value);
    }

    function _mint(address account, uint256 value) internal {
        require(account != address(0), "mint to zero");
        _totalSupply += value;
        _balances[account] += value;
        emit Transfer(address(0), account, value);
    }

    function _burn(address account, uint256 value) internal {
        require(account != address(0), "burn from zero");
        uint256 bal = _balances[account];
        require(bal >= value, "burn > balance");
        _balances[account] = bal - value;
        _totalSupply -= value;
        emit Transfer(account, address(0), value);
    }

    function _approve(address _owner, address spender, uint256 value) internal {
        require(_owner != address(0), "owner zero");
        require(spender != address(0), "spender zero");
        _allowances[_owner][spender] = value;
        emit Approval(_owner, spender, value);
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

    /// @notice TRON tarafında bridge mint (BSC -> TRON lock/mint flow)
    function bridgeMint(address to, uint256 amount) external onlyBridge {
        _mint(to, amount);
    }

    /// @notice TRON tarafında bridge burn (TRON -> BSC burn/release flow)
    function bridgeBurn(address from, uint256 amount) external onlyBridge {
        _burn(from, amount);
    }
}

