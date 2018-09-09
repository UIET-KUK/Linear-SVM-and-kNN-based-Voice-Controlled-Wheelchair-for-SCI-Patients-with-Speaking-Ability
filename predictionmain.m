clc;
Fs=8000;
Time = 0.5;
nBits = 8;
spd=0;
dcr=0;
dcl=0;
clear a;
a = arduino();
recObj = audiorecorder(Fs, nBits, 1);
fprintf('Programme is Running....\n speak following cammand to control Wheelchair.\n');
fprintf('\n');
fprintf('Run, Stop, Back, Left,Right, Fast, Slow\n');
while(1)
	pause(0.1);
    ir1=readDigitalPin(a, 'D7');
    if ir1==1 
    writePWMDutyCycle(a,'D6',0);
    writePWMDutyCycle(a,'D4',0);
    pause(1);
    else   
    recordblocking(recObj, Time);
    x2 = getaudiodata(recObj);
    [b1,a1]=fir1(52,[400 3500]/(Fs/2), 'bandpass');
    s3=filter(b1,a1,x2);
    x23=max(s3(200:end,1));
        if(x23<0.05)   
        else
        x1=x2;
%       sound(x1,Fs);
        [daa,sr1]   = featuremfcc(x2,Fs);
        sound(sr1,Fs);
        [~,sd1]=size(daa);
        X = daa';
            if (sd1<6)
            else
            yfit = knncl.predictFcn(X);
            val1 = sum(yfit == 1);
            val2 = sum(yfit == 2);
            val3 = sum(yfit == 3);    
            val4 = sum(yfit == 4);
            val5 = sum(yfit == 5);
            val6 = sum(yfit == 6);
            val7 = sum(yfit == 7);
            tr=[0,val1,val2,val3,val4,val5,val6,val7];
            [rb,cb] = max(tr);
                if (cb==2) 
                fprintf('Run');
                spd=0.20;
                dcr = spd;
                dcl = spd;
                dirr =1;
                dirl =0;
                	elseif (cb==3)
                	fprintf('Stop');
                	writePWMDutyCycle(a,'D6',0);
                	writePWMDutyCycle(a,'D4',0);
        		dcr = 0;
            		dcl = 0;
               		elseif (cb==4)
    			fprintf('back');
        		dcr = 0.20;
            		dcl = 0.20;
               		dirr = 0;
    			dirl = 1;
        		elseif (cb==5)
            		fprintf('left');
                	dcr = 0.20;
    			dcl = 0;
        		dirr =1;
            		dirl =0;
                	elseif (cb==6)
    			fprintf('Right');
        		dcr = 0;
            		dcl = 0.20;
                	dirr =0;
    			dirl =0;
        		elseif (cb==7)
            		fprintf('Fast');
                   		if (spd<0.71) 
            			spd=spd+0.10; %Incresing duty cycle by 10%.
                    		dcr = spd;
        			dcl = spd;
                    		end
            		elseif (cb==8)
                	fprintf('Slow');
                       		if (spd>0.21)
                        	spd=spd-0.10; %decresing duty cycle by 10%.
                        	dcr = spd;
                        	dcl = spd;     
                        	end
                end
            writePWMDutyCycle(a,'D6',dcr);
            writePWMDutyCycle(a,'D4',dcl);
            writeDigitalPin(a, 'D5', dirr);
            writeDigitalPin(a, 'D3', dirl);
            fprintf('\n')
            end
        end
    end
end
