
module mixed_column (
 input [0:127] data,
    output wire [0:127] result
);
function [7:0]product;
input [7:0] a;
reg [7:0]temp;
reg [7:0] temp2;
integer i;
begin
for(i=7;i>0;i=i-1)begin
temp[i]=a[i-1];
end
temp[0]=0;
if(a[7]== 1'b1)begin
temp2 = 8'b00011011;
product=temp^temp2;
end
else
begin 
product=temp;
end
end
endfunction

reg [0:127] state;
integer c;
integer r;
 initial begin
        r = 0;
        c = 0;
end
always @(data) begin
for(c=0;c<4;c=c+1)begin
for(r=0;r<4;r=r+1) begin
state[(32*c)+(8*r)+:8]=product(data[(32*c)+8*((r)%4)+:8])^(product(data[(32*c)+((r+1)%4)*8+:8])^data[(32*c)+((r+1)%4)*8+:8])^data[(32*c)+((r+2)%4)*8+:8]^data[(32*c)+((r+3)%4)*8+:8];
end
end

end
assign result= state;
endmodule



 