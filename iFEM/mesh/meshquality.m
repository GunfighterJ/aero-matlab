function [q,u,idx] = meshquality(node,elem,fh,varargin)
%% MESHQUALITY computes qualities of a mesh
%
% q = meshquality(node,elem) computes the shape regularity of elements in
% the mesh (node,elem). The default mesh quality is defined as the ration
% of the volume and the sum of squared edge lenghts.
%
% q = meshquality(node,elem,1) computes the mesh quality defined as the
% ration of the inradius and circumradius.
%
% All ratio are scaled such that for the equillateral triangle/tetrahedron,
% q =1 and the closer to 1, the better is the element.
%
% [q,u] = meshquality(node,elem,type,fh) also computes the uniformity u of
% the mesh. It is defined by the standard deviation of the ratio of actual
% sizes to desired sizes specified by fh. That number is normalized to
% measure the relative sizes. The smaller the value of the uniformity, the
% more uniform is the point distribution. 
%
% [q,u,idx] = meshquality(node,elem) outputs the idx of elements with the
% minimal quality. Then one can use findelem(node,elem,idx) to find out
% this element.
%
% This function uses simpqual.m and uniformity.m coded by Per-Olof Persson
% in distmesh.
%
% Example
%   load lakemesh
%   figure(1); showmesh(node,elem);
%   meshquality(node,elem);
%   figure(2); showmeshquality(node,elem);
%
% See also  showmeshquality
%
% Copyright (C) Long Chen. See COPYRIGHT.txt for details.

q = simpqual(node,elem);
if (nargin >= 3) && ~isempty(fh)
    u = uniformity(node,elem,fh,varargin{:});
else
    u = 0;
end
[mq,idx] = min(q);
fprintf(' - Min quality %.4f',mq);
fprintf(' - Mean quality %.4f',mean(q));
if nargin >= 3
    fprintf(' - Uniformity %.2f%%',100*u);
end
disp(' ')
% hold on
% findelem(node,elem,ix,'noindex');