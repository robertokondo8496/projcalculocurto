function mpc = case16
%CASE9    Power flow data for 16 bus, 3 generator case.
%   Please see CASEFORMAT for details on the case file format.
%
%   Based on data from Joe H. Chow's book, p. 70.

%   MATPOWER
%   $Id: case9.m 2408 2014-10-22 20:41:33Z ray $

%% MATPOWER Case Format : Version 2
mpc.version = '2';

%%-----  Power Flow Data  -----%%
%% system MVA base
mpc.baseMVA = 100;


%% bus data
%	bus_i	type	Pd	Qd	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
mpc.bus = [
	1	2	0  0  0 0   1 0.1  0 138  1 1.05 0.95;
	2	1	0  0  0 0   1 1    0 345  1 1.08 0.95;
	3   1	28 16 0 50  1 1    0 345  1 1.08 0.95;
	4   1	54 39 0 0   2 1    0 230  1 1.07 0.95;
	5   1	20 11 0 0   2 1    0 230  1 1.07 0.95;
	6   1	12 7  0 0   2 1    0 230  1 1.07 0.95;
	7   1	8  8  0 0   2 1    0 230  1 1.07 0.95;
	8   1	28 13 0 0   2 1    0 230  1 1.07 0.95;
	9   2	0  0  0 0   2 0.1  0 138  1 1.05 0.95;
    10  1  86 17 0 20  1 1    0 345  1 1.08 0.95;
    11  1  25 16 0 30  1 1    0 345  1 1.08 0.95;
    12  1  20 15 0 0   1 1    0 345  1 1.08 0.95;
    13  1  58 31 0 30  1 1    0 345  1 1.08 0.95;
    14  1  35 19 0 0   1 1    0 138  1 1.05 0.95;
    15  1  0  0  0 0   1 1    0 345  1 1.08 0.95;
    16  3  0  0  0 0   2 0.1  0 138  1 1.05 0.95; 
];

%% generator data
%	bus	Pg	Qg	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
mpc.gen = [
	1	 134 0 120 -120 1.02 100 1 380 0;
	9  0   0 70  -50  1.01 100 1 0   0;
    16 0   0 180 -180 1.01 100 1 378 0; 
  16 0   0 180 -180 1.01 100 1 378 0;
  16 0   0 180 -180 1.01 100 1 378 0;
];

%% branch data
%	fbus	tbus	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax

mpc.branch = [
	2  3  0.45 4.96 8.48  999 999 999  1 0 1 0 0;
  2  3  0.45 4.96 8.48  999 999 999  1 0 1 0 0;
  3  12 0.24 2.64 4.50  999 999 999  1 0 1 0 0;
  3  15 0.79 8.38 0.306 999 999 999  1 0 1 0 0;
  3  15 0.79 8.38 0.306 999 999 999  1 0 1 0 0;
  4  5  0.69 7.37 2.7   999 999 999  1 0 1 0 0;
  4  5  0.69 7.37 2.7   999 999 999  1 0 1 0 0;
  5  6  0.50 5.36 1.96  999 999 999  1 0 1 0 0;
  6  7  0.60 6.37 2.33  999 999 999  1 0 1 0 0;
  7  8  0.47 5.03 1.84  999 999 999  1 0 1 0 0;
  10 11 0.34 3.72 6.36  999 999 999  1 0 1 0 0;
  11 12 0.39 4.34 7.42  999 999 999  1 0 1 0 0;
  12 13 0.22 2.48 4.24  999 999 999  1 0 1 0 0;
  12 13 0.22 2.48 4.24  999 999 999  1 0 1 0 0; 
  1  2  0    1.50 0     999 999 999  1 0 1 0 0; 
  3  14 0    8.33 0     999 999 999  1 0 1 0 0; 
  8  9  0    12.5 0     999 999 999  1 0 1 0 0; 
  8  10 0    10.0 0     999 999 999  1 0 1 0 0; 
  4  15 0    6.67 0     999 999 999  1 0 1 0 0;  
  6  16 0    1.67 0     999 999 999  1 0 1 0 0;   
];

[num_barras, x]=size(mpc.bus)
[num_linhas, xx]=size(mpc.branch)

%%% incremento das cargas
INCREM=input('indique o incremento da carga em %: ');
  for i=1:num_barras
  mpc.bus(i,3) = mpc.bus(i,3)*(1+(INCREM/100));
  mpc.bus(i,4) = mpc.bus(i,4)*(1+(INCREM/100));
  end

mpc.branch(:,3)=mpc.branch(:,3)/100;
mpc.branch(:,4)=mpc.branch(:,4)/100;
mpc.branch(:,5)=mpc.branch(:,5)/100;


