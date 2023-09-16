% Define path
path = './docs/SchefoldEmpiricTest.xlsx';

% Read data from Excel using xlsread
B_vec = xlsread(path, 'Tabelle1', 'AK3:AK68');
B1 = diag(B_vec(1:33));
B2 = diag(B_vec(34:66));
B = [eye(33),eye(33)];
l = xlsread(path, 'Tabelle1', 'EK3:EK68');

% Process l vector
for i=1:length(l)
    if (l(i) ~= 0)
        l(i) = l(i) / B_vec(i);
    end
end
l = [transpose(l(1:33)),transpose(l(34:66))];
r = 0.64;

% Reading A matrices from Excel using xlsread
A1 = xlsread(path, 'Tabelle1', 'C3:AI35');  % This replaces 'Z3S3:Z35S35'
A2 = xlsread(path, 'Tabelle1', 'C36:AI68'); % This replaces 'Z36S3:Z68S35'

% Process A matrices
for i=1:length(B1)
    if (B1(i,i) ~= 0)
        A1(:,i) = A1(:,i) / B1(i,i);
    end
    if (B2(i,i) ~= 0)
        A2(:,i) = A2(:,i) / B2(i,i);
    end
end

% Construct A matrix
A = [A1,A2];

% Calculate eigenvalues
a1 = max(eig(A1));
R1 = (1 - a1) /a1;
a2 = max(eig(A2));
R2 = (1 - a2) /a2;

% Construct the C matrix
d = -1*ones(33,1);
C = -1*(B-(1+r)*A);

% Define lower bounds
lb = zeros(66,1);

% Solve linear programming problem
x = linprog(l,C,d,[],[], lb, []);
