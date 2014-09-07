%function fig2tikz(gcf,type,caption,filename,svn_path) 
%
% INPUTS: 
%       gcf: figure handle 
%       type: '2d' for graph layout and '3d' for surf layout
%       caption: Figure caption for the latex document.
%       filename: Name of the two files which will be created as *.tikz and *.tex
%       svn_path: the path to svn dir
% OUTPUTS:
%       one *.tikz file as specified inside the file.
%       one *.tex file as specified inside the file.
%       Print to screen of where these files are being created
%
% DEPENDENCIES:
%       Dependent on matlab2tikz.m 
%
% EXAMPLE:
% fig2tikz(gcf,'2d','Graph Plot',figure_filename,'/Path/to/svn/root_repo');
%
function fig2tikz(gcf,type,caption,filename,svn_path) 

    filename_tex = filename; filename = strrep(filename,' ','_');
    filetikz = sprintf('%s/img/%s.tikz',svn_path,filename);
    filetex = sprintf('%s/img/%s.tex',svn_path,filename);
    system(sprintf('sudo rm %s && rm %s',filetex,filetikz)); 

    if type == '3d'
         leg = legend('location', 'Northwest');
         % set(leg, 'location','northwest');
         legend boxoff;
         matlab2tikz(sprintf('%s/img/%s.tikz',svn_path,filename),'width','7cm','height','7cm');
    end
    if type == '2d' 
        matlab2tikz(sprintf('%s',filetikz),'nosize',true);
    end
    system(sprintf('printf "\\n \\\\\\begin{figure}[!t]\\n    \\centering\\n    \\input img/%s.tikz\\n    \\caption{%s}\\n    \\label{fig:%s}\\n \\\\\\end{figure}" >> %s',filename,caption,filename,filetex));
    fprintf(sprintf('\n\nTwo files have been written:\n(image)\n    %s\nand\n(wrapper)\n    %s\n\nThis means that you can do:\n    input img/%s.tex in your document.\n\n',filetikz,filetex,filename));
end
