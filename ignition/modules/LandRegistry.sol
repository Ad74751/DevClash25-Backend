// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract LandRegistry{
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
            _isUndisputed
        );
        return landCount;   
    }


}