pragma solidity 0.5.6;
pragma experimental ABIEncoderV2;

 
import './DIDUtils.sol';  
import './CredentialStorage.sol';


/**
 * @title DidLedger
 * @dev This contract is credential storage implementation
 */

 //did:kt:0d82ec18df5395bf2ca7611f0648bfc1c935bdd1773c1bb411c42f23318ba9ab
 //did:kt:1111ec18df5395bf2ca7611f0648bfc1c935bdd1773c1bb411c42f23318ba9ab
contract CredentialManagement is CredentialStorage {

    modifier checkExistVC(string memory cid){
        require(vcState[cid] == CredentialState.None,"Already Exists Document");
        _;
    }

    modifier checkActiveVC(string memory cid){
        require(vcState[cid] == CredentialState.Active,"VC None or Deactivated");
        _;
    }

    modifier checkAuthority(string memory did, string memory cid){
        require(DIDUtils.equalString( vcs[cid].owner , did) || DIDUtils.equalString( vcs[cid].issuer , did) ,"Not The Owner");
        _;
        
    }

    function register(
        string memory uDid,
        string memory iDid,
        string memory cid,
        string memory ciid) public 
        checkExistVC(cid)
        returns(string memory)
    {
        vcs[cid].id = cid;
        vcs[cid].iid = ciid;
        vcs[cid].owner = uDid;
        vcs[cid].issuer = iDid;
        vcState[cid] = CredentialState.Active;
    }

    function getVC(
        string memory cid,
        string memory uDid) public view 
        checkAuthority(uDid,cid) checkActiveVC(cid)
        returns(Credential memory) 
    {
        Credential memory vc = vcs[cid];
        return vc;
    }

    function revoke(
        string memory cid,
        string memory iDid) public 
        checkAuthority(iDid,cid) checkActiveVC(cid)
    {
        vcState[cid] = CredentialState.Deactivated;
    }


}

//수정본