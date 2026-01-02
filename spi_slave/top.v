module top (
    input wire SPI_CS_N,
    input wire SPI_MOSI,
    input wire SPI_SCLK,
    output wire SPI_MISO,
    output wire LED0
); 


wire [7:0] x, y , sum; 
wire valid; 

spi_slave_8bit spi(

    .spi_cs_n(SPI_CS_N), 
    .spi_miso(SPI_MISO),
    .spi_mosi(SPI_MOSI),
    .spi_sclk(SPI_SCLK), 
    .rx_x(x)
    .rx_y(y)
    .tx_data(sum)
); 

adder8 add(

    .x(x),
    .y(y),
    .sum(sum)
);

assign LED0 = valid 

endmodule
