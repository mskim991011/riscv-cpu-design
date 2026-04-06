`timescale 1ns / 1ps

module instruction_mem (
    input  [31:0] instr_addr,
    output [31:0] instr_data
);
  logic [31:0] rom[0:127];

    initial begin       
        $readmemh("risv_rv32.mem",rom);
    end
    
  assign instr_data = rom[instr_addr[31:2]];  //PC +=4 >>    
endmodule





////R-TYPE SIMULATION/////
//initial begin
//
//    rom[0] = 32'h004182b3; // ADD  x5, x3, x4
//    rom[1] = 32'h41408533; // SUB  x10, x1, x20
//    rom[2] = 32'h402555b3; // SRA  x11, x10, x2  
//    rom[3] = 32'h00255633; // SRL  x12, x10, x2 
//    rom[4] = 32'h005526b3; // SLT  x13, x10, x5 
//    rom[5] = 32'h00553733; // SLTU x14, x10, x5  
//
//end


//S-TYPE SIMULATION/////    
//initial begin
//
//    rom[0] = 32'h00100023; // SB x1, 0
//    rom[1] = 32'h002000a3; // SB x2, 1
//    rom[2] = 32'h00300123; // SB x3, 2
//    rom[3] = 32'h004001a3; // SB x4, 3  
//    rom[4] = 32'h00501223; // SH x5, 4
//    rom[5] = 32'h00602423; // SW x6, 8
//end



//B_TYPE SIMULATION////
//    initial begin   
//    rom[0] = 32'hffb00593; // ADDI x11, x0, -5  (x11에 -5)
//    rom[1] = 32'h00b51463; // BNE x10, x11, 8
//    rom[2] = 32'h004182b3; // (건너뛰어야 함) PC + 8
//    rom[3] = 32'h00a5c463; // BLT x11, x10, 8
//    rom[4] = 32'h004182b3; // (건너뛰어야 함) PC + 8  
//    end

//U_TYPE SIMULATION////
//    initial begin
//        rom[0] = 32'h123452b7; // LUI  x5 0x12345 
//        rom[1] = 32'h00002317; // AUIPC x6 0x00002
//    end

//I_TYPE SIMULATION ///
//  initial begin
//    rom[0] = 32'h00042583;  // LW  x11, 0(x8) 
//
//    // --- 2. 16비트 (Halfword) ---
//    rom[1] = 32'h00041603;  // LH  x12, 0(x8) -
//    rom[2] = 32'h00241683;  // LH  x13, 2(x8)  
//    rom[3] = 32'h00245703;  // LHU x14, 2(x8) 
//
//    // --- 3. 8비트 (Byte) ---
//    rom[4] = 32'h00040783;  // LB  x15, 0(x8) 
//    rom[5] = 32'h00140803;  // LB  x16, 1(x8) 
//    rom[6] = 32'h00240883;  // LB  x17, 2(x8) 
//    rom[7] = 32'h00340903;  // LB  x18, 3(x8) 
//    rom[8] = 32'h00344983;  // LBU x19, 3(x8) 
//  end

//S_TYP SIMULATION////
//    initial begin
//        //SW 
//        rom[0] = 32'h01F02023; // SW x31, 0(x0)  
//
//        //SH 
//        rom[1] = 32'h00101223; // SH x1, 4(x0)   
//        rom[2] = 32'h00201323; // SH x2, 6(x0)   
//
//        // SB 
//        rom[3] = 32'h00300423; // SB x3, 8(x0)   
//        rom[4] = 32'h004004A3; // SB x4, 9(x0)  
//        rom[5] = 32'h00500523; // SB x5, 10(x0)  
//        rom[6] = 32'h006005A3; // SB x6, 11(x0)  
//    end