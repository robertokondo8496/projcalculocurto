nl=20;
nb=16;
de= [16 15 10 1 3  9 2 2  3  3  3 4 4 5 6 7 10 11 12 12]';
para=[6  4  8 2 14 8 3 3 12 15 15 5 5 6 7 8 11 12 13 13]';
r1=[0         0        0         0        0        0   0.0045 0.0045 0.0024 0.0079 0.0079 0.0069 0.0069 0.005 0.006 0.0047 0.0034 0.0039 0.0022 0.0022]';
x1=[0.016667  0.0670   0.100         0.015    0.0833   0.1250  0.0496 0.0496 0.0264 0.0838 0.0838 0.0737 0.0737 0.0536 0.0637 0.0503 0.0372 0.0434 0.0248 0.0248]';
r0=[0         0        0         0        0        0   0.02640 0.02640 0.02400 0.077 0.077 0.07790 0.07790 0.05530 0.05030 0.0248 0.0360 0.0230 0.024 0.024]';
x0=[0.014333  0.0514   0.0926         0.01365 0.0756   0.1117  0.20960 0.2096 0.07770 0.30730 0.30730 0.30050 0.30050 0.15190 0.18090 0.12900 0.1400 0.18270 0.0777 0.0777]';
bl=[0         0        0         0        0        0   0.424 0.424 0.22525 0.15315 0.15315 0.13475 0.13475 0.09800 0.11640 0.0910 0.31800 0.37100 0.21200 0.21200]';
ng=3;
ig=[1 16 9]';
xg1=[0.2 0.0933 0.25]';
xg0=[0.20 0.0933 0.25]';
nc=1;
bc=[0.2];
ic=[10];
nr=3;
br=[0.9 0.3 0.3]'; 
ir=[3 11 13]';
xn=0; % Não é conhecido o valor da impedância de aterramento
%Matrizes de Incidência
if nl >= nb
aux=eye(nb,nl);
Af=sparse(aux(:,de));
Afo=sparse(aux(:,para));
else
   Af=sparse(nb,nl);
  	Afo=sparse(nb,nl);
		for line=[1:nl];
   	k1=de(line);
		k2=para(line);
      Af(k1,line)=1;
      Afo(k2,line)=1;
      end
end

biv=(1:nb)';
liv=(1:nl)';

%Matriz Y1 e Y2
Y=sparse(nb,nb);
     for line=1:nl
        k1=de(line);
        k2=para(line);
        aux=-(1/(r1(line)+(j*x1(line))));
        Y(k1,k2)=Y(k1,k2)+aux;
        Y(k1,k1)=Y(k1,k1)-aux+j*bl(line);
        Y(k2,k2)=Y(k2,k2)-aux+j*bl(line);
        Y(k2,k1)=Y(k2,k1)+aux;
     end
      

     for i=1:ng
     aux=1/(j*xg1(i));
     Y(ig(i),ig(i))=Y(ig(i),ig(i))+aux;
     end
     
     % Capacitores
      for i=1:nc
      Y(ic(i),ic(i))=Y(ic(i),ic(i))+j*bc(i);
      end
       
     % Reatores
     for i=1:nr
     Y(ir(i),ir(i))=Y(ir(i),ir(i))-j*br(i);
     end
   

Y1=Y;    
Z1=inv(Y1)
Z2=Z1


% Matriz Yo
Y=sparse(nb,nb);
     for line=1:nl
        k1=de(line);
        k2=para(line);
        aux=-(1/(r0(line)+(j*x0(line))));
        Y(k1,k2)=Y(k1,k2)+aux;
        Y(k1,k1)=Y(k1,k1)-aux+j*bl(line);
        Y(k2,k2)=Y(k2,k2)-aux+j*bl(line);
        Y(k2,k1)=Y(k2,k1)+aux;
     end
         
    % Gerador 1: em Yaterrada
     XGo=xg0+3*xn;
     
     for i=1:ng
     aux=1/(j*XGo(i));
     Y(ig(i),ig(i))=Y(ig(i),ig(i))+aux;
     end
     
   
%      Capacitores
      for i=1:nc
      Y(ic(i),ic(i))=Y(ic(i),ic(i))+j*bc(i);
      end
       
%      Reatores
     for i=1:nr
     Y(ir(i),ir(i))=Y(ir(i),ir(i))-j*br(i);
     end
     
 % Transformador OP
         %Trafo 1 -2 
         Y(1,1)=Y(1,1)-(1/(j*x0(4)));
         Y(1,2)=Y(1,2)+(1/(j*x0(4)));
         Y(2,1)=Y(1,2);
         
          %Trafo 9 -8 
         Y(9,9)=Y(9,9)-(1/(j*x0(6)));
         Y(9,8)=Y(9,8)+(1/(j*x0(6)));
         Y(8,9)=Y(9,8);
         
        %Trafo 16 -6 
         Y(16,16)=Y(16,16)-(1/(j*x0(1)));
         Y(16,6)=Y(16,6)+(1/(j*x0(1)));
         Y(6,16)=Y(16,6);
        
Y0=Y;     
Z0=inv(Y);


