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
        dampr % damping ratio
        ns % number of spectral lines
        freqbnds % frequency bnds
        out % output dof index
        in % input dof index
        AA % residue array [n,n,ne]
        HH % frequnecy response function [no,ni,ns]
	end

%% dependent properties
	properties (Dependent)
        no % number of outputs
        ni % number of inputs
        ne % number of effective modes
        w % frequency vector [rad/sec]
        dampf % damping factor [rad/sec]
        Wn % damped natural frequency [rad/sec]
        root % positive system poles
        Qr % modal scaling
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
		function no = get.no(self)
		%% number of outputs
			no = length(self.out);
		end

		function ni = get.ni(self)
		%% number of inputs
			ni = length(self.in);
        end

		function w = get.w(self)
		%% frequency vector [rad/sec]
			w = linspace(self.freqbnds(1),self.freqbnds(2),self.ns);
		end

		function dampf = get.dampf(self)
		%% damping factor [rad/sec]
			dampf = -self.dampr.*self.W;
		end

		function Wn = get.Wn(self)
		%% damped natural frequency [rad/sec]
			Wn = sqrt(self.W.^2 + self.dampf.^2);
		end

		function root = get.root(self)
		%% positive system poles
			root = self.dampf + 1j.*self.Wn;
		end

		function Qr = get.Qr(self)
		%% modal scaling
        % notes:
        %  * -true unity mass due t the mass normalized eigenvector
			Qr = 1./(2j.*diag(self.Mr).*self.Wn);
		end
        function ne = get.ne(self)
        %% number of effective modes
            ne = size(self.V,2);
        end
	end

%% static methods
	methods (Static)
        [Hs,hh] = vibsFRF(AA,root,in,out,w);
        fh = vibsFRFplot(Hs,hh,in,out,w);
        
        [hs,h] = vibsIRF(AA,root,in,out,fs,l);
        fh = vibsIRFplot(hs,h,in,out,fs,l);
        
        fh = vibsPhaseplot(Hs,hh,in,out,w);
	end

%% protected methods
	methods (Access = protected)
	end

end
