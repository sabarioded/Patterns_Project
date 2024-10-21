/*------------------------------------------------------------------------------
 * File          : Pattern_Generator_sequencer.sv
 * Project       : RTL
 * Author        : epmkos
 * Creation date : Jul 30, 2024
 * Description   : A UVM sequencer and associated sequence to generate 
 *                 different test patterns for the DUT.
 *------------------------------------------------------------------------------*/

class Pattern_Generator_transaction extends uvm_sequence_item;
    
    // Fields for the transaction
    logic              f_sync;          // First sync signal
    logic              sync;            // Sync signal, starts the count
    rand logic [11:0]  constVal;        // Constant value for specific modes
    logic [1:0]        X;               // deltaX for ramp mode
    logic [1:0]        Y;               // deltaY for ramp mode
    logic [2:0]        Mode;            // Work mode
    logic [11:0]       cnt;             // Output count

    // Constructor: Initializes the transaction object
    function new(string name = "");
        super.new(name);
    endfunction: new

    // UVM macros to enable transaction object field automation
    `uvm_object_utils_begin(Pattern_Generator_transaction)
        `uvm_field_int(f_sync, UVM_ALL_ON)       // Sync flag
        `uvm_field_int(sync, UVM_ALL_ON)         // Sync signal
        `uvm_field_int(constVal, UVM_ALL_ON)     // Constant value
        `uvm_field_int(X, UVM_ALL_ON)            // X delta for ramp
        `uvm_field_int(Y, UVM_ALL_ON)            // Y delta for ramp
        `uvm_field_int(Mode, UVM_ALL_ON)         // Work mode
    `uvm_object_utils_end
endclass: Pattern_Generator_transaction

// Pattern Generator Sequence to generate different transactions
class Pattern_Generator_sequence extends uvm_sequence#(Pattern_Generator_transaction);

    // Constructor: Initializes the sequence object
    function new(string name = "");
        super.new(name);
    endfunction: new

    `uvm_object_utils(Pattern_Generator_sequence) // UVM automation macro

    // Main sequence body, which generates multiple transactions
    task body();
        Pattern_Generator_transaction pg_pkt;

        // Generate and run a series of test patterns with different modes
       // `uvm_info("", "Randomize Try0", UVM_MEDIUM)
        
        // Create the first transaction object
        pg_pkt = Pattern_Generator_transaction::type_id::create(.name("pg_pkt"), .contxt(get_full_name()));
        
        // Test different operational modes
        //Test_mode($urandom_range(3, 0), $urandom_range(3, 0), 3'b001); // Regular mode
        //Test_mode($urandom_range(3, 0), $urandom_range(3, 0), 3'b010); // Constant mode
        //Test_mode($urandom_range(3, 0), $urandom_range(3, 0), 3'b011); // White 1x1 mode
        Test_mode($urandom_range(3, 0), $urandom_range(3, 0), 3'b100); // Black 1x1 mode
        //Test_mode($urandom_range(3, 0), $urandom_range(3, 0), 3'b101); // White 2x2 mode
        //Test_mode($urandom_range(3, 0), $urandom_range(3, 0), 3'b110); // Black 2x2 mode
		//Test_mode($urandom_range(3, 0), $urandom_range(3, 0), 3'b000); // Inactive
        
        // Test with fixed values for the X and Y modes
        //Test_mode(2'b00, 2'b00, 3'b111); // 0-0 pattern
        //Test_mode(2'b00, 2'b01, 3'b111); // 0-1 pattern
        //Test_mode(2'b00, 2'b10, 3'b111); // 0-2 pattern
        //Test_mode(2'b00, 2'b11, 3'b111); // 0-3 pattern
        //Test_mode(2'b01, 2'b00, 3'b111); // 1-0 pattern
        //Test_mode(2'b10, 2'b00, 3'b111); // 2-0 pattern
        //Test_mode(2'b11, 2'b00, 3'b111); // 3-0 pattern
        //Test_mode(2'b01, 2'b01, 3'b111); // 1-1 pattern
        //Test_mode(2'b01, 2'b10, 3'b111); // 1-2 pattern
        //Test_mode(2'b01, 2'b11, 3'b111); // 1-3 pattern
        //Test_mode(2'b10, 2'b01, 3'b111); // 2-1 pattern
        //Test_mode(2'b10, 2'b10, 3'b111); // 2-2 pattern
        //Test_mode(2'b10, 2'b11, 3'b111); // 2-3 pattern
        //Test_mode(2'b11, 2'b01, 3'b111); // 3-1 pattern
        //Test_mode(2'b11, 2'b10, 3'b111); // 3-2 pattern
        //Test_mode(2'b11, 2'b11, 3'b111); // 3-3 pattern
    endtask: body 

    // Sub-task to generate a transaction with specific X, Y, and mode values
    task Test_mode(input [2:0] Xmode, input [2:0] Ymode, input [2:0] mode);
        begin
            Pattern_Generator_transaction pg_pkt;

            //`uvm_info("", "Randomize Try0", UVM_MEDIUM)
            pg_pkt = Pattern_Generator_transaction::type_id::create(.name("pg_pkt"), .contxt(get_full_name()));
            
            // Start the transaction item
            start_item(pg_pkt);
            
            // Set the X, Y, and mode values for this transaction
            pg_pkt.X = Xmode;
            pg_pkt.Y = Ymode;
            pg_pkt.constVal = $urandom_range(4095, 0);  // Random constant value
            pg_pkt.Mode = mode;  // Set the mode

            // End the transaction
            finish_item(pg_pkt);
        end
    endtask : Test_mode
endclass: Pattern_Generator_sequence

// Define the sequencer for handling Pattern_Generator transactions
typedef uvm_sequencer#(Pattern_Generator_transaction) Pattern_Generator_sequencer;
