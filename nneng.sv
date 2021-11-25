`include "DW02_mult_3_stage.v"
module nneng(nnengi.tnn nn,nnmemi.tmem data,nnmemi.tmem weight);
reg [3:0] c0,c0_1;
reg [23:0] c1,c1_1;
reg [3:0] c2,c2_1;
reg [23:0] c3,c3_1,sigw,sigw_d;
reg [1:0] w,w_1;
reg [15:0] iw,ow,ow_d,iw_1,ow_1_d,ow_1,ow_2_d,ow_2,ow_3,ow_3_d,ow_4_d,ow_4,ow_5,ow_5_d,ow_6,ow_6_d,ow_7,ow_7_d,ow_8,ow_8_d,ow_9,ow_9_d,ow_10,ow_10_d,ow_11,ow_11_d,ow_12,ow_12_d;
reg [2:0] c,d;
reg [23:0] dcount,wcount,dcount_1,wcount_1;
typedef enum reg [3:0]{s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12}state;
logic signed [15:0][31:0] d512,w512,w512_d;
logic signed [75:0] sum,sum_s,sum_d,sum_sd,sum_1,sum_1d,sum_2,sum_2d,sum_3,sum_3d,sum_4,sum_4d;
logic signed [63:0] mul0,mul1,mul2,mul3,mul4,mul5,mul6,mul7,mul8,mul9,mul10,mul11,mul12,mul13,mul14,mul15;
logic signed [63:0] c1x1,c1x1_d,c2x2,c2x2_d,c3x3,c3x3_d,cx1,cx2,cx3;
logic signed [31:0] c1x132,c1x132_d,c2x232,c2x232_d,c3x332,c3x332_d;
state ps,ns,ps_0,ns_0;
logic [9:0] neuronix,neuronix_d;
logic [7:0][63:0] sumsig;
logic [3:0] pull_count,pull_count_d;
logic [7:0] neuronoffset,neuronoffset_d;
logic [23:0] neuronaddr,neuronaddr_d;
logic [31:0] neuronbase,neuronbase_d,neuronbase_1,neuronbase_1_d,neuronbase_2,neuronbase_2_d,neuronbase_3,neuronbase_3_d;
logic [15:0][31:0] coef,coef_d;
logic signed [31:0] sigsum,sigsum_f,sigsum_d,sigsum_f_d;
logic signed [31:0] co0,co0_d,co01_d,co01,co02_d,co02,co1,co1_d,co2,co2_d,co3,co3_d;
logic [25:0] f;
logic signed [31:0] f_final,f_final_1,f_2,f_22,f_31,f_31_1,f_final_2_d,f_final_2,f_final_3_d,f_final_3,f_final_4,f_final_5,f_final_4_d,f_final_5_d;
logic signed [31:0] f_final_6,f_final_6_d,f_32,f_32_d,f_23,f_23_d,f_24,f_24_d,f_25_d,f_25,f_26,f_26_d,f_33,f_33_d,f_34,f_34_d;
logic [63:0] f_21,f_2_1,f_3,f_3_1;
logic [23:0] weight_location;
logic [23:0] data_location;
logic [23:0] result_location;
logic [23:0] neuron_index;
logic [15:0] input_width;
logic [15:0] output_width;
logic [7:0] neuron_scaling;
logic [7:0] final_layer;
DW02_mult_3_stage #(32,32) m0(d512[0],w512[0],1'b1,nn.Clk,mul0);
DW02_mult_3_stage #(32,32) m1(d512[1],w512[1],1'b1,nn.Clk,mul1);
DW02_mult_3_stage #(32,32) m2(d512[2],w512[2],1'b1,nn.Clk,mul2);
DW02_mult_3_stage #(32,32) m3(d512[3],w512[3],1'b1,nn.Clk,mul3);
DW02_mult_3_stage #(32,32) m4(d512[4],w512[4],1'b1,nn.Clk,mul4);
DW02_mult_3_stage #(32,32) m5(d512[5],w512[5],1'b1,nn.Clk,mul5);
DW02_mult_3_stage #(32,32) m6(d512[6],w512[6],1'b1,nn.Clk,mul6);
DW02_mult_3_stage #(32,32) m7(d512[7],w512[7],1'b1,nn.Clk,mul7);
DW02_mult_3_stage #(32,32) m8(d512[8],w512[8],1'b1,nn.Clk,mul8);
DW02_mult_3_stage #(32,32) m9(d512[9],w512[9],1'b1,nn.Clk,mul9);
DW02_mult_3_stage #(32,32) m10(d512[10],w512[10],1'b1,nn.Clk,mul10);
DW02_mult_3_stage #(32,32) m11(d512[11],w512[11],1'b1,nn.Clk,mul11);
DW02_mult_3_stage #(32,32) m12(d512[12],w512[12],1'b1,nn.Clk,mul12);
DW02_mult_3_stage #(32,32) m13(d512[13],w512[13],1'b1,nn.Clk,mul13);
DW02_mult_3_stage #(32,32) m14(d512[14],w512[14],1'b1,nn.Clk,mul14);
DW02_mult_3_stage #(32,32) m15(d512[15],w512[15],1'b1,nn.Clk,mul15);
DW02_mult_3_stage #(32,32) m16(f_final,f_final,1'b1,nn.Clk,f_21);
DW02_mult_3_stage #(32,32) m17(f_2,f_final_2,1'b1,nn.Clk,f_3);
DW02_mult_3_stage #(32,32) m18(co1,f_final_6,1'b1,nn.Clk,cx1);
DW02_mult_3_stage #(32,32) m19(co2,f_26,1'b1,nn.Clk,cx2);
DW02_mult_3_stage #(32,32) m20(co3,f_34,1'b1,nn.Clk,cx3);
typedef struct packed{
    reg [367:0] reserved;
    reg [23:0] weight_location;
    reg [23:0] data_location;
    reg [23:0] result_location;
    reg [15:0] input_width;
    reg [15:0] output_width;
    reg [23:0] neuron_index;
    reg [7:0] neuron_scaling;
    reg [7:0] final_layer;
} CMD;
CMD cmdm,cmdm_d;
always_ff @(posedge nn.Clk or posedge nn.Reset)
begin
	if(nn.Reset)
	begin
		ps<=s0;
		ps_0<=s0;
		c0<=0;
		c1<=0;
		c2<=0;
		c3<=0;
		w<=0;
		ow<=0;
		dcount<=0;
		wcount<=0;
		sigw<=0;
		pull_count<=0;
	end
	else
	begin
		ps<= #1 ns;
		ps_0<= #1 ns_0;
		c0<= #1 c0_1;
		c1<= #1 c1_1;
		c2<= #1 c2_1;
		c3<= #1 c3_1;
		w<= #1 w_1;
		dcount<= #1 dcount_1;
		wcount<= #1 wcount_1;
		f_final<= #1 f_final_1;
		f_final_2<= #1 f_final_2_d;
		f_final_3<= #1 f_final_3_d;
		f_final_4<= #1 f_final_4_d;
		f_final_5<= #1 f_final_5_d;
		f_final_6<= #1 f_final_6_d;
		//f_21<= #1 f_2_1;
		f_22<= #1 f_2;
		f_23<= #1 f_23_d;
		f_24<= #1 f_24_d;
		f_25<= #1 f_25_d;
		//f_3<= #1 f_3_1;
		f_31<= #1 f_31_1;
		f_32<=#1 f_32_d;
		ow<= #1 ow_d;
		iw<= #1 iw_1;
		ow_1<= #1 ow_1_d;
		ow_2<= #1 ow_2_d;
		ow_3<= #1 ow_3_d;
		ow_4<= #1 ow_4_d;
		ow_5<= #1 ow_5_d;
		ow_6<= #1 ow_6_d;
		ow_7<= #1 ow_7_d;
		w512<= #1 w512_d;
		sum<= #1 sum_d;
		sum_s<= #1 sum_sd;
		co0<= #1 co0_d;
		co01<= #1 co01_d;
		co02<= #1 co02_d;
		co1<= #1 co1_d;
		co2<= #1 co2_d;
		co3<= #1 co3_d;
		ow_8<= #1 ow_8_d;
		ow_9<= #1 ow_9_d;
		ow_10<= #1 ow_10_d;
		ow_11<= #1 ow_11_d;
		ow_12<= #1 ow_12_d;
		f_34<= #1 f_34_d;
		f_33<= #1 f_33_d;
		f_26<= #1 f_26_d;
		neuronix<= #1 neuronix_d;
		neuronoffset<= #1 neuronoffset_d;
		neuronaddr<= #1 neuronaddr_d;
		neuronbase<= #1 neuronbase_d;
		neuronbase_1<= #1 neuronbase_1_d;
		neuronbase_2<= #1 neuronbase_2_d;
		neuronbase_3<= #1 neuronbase_3_d;
		cmdm<= #1 cmdm_d;
		c1x1<= #1 c1x1_d;
		c2x2<= #1 c2x2_d;
		c3x3<= #1 c3x3_d;
		c1x132<= #1 c1x132_d;
		c2x232<= #1 c2x232_d;
		c3x332<= #1 c3x332_d;
		coef<= #1 coef_d;
		sigsum<= #1 sigsum_d;
		sigsum_f<= #1 sigsum_f_d;
		sigw<= #1 sigw_d;
		pull_count<= #1 pull_count_d;
		sum_1<= #1 sum_1d;
		sum_2<= #1 sum_2d;
		sum_3<= #1 sum_3d;
		sum_4<= #1 sum_4d;
	end
end
always_comb
begin
nn.Calculation_busy=1;
nn.Calculation_complete=0;
nn.Empty=1;
nn.Dout=0;
nn.Stop_data=0;
nn.Stop_weight=0;
c0_1=c0;
c1_1=c1;
c2_1=c2;
c3_1=c3;
c1x1_d=c1x1;
c2x2_d=c2x2;
c3x3_d=c3x3;
c1x132_d=c1x132;
c2x232_d=c2x232;
c3x332_d=c3x332;
dcount_1=dcount;
wcount_1=wcount;
w_1=w;
f_final_1=f_final;
f_final_2_d=f_final_2;
f_final_3_d=f_final_3;
f_final_4_d=f_final_4;
f_final_5_d=f_final_5;
f_final_6_d=f_final_6;
//f_2_1=f_21;
f_2=f_22;
w512_d=w512;
f_23_d=f_23;
f_24_d=f_24;
f_25_d=f_25;
//f_3_1=f_3;
f_31_1=f_31;
f_32_d=f_32;
co02_d=co02;
co01_d=co01;
sum_d=sum;
sum_sd=sum_s;
ow_d=ow;
ow_1_d=ow_1;
ow_2_d=ow_2;
ow_3_d=ow_3;
ow_4_d=ow_4;
ow_5_d=ow_5;
ow_6_d=ow_6;
ow_7_d=ow_7;
ow_8_d=ow_8;
ow_9_d=ow_9;
ow_10_d=ow_10;
ow_11_d=ow_11;
ow_12_d=ow_12;
f_33_d=f_33;
f_34_d=f_34;
f_26_d=f_26;
sum_1d=sum_1;
sum_2d=sum_2;
sum_3d=sum_3;
sum_4d=sum_4;
neuronix_d=neuronix;
neuronaddr_d=neuronaddr;
neuronbase_d=neuronbase;
neuronbase_1_d=neuronbase_1;
neuronbase_2_d=neuronbase_2;
neuronbase_3_d=neuronbase_3;
neuronoffset_d=neuronoffset;
co0_d=co0;
co1_d=co1;
co2_d=co2;
co3_d=co3;
iw_1=iw;
coef_d=coef;
sigsum_d=sigsum;
sigsum_f_d=sigsum_f;
cmdm_d=cmdm;
sigw_d=sigw;
pull_count_d=pull_count;
data.Mwrite=0;
data.Min=0;
weight.Mwrite=0;
weight.Maddr=0;
weight.Min=0;
d512=0;
data.Mreq=1;
weight.Mreq=1;
data.Maddr=0;
ns=ps;
		if(nn.Push_data)		
			begin
				data.Mreq=1;				
				if(c1<8)
					begin
					data.Maddr=c0;			
					data.Mwrite=16'h3<<c1*2;
					data.Min=nn.Din<<c1*64;		
					c1_1=c1+1;
					if(c1_1==8)			
					begin
						c1_1=0;			
						c0_1=c0+1;		
					end
					end
			end
		if(nn.Push_weight)	
				begin
					weight.Mreq=1;			
					if(c2<8)
					begin			
					weight.Maddr=c3;		
					weight.Mwrite=16'h3<<c2*2;	
					weight.Min=nn.Din<<c2*64;	
					c2_1=c2+1;
					if(c2_1==8) 			
					begin
						c2_1=0;		
						c3_1=c3+1;		
					end
					end
				end
	case(ps)
	s0:begin	
		ns=(nn.Start_calc)?s1:s0;		
	end
	s1:
	begin
		weight.Mreq=1;
		weight.Mwrite=0;		
		weight.Maddr=0;	
		ns=s2;
	end
	s2:
	begin
		weight.Mreq=1;
		weight.Maddr=0;
		ns=s3;
	end
	s3:
	begin
		weight.Mreq=1;
		cmdm_d=weight.Mout;		
		ns=s4;
	end
	s4:
	begin
		weight_location=cmdm.weight_location;
		data_location=cmdm.data_location;
		result_location=cmdm.result_location;
		neuron_index=cmdm.neuron_index;
		input_width=cmdm.input_width;
		output_width=cmdm.output_width;
		neuron_scaling=cmdm.neuron_scaling;
		final_layer=cmdm.final_layer;
		ns=s5;
	end
	s5:					 
	begin	
		nn.Calculation_busy=1;
		nn.Empty=1;		
		data.Mwrite=0;
		data.Mreq=1;
		dcount_1=cmdm.data_location;
		weight.Mwrite=0;
		weight.Mreq=1;
		wcount_1=cmdm.weight_location;
		ns=s6;
	end
	s6:					
	begin
		weight.Mreq=1;
		data.Maddr=dcount;
		weight.Maddr=wcount;
		d512=data.Mout;
		if(w_1<2)
			w_1=w+1;
		else
		begin
			w_1 = 0;
			w512_d=weight.Mout;
			ns=s7;
		end	
	end
	s7:
	begin
		sum_1d=mul0+mul1+mul2+mul3;
		sum_2d=mul4+mul5+mul6+mul7;
		sum_3d=mul8+mul9+mul10+mul11;
		sum_4d=mul12+mul13+mul14+mul15;
		ns=s8;
	end
	s8:					
	begin
		sum_d=sum_1+sum_2+sum_3+sum_4;
		if((sum[75:52]==24'hFFFFFF)||(sum[75:52]==24'h000000))
			sum_sd=sum;
		else if(sum[75])
			begin
				sum_sd=-76'h000000f_f7ffffffffff;
			end
		else if (!sum[75])
			begin
				sum_sd=76'h000000f_f80000000000;
			end
		else
			sum_sd=sum;
		
		neuronix_d=(sum_s>>43)&'h3ff;
            	neuronoffset_d=neuronix>>2;
            	neuronbase_d=(neuronix&32'h3)<<2;
		neuronbase_1_d=neuronbase;
		neuronbase_2_d=neuronbase_1;
		neuronbase_3_d=neuronbase_2;
           	neuronaddr_d=cmdm.neuron_index+neuronoffset;
		weight.Maddr=neuronaddr;
		weight.Mwrite=0;
		weight.Mreq=1;
		ow_d=ow+1;
		ow_1_d =ow;
		ow_2_d=ow_1;
		ow_3_d=ow_2;
		ow_4_d=ow_3;
		ow_5_d=ow_4;
		ow_6_d=ow_5;
		ow_7_d=ow_6;
		ow_8_d=ow_7;
		ow_9_d=ow_8;
		ow_10_d=ow_9;
		ow_11_d=ow_10;
		ns=s9;
	end	
	s9:
	begin
		ow_12_d=ow_11;
		weight.Mreq=1;
		f=sum_s[42:17];
		f_final_1={6'b000000,f};
		f_final_2_d=f_final;
		f_final_3_d=f_final_2;
		f_final_4_d=f_final_3;
		f_final_5_d=f_final_4;
		f_final_6_d=f_final_5;
		f_2=f_21>>31;
		f_23_d=f_22;
		f_24_d=f_23;
		f_25_d=f_24;
		f_26_d=f_25;
		f_31_1=f_3>>31;
		f_32_d=f_31;
		f_33_d=f_32;
		f_34_d=f_33;
		coef_d=weight.Mout;
		co0_d=coef[neuronbase_3+3];
            	co1_d=coef[neuronbase_3+2];
            	co2_d=coef[neuronbase_3+1];
            	co3_d=coef[neuronbase_3+0];
		co01_d=co0;
		co02_d=co01;
		c1x132_d=cx1>>31;
		c2x232_d=cx2>>31;
		c3x332_d=cx3>>31;
		sigsum_d=co01+c1x132+c2x232+c3x332;
		sigsum_f_d=sigsum>>>6;
		ns=s10;
	end
	s10:
	begin
	if(ow_12==cmdm.output_width)
		begin
			ns=s11;
		end
		else
		begin
			data.Mreq=1;
			data.Maddr=cmdm.result_location;
			data.Mwrite=16'h1<<ow_12;
			data.Min=sigsum_f<<ow_12*32;
			wcount_1=wcount+1;
			ns=s6;
		end
	end
	s11:
	begin
		nn.Calculation_busy=1;
		nn.Empty=1;		
		data.Mreq=1;
		data.Maddr=cmdm.result_location;
		data.Mwrite=0;
		ns=s12;		
	end
	s12:
	begin
		data.Mreq=1;
		nn.Calculation_complete=1;
		nn.Calculation_busy=0;
		nn.Empty=0;
		data.Maddr=cmdm.result_location;
		sumsig=data.Mout;
		if(nn.Pull)
		begin
			if(pull_count==(cmdm.output_width)/2)
			begin
				nn.Calculation_busy=1;
				nn.Empty=1;
			end
			else
			begin
			nn.Dout=sumsig[pull_count];
			pull_count_d=pull_count+1;
			end
		end
		else
		begin
			nn.Calculation_busy=1;
			nn.Empty=1;
		end
	end								
	endcase																
end
endmodule