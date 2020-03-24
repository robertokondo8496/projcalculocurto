function [ saida ] = pu_tensao( entrada, tipo )

VbaseAlta = 23100/1.73;
VbaseBaixa = 380/1.73;

if tipo == 1 % alta
    saida = VbaseAlta * entrada;
end
if tipo == 0 % baixa
    saida = VbaseBaixa * entrada;
end
    
    
end