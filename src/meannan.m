function avgvalue=meannan(data)
% Heling Zhou, Ph.D.
% Email: helingzhou7@gmail.com
% calculating mean values ignore nan and inf
avgvalue=mean(data(~isnan(data)&~isinf(data)));
end