`timescale 1ns / 1ps

module RV32I_top (
    input clk,
    input reset
);
    logic dwe, branch;
    logic [2:0] o_funct3;
    logic [31:0] instr_addr, instr_data, dwdata, daddr, drdata;
    instruction_mem U_INSTRUCTION_MEM (.*);
    RV32I_CPU U_RV32 (
        .*,
        .o_funct3(o_funct3)
    );
    data_mem U_DATA_MEM (
        .*,
        .i_funct3(o_funct3)
    );
endmodule

