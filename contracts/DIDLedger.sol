pragma solidity 0.5.6;
pragma experimental ABIEncoderV2;

import './DIDStorage.sol';
import './DIDUtils.sol';

//#orign : 원래코드
/**
 * @title DidLedger
 * @dev This contract is did document storage implementation
 */
// "did:kt:6f4303aa6cea2b0fae462fa9cc792443c03a0609"
contract DIDLedger is DIDStorage {

    modifier checkExistDom(string memory userInfo){
        string memory did = DIDUtils.genDid(userInfo);
//#orign        string memory did = DIDUtils.genDid(msg.sender);
        //1-1-1. 사용가능한 did가 이미 존재하면, 사용자 신원인증 값 요구 **
        require(didState[did] == DIDState.None,"Already Exists Document");
        _;
    }
    
    modifier recheckExistDom(string memory userInfo){
        string memory did = DIDUtils.genDid(userInfo);
        require(didState[did] == DIDState.Active,"None or Deactivated");
        _;
    }

    modifier checkActiveDom(string memory did){
        require(didState[did] == DIDState.Active,"None or Deactivated");
        _;
    }

    modifier checkExistAddr(string memory did,address addr_){//중복된 pubkey있는지 확인 
        Document memory dom = documents[did];
        string memory addr = DIDUtils.genAddrKey(addr_);
        //uint256 dup = 0
        for(uint256 i=0;i<dom.publicKeys.length;i++){
            require(keccak256(bytes(dom.publicKeys[i].pubKeyData)) != keccak256(bytes(addr)),'Already Exists Address');
            _;
        }
    }

    modifier verifyFormat(string memory did){
        require(DIDUtils.verifyDidFormat(did),'Invalid format');
        _;
    }


    
    function create_view(
        string memory userInfo) public view
        returns(Document memory)
    {
        string memory did = DIDUtils.genDid(userInfo);
        Document memory dom = documents[did];
        // for(uint256 i=0;i<dom.publicKeys.length;i++){
        //     if(dom.publicKeys[i].disable) delete dom.publicKeys[i];
        // }
        return dom;


    }

    // 1. did 및 did문서 생성
    // 1-1. did 존재 유무 검사 checkExistDom 
    function create(
        string memory userInfo,
        address addr) public 
        checkExistDom(userInfo)
        returns(string memory did)
    {
        //1-1-2. 사용가능한 did가 존재하지 않으면, did 생성 및 did문서 생성
        //userInfo = '6f4303aa6cea2b0fae462fa9cc792443c03a0609';
        did = DIDUtils.genDid(userInfo);
        string memory keyID = DIDUtils.genPublicKeyID(did,1);
        string memory addrKey = DIDUtils.genAddrKey(addr);
        string memory keyType = 'EcdsaSecp256k1RecoveryMethod2020';
        PublicKey memory defaultKey = PublicKey(keyID,keyType,addrKey,false);
                                   // https://www.w3.org/ns/did -> 확인해보기 
        documents[did].contexts.push("https://www.w3.org/ns/did/v1");
        documents[did].id = did;
        documents[did].publicKeys.push(defaultKey);
        didState[did] = DIDState.Active;
        idType[did] = IdType.User;
    }

    function getDocument(string memory did) public view 
        verifyFormat(did) 
        returns(Document memory) 
    {
        Document memory dom = documents[did];
        // for(uint256 i=0;i<dom.services.length;i++){
        //     if(dom.services[i].disable) delete dom.services[i];
        // }
        for(uint256 i=0;i<dom.publicKeys.length;i++){
            if(dom.publicKeys[i].disable) delete dom.publicKeys[i];
        }
        return  dom;
    }


    //'EcdsaSecp256k1VerificationKey2019'

    function addPubKey(
        string memory userInfo,
        address addr) public 
        recheckExistDom(userInfo)
    {
        string memory did = DIDUtils.genDid(userInfo);
        _addPubKey(did,addr);        
    }
    
    
    function _addPubKey(
        string memory did,
        address addr) internal 
        verifyFormat(did) checkActiveDom(did) checkExistAddr(did,addr)
        returns(string memory)
    {
        uint256 index = documents[did].publicKeys.length;
        string memory keyID = DIDUtils.genPublicKeyID(did,index+1);
        string memory keyType = 'EcdsaSecp256k1VerificationKey2019';
        string memory keyAddr = DIDUtils.genAddrKey(addr);
        documents[did].publicKeys.push(PublicKey(keyID,keyType,keyAddr,false));
    }
    
    //'EcdsaSecp256k1RecoveryMethod2020'
    
    function addAddrKey(
        string memory userInfo,
        address addr) public 
        recheckExistDom(userInfo)
    {
        string memory did = DIDUtils.genDid(userInfo);
        _addAddrKey(did,addr);        
    }
   
    function _addAddrKey(
        string memory did,
        address addr) internal 
        verifyFormat(did) checkActiveDom(did) checkExistAddr(did,addr)
    {
        uint256 index = documents[did].publicKeys.length;
        string memory keyID = DIDUtils.genPublicKeyID(did,index+1);
        string memory keyType = 'EcdsaSecp256k1RecoveryMethod2020';
        string memory keyAddr = DIDUtils.genAddrKey(addr);
        documents[did].publicKeys.push(PublicKey(keyID,keyType,keyAddr,false));  
    }

    // add service
    function createSvc(
        string memory svcInfo,
        string memory endPoint,
        string memory svcType,
        address addr) public 
    {
        _createSvc(svcInfo,endPoint,svcType,addr);    
    }


    function _createSvc(
        string memory svcInfo,
        string memory endPoint,
        string memory svcType,
        address addr) internal 
        checkExistDom(svcInfo)
        returns(string memory svcId)
    {
        svcId = DIDUtils.genDid(svcInfo);
        string memory keyID = DIDUtils.genPublicKeyID(svcId,1);
        string memory addrKey = DIDUtils.genAddrKey(addr);
        string memory keyType = 'EcdsaSecp256k1RecoveryMethod2020';
        PublicKey memory defaultKey = PublicKey(keyID,keyType,addrKey,false);
        documents[svcId].id = svcId;
        documents[svcId].contexts.push("https://www.w3.org/ns/did/v1");
        documents[svcId].publicKeys.push(defaultKey);
        documents[svcId].svcEndPoint=endPoint;
        documents[svcId].svcType=svcType;
        idType[svcId] = IdType.Service;
        didState[svcId] = DIDState.Active;
    }


    //delete publickey did serviceDID




    function recoverSignature(
        string memory did, 
        string memory fType, 
        uint8 sigV, bytes32 sigR, bytes32 sigS) internal 
        returns(address)
    {
        bytes32 hash =  DIDUtils.genSignHash(fType, address(this), nonce[did], did);
        address signer = ecrecover(hash, sigV, sigR, sigS);
        nonce[did]++;
        return signer;
    }

}

//수정본