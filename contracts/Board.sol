// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Board {
    enum Color { White, Black, Red }

    struct Cell {
        uint8 x;
        uint8 y;
        Color color;
    }

    mapping(uint => Cell) public cells;
    
    uint public whiteCellCount;
    uint public blackCellCount;
    uint public redCellCount;

    uint8 constant public maxX = 5;
    uint8 constant public maxY = 7;

    constructor() {
        // Initialize the board with random colors
        randomizeColors();
    }

    function randomizeColors() public {
        uint seed = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender, block.prevrandao)));

        whiteCellCount = 0;
        blackCellCount = 0;
        redCellCount = 0;

        for (uint8 x = 0; x < maxX; x++) {
            for (uint8 y = 0; y < maxY; y++) {
                uint cellId = x * 10 + y;
                Color color = Color(seed % 3); // Generate a random color (0, 1, or 2)
                cells[cellId] = Cell(x, y, color);

                // Update counts based on cell color
                if (color == Color.White) {
                    whiteCellCount++;
                } else if (color == Color.Black) {
                    blackCellCount++;
                } else if (color == Color.Red) {
                    redCellCount++;
                }

                seed = uint256(keccak256(abi.encodePacked(seed))); // Update the seed for the next cell
            }
        }
    }

    function getCellColor(uint8 x, uint8 y) public view returns (string memory) {
        if (x >= maxX || y >= maxY) {
            return "Unknown"; // Return "Unknown" for coordinates outside the valid range
        }

        uint cellId = x * 10 + y;
        return colorToString(cells[cellId].color);
    }

    function colorToString(Color color) internal pure returns (string memory) {
        if (color == Color.White) return "White";
        if (color == Color.Black) return "Black";
        if (color == Color.Red) return "Red";
        return "Unknown"; // Handle an invalid color gracefully
    }
}
