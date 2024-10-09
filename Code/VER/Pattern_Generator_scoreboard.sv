/*------------------------------------------------------------------------------
 * File          : Pattern_Generator_scoreboard.sv
 * Project       : RTL
 * Author        : epmkos
 * Creation date : Jul 30, 2024
 * Description   : A UVM scoreboard that compares transactions from the DUT 
 *                 (Design Under Test) and a reference model, ensuring that 
 *                 the output signals match.
 *------------------------------------------------------------------------------*/

class Pattern_Generator_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(Pattern_Generator_scoreboard)  // Macro to register the class with the UVM factory

    // Analysis ports that receive transactions from the DUT and reference model
    uvm_analysis_export #(Pattern_Generator_transaction) sb_export_dut;
    uvm_analysis_export #(Pattern_Generator_transaction) sb_export_ref;

    // FIFOs to store incoming transactions before comparison
    uvm_tlm_analysis_fifo #(Pattern_Generator_transaction) dut_fifo;
    uvm_tlm_analysis_fifo #(Pattern_Generator_transaction) ref_fifo;

    // Transaction objects to store individual transactions from DUT and reference model
    Pattern_Generator_transaction transaction_dut;
    Pattern_Generator_transaction transaction_ref;

    // Constructor: Initialize the scoreboard and transaction objects
    function new(string name, uvm_component parent);
        super.new(name, parent);  // Call the superclass constructor

        // Create transaction objects for DUT and reference model
        transaction_dut = new("transaction_dut");
        transaction_ref = new("transaction_ref");
    endfunction: new

    // Build phase: Initialize analysis exports and FIFOs
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Create and register analysis exports for DUT and reference model
        sb_export_dut = new("sb_export_dut", this);
        sb_export_ref = new("sb_export_ref", this);

        // Initialize the FIFOs for storing transactions
        dut_fifo = new("dut_fifo", this);
        ref_fifo = new("ref_fifo", this);
    endfunction: build_phase

    // Connect phase: Link the analysis exports to their corresponding FIFOs
    function void connect_phase(uvm_phase phase);
        // Connect the DUT export port to the DUT FIFO's analysis export port
        sb_export_dut.connect(dut_fifo.analysis_export);
        // Connect the reference export port to the reference FIFO's analysis export port
        sb_export_ref.connect(ref_fifo.analysis_export);
    endfunction: connect_phase

    // Task that runs in parallel to process and compare transactions from DUT and reference
    task run();
        forever begin
            // Block until a transaction is available in the DUT FIFO
            dut_fifo.get(transaction_dut);
            // Block until a transaction is available in the reference FIFO
            ref_fifo.get(transaction_ref);

            // Compare the transactions from DUT and reference model
            compare();
        end
    endtask: run

    // Function to compare the DUT and reference transactions
    virtual function void compare();
        // Check if the 'cnt' fields of the DUT and reference transactions match
        if(transaction_dut.cnt == transaction_ref.cnt) begin
            // Uncomment the line below to print a success message on match
            //`uvm_info("compare", {"Test: OK!"}, UVM_LOW)
        end else begin
            // Log a failure message if the 'cnt' fields do not match
            `uvm_info("compare", {"Test: Fail!"}, UVM_LOW)
        end
    endfunction: compare
endclass: Pattern_Generator_scoreboard
