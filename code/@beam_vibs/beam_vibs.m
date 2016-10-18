classdef beam_vibs < handle
%% classdef beam_vibs
% 
% 
% 
% author: john devitis
% create date: 18-Oct-2016 16:46:00

%% object properties
	properties
        K % global stiffness matrix
        M % global mass matrix
        V % eigenvectors
        W % natural frequencies [rad/sec]
        F % natural frequencies [hz]
        Mr % modal mass
        Kr % modal stiffness
        Vn % mass normalized shapes
	end

%% dependent properties
	properties (Dependent)
        ne % number of effective modes
	end

%% private properties
	properties (Access = private)
	end

%% dynamic methods
	methods
	%% constructor
		function self = beam_vibs()
		end

	%% ordinary methods

	%% dependent methods
        function ne = get.ne(self)
            ne = size(self.V,2);
        end
	end

%% static methods
	methods (Static)
	end

%% protected methods
	methods (Access = protected)
	end

end