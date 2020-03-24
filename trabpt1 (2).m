%***** Cálculo de Curto-Circuito Subtransitório a 1/3 da barra 4 *****
%*********************************************************************
%*****  Roberto Kondo, Victor S. Sismotto ****************************
%*********************************************************************

linhas = 4; %transformador foi contabilizado nas linhas
barras = 5; % são 4 barras + 1 devido à análise ser a 1/3 da barra 11
de = [1 2 3 5]';
para = [2 3 5 4]';

% impedâncias das linhas

r1 = [0.007762      0           2/3*0.002866    1/3*0.002866]';
x1 = [0.005499      0.05893     2/3*0.000987    1/3*0.000987]';
r2 = [0.007762      0           2/3*0.002866    1/3*0.002866]';
x2 = [0.005499      0.05893     2/3*0.000987    1/3*0.000987]';
r0 = [0.000016313   0           2/3*0.019071    1/3*0.019071]';
x0 = [0.0001193     0.0875      2/3*0.02312     1/3*0.02312]';

% gerador - curto subtransitório

xg1 = 0.1204;
xg2 = 0.1423;
xg0 = 0.0875;

% su

rsu1 = 0.0000737;
xsu1 = 0.00712;
rsu2 = 0.0000737;
xsu2 = 0.00712;
rsu0 = 0.000016;
xsu0 = 0.00012;

% montagem da matriz Y

% seq. positiva

Y = sparse(barras,barras);

for linha=1:linhas %linha 1 é 1-2, linha 2 é 2-3, linha 3 é 3-5 e linha 4 é 5-4.
        a1 = de(linha);
        a2 = para(linha);
        % esse algoritmo vai montar os elementos Y11, Y12, Y21, Y22, Y33, Y35, Y53, Y55, Y44, Y45 e
        % Y54. a1 assume os valores 1,3,5 e a2 2,5,4.
        
        Y(a1,a1) = Y(a1,a1)+1/(r1(linha)+1j*x1(linha));
        Y(a1,a2) = Y(a1,a2)-1/(r1(linha)+1j*x1(linha));
        Y(a2,a1) = Y(a2,a1)-1/(r1(linha)+1j*x1(linha));
        Y(a2,a2) = Y(a2,a2)+1/(r1(linha)+1j*x1(linha));

end
    Y(1,1) = Y(1,1)+1/(rsu1+1j*xsu1);
    Y(5,5) = Y(5,5)+1/(1j*xg1); 
        Y1 = Y;
        Z1 = inv(Y1);
      
        
% seq. negativa

linhas = 4; %transformador foi contabilizado nas linhas
barras = 5; % são 4 barras + 1 devido à análise ser a 1/3 da barra 11


Y = sparse(barras,barras);

for linha=1:linhas
        a1 = de(linha);
        a2 = para(linha);
 
        Y(a1,a1) = Y(a1,a1)+1/(r2(linha)+1j*x2(linha));
        Y(a1,a2) = Y(a1,a2)-1/(r2(linha)+1j*x2(linha));
        Y(a2,a1) = Y(a2,a1)-1/(r2(linha)+1j*x2(linha));
        Y(a2,a2) = Y(a2,a2)+1/(r2(linha)+1j*x2(linha));

end
        Y(1,1) = Y(1,1)+1/(rsu1+1j*xsu2);
        Y(5,5) = Y(5,5)+1/(1j*xg2); 
        Y2 = Y;
        Z2 = inv(Y2);
        
% seq. zero

linhas = 4; %transformador foi contabilizado nas linhas
barras = 5; % são 4 barras + 1 devido à análise ser a 1/3 da barra 11

Y = sparse(barras,barras);

 
for linha=1:linhas
        a1 = de(linha);
        a2 = para(linha);
        
        if (a1==2) && (a2==3)
        Y(a1,a1) = Y(a1,a1);
        Y(a1,a2) = 0 + 1j*0;
        Y(a2,a1) = 0 + 1j*0;
        Y(a2,a2) = Y(a2,a2)+1/(r0(linha)+1j*x0(linha));
        end
        if (a1~=2) && (a2~=3)
        Y(a1,a1) = Y(a1,a1)+1/(r0(linha)+1j*x0(linha));
        Y(a1,a2) = Y(a1,a2)-1/(r0(linha)+1j*x0(linha));
        Y(a2,a1) = Y(a2,a1)-1/(r0(linha)+1j*x0(linha));
        Y(a2,a2) = Y(a2,a2)+1/(r0(linha)+1j*x0(linha));
        end
end
        Y(1,1) = Y(1,1)+1/(rsu1+1j*xsu2);
        Y(5,5) = Y(5,5)+1/(1j*xg2); 
        Y0 = Y
        Z0 = inv(Y0);
        