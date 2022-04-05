// SPDX-License-Identifier: MIT LICENSE

pragma solidity 0.8.4;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";


contract Alan is ERC20, ERC20Burnable, Ownable {

  mapping(address => bool) controllers;
  
  constructor() ERC20("Alan", "ALN") { }

  function mint(address _to, uint256 _amount) external {
    require(controllers[msg.sender], "Only controllers can mint");
    _mint(_to, _amount);
  }

  function burnFrom(address _account, uint256 _amount) public override {
      if (controllers[msg.sender])
          _burn(_account, _amount);
      else
          super.burnFrom(_account, _amount);
  }

  function addController(address _controller) external onlyOwner {
    controllers[_controller] = true;
  }

  function removeController(address _controller) external onlyOwner {
    controllers[_controller] = false;
  }
}
