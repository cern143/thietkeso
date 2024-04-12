module Filter_block_1
#(
    parameter n = 63,
    parameter signed [0:16*n-1] coef = 
    {
    16'b1111111111111111,
    16'b1111111111111111,
    16'b1111111111111111,
    16'b1111111111111110,
    16'b1111111111111110,
    16'b1111111111111110,
    16'b1111111111111111,
    16'b0000000000000000,
    16'b0000000000000001,
    16'b0000000000000010,
    16'b0000000000000100,
    16'b0000000000000101,
    16'b0000000000000101,
    16'b0000000000000101,
    16'b0000000000000011,
    16'b1111111111111111,
    16'b1111111111111011,
    16'b1111111111110110,
    16'b1111111111110001,
    16'b1111111111101101,
    16'b1111111111101100,
    16'b1111111111101110,
    16'b1111111111110100,
    16'b0000000000000000,
    16'b0000000000001111,
    16'b0000000000100010,
    16'b0000000000110111,
    16'b0000000001001100,
    16'b0000000001100000,
    16'b0000000001101111,
    16'b0000000001111001,
    16'b0000000001111101,
    16'b0000000001111001,
    16'b0000000001101111,
    16'b0000000001100000,
    16'b0000000001001100,
    16'b0000000000110111,
    16'b0000000000100010,
    16'b0000000000001111,
    16'b0000000000000000,
    16'b1111111111110100,
    16'b1111111111101110,
    16'b1111111111101100,
    16'b1111111111101101,
    16'b1111111111110001,
    16'b1111111111110110,
    16'b1111111111111011,
    16'b1111111111111111,
    16'b0000000000000011,
    16'b0000000000000101,
    16'b0000000000000101,
    16'b0000000000000101,
    16'b0000000000000100,
    16'b0000000000000010,
    16'b0000000000000001,
    16'b0000000000000000,
    16'b1111111111111111,
    16'b1111111111111110,
    16'b1111111111111110,
    16'b1111111111111110,
    16'b1111111111111111,
    16'b1111111111111111,
    16'b1111111111111111
    }
)

(
    input clk, 
    input rst_n,
    input ena, 
    input signed [0:15] x_in,
    output reg signed [0:31] y_out
);  
    wire signed [0:32*n-1] acc_tmp;
    reg [0:31] y_tmp;
    reg signed [0:32*n-1] acc;
    reg signed [0:16*n-1] delay_x;
    integer i, j, k, test;
    //reg signed [15:0] sum;
    
    //for(l=0; l<n; l=l+1) begin
    //    coef_cov[16*k +: 16] = (coef[16*l] == 1'b1) ? {8'b11111111, coef[16*l +: 16]} : {8'b00000000, coef[16*l +: 16]};
    //end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            for(i=0; i<n; i=i+1) begin
                delay_x[16*i +: 16] <= 0;
            end
        end
        else begin
            if(ena) begin
                delay_x[0:15] <= x_in;
                for(i=1; i<n; i=i+1) begin
                    delay_x[16*i+: 16] <= delay_x[16*(i-1) +: 16];
                end
            end
            else begin
                for(i=0; i<n; i=i+1) begin
                    delay_x[16*i +: 16] <= delay_x[16*i +: 16];
                end
            end
            
        end
    end
    multiply mul_1(.delay_x(delay_x[0:15]), .coef(coef[0:15]), .acc(acc_tmp[0:31]));     
    multiply mul_2(.delay_x(delay_x[16:31]), .coef(coef[16:31]), .acc(acc_tmp[32:63]));  
    multiply mul_3(.delay_x(delay_x[32:47]), .coef(coef[32:47]), .acc(acc_tmp[64:95]));  
    multiply mul_4(.delay_x(delay_x[48:63]), .coef(coef[48:63]), .acc(acc_tmp[96:127])); 
    multiply mul_5(.delay_x(delay_x[64:79]), .coef(coef[64:79]), .acc(acc_tmp[128:159]));
    multiply mul_6(.delay_x(delay_x[80:95]), .coef(coef[80:95]), .acc(acc_tmp[160:191]));
    multiply mul_7(.delay_x(delay_x[96:111]), .coef(coef[96:111]), .acc(acc_tmp[192:223]));
    multiply mul_8(.delay_x(delay_x[112:127]), .coef(coef[112:127]), .acc(acc_tmp[224:255]));
    multiply mul_9(.delay_x(delay_x[128:143]), .coef(coef[128:143]), .acc(acc_tmp[256:287]));
    multiply mul_10(.delay_x(delay_x[144:159]), .coef(coef[144:159]), .acc(acc_tmp[288:319]));
    multiply mul_11(.delay_x(delay_x[160:175]), .coef(coef[160:175]), .acc(acc_tmp[320:351]));
    multiply mul_12(.delay_x(delay_x[176:191]), .coef(coef[176:191]), .acc(acc_tmp[352:383]));
    multiply mul_13(.delay_x(delay_x[192:207]), .coef(coef[192:207]), .acc(acc_tmp[384:415]));
    multiply mul_14(.delay_x(delay_x[208:223]), .coef(coef[208:223]), .acc(acc_tmp[416:447]));
    multiply mul_15(.delay_x(delay_x[224:239]), .coef(coef[224:239]), .acc(acc_tmp[448:479]));
    multiply mul_16(.delay_x(delay_x[240:255]), .coef(coef[240:255]), .acc(acc_tmp[480:511]));
    multiply mul_17(.delay_x(delay_x[256:271]), .coef(coef[256:271]), .acc(acc_tmp[512:543]));
    multiply mul_18(.delay_x(delay_x[272:287]), .coef(coef[272:287]), .acc(acc_tmp[544:575]));
    multiply mul_19(.delay_x(delay_x[288:303]), .coef(coef[288:303]), .acc(acc_tmp[576:607]));
    multiply mul_20(.delay_x(delay_x[304:319]), .coef(coef[304:319]), .acc(acc_tmp[608:639]));
    multiply mul_21(.delay_x(delay_x[320:335]), .coef(coef[320:335]), .acc(acc_tmp[640:671]));
    multiply mul_22(.delay_x(delay_x[336:351]), .coef(coef[336:351]), .acc(acc_tmp[672:703]));
    multiply mul_23(.delay_x(delay_x[352:367]), .coef(coef[352:367]), .acc(acc_tmp[704:735]));
    multiply mul_24(.delay_x(delay_x[368:383]), .coef(coef[368:383]), .acc(acc_tmp[736:767]));
    multiply mul_25(.delay_x(delay_x[384:399]), .coef(coef[384:399]), .acc(acc_tmp[768:799]));
    multiply mul_26(.delay_x(delay_x[400:415]), .coef(coef[400:415]), .acc(acc_tmp[800:831]));
    multiply mul_27(.delay_x(delay_x[416:431]), .coef(coef[416:431]), .acc(acc_tmp[832:863]));
    multiply mul_28(.delay_x(delay_x[432:447]), .coef(coef[432:447]), .acc(acc_tmp[864:895]));
    multiply mul_29(.delay_x(delay_x[448:463]), .coef(coef[448:463]), .acc(acc_tmp[896:927]));
    multiply mul_30(.delay_x(delay_x[464:479]), .coef(coef[464:479]), .acc(acc_tmp[928:959]));
    multiply mul_31(.delay_x(delay_x[480:495]), .coef(coef[480:495]), .acc(acc_tmp[960:991]));
    multiply mul_32(.delay_x(delay_x[496:511]), .coef(coef[496:511]), .acc(acc_tmp[992:1023]));
    multiply mul_33(.delay_x(delay_x[512:527]), .coef(coef[512:527]), .acc(acc_tmp[1024:1055]));
    multiply mul_34(.delay_x(delay_x[528:543]), .coef(coef[528:543]), .acc(acc_tmp[1056:1087]));
    multiply mul_35(.delay_x(delay_x[544:559]), .coef(coef[544:559]), .acc(acc_tmp[1088:1119]));
    multiply mul_36(.delay_x(delay_x[560:575]), .coef(coef[560:575]), .acc(acc_tmp[1120:1151]));
    multiply mul_37(.delay_x(delay_x[576:591]), .coef(coef[576:591]), .acc(acc_tmp[1152:1183]));
    multiply mul_38(.delay_x(delay_x[592:607]), .coef(coef[592:607]), .acc(acc_tmp[1184:1215]));
    multiply mul_39(.delay_x(delay_x[608:623]), .coef(coef[608:623]), .acc(acc_tmp[1216:1247]));
    multiply mul_40(.delay_x(delay_x[624:639]), .coef(coef[624:639]), .acc(acc_tmp[1248:1279]));
    multiply mul_41(.delay_x(delay_x[640:655]), .coef(coef[640:655]), .acc(acc_tmp[1280:1311]));
    multiply mul_42(.delay_x(delay_x[656:671]), .coef(coef[656:671]), .acc(acc_tmp[1312:1343]));
    multiply mul_43(.delay_x(delay_x[672:687]), .coef(coef[672:687]), .acc(acc_tmp[1344:1375]));
    multiply mul_44(.delay_x(delay_x[688:703]), .coef(coef[688:703]), .acc(acc_tmp[1376:1407]));
    multiply mul_45(.delay_x(delay_x[704:719]), .coef(coef[704:719]), .acc(acc_tmp[1408:1439]));
    multiply mul_46(.delay_x(delay_x[720:735]), .coef(coef[720:735]), .acc(acc_tmp[1440:1471]));
    multiply mul_47(.delay_x(delay_x[736:751]), .coef(coef[736:751]), .acc(acc_tmp[1472:1503]));
    multiply mul_48(.delay_x(delay_x[752:767]), .coef(coef[752:767]), .acc(acc_tmp[1504:1535]));
    multiply mul_49(.delay_x(delay_x[768:783]), .coef(coef[768:783]), .acc(acc_tmp[1536:1567]));
    multiply mul_50(.delay_x(delay_x[784:799]), .coef(coef[784:799]), .acc(acc_tmp[1568:1599]));
    multiply mul_51(.delay_x(delay_x[800:815]), .coef(coef[800:815]), .acc(acc_tmp[1600:1631]));
    multiply mul_52(.delay_x(delay_x[816:831]), .coef(coef[816:831]), .acc(acc_tmp[1632:1663]));
    multiply mul_53(.delay_x(delay_x[832:847]), .coef(coef[832:847]), .acc(acc_tmp[1664:1695]));
    multiply mul_54(.delay_x(delay_x[848:863]), .coef(coef[848:863]), .acc(acc_tmp[1696:1727]));
    multiply mul_55(.delay_x(delay_x[864:879]), .coef(coef[864:879]), .acc(acc_tmp[1728:1759]));
    multiply mul_56(.delay_x(delay_x[880:895]), .coef(coef[880:895]), .acc(acc_tmp[1760:1791]));
    multiply mul_57(.delay_x(delay_x[896:911]), .coef(coef[896:911]), .acc(acc_tmp[1792:1823]));
    multiply mul_58(.delay_x(delay_x[912:927]), .coef(coef[912:927]), .acc(acc_tmp[1824:1855]));
    multiply mul_59(.delay_x(delay_x[928:943]), .coef(coef[928:943]), .acc(acc_tmp[1856:1887]));
    multiply mul_60(.delay_x(delay_x[944:959]), .coef(coef[944:959]), .acc(acc_tmp[1888:1919]));
    multiply mul_61(.delay_x(delay_x[960:975]), .coef(coef[960:975]), .acc(acc_tmp[1920:1951]));
    multiply mul_62(.delay_x(delay_x[976:991]), .coef(coef[976:991]), .acc(acc_tmp[1952:1983]));
    multiply mul_63(.delay_x(delay_x[992:1007]), .coef(coef[992:1007]), .acc(acc_tmp[1984:2015]));
    always @(posedge clk) begin
        if(ena) begin
            for(j=0; j<n; j=j+1) begin
                acc[32*j +: 32] <= acc_tmp[32*j +: 32];
                $display("j = %d, acc = %d, delay_x = %d, coef = %d", j, $signed(acc_tmp[32*j+: 32]), $signed(delay_x[16*j +: 16]), $signed(coef[16*j +: 16]));
            end
        end
        else begin
            for(j=0; j<n; j=j+1) begin
                acc[32*j +: 32] <= acc[32*j +: 32];
            end
        end
    end
    
    always @(posedge clk) begin
        if(ena)
            y_out <= acc_tmp[0:31] + acc_tmp[32:63] + acc_tmp[64:95] + acc_tmp[96:127] + acc_tmp[128:159] + acc_tmp[160:191] + acc_tmp[192:223] + acc_tmp[224:255] + acc_tmp[256:287] + acc_tmp[288:319] + acc_tmp[320:351] + acc_tmp[352:383] + acc_tmp[384:415] + acc_tmp[416:447] + acc_tmp[448:479] + acc_tmp[480:511] + acc_tmp[512:543] + acc_tmp[544:575] + acc_tmp[576:607] + acc_tmp[608:639] + acc_tmp[640:671] + acc_tmp[672:703] + acc_tmp[704:735] + acc_tmp[736:767] + acc_tmp[768:799] + acc_tmp[800:831] + acc_tmp[832:863] + acc_tmp[864:895] + acc_tmp[896:927] + acc_tmp[928:959] + acc_tmp[960:991] + acc_tmp[992:1023] + acc_tmp[1024:1055] + acc_tmp[1056:1087] + acc_tmp[1088:1119] + acc_tmp[1120:1151] + acc_tmp[1152:1183] + acc_tmp[1184:1215] + acc_tmp[1216:1247] + acc_tmp[1248:1279] + acc_tmp[1280:1311] + acc_tmp[1312:1343] + acc_tmp[1344:1375] + acc_tmp[1376:1407] + acc_tmp[1408:1439] + acc_tmp[1440:1471] + acc_tmp[1472:1503] + acc_tmp[1504:1535] + acc_tmp[1536:1567] + acc_tmp[1568:1599] + acc_tmp[1600:1631] + acc_tmp[1632:1663] + acc_tmp[1664:1695] + acc_tmp[1696:1727] + acc_tmp[1728:1759] + acc_tmp[1760:1791] + acc_tmp[1792:1823] + acc_tmp[1824:1855] + acc_tmp[1856:1887] + acc_tmp[1888:1919] + acc_tmp[1920:1951] + acc_tmp[1952:1983] + acc_tmp[1984:2015];
            //y_out <=
        else 
            y_out <= y_out; 
    end

    // always @(acc) begin
    //     for(test = 0; test < 63; test = test + 1) begin
    //         $display("acc_%d = %d_%b", test, acc[32*test:32*(test+1)-1]);
    //     end
    // end
endmodule