/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import { Signer } from "ethers";
import { Provider, TransactionRequest } from "@ethersproject/providers";
import { Contract, ContractFactory, Overrides } from "@ethersproject/contracts";

import type { CoinsLeagueFactory } from "../CoinsLeagueFactory";

export class CoinsLeagueFactory__factory extends ContractFactory {
  constructor(signer?: Signer) {
    super(_abi, _bytecode, signer);
  }


  getDeployTransaction(overrides?: Overrides): TransactionRequest {
    return super.getDeployTransaction(overrides || {});
  }

  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): CoinsLeagueFactory {
    return new Contract(address, _abi, signerOrProvider) as CoinsLeagueFactory;
  }
}

const _abi = [
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "address",
        name: "gameAddress",
        type: "address",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "id",
        type: "uint256",
      },
    ],
    name: "GameCreated",
    type: "event",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    name: "coinsLeague",
    outputs: [
      {
        internalType: "contract CoinsLeague",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint8",
        name: "_num_players",
        type: "uint8",
      },
      {
        internalType: "uint256",
        name: "_duration",
        type: "uint256",
      },
      {
        internalType: "uint256",
        name: "_amount",
        type: "uint256",
      },
      {
        internalType: "uint8",
        name: "_num_coins",
        type: "uint8",
      },
      {
        internalType: "uint256",
        name: "_abort_timestamp",
        type: "uint256",
      },
    ],
    name: "createGame",
    outputs: [
      {
        internalType: "contract CoinsLeague",
        name: "gameAddress",
        type: "address",
      },
    ],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "totalGames",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
];

const _bytecode =
  "0x608060405234801561001057600080fd5b506143a3806100206000396000f3fe60806040523480156200001157600080fd5b5060043610620000465760003560e01c80632c4e591b146200004b5780634da1d4e3146200006d578063f60218da14620000a3575b600080fd5b62000055620000d9565b6040516200006491906200038e565b60405180910390f35b6200008b60048036038101906200008591906200027e565b620000e5565b6040516200009a919062000371565b60405180910390f35b620000c16004803603810190620000bb919062000252565b620001d6565b604051620000d0919062000371565b60405180910390f35b60008080549050905090565b60008585858585604051620000fa9062000216565b6200010a959493929190620003ab565b604051809103906000f08015801562000127573d6000803e3d6000fd5b5090506000819080600181540180825580915050600190039060005260206000200160009091909190916101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055507f306841c3fce8498c2d9b7194b8da4c04d03847394e237b625ce6d029b107f07781600080549050604051620001c592919062000344565b60405180910390a195945050505050565b60008181548110620001e757600080fd5b906000526020600020016000915054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b613ebe80620004b083390190565b60008135905062000235816200047b565b92915050565b6000813590506200024c8162000495565b92915050565b6000602082840312156200026557600080fd5b6000620002758482850162000224565b91505092915050565b600080600080600060a086880312156200029757600080fd5b6000620002a7888289016200023b565b9550506020620002ba8882890162000224565b9450506040620002cd8882890162000224565b9350506060620002e0888289016200023b565b9250506080620002f38882890162000224565b9150509295509295909350565b6200030b8162000408565b82525050565b6200031c8162000453565b82525050565b6200032d816200043c565b82525050565b6200033e8162000446565b82525050565b60006040820190506200035b600083018562000300565b6200036a602083018462000322565b9392505050565b600060208201905062000388600083018462000311565b92915050565b6000602082019050620003a5600083018462000322565b92915050565b600060a082019050620003c2600083018862000333565b620003d1602083018762000322565b620003e0604083018662000322565b620003ef606083018562000333565b620003fe608083018462000322565b9695505050505050565b600062000415826200041c565b9050919050565b600073ffffffffffffffffffffffffffffffffffffffff82169050919050565b6000819050919050565b600060ff82169050919050565b6000620004608262000467565b9050919050565b600062000474826200041c565b9050919050565b62000486816200043c565b81146200049257600080fd5b50565b620004a08162000446565b8114620004ac57600080fd5b5056fe60806040523480156200001157600080fd5b5060405162003ebe38038062003ebe8339818101604052810190620000379190620001ad565b600b8560ff161062000080576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016200007790620002d5565b60405180910390fd5b428111620000c5576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401620000bc90620002b3565b60405180910390fd5b84600960000160066101000a81548160ff021916908360ff160217905550836009600101819055506000600960000160006101000a81548160ff021916908360018111156200013d577f4e487b7100000000000000000000000000000000000000000000000000000000600052602160045260246000fd5b02179055508260096004018190555081600960000160056101000a81548160ff021916908360ff16021790555080600960030181905550505050505062000353565b60008151905062000190816200031f565b92915050565b600081519050620001a78162000339565b92915050565b600080600080600060a08688031215620001c657600080fd5b6000620001d68882890162000196565b9550506020620001e9888289016200017f565b9450506040620001fc888289016200017f565b93505060606200020f8882890162000196565b925050608062000222888289016200017f565b9150509295509295909350565b60006200023e601783620002f7565b91507f46757475726520646174652069732072657175697265640000000000000000006000830152602082019050919050565b600062000280600e83620002f7565b91507f4d617820313020706c61796572730000000000000000000000000000000000006000830152602082019050919050565b60006020820190508181036000830152620002ce816200022f565b9050919050565b60006020820190508181036000830152620002f08162000271565b9050919050565b600082825260208201905092915050565b6000819050919050565b600060ff82169050919050565b6200032a8162000308565b81146200033657600080fd5b50565b620003448162000312565b81146200035057600080fd5b50565b613b5b80620003636000396000f3fe60806040526004361061011f5760003560e01c806390506f20116100a0578063e29eb83611610064578063e29eb8361461038a578063f0f32497146103b5578063f48b31b9146103e0578063f60cdcf6146103fc578063f71d96cb146104275761011f565b806390506f20146102be5780639f599553146102d5578063c3fe3e2814610312578063c6cef9aa14610348578063d65ab5f2146103735761011f565b80635e123ce4116100e75780635e123ce4146101e55780636bd5450a146102105780636cbc2ded1461025057806377a65973146102675780637d0f7a881461027e5761011f565b8063160b852414610124578063244121c61461014f5780633ccfd60b1461017a5780634e71d92d146101915780635b6cca80146101a8575b600080fd5b34801561013057600080fd5b50610139610465565b604051610146919061355d565b60405180910390f35b34801561015b57600080fd5b5061016461048a565b604051610171919061324d565b60405180910390f35b34801561018657600080fd5b5061018f6104a4565b005b34801561019d57600080fd5b506101a6610639565b005b3480156101b457600080fd5b506101cf60048036038101906101ca9190612af3565b6109d5565b6040516101dc9190613322565b60405180910390f35b3480156101f157600080fd5b506101fa610a73565b604051610207919061324d565b60405180910390f35b34801561021c57600080fd5b5061023760048036038101906102329190612af3565b610a8d565b6040516102479493929190613578565b60405180910390f35b34801561025c57600080fd5b50610265610af7565b005b34801561027357600080fd5b5061027c610dc3565b005b34801561028a57600080fd5b506102a560048036038101906102a09190612af3565b610eef565b6040516102b594939291906131e6565b60405180910390f35b3480156102ca57600080fd5b506102d3610f3f565b005b3480156102e157600080fd5b506102fc60048036038101906102f79190612b5d565b61105c565b604051610309919061322b565b60405180910390f35b34801561031e57600080fd5b50610327611135565b60405161033f9c9b9a99989796959493929190613268565b60405180910390f35b34801561035457600080fd5b5061035d6111de565b60405161036a919061324d565b60405180910390f35b34801561037f57600080fd5b506103886111f8565b005b34801561039657600080fd5b5061039f61142f565b6040516103ac919061355d565b60405180910390f35b3480156103c157600080fd5b506103ca61143c565b6040516103d7919061324d565b60405180910390f35b6103fa60048036038101906103f59190612b1c565b611456565b005b34801561040857600080fd5b5061041161192b565b60405161041e919061355d565b60405180910390f35b34801561043357600080fd5b5061044e60048036038101906104499190612b5d565b611938565b60405161045c9291906131bd565b60405180910390f35b60006064600a60096005015461047b91906137f4565b61048591906137c3565b905090565b6000600960000160029054906101000a900460ff16905090565b60011515600960000160049054906101000a900460ff161515146104fd576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016104f4906134fd565b60405180910390fd5b6000600760003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000205490506000600760003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020819055506000803373ffffffffffffffffffffffffffffffffffffffff16836040516105ad906131a8565b60006040518083038185875af1925050503d80600081146105ea576040519150601f19603f3d011682016040523d82523d6000602084013e6105ef565b606091505b509150915081610634576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040161062b906133bd565b60405180910390fd5b505050565b60011515600960000160039054906101000a900460ff16151514610692576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610689906134dd565b60405180910390fd5b3373ffffffffffffffffffffffffffffffffffffffff16600660003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060000160019054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1614610762576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016107599061333d565b60405180910390fd5b60001515600660003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060020160009054906101000a900460ff161515146107f8576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016107ef9061339d565b60405180910390fd5b6001600660003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060020160006101000a81548160ff021916908315150217905550600061085d610465565b60096005015461086d91906138e2565b90506000606461087b61198c565b600660003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060000160009054906101000a900460ff1660ff1660038110610905577f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b60200201518361091591906137f4565b61091f91906137c3565b90506000803373ffffffffffffffffffffffffffffffffffffffff1683604051610948906131a8565b60006040518083038185875af1925050503d8060008114610985576040519150601f19603f3d011682016040523d82523d6000602084013e61098a565b606091505b5091509150816109cf576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016109c6906133bd565b60405180910390fd5b50505050565b6000806000806000808673ffffffffffffffffffffffffffffffffffffffff1663feaf968c6040518163ffffffff1660e01b815260040160a06040518083038186803b158015610a2457600080fd5b505afa158015610a38573d6000803e3d6000fd5b505050506040513d601f19601f82011682018060405250810190610a5c9190612b86565b945094509450945094508395505050505050919050565b6000600960000160019054906101000a900460ff16905090565b60066020528060005260406000206000915090508060000160009054906101000a900460ff16908060000160019054906101000a900473ffffffffffffffffffffffffffffffffffffffff16908060010154908060020160009054906101000a900460ff16905084565b600960010154600960020154610b0d9190613703565b421015610b4f576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610b469061353d565b60405180910390fd5b60011515600960000160019054906101000a900460ff16151514610ba8576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610b9f9061351d565b60405180910390fd5b60001515600960000160039054906101000a900460ff16151514610c01576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610bf89061349d565b60405180910390fd5b6001600960000160036101000a81548160ff02191690831515021790555060005b600880549050811015610db057600060088281548110610c6b577f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b9060005260206000209060030201905060005b8160000180549050811015610d9b576000826000018281548110610ccb577f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b9060005260206000200160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1690506000600560008373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000209050610d44826109d5565b8160020181905550806002015481600101548260020154610d65919061384e565b610d6f9190613759565b8160030154610d7e919061366f565b816003018190555050508080610d93906139b0565b915050610c7e565b50508080610da8906139b0565b915050610c22565b50610db9611a0f565b610dc1611bfd565b565b60011515600960000160039054906101000a900460ff16151514610e1c576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610e13906134dd565b60405180910390fd5b6000735bd68b4d6f90bcc9f3a9456791c0db5a43df676d90506000808273ffffffffffffffffffffffffffffffffffffffff16610e57610465565b604051610e63906131a8565b60006040518083038185875af1925050503d8060008114610ea0576040519150601f19603f3d011682016040523d82523d6000602084013e610ea5565b606091505b509150915081610eea576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610ee1906133bd565b60405180910390fd5b505050565b60056020528060005260406000206000915090508060000160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff16908060010154908060020154908060030154905084565b60001515600960000160019054906101000a900460ff16151514610f98576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610f8f906134bd565b60405180910390fd5b600960000160069054906101000a900460ff1660ff166008805490501415610ff5576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610fec9061345d565b60405180910390fd5b426009600301541161103c576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016110339061347d565b60405180910390fd5b6001600960000160046101000a81548160ff021916908315150217905550565b606060088281548110611098577f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b906000526020600020906003020160000180548060200260200160405190810160405280929190818152602001828054801561112957602002820191906000526020600020905b8160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190600101908083116110df575b50505050509050919050565b60098060000160009054906101000a900460ff16908060000160019054906101000a900460ff16908060000160029054906101000a900460ff16908060000160039054906101000a900460ff16908060000160049054906101000a900460ff16908060000160059054906101000a900460ff16908060000160069054906101000a900460ff1690806001015490806002015490806003015490806004015490806005015490508c565b6000600960000160049054906101000a900460ff16905090565b600960000160069054906101000a900460ff1660ff1660088054905014611254576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040161124b9061341d565b60405180910390fd5b60001515600960000160049054906101000a900460ff161515146112ad576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016112a49061335d565b60405180910390fd5b6001600960000160016101000a81548160ff0219169083151502179055504260096002018190555060005b60088054905081101561142c57600060088281548110611321577f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b9060005260206000209060030201905060005b8160000180549050811015611417576000826000018281548110611381577f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b9060005260206000200160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1690506000600560008373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002090506113fa826109d5565b81600101819055505050808061140f906139b0565b915050611334565b50508080611424906139b0565b9150506112d8565b50565b6000600960050154905090565b6000600960000160039054906101000a900460ff16905090565b600960000160069054906101000a900460ff1660ff16600880549050106114b2576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016114a9906133dd565b60405180910390fd5b8051600960000160059054906101000a900460ff1660ff16101561150b576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401611502906133fd565b60405180910390fd5b6009600401543414611552576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016115499061337d565b60405180910390fd5b60001515600960000160049054906101000a900460ff161515146115ab576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016115a29061335d565b60405180910390fd5b6000600760003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020541461162d576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016116249061343d565b60405180910390fd5b600081816000019080519060200190611647929190612894565b5060005b82518110156117c8576040518060800160405280848381518110611698577f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b602002602001015173ffffffffffffffffffffffffffffffffffffffff168152602001600081526020016000815260200160008152506005600085848151811061170b577f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b602002602001015173ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060008201518160000160006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555060208201518160010155604082015181600201556060820151816003015590505080806117c0906139b0565b91505061164b565b50338160010160006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555034600760003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020819055506118683460096005015461287e90919063ffffffff16565b600960050181905550600881908060018154018082558091505060019003906000526020600020906003020160009091909190915060008201816000019080546118b392919061291e565b506001820160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff168160010160006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055506002820154816002015550505050565b6000600880549050905090565b6008818154811061194857600080fd5b90600052602060002090600302016000915090508060010160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff16908060020154905082565b611994612970565b6040518060600160405280603260ff168152602001601e60ff168152602001601460ff1681525060009060036119cb929190612992565b506000600380602002604051908101604052809291908260038015611a05576020028201915b8154815260200190600101908083116119f1575b5050505050905090565b60005b600880549050811015611bfa57600060088281548110611a5b577f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b906000526020600020906003020190506000816002018190555060005b8160000180549050811015611be5576000826000018281548110611ac5577f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b9060005260206000200160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1690506000600560008373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000206040518060800160405290816000820160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020016001820154815260200160028201548152602001600382015481525050905080606001518460020154611bc8919061366f565b846002018190555050508080611bdd906139b0565b915050611a78565b50508080611bf2906139b0565b915050611a12565b50565b600080600080600080600090505b600880549050811015611d6357600060088281548110611c54577f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b906000526020600020906003020160020154905060006001811115611ca2577f4e487b7100000000000000000000000000000000000000000000000000000000600052602160045260246000fd5b600960000160009054906101000a900460ff166001811115611ced577f4e487b7100000000000000000000000000000000000000000000000000000000600052602160045260246000fd5b1415611d235786811315611d0657819450809650611d1e565b85811315611d1957819350809550611d1d565b8192505b5b611d4f565b86811215611d3657819450809650611d4e565b85811215611d4957819350809550611d4d565b8192505b5b5b508080611d5b906139b0565b915050611c0b565b5060026008805490501115612410576040518060800160405280600060ff16815260200160088581548110611dc1577f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b906000526020600020906003020160010160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200160088581548110611e48577f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b9060005260206000209060030201600201548152602001600015158152506006600060088681548110611ea4577f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b906000526020600020906003020160010160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060008201518160000160006101000a81548160ff021916908360ff16021790555060208201518160000160016101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055506040820151816001015560608201518160020160006101000a81548160ff0219169083151502179055509050506040518060800160405280600160ff16815260200160088481548110611ff4577f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b906000526020600020906003020160010160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020016008848154811061207b577f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b90600052602060002090600302016002015481526020016000151581525060066000600885815481106120d7577f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b906000526020600020906003020160010160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060008201518160000160006101000a81548160ff021916908360ff16021790555060208201518160000160016101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055506040820151816001015560608201518160020160006101000a81548160ff0219169083151502179055509050506040518060800160405280600260ff16815260200160088381548110612227577f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b906000526020600020906003020160010160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001600883815481106122ae577f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b906000526020600020906003020160020154815260200160001515815250600660006008848154811061230a577f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b906000526020600020906003020160010160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060008201518160000160006101000a81548160ff021916908360ff16021790555060208201518160000160016101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055506040820151816001015560608201518160020160006101000a81548160ff021916908315150217905550905050612877565b6040518060800160405280600060ff1681526020016008858154811061245f577f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b906000526020600020906003020160010160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001600885815481106124e6577f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b9060005260206000209060030201600201548152602001600015158152506006600060088681548110612542577f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b906000526020600020906003020160010160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060008201518160000160006101000a81548160ff021916908360ff16021790555060208201518160000160016101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055506040820151816001015560608201518160020160006101000a81548160ff0219169083151502179055509050506040518060800160405280600160ff16815260200160088481548110612692577f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b906000526020600020906003020160010160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200160088481548110612719577f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b9060005260206000209060030201600201548152602001600015158152506006600060088581548110612775577f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b906000526020600020906003020160010160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060008201518160000160006101000a81548160ff021916908360ff16021790555060208201518160000160016101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055506040820151816001015560608201518160020160006101000a81548160ff0219169083151502179055509050505b5050505050565b6000818361288c9190613703565b905092915050565b82805482825590600052602060002090810192821561290d579160200282015b8281111561290c5782518260006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff160217905550916020019190600101906128b4565b5b50905061291a91906129d7565b5090565b82805482825590600052602060002090810192821561295f5760005260206000209182015b8281111561295e578254825591600101919060010190612943565b5b50905061296c91906129d7565b5090565b6040518060600160405280600390602082028036833780820191505090505090565b82600381019282156129c6579160200282015b828111156129c5578251829060ff169055916020019190600101906129a5565b5b5090506129d391906129d7565b5090565b5b808211156129f05760008160009055506001016129d8565b5090565b6000612a07612a02846135ee565b6135bd565b90508083825260208201905082856020860282011115612a2657600080fd5b60005b85811015612a565781612a3c8882612a60565b845260208401935060208301925050600181019050612a29565b5050509392505050565b600081359050612a6f81613ac9565b92915050565b600082601f830112612a8657600080fd5b8135612a968482602086016129f4565b91505092915050565b600081519050612aae81613ae0565b92915050565b600081359050612ac381613af7565b92915050565b600081519050612ad881613af7565b92915050565b600081519050612aed81613b0e565b92915050565b600060208284031215612b0557600080fd5b6000612b1384828501612a60565b91505092915050565b600060208284031215612b2e57600080fd5b600082013567ffffffffffffffff811115612b4857600080fd5b612b5484828501612a75565b91505092915050565b600060208284031215612b6f57600080fd5b6000612b7d84828501612ab4565b91505092915050565b600080600080600060a08688031215612b9e57600080fd5b6000612bac88828901612ade565b9550506020612bbd88828901612a9f565b9450506040612bce88828901612ac9565b9350506060612bdf88828901612ac9565b9250506080612bf088828901612ade565b9150509295509295909350565b6000612c098383612c15565b60208301905092915050565b612c1e81613916565b82525050565b612c2d81613916565b82525050565b6000612c3e8261362a565b612c488185613642565b9350612c538361361a565b8060005b83811015612c84578151612c6b8882612bfd565b9750612c7683613635565b925050600181019050612c57565b5085935050505092915050565b612c9a81613928565b82525050565b612ca98161399e565b82525050565b612cb881613947565b82525050565b6000612ccb60148361365e565b91507f596f7520617265206e6f7420612077696e6e65720000000000000000000000006000830152602082019050919050565b6000612d0b60108361365e565b91507f47616d65207761732061626f72746564000000000000000000000000000000006000830152602082019050919050565b6000612d4b602d8361365e565b91507f596f75206e65656420746f2073656e742065786163746c79207468652076616c60008301527f7565206f662074686520706f74000000000000000000000000000000000000006020830152604082019050919050565b6000612db160138361365e565b91507f596f7520616c726561647920636c61696d6564000000000000000000000000006000830152602082019050919050565b6000612df160148361365e565b91507f4661696c656420746f2073656e642045746865720000000000000000000000006000830152602082019050919050565b6000612e3160118361365e565b91507f47616d6520616c72656164792066756c6c0000000000000000000000000000006000830152602082019050919050565b6000612e7160168361365e565b91507f45786365656420737570706f7274656420636f696e73000000000000000000006000830152602082019050919050565b6000612eb1601e8361365e565b91507f4e6f74206d656574206d696e206e756d626572206f6620706c617965727300006000830152602082019050919050565b6000612ef160128361365e565b91507f596f7520416c7265616479206a6f696e656400000000000000000000000000006000830152602082019050919050565b6000612f31603a8361365e565b91507f546865726520697320656e6f75676820706c617965727320666f72207468652060008301527f67616d652c20636f756c64206e6f742062652061626f727465640000000000006020830152604082019050919050565b6000612f97601f8361365e565b91507f41626f72742074696d657374616d70206e6f7420656c617073656420796574006000830152602082019050919050565b6000612fd7601b8361365e565b91507f47616d65206e6565647320616c72656164792066696e697368656400000000006000830152602082019050919050565b6000613017602a8361365e565b91507f47616d6520737461727465642c20636f756c64206e6f742062652061626f727460008301527f656420616e796d6f7265000000000000000000000000000000000000000000006020830152604082019050919050565b600061307d60118361365e565b91507f47616d65206e6f742066696e69736865640000000000000000000000000000006000830152602082019050919050565b60006130bd600083613653565b9150600082019050919050565b60006130d760108361365e565b91507f47616d65206e6f742061626f72746564000000000000000000000000000000006000830152602082019050919050565b600061311760198361365e565b91507f47616d65206e6565647320746f207374617274206669727374000000000000006000830152602082019050919050565b6000613157600e8361365e565b91507f47616d65206e6f7420656e6465640000000000000000000000000000000000006000830152602082019050919050565b61319381613971565b82525050565b6131a28161397b565b82525050565b60006131b3826130b0565b9150819050919050565b60006040820190506131d26000830185612c24565b6131df6020830184612caf565b9392505050565b60006080820190506131fb6000830187612c24565b6132086020830186612caf565b6132156040830185612caf565b6132226060830184612caf565b95945050505050565b600060208201905081810360008301526132458184612c33565b905092915050565b60006020820190506132626000830184612c91565b92915050565b60006101808201905061327e600083018f612ca0565b61328b602083018e612c91565b613298604083018d612c91565b6132a5606083018c612c91565b6132b2608083018b612c91565b6132bf60a083018a613199565b6132cc60c0830189613199565b6132d960e083018861318a565b6132e761010083018761318a565b6132f561012083018661318a565b61330361014083018561318a565b61331161016083018461318a565b9d9c50505050505050505050505050565b60006020820190506133376000830184612caf565b92915050565b6000602082019050818103600083015261335681612cbe565b9050919050565b6000602082019050818103600083015261337681612cfe565b9050919050565b6000602082019050818103600083015261339681612d3e565b9050919050565b600060208201905081810360008301526133b681612da4565b9050919050565b600060208201905081810360008301526133d681612de4565b9050919050565b600060208201905081810360008301526133f681612e24565b9050919050565b6000602082019050818103600083015261341681612e64565b9050919050565b6000602082019050818103600083015261343681612ea4565b9050919050565b6000602082019050818103600083015261345681612ee4565b9050919050565b6000602082019050818103600083015261347681612f24565b9050919050565b6000602082019050818103600083015261349681612f8a565b9050919050565b600060208201905081810360008301526134b681612fca565b9050919050565b600060208201905081810360008301526134d68161300a565b9050919050565b600060208201905081810360008301526134f681613070565b9050919050565b60006020820190508181036000830152613516816130ca565b9050919050565b600060208201905081810360008301526135368161310a565b9050919050565b600060208201905081810360008301526135568161314a565b9050919050565b6000602082019050613572600083018461318a565b92915050565b600060808201905061358d6000830187613199565b61359a6020830186612c24565b6135a76040830185612caf565b6135b46060830184612c91565b95945050505050565b6000604051905081810181811067ffffffffffffffff821117156135e4576135e3613a86565b5b8060405250919050565b600067ffffffffffffffff82111561360957613608613a86565b5b602082029050602081019050919050565b6000819050602082019050919050565b600081519050919050565b6000602082019050919050565b600082825260208201905092915050565b600081905092915050565b600082825260208201905092915050565b600061367a82613947565b915061368583613947565b9250817f7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff038313600083121516156136c0576136bf6139f9565b5b817f80000000000000000000000000000000000000000000000000000000000000000383126000831216156136f8576136f76139f9565b5b828201905092915050565b600061370e82613971565b915061371983613971565b9250827fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0382111561374e5761374d6139f9565b5b828201905092915050565b600061376482613947565b915061376f83613947565b92508261377f5761377e613a28565b5b600160000383147f8000000000000000000000000000000000000000000000000000000000000000831416156137b8576137b76139f9565b5b828205905092915050565b60006137ce82613971565b91506137d983613971565b9250826137e9576137e8613a28565b5b828204905092915050565b60006137ff82613971565b915061380a83613971565b9250817fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0483118215151615613843576138426139f9565b5b828202905092915050565b600061385982613947565b915061386483613947565b9250827f80000000000000000000000000000000000000000000000000000000000000000182126000841215161561389f5761389e6139f9565b5b827f7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0182136000841216156138d7576138d66139f9565b5b828203905092915050565b60006138ed82613971565b91506138f883613971565b92508282101561390b5761390a6139f9565b5b828203905092915050565b600061392182613951565b9050919050565b60008115159050919050565b600081905061394282613ab5565b919050565b6000819050919050565b600073ffffffffffffffffffffffffffffffffffffffff82169050919050565b6000819050919050565b600060ff82169050919050565b600069ffffffffffffffffffff82169050919050565b60006139a982613934565b9050919050565b60006139bb82613971565b91507fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff8214156139ee576139ed6139f9565b5b600182019050919050565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052601160045260246000fd5b7f4e487b7100000000000000000000000000000000000000000000000000000000600052601260045260246000fd5b7f4e487b7100000000000000000000000000000000000000000000000000000000600052602160045260246000fd5b7f4e487b7100000000000000000000000000000000000000000000000000000000600052604160045260246000fd5b60028110613ac657613ac5613a57565b5b50565b613ad281613916565b8114613add57600080fd5b50565b613ae981613947565b8114613af457600080fd5b50565b613b0081613971565b8114613b0b57600080fd5b50565b613b1781613988565b8114613b2257600080fd5b5056fea26469706673582212201928fa8db77665110609742b4de4ffba82e192a5e2a75e17aa1bcdfd2f48b99b64736f6c63430008000033a2646970667358221220f41de8fd4858fd4c25f376b059e1d8a5cf3fe86030c40d5ef15a9fd0399c1d2464736f6c63430008000033";
