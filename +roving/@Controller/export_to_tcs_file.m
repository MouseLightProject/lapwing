function export_to_tcs_file(self)

% throw up the dialog box to get file name
[file_name,dir_name]= ...
  uiputfile({'*.tcs' 'Traces file (*.tcs)'}, ...
            'Export ROIs to file...');
if isnumeric(file_name) || isnumeric(dir_name)
  % this happens if user hits Cancel
  return;
end
file_name_abs=fullfile(dir_name,file_name);

% could take a while
self.view.hourglass();

try
  % calc the ROI means  
  roi_mean=self.model.mean_over_rois();
  
  % save to .tcs file
  t=self.model.t;  % s
  roi_label={self.model.roi.label}';
  roving.write_o_to_tcs(file_name_abs,...
                        t,roi_mean,roi_label);
catch excp
  self.view.unhourglass();
  rethrow(excp);
end

% back to usual pointer
self.view.unhourglass();
                      
end
