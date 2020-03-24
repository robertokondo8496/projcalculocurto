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
        aux=-(1/(j*x1(line)));
        Y(k1,k2)=Y(k1,k2)+aux;
        Y(k1,k1)=Y(k1,k1)-aux+j*bl(line)/2;
        Y(k2,k2)=Y(k2,k2)-aux+j*bl(line)/2;
        Y(k2,k1)=Y(k2,k1)+aux;
     end
      

     for i=1:ng
     aux=1/(j*xg1(i));
     Y(ig(i),ig(i))=Y(ig(i),ig(i))+aux;
     end
     
      for i=1:nb,
      Y(i,i)=Y(i,i)+j*bc(i);
      end
          
Y1=Y;     
Z1=inv(Y1);
Y2=Y;  
Z2=Z1;

%Matriz Yo
Y0=sparse(nb,nb);
     for line=1:nl
        k1=de(line);
        k2=para(line);
        aux=-(1/(j*x0(line)));
        Y0(k1,k2)=Y0(k1,k2)+aux;
        Y0(k1,k1)=Y0(k1,k1)-aux+j*bl(line)/2;
        Y0(k2,k2)=Y0(k2,k2)-aux+j*bl(line)/2;
        Y0(k2,k1)=Y0(k2,k1)+aux;
     end
        
     %Gerador 1: em Yaterrada
     XGo=xg0+3*xn;     
     for i=1:ng
     aux=1/(j*XGo(i));
     Y0(ig(i),ig(i))=Y0(ig(i),ig(i))+aux;
     end
     
     % Capacitores
     for i=1:nb,
     Y0(i,i)=Y0(i,i)+j*bc(i);
     end
       
     % Transformadores  com delta
         Y0(6,10)=0;
         Y0(10,6)=0;
         Y0(10,10)= Y0(10,10)- (1/(j*x0(13)));
         
           
    
Z0=inv(Y);

