% normalize

A1 = A_can_tot;
A2 = A_ger_tot;
B1 = output_can_tot;
B2 = output_ger_tot;

for i = 1:length(B1)

    if (B1(i) ~= 0)
        A1(:, i) = A1(:, i) / B1(i);
    end

    if (B2(i) ~= 0)
        A2(:, i) = A2(:, i) / B2(i);
    end

end

A = [A1, A2];

B_vec = [B1, B2];
l = [comp_can_tot, comp_ger_tot];

for i = 1:length(l)

    if (l(i) ~= 0)
        l(i) = l(i) / B_vec(i);
    end

end

B = [eye(36, 36), eye(36, 36)];

% solve
step = 0.001;
a1 = max(eig(A1));
a2 = max(eig(A2));
R1 = (1 - a1) / a1;
R2 = (1 - a2) / a2;
R = min(R1, R2);
RR = R / step;
d = -1 * ones(36, 1);
lb = zeros(72, 1);
qq = ones(72, 1);
X = ones(72, fix(RR));
opts = optimoptions(@linprog, 'Display', 'none');

tic;
i = 1;

for r = 0:step:R
    C = -1 * (B - (1 + r) * A);

    if all(C * qq - d < 0.001)
        disp('B-(1+r) gleich Endnachfrage d für r='); disp(r);
    end

    X(:, i) = linprog(l, C, d, [], [], lb, [], opts);
    i = i + 1;
end

toc;
