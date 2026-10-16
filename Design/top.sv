module top
(
    input pclk,
    input presetn,
    input [1:0] slv_addr_in, /// 01 - slave1 , 10 - slave2
    input [3:0] addrin,
    input [7:0] datain,
    input wr,
    input newd,
    
    output reg slverr_o,
    output reg [7:0] dataout
);
wire psel1, psel2;
wire [7:0] prdata1, prdata2;
wire [7:0] prdata;
wire pready1,pready2;
wire pslverr1, pslverr2;
wire pready,pslverr;
wire pwrite;
wire [3:0] paddr;
wire [7:0] pwdata;
apb_m_top m1 (
        .pclk(pclk),
        .presetn(presetn),
        .slv_addr_in(slv_addr_in),
        .addrin(addrin),
        .datain(datain),
        .wr(wr),
        .newd(newd),
        .prdata(prdata),
        .pready(pready),
        .psel1(psel1),
        .psel2(psel2),
        .penable(penable),
        .slverr(slverr),
        .paddr(paddr),
        .pwdata(pwdata),
        .pwrite(pwrite),
        .dataout(dataout)
    );
    
   apb_s_top s1 (
        .pclk(pclk),
        .presetn(presetn),
        .paddr(paddr),
        .psel(psel1),
        .penable(penable),
        .pwdata(pwdata),
        .pwrite(pwrite),
        .prdata(prdata1),
        .pready(pready1),
        .pslverr(pslverr1)
    );
    
    
    apb_s_top s2 (
        .pclk(pclk),
        .presetn(presetn),
        .paddr(paddr),
        .psel(psel2),
        .penable(penable),
        .pwdata(pwdata),
        .pwrite(pwrite),
        .prdata(prdata2),
        .pready(pready2),
        .pslverr(pslverr2)
    ); 
assign  prdata = (psel1 == 1'b1) ? prdata1 : ((psel2 == 1'b1) ? prdata2 : 8'h00) ;    
assign  pready = (psel1 == 1'b1) ? pready1 : ((psel2 == 1'b1) ? pready2 : 1'b0) ;    
assign  pslverr = (psel1 == 1'b1) ? pslverr1 : ((psel2 == 1'b1) ? pslverr2 : 1'b0) ;    
assign  slverr_o = pslverr;
endmodule
