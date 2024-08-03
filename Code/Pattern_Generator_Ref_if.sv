/*------------------------------------------------------------------------------
 * File          : Pattern_Generator_Ref_if.sv
 * Project       : RTL
 * Author        : epmkos
 * Creation date : Jul 30, 2024
 * Description   :
 *------------------------------------------------------------------------------*/
interface Pattern_Generator_Ref_if;
logic 				clk;			//16ns master clock	
logic 				rst_n;			//Asynchronous active low reset
logic 				f_sync;			//First sync signal
logic 				sync;			//Sync signal, starts the count
logic [11:0]		constVal;		//constant value 
logic [1:0]			X;				//deltaX for ramp mode
logic [1:0] 		Y;				//deltaY for ramp mode
logic [2:0] 		Mode;			//work mode

// =================
//		Outputs
// =================
logic [11:0]		cnt;		//output count

endinterface : Pattern_Generator_Ref_if