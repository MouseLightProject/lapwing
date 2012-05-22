function quit(self)

% Check for unsaved data
if ~isempty(self.model) && ~self.model.saved
  button=questdlg('Changes not saved.  Would you like to save changes?',...
                  'Save changes?',...
                  'Save','Discard','Cancel',...
                  'Save');
  if strcmp(button,'Cancel')
    return;
  elseif strcmp(button,'Save')
    if self.model.file_native
      self.save(self.model.filename_abs);
    else
      saved=self.save_as();
      if ~saved
        % means user hit cancel in the 'save as' dialog box
        return;
      end
    end
  end
end

% Tell the view wassup.
self.view.quit_requested();

end