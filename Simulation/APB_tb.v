module APB_tb ();
reg PCLK , PRESETn ;
reg SWRITE ;
reg [31:0] SADDR , SWDATA ; 
reg [3:0] SSTRB ;
reg [2:0] SPROT  ;
reg transfer ;
wire [31:0] PRDATA ;

APB_Wrapper dut (
    .PCLK(PCLK),
    .PRESETn(PRESETn),
    .SWRITE(SWRITE),
    .SADDR(SADDR),
    .SWDATA(SWDATA),
    .SSTRB(SSTRB),
    .SPROT(SPROT),
    .transfer(transfer),
    .PRDATA(PRDATA)
);
//20NS CLK
initial begin
    PCLK = 0;
    forever #10 PCLK = ~PCLK;
end   

//in this testbench we are the external system and we are sending the address,the write data and the transfer signal
//to the APB master and then to the APB slave 
initial begin
    PRESETn = 0;
    SPROT = 0;
    #20;
    //***********first we will write in several places*************\\
    PRESETn = 1;
    transfer = 1; //begin to transfer
    SADDR = 32'h000000ff;  //random address
    SWDATA = 32'h01010101; //random data
    SWRITE = 1; //write data
    SSTRB = 4'b1111; //written data should be 0x01010101
    #40; //wait until the writing is complete
    SADDR = 32'h000001ff;
    SWDATA = 32'hff112277; 
    SSTRB = 4'b0110; //written data should be 0x112200
    #40;
    SADDR = 32'h000002ff;
    SWDATA = 32'h8899aabb; 
    SSTRB = 4'b1001; //written data should be 0x880000bb
    #40;
    SADDR = 32'h000003ff;
    SWDATA = 32'hccccdddd;
    SSTRB = 4'b0111; //written data should be 0xffccdddd (sign extended)
    #40;

    //***********then we will read from these places*************\\
    transfer = 0; //cancel transfer for a little bit
    #20; 
    PRESETn = 0; //to start again
    #20;
    PRESETn = 1;
    transfer = 1; //begin to transfer
    SADDR = 32'h000000ff;
    SWRITE = 0;
    SSTRB = 4'b0000; //read data should be 0x01010101
    #40;
    SADDR = 32'h000001ff;
    SSTRB = 4'b0000; //read data should be 0x112200
    #40;
    SADDR = 32'h000002ff;
    SSTRB = 4'b0000; //read data should be 0x880000bb
    #40;
    SADDR = 32'h000003ff;
    SSTRB = 4'b0000; //read data should be 0xccdddd
    #40;
    //another ex to test the PSLVERR function
    SADDR = 32'h00000033;
    SSTRB = 4'b1001;
    #60;
    $stop;
end
endmodule