/*------------------------------------------------------------------------------
 * File          : Pattern_Generator_if.sv
 * Project       : RTL
 * Author        : epmkos
 * Creation date : Jul 30, 2024
 * Description   : This file defines the interface for the Pattern Generator module.
 *                 It includes signal declarations for inputs and outputs that are 
 *                 used to control and monitor the pattern generator in different modes.
 *------------------------------------------------------------------------------*/
interface Pattern_Generator_if;

	// =================
	//		Inputs
	// =================
	logic 				clk;			// 16ns master clock
	logic 				rst_n;			// Asynchronous active low reset
	logic 				f_sync;			// First sync signal, used for initialization
	logic 				sync;			// Sync signal, starts the counting process
	logic [11:0]		constVal;		// Constant value for specific operations
	logic [1:0]			X;				// deltaX for ramp mode, controls the X-axis increment
	logic [1:0] 		Y;				// deltaY for ramp mode, controls the Y-axis increment
	logic [2:0] 		Mode;			// Work mode selector, determines the operation mode of the pattern generator

	// =================
	//		Outputs
	// =================
	logic [11:0]		cnt;			// Output count, the result of the pattern generation

endinterface : Pattern_Generator_if
