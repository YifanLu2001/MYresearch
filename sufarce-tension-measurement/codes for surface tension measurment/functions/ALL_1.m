%% get the edge of the droplet in scenario 1
% when the whole edge is clear and can be detected directly

function [I1_edge]=ALL_1(I1)
t1=graythresh(I1);
I1_bw=im2bw(I1,t1);
global I1_edge;
I1_edge=edge(I1_bw, 'canny');
end
