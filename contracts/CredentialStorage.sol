pragma solidity 0.5.6;

contract CredentialStorage{

    mapping(string => Credential) vcs; //key: CredentialID, value: Credential
    mapping(string => CredentialState) vcState;

    enum CredentialState {None, Active, Deactivated}
    struct Credential{
        string id;
        string iid;
        string owner;
        string issuer;
    }




}