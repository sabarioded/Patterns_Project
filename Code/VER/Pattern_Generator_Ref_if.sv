/*------------------------------------------------------------------------------
 * File          : Pattern_Generator_Ref_if.sv
 * Project       : RTL
 * Author        : Oded and Margarita
 * Creation date : Jul 30, 2024
 * Description   : This SystemVerilog interface defines the signal connections
 *                 for the reference pattern generator module. It includes 
 *                 various input and output signals necessary for the module's
 *                 operation, including clock, reset, sync signals, mode 
 *                 selection, and output count.
 *------------------------------------------------------------------------------*/
interface Pattern_Generator_Ref_if;

    // =================
    //    Inputs
    // =================

    logic  clk;            // 16ns master clock
    logic  rst_n;          // Asynchronous active low reset
    logic  f_sync;         // First sync signal, indicates start of operation
    logic  sync;           // Sync signal, triggers the start of counting
    logic  [11:0] constVal;// Constant value input, potentially used for operations
    logic  [1:0]  X;       // deltaX for ramp mode, defines slope along X-axis
    logic  [1:0]  Y;       // deltaY for ramp mode, defines slope along Y-axis
    logic  [2:0]  Mode;    // Work mode selection, defines the mode of operation

    // =================
    //    Outputs
    // =================
    
    logic  [11:0] cnt;     // Output count, the primary output of the pattern generator

endinterface : Pattern_Generator_Ref_if
