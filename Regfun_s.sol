pragma solidity ^0.8.0;

contract IdentityVerification {
    mapping(string => string) verificationTable;

    function add(string memory identity, string memory responseValue) public {
        verificationTable[identity] = responseValue;
    }
    function calculateHash(string memory value) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(value));
    }

    // verify if R2 is equal to R2star
    function verifyR2(bytes32 R2, string memory identity, string memory response, uint256 randomValue, uint256 timestamp) internal pure returns (bool) {
        bytes32 R2star = calculateHash(concatenateStrings(identity, response, uint2str(randomValue), uint2str(timestamp)));
        return R2 == R2star;
    }
    function calculateR3(string memory identity, string memory response, uint256 randomValue) internal pure returns (bytes32) {
        return calculateHash(concatenateStrings(identity, uint2str(randomValue), response, ""));
    }
    function calculateR4(bytes32 R3, string memory identity, string memory challenge) internal pure returns (bytes32) {
        return R3 ^ calculateHash(concatenateStrings(identity, challenge, "", ""));
    }
    function calculateR4(
        string memory identity,
        string memory response,
        uint256 randomValue,
        uint256 timestamp,
        bytes32 R1,
        bytes32 R2
    ) public view returns (bytes32) {
        // Step 1: Calculate R0
        bytes32 R0 = calculateHash(concatenateStrings(identity, response, "", ""));

        // Step 2: Calculate RNs
        bytes32 RNs = R1 ^ calculateHash(concatenateStrings(identity, response, "", ""));

        // Step 3: Verify if R2 is equal to R2star
        require(verifyR2(R2, identity, response, randomValue, timestamp), "R2 does not match R2star");

        // Step 4: Calculate R3
        bytes32 R3 = calculateR3(identity, response, randomValue);

        // Step 5: Calculate R4
        string memory challenge = verificationTable[identity];
        bytes32 R4 = calculateR4(R3, identity, challenge);

        return R4;
    }
    function uint2str(uint256 _i) internal pure returns (string memory) {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 length;
        while (j != 0) {
            length++;
            j /= 10;
        }
        bytes memory bstr = new bytes(length);
        uint256 k = length;
        while (_i != 0) {
            k = k - 1;
            uint8 temp = uint8(48 + _i % 10);
            bstr[k] = bytes1(temp);
            _i /= 10;
        }
        return string(bstr);
    }
    function concatenateStrings(
        string memory a,
        string memory b,
        string memory c,
        string memory d
    ) internal pure returns (string memory) {
        return string(abi.encodePacked(a, b, c, d));
    }
}
