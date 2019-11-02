% Quickly simulates from the command window, then plots relevant plots

sim('main',[0 simTime],simset('SrcWorkspace','current','DstWorkspace','current'))
plotprobs;