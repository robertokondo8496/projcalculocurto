function[valorpolar] = convcartpol(A)

x = real(A);
y = imag(A);


angulo = atan2(y,x);
angulo = angulo * 180/3.14;
modulo = hypot(x,y);

    
valorpolar  =  zeros(1,2);
valorpolar(1,1) = modulo;
valorpolar(1,2) = angulo;
