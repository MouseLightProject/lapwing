function open_file_given_file_name(self, filename)
    
    % filename is a filename, can be relative or absolute
    
    % break up the file name
    [~,base_name,ext]=fileparts(filename);
    filename_local=[base_name ext];
    
    % load the optical data
    self.hourglass()
    try
        %self.model=lapwing.Model();  % now done during controller construction
        self.model.open_file_given_file_name(filename);
    catch err
        self.unhourglass();
        if strcmp(err.identifier,'MATLAB:imagesci:imfinfo:whatFormat')
            errordlg(sprintf('Unable to determine file format of %s', ...
                filename_local),...
                'File Error');
            return;
        elseif strcmp(err.identifier,'MATLAB:load:notBinaryFile')
            errordlg(sprintf('%s does not seem to be a binary file.', ...
                filename_local),...
                'File Error');
            return;
        elseif isempty(err.identifier)
            errordlg(sprintf('Unable to read %s, and error lacks identifier.', ...
                filename_local),...
                'File Error');
            return;
        elseif strcmp(err.identifier,'VideoFile:UnableToLoad')
            errordlg(sprintf('Error opening %s.',filename_local),...
                'File Error');
            return;
        elseif strcmp(err.identifier,'VideoFile:UnsupportedPixelType')
            errordlg(sprintf('Error opening %s: Unsupported pixel type.', ...
                filename_local),...
                'File Error');
            return;
        else
            rethrow(err);
        end
    end
    
    % Update the view HG objects to match the model & view state
    self.model_changed();
    
    % % set self
    % self.card_birth_roi_next=1;
    
    % OK, we're done.
    self.unhourglass()    
end
