interface abp_if;

  // Clock and Reset
  logic        pclk;
  logic        presetn;

  // APB Address and Control Signals
  logic [31:0] paddr;
  logic        psel;
  logic        penable;
  logic        pwrite;

  // APB Data Signals
  logic [7:0]  pwdata;
  logic [7:0]  prdata;

  // APB Response Signals
  logic        pready;
  logic        pslverr;

endinterface
