function [] = guiFinalProject()
%close all previous figures that may be open
close all;
%create a global called gui
global gui

%create gui figure with a plot in the middle
    gui.fig = figure();
    gui.p = plot(0,0);
    gui.p.Parent.Position = [0.3 0.15 0.6 0.6];

%for customization of the graph such as giving it a title name, x label,
%and y label
    gui.plotTitleText = uicontrol('style','text','units','normalized','position',[0 .4 .1 .1],'string','Title:','horizontalalignment','right');
    gui.plotTitleEdit = uicontrol('style','edit','units','normalized','position',[.03 .398 .1 .05]);
    gui.plotXAxesText = uicontrol('style','text','units','normalized','position',[0 .267 .1 .1],'string','X Axes:','horizontalalignment','right');
    gui.plotXAxesEdit = uicontrol('style','edit','units','normalized','position',[.03 .265 .1 .05]);
    gui.plotYAxesEdit = uicontrol('style','text','units','normalized','position',[0 .134 .1 .1],'string','Y Axes:','horizontalalignment','right');
    gui.plotYAxesEdit = uicontrol('style','edit','units','normalized','position',[0.03 .132 .1 .05]);

%x coordinate
    gui.xDataText = uicontrol('style','text','position',[20 380 50 20],'string','X Values:','horizontalalignment','right');
    gui.xDataEdit = uicontrol('style','edit','position',[80 380 50 20]);

%y coordinate    
    gui.yDataText = uicontrol('style','text','position',[20 350 50 20],'string','Y Values:','horizontalalignment','right'); 
    gui.yDataEdit = uicontrol('style','edit','position',[80 350 50 20]);

%gui radiobuttons for picking the color and type
    gui.buttonGroup = uibuttongroup('visible','on','units','normalized','position',[0.02 0.53 .2 .2],'SelectionChangeFcn',{@buttonCallback});
    gui.redCirclesButton = uicontrol(gui.buttonGroup,'style','radiobutton','units','normalized','position',[.1 .8 1 .2],'HandleVisibility','off','string','Red circles');
    gui.blueAsteriskButton = uicontrol(gui.buttonGroup,'style','radiobutton','units','normalized','position',[.1 .5 1 .2],'HandleVisibility','off','string','Blue asterisks');
    gui.greenDashesButton = uicontrol(gui.buttonGroup,'style','radiobutton','units','normalized','position',[.1 .2 1 .2],'HandleVisibility','off','string','Green dashes');
    gui.buttonGroupTitle = uicontrol('style','text','position',[8 310 100 15],'string','Color and Type','horizontalalignment','right');

%Plot button
    gui.plotButton = uicontrol('style','pushbutton','String','Push','position',[235 370 100 40],'callback',{@buttonCallback});
   
%reset button
    gui.resetButton = uicontrol('style','pushbutton','string','Reset','position',[350 370 100 40],'callback',{@resetCallback});
    
    end

%Callback function to make everything work
function [] = buttonCallback(~,~)
%restating the global
global gui;
%Turning the string into numbers that can be plotted as x and y on the plot
x = str2num(gui.xDataEdit.String);
y = str2num(gui.yDataEdit.String);
%This allows for changes of color and type of points on the graph
  if strcmp(gui.buttonGroup.SelectedObject.String,'Red circles')
      type = 'ro';
  elseif strcmp(gui.buttonGroup.SelectedObject.String,'Blue asterisks')
      type = 'b*';
  else
      type = 'g--';
  end
%this plots the data
  plot(x,y,type)
%this will create the title and label on the graph
  if ~isempty(gui.plotTitleEdit.String)
      title(gui.plotTitleEdit.String)
  end
  
  if ~isempty(gui.plotXAxesEdit.String)
      xlabel(gui.plotXAxesEdit.String)
  end
  
  if ~isempty(gui.plotYAxesEdit.String)
      ylabel(gui.plotYAxesEdit.String)
  end
  
%if the values aren't at the same length an error message will show up
  if strlength(gui.xDataEdit.String)~=strlength(gui.yDataEdit.String)
msgbox('ERROR! X and Y values are not the same length','Plotting Error','error','modal')
  end
  
end

%Callback function to reset all inputs when the reset button is clicked
function [] = resetCallback(~,~)
global gui;
hold off;
gui.p = plot(0,0);
gui.xDataEdit.String = ' ';
gui.yDataEdit.String = ' ';
gui.plotTitleEdit.String = ' ';
gui.plotXAxesEdit.String = ' ';
gui.plotYAxesEdit.String = ' ';
end