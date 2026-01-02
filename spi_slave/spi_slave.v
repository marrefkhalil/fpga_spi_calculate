module spi_slave (
    input wire spi_cs_n,
    input wire spi_sclk,
    input wire spi_mosi,
    output wire spi_miso,
    output reg [7:0] rx_x,
    output reg [7:0] rx_y,
    output reg [7:0] rx_valid,
    input  wire [7:0] tx_data 
);

    reg [7:0] rx_shift;
    reg [7:0] tx_shift;
    reg [2:0] bit_cnt;
    reg [1:0] byte_cnt
 
@always (posedge spi_cs_n, negedge spi_sclk) 
begin 
    if (spi_cs_n) begin 
        spi_miso <= 1'b0; 
        tx_shift <= 8'h00; 
    end 
    else begin 
        spi_miso <= tx_shift[7]; 
        tx_shift <= {tx_shift[6:0], 1'b0};
    end 
end


@always(posedge spi_sclk or posedge spi_cs_n) 
begin 
    if (spi_cs_n) begin
        rx_y <= 8'h00;
        rx_x <= 8'h00;
        rx_valid <= 1'b0;
        bit_cnt <= 3'd0;
        byte_cnt <=2'd0;
        rx_shift <= 8'h00;
    end
    else begin 
         rx_valid <= 1'b0; 
         rx_shift <= {rx_shift[6:0], spi_mosi}; 

         if (bit_cnt == 3'd7) begin 
            case (byte_cnt)

                2'd0: 
                    begin 
                         rx_x <= {rx_shift[6:0], spi_mosi};
                         byte_cnt <= byte_cnt + 1'd1; 
                    end

                2'd1: 
                    begin 
                         rx_y <= {rx_shift[6:0], spi_mosi;
                         rx_valid <= 1'b1; 
                         tx_shift <= tx_data;
                    end
            endcase
            bit_cnt <= bit_cnt + 1'd1;
            byte_cnt <= byte_cnt +1;           
            rx_shift <= 8'h00; 
         end 
         else begin 
             bit_cnt <= bit +1'd1; 
         end
    end
end

endmodule