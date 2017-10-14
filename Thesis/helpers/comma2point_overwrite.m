function    comma2point_overwrite( filespec )
    % https://nl.mathworks.com/matlabcentral/answers/57276-import-data-file-with-comma-decimal-point#answer_69283
    % replaces all occurences of comma (",") with point (".") in a text-file.
    % Note that the file is overwritten, which is the price for high speed.
        file    = memmapfile( filespec, 'writable', true );
        comma   = uint8(',');
        point   = uint8('.');
        file.Data(transpose( file.Data==comma)) = point;
end