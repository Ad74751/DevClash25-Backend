const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("LandRegistryModule", (m) => {

    const landRegistry = m.contract("LandRegistry", [], {});

    return { landRegistry };
});