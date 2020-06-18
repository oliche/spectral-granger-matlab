fs = 500;
ns = 5000;
rng(42)
eta = randn(ns, 2) - 0.5;

t = [0 : ns - 1] / fs;
[x1, x2, c] = deal(zeros(ns, 1));
x1(1:2) = eta(1:2, 1);
x2(1:2) = eta(1:2, 2);
c(:) = 0.2;
for m = 3:ns
    x1(m) = 0.55 .* x1(m - 1) - 0.8 .* x1(m - 2) + c(m) .* x2(m -1) + eta(m, 1);
    x2(m) = 0.55 .* x2(m - 1) - 0.8 .* x2(m - 2) + eta(m, 2);
end

X = cat(3, x1, x2);
[M, S] = spectral_granger(X, fs); % 1.8 secs compared to 145 secs originally

er = load('expected.mat');
d  =er.M.gc - M.gc;

assert(all(abs(d(:) < 1e-12)))
