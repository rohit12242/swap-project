pragma solidity ^0.8.0;

interface IUniswap{
    function swapExactTokensForETH(uint amountIn, 
    uint amountOutMin, 
    address[] calldata path, 
    address to, 
    uint deadline) external returns (uint[] memory amounts);
    function WETH() external pure returns (address);
}

interface IERC20{
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);
    function approve(
        address spender,
        uint256 amount
    ) external returns (bool);
}

contract Swap {
    IUniswap uniswap;
    IERC20 token;
    mapping(address=>uint) ethAmt;
    
    constructor(address _uniswap){
        uniswap = IUniswap(_uniswap);
        
    }
    
    function swapErc20ToEth(address token,uint amountIn,uint amountOutMin,uint deadline) public{
        IERC20(token).transferFrom(msg.sender,address(this),amountIn);
        address[] memory path = new address[](2);
        path[0] = token;
        path[1] = uniswap.WETH();
        IERC20(token).approve(address(uniswap),amountIn);
        uniswap.swapExactTokensForETH(amountIn,amountOutMin,path,msg.sender,deadline);
        
    }
    
    function withdrawEth(uint amt) public{
        
    }
}
