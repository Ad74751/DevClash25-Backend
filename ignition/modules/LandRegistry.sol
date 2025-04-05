// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract LandRegistry {
    struct Land {
        uint256 id;
        string landAddress;
        uint256 pincode;
        uint256 area;
        address owner;
        string surveyNumber;
        string landType;
        string documentCID;
        string landImageCID;
        bool isUndisputed;
        bool exists;
    }

    uint256 public landCount;
    mapping(uint256 => Land) public lands;

    function registerLand(
        string memory _address,
        uint256 _pincode,
        uint256 _area,
        address _owner,
        string memory _surveyNumber,
        string memory _landType,
        string memory _documentCID,
        string memory _landImageCID,
        bool _isUndisputed
    ) public returns (uint256) {
        require(bytes(_address).length > 0, "Address is required");
        require(_pincode > 0, "Pincode is required");
        require(_area > 0, "Area is required");
        require(bytes(_surveyNumber).length > 0, "Survey number is required");
        require(bytes(_landType).length > 0, "Land type is required");
        require(bytes(_documentCID).length > 0, "Document CID is required");
        landCount++;
        lands[landCount] = Land(
            landCount,
            _address,
            _pincode,
            _area,
            _owner,
            _surveyNumber,
            _landType,
            _documentCID,
            _landImageCID,
            _isUndisputed,
            true
        );
        return landCount;
    }

    function getLand(
        uint256 _landId
    )
        public
        view
        returns (
            uint256,
            string memory,
            uint256,
            uint256,
            string memory,
            string memory,
            string memory,
            string memory,
            address
        )
    {
        require(_landId > 0 && _landId <= landCount, "Land not found");
        Land memory land = lands[_landId];
        return (
            land.id,
            land.landAddress,
            land.pincode,
            land.area,
            land.surveyNumber,
            land.landType,
            land.documentCID,
            land.landImageCID,
            land.owner
        );
    }

    function getLandsByOwner(
        address _owner
    ) public view returns (Land[] memory) {
        uint256 count = 0;

        for (uint256 i = 1; i <= landCount; i++) {
            if (lands[i].owner == _owner) {
                count++;
            }
        }
        Land[] memory result = new Land[](count);
        uint256 index = 0;
        for (uint256 i = 1; i <= landCount; i++) {
            if (lands[i].owner == _owner) {
                result[index] = lands[i];
                index++;
            }
        }
        return result;
    }

    function searchLand(
        string memory _address,
        string memory _surveyNumber
    ) public view returns (Land[] memory) {
        uint256 count = 0;
        for (uint256 i = 1; i <= landCount; i++) {
            if (lands[i].exists) {
                bool m = true;
                if (bytes(_address).length > 0) {
                    if (
                        keccak256(bytes(lands[i].landAddress)) !=
                        keccak256(bytes(_address))
                    ) {
                        m = false;
                    }
                }
                if (bytes(_surveyNumber).length > 0) {
                    if (
                        keccak256(bytes(lands[i].surveyNumber)) !=
                        keccak256(bytes(_surveyNumber))
                    ) {
                        m = false;
                    }
                }
                if (m) {
                    count++;
                }
            }
        }
        Land[] memory result = new Land[](count);
        uint256 index = 0;
        for (uint256 i = 1; i <= landCount; i++) {
            if (lands[i].exists) {
                bool m = true;
                if (bytes(_address).length > 0) {
                    if (
                        keccak256(bytes(lands[i].landAddress)) !=
                        keccak256(bytes(_address))
                    ) {
                        m = false;
                    }
                }
                if (bytes(_surveyNumber).length > 0) {
                    if (
                        keccak256(bytes(lands[i].surveyNumber)) !=
                        keccak256(bytes(_surveyNumber))
                    ) {
                        m = false;
                    }
                }
                if (m) {
                    result[index] = lands[i];
                    index++;
                }
            }
        }
        return result;
    }
}
