%--------------------------------------------------------------------------
% INSTALL_Direct_Method_Examples
% This scripts helps you get the project up and running
%--------------------------------------------------------------------------
% Automatically adds project files to your MATLAB path, downloads the
% required MATLAB File Exchange submissions, and opens an example.
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% https://github.com/danielrherber/optimal-control-direct-method-examples
%--------------------------------------------------------------------------
function INSTALL_Direct_Method_Examples

	warning('off','MATLAB:dispatcher:nameConflict');

	% Add project contents to path
	AddProjectContents

	% FX submissions
	FXSubmissions
    
	% Add project contents to path again
	AddProjectContents

	% Open example
	OpenExample('Run_All_Examples')

	% Close this file
	CloseThisFile(mfilename)

	warning('on','MATLAB:dispatcher:nameConflict');

end
%--------------------------------------------------------------------------
function AddProjectContents
	disp('--- Adding project contents to path')
	disp(' ')

	fullfuncdir = which(mfilename('fullpath'));
	projectdir = fullfile(fileparts(fullfuncdir));
	addpath(genpath(projectdir)) % add contents
end
%--------------------------------------------------------------------------
function FXSubmissions
	disp('--- Obtaining required MATALB File Exchange submissions')

	ind = 0;
    
	ind = ind + 1;
	zips(ind).url = 'https://www.mathworks.com/matlabcentral/mlc-downloads/downloads/submissions/51104/versions/1/download/zip/v1.zip';
	zips(ind).name = 'MFX 51104';
	zips(ind).test = 'LagrangeInter';

	% obtain full function path
	full_fun_path = which(mfilename('fullpath'));
	outputdir = fullfile(fileparts(full_fun_path),'include\');

	% download and unzip
	DownloadWebZips(zips,outputdir)

	disp(' ')
end
%--------------------------------------------------------------------------
% download and unzip weblinks that contain zip files
function DownloadWebZips(zips,outputdir)
    % store the current directory
    olddir = pwd;
    % change to the output directory
    cd(outputdir)
    for k = 1:length(zips)
        % first check if the test file is in the path
        if exist(zips(k).test,'file') == 0
            % get data
            url = zips(k).url;
            name = zips(k).name;
            % download zip file
            zipname = websave(name,url);
            % save location
            outputdirname = fullfile(outputdir,name);
            % create a folder utilizing name as the foldername name
            if ~exist(outputdirname, 'dir')
                mkdir(outputdirname);
            end
            % unzip the zip
            unzip(zipname,outputdirname);
            % delete the zip file
            delete([name,'.zip'])
            % output to the command window
            disp(['Downloaded and unzipped ',name])
        end
    end
    % change back to the original directory
    cd(olddir)
end
%--------------------------------------------------------------------------
function OpenExample(name)
	disp(['--- Opening ', name])
	disp(' ')

	% open the file
	open(name);
end
%--------------------------------------------------------------------------
function CloseThisFile(name)
	disp(['--- Closing ', name])
	disp(' ')
    
    h = matlab.desktop.editor.getAll;
    for k = 1:numel(h)
        if ~isempty(strfind(h(k).Filename,name))
            h(k).close % close this file
        end
    end
end