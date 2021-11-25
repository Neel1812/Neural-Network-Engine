module nd(
input         Clk,
input         Reset,
input  [3:0]  DeviceID,
input         Firstin,
input  [63:0] Din,
output reg        Firstout,
output reg [63:0] Dout,
output reg [63:0] nneval_Din,
output reg    nneval_Push_data,         
output reg    nneval_First_data,
output reg    nneval_Push_weight,
output reg    nneval_First_weight,         
output reg    nneval_Start_calc,
input         nneval_Calculation_busy,
input         nneval_Calculation_complete,
output reg    nneval_Pull,
input         nneval_Empty,
input [63:0]  nneval_Dout
);

logic [63:0] data_in;
logic  [3:0] write_count_d;
logic  [3:0] write_count;
logic [63:0] cword;
logic [63:0] cword_d;
logic [2:0]  status;
logic        calc_done,calc_done_d;
logic        fw,fw_d,fd,fd_d;
//reg [3:0]  noc_state;
logic [63:0] result;
logic nneval_result,nneval_result_d;

typedef enum reg [2:0] {idle,write_state,read_state,write_resp_state,read_resp_state} noc_state;
noc_state ps,ns;

always@(*)begin
write_count_d = write_count;
cword_d = cword;
Dout=0;
Firstout=0;
nneval_First_data=0;
nneval_First_weight=0;
nneval_Push_data=0;
nneval_Push_weight=0;
nneval_Start_calc=0;
fd_d=fd;
fw_d=fw;

if(!calc_done) begin
	calc_done_d = nneval_Calculation_complete;
end else begin
	calc_done_d = calc_done;
end

status = {calc_done,nneval_Calculation_busy,nneval_Empty};

if(!nneval_Empty) begin
	nneval_result_d = nneval_result;
end else begin
	nneval_result_d = 0;
end

//res = (status[0]) ? res: nneval_Dout;
if(status[0]) begin
	result = result;
end else begin
	result = nneval_Dout;
end

//ns = ps;
ns = idle;
	case(ps)
		idle : begin
				if(Firstin) begin
					cword_d = Din;
				end
				if(Din[63:59] == 5'd0) begin
					ns = idle;
				end else if(Din[63:59] == 5'd2) begin
					ns = read_resp_state;
				end else if(Din[63:59] == 5'd4) begin
					ns = write_state;
				end else begin
					ns = idle;
				end
			   end
			   
		write_state : begin
						//write_count_d = cword[47:44];
						write_count_d = 4;
						
						if(cword[2:0]== 3'd0) begin
							if(Din[1:0] == 2'd1) begin
								nneval_Start_calc  = 1;
								fw_d=0;
								fd_d=0;
								nneval_Pull=0;
								calc_done_d=0;
								ns                 = write_resp_state;
							end 
							else if(Din[1:0] == 2'd2) begin
								fd_d=0;
								fw_d=0;
								ns = write_resp_state;
							end 
						end
					      if(cword[2:0]== 3'd2) begin
							nneval_Push_weight = 1;
							nneval_Push_data = 0;
							if(!fw)begin
								fw_d=1; nneval_First_weight=1;end
							if(write_count > 1) begin
							nneval_Din = Din;
							write_count_d = write_count - 1;
							ns            = write_state;          
 						end else begin
							ns  = write_resp_state;
						end
						end
						
					 if(cword[2:0]== 3'd3)begin
							nneval_Push_data = 1;
							nneval_Push_weight = 0;
							if(!fd)begin
								fd_d=1; nneval_First_data=1;end
							if(write_count > 1) begin
							nneval_Din = Din;
							write_count_d = write_count - 1;
							ns            = write_state;          
 						end else begin
							ns  = write_resp_state;
						end
						end
							
						end
					  
		write_resp_state  : begin
							Firstout=1;
							Dout = 64'h2827000000000000;
							ns = idle;
							end
							
		read_resp_state       : begin
									if (!nneval_Pull) 
										nneval_Pull = (cword[39:0]== 4 && status[0] && !status[1])? 1'b1: 1'b0;
										Firstout = 1;
										Dout = {16'h1827,cword[47:40],cword[39:0]};
										
										ns = read_state;
						        end
								
		read_state  : begin
						if(cword[2:0]== 3'd1) begin
							Dout = {61'h0,status};
							ns=idle;
						end else if(cword[2:0]== 3'd4)begin
							nneng_Pull=1;
							Dout = result;
							nneval_result=1;
							ns=idle;
					  end
					  end
	endcase
end
					
always @(posedge Clk or posedge Reset) begin
if(Reset)
begin
write_count<=0;
calc_done<=0;
fd<=0;
fw<=0;
ps<=idle;
end
else
begin
write_count<= #1 write_count_d;
cword<= #1 cword_d;
ps<= #1 ns;
nneval_result<= #1 nneval_result_d;
calc_done<= #1 calc_done_d;
fd<= #1 fd_d;
fw<= #1 fw_d;
end
end

endmodule

