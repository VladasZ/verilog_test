module mojo_top(
    input clk,
    
    input rst_n,
    
    input cclk,
    output spi_miso,
    input spi_ss,
    input spi_mosi,
    input spi_sck,
    output [3:0] spi_channel,
    input avr_tx,
    output avr_rx,
    input avr_rx_busy,
    
    input button_in,
    output [7:0] led
  );
  
  localparam COUNTER_SIZE = 8;
  localparam PACKET_SIZE = 8;
    
  // AVR SETUP
  wire [7:0] tx_data;
  wire new_tx_data;
  wire tx_busy;
  wire [7:0] rx_data;
  wire new_rx_data;
 
  avr_interface avr_interface (
    .clk(clk),
    .rst(rst),
    .cclk(cclk),
    .spi_miso(spi_miso),
    .spi_mosi(spi_mosi),
    .spi_sck(spi_sck),
    .spi_ss(spi_ss),
    .spi_channel(spi_channel),
    .tx(avr_rx), // FPGA tx goes to AVR rx
    .rx(avr_tx),
    .channel(4'd15), // invalid channel disables the ADC
    .new_sample(),
    .sample(),
    .sample_channel(),
    .tx_data(tx_data),
    .new_tx_data(new_tx_data),
    .tx_busy(tx_busy),
    .tx_block(avr_rx_busy),
    .rx_data(rx_data),
    .new_rx_data(new_rx_data)
  );
  
  // AVR SETUP
  
  // SERIAL SENDER SETUP
  
  wire send_serial;
  wire serial;
  wire serial_is_busy;
  wire serial_skip;
  wire serial_is_sending;
  wire [64:0] serial_data;
      
  serial_sender serial_sender(
    .clk(clk),
    .send(send_serial),
    .data(serial_data),
    .serial_busy(tx_busy),
    .busy(serial_is_busy),
    .skip(serial_skip),
    .new_tx(new_tx_data),
    .tx_data(tx_data),
    .is_sending(serial_is_sending)
  );
  
  // SERIAL SENDER SETUP

  wire button = ~button_in;
  wire switch;
  wire blink;
  wire every_second;
  wire [7:0] index;
  
  signal_generator #(.DELAY(50000000)) every_second_generator(clk, every_second);
  switch switch_module(every_second, switch);
  blinker blinker_module(clk, blink);
  indexer #(.SIZE(COUNTER_SIZE)) indexer(every_second, index);
  //timer timer(every_second, index);
  
  assign send_serial = every_second;
  assign serial_data = index;

  
  assign led = index;


endmodule