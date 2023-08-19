%% process the droplet image in scenario 2
% get the edge of the clear half droplet directly

function [I12_edge]=half_1(I12)
I12_edge=edge(I12,'sobel');
end