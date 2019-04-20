%% Game of Dots and Boxes
function game
%Game of Dots and Boxes
%boarders included in play
%2 to 7 players
%can choose names and colors
%color must be short name, long name, or RGB triplet
%can choose board size
%displays winner at the end
%% setting up the variable
%asks how many players
numplayers=input('How many players?');
%asks how large a play field
size=input('How large of a playing field?');
%for loop to ask each players name and color
for i=1:numplayers
    players{i,:}=input(['Name of Player',num2str(i),'?'],'s');
    color{i,:}=input(['What Color?'],'s');
end
%set the turn to one
turn=1;
%set step to one to go to next step
step=1;
%initialize zeros vector for scores of player
score =zeros(1,numplayers);
%matrixs to storage the played lines
xvecs=zeros(size+1,size+1);
yvecs=zeros(size+1,size+1);
%% setting up board
%initialize grid
figure(1)
%size of axis
axis([0, size, 0 ,size])
%set tick length for x and y
set(gca,'xtick',[0:size],'ytick',[0:size])
grid on
hold on

%% game play
%while loop so game runs till all squares are filled
while sum(score)<size^2
    %if the turn value is greater than players turn is set back to 1
    if turn==numplayers+1
        turn=1;
    end
    %title displays the name of the player in their color for their turn
    title(players{turn},'color',color{turn},'fontsize',22)
    %get cartesian points of click
    [x,y]=ginput(1);
    %round to nearest integer
    rx=round(x);
    ry=round(y);
    %distance from the rounded point and actual point
    dist=[(rx-x),(ry-y)];
    %index of the vector x or y
    [~,ind]=min(abs(dist));
    %find direction of line
    x1=rx-((ind==2)*(dist(1)>0));
    y1=ry-((ind==1)*(dist(2)>0));
    %points of the other directions
    x0=x1-1;
    y0=y1-1;
    x2=x1+1;
    y2=y1+1;
    x3=x1+2;
    y3=y1+2;
    %vector of x values of line
    xline=[x1,x1+(ind==2)];
    %vector of x values of line
    yline=[y1,y1+(ind==1)];
    %if x is closer
    if ind==1
                %if line isn't already saved
                if yvecs(y2,x2) == 0
                    %save line
                    yvecs(y2,x2) = turn;
                    step=1;
                else
                    %back to top
                    step = 0;
                end
    else %y is closer
                %line isn't already saved
                if xvecs(y2,x2) == 0
                    %save line
                    xvecs(y2,x2) = turn;
                    step=1;
                else
                    %back to top
                    step = 0;
                end
    end
    
    %if line is save
    if step==1
        %plot the line with players color
        line(xline,yline,'color',color{turn}, 'linewidth', 5)
            %check if a box is formed
            %if x is closer
            if ind==1
                %if line not on edge
                if x1 > 0
                    %find any vectors that are open if so no box
                    if isempty(find([yvecs(y2,x1), xvecs(y2,x1), xvecs(y3,x1)]==0, 1))
                        %fill given dimension with player's color
                        fill( [x0, x1, x1, x0],[y1, y1, y2, y2],color{turn} )
                        %add to players score
                        score(turn) = score(turn) + 1;
                        %back to the top
                        step=0;
                    end
                end
                %if line not on edge
                if x1 < size
                    %find any vectors that are open if so no box
                    if isempty(find([yvecs(y2,x3), xvecs(y2,x2), xvecs(y3,x2)]==0, 1))
                        %fill given dimension with player's color
                        fill( [x1, x2, x2, x1],[y1, y1, y2, y2],color{turn} )
                        %add to players score
                        score(turn) = score(turn) + 1;
                        %back to the top
                        step=0;
                    end
                end
            %if y is closer
            else
                %if line is on the edge
                if y1 > 0
                    %find any vectors that are open if so no box
                    if isempty(find([xvecs(y1,x2), yvecs(y1,x2), yvecs(y1,x3)]==0, 1))
                        %fill given dimension with player's color
                        fill( [x1, x2, x2, x1],[y0, y0, y1, y1],color{turn} )
                        %add to players score
                        score(turn) = score(turn) + 1;
                        %back to the top
                        step=0;
                    end
                end
                %if line is on the edge
                if y1 < size
                    %find any vectors that are open if so no box
                    if isempty(find([xvecs(y3,x2), yvecs(y2,x2), yvecs(y2,x3)]==0, 1))
                        %fill given dimension with player's color
                        fill( [x1, x2, x2, x1],[y1, y1, y2, y2],color{turn} )
                        %add to players score
                        score(turn) = score(turn) + 1;
                        %back to the top
                        step=0;
                    end
                end
            end
    end
    
    %scoreboard
    scoreboard='';
    %for loop for how many players
    for i=1:numplayers
        %new scoreboard of players name and updated score
        scoreboard=[scoreboard,[players{i,:},':',num2str(score(i)),' ']];
        %display scoreboard as x label
        xlabel(scoreboard,'fontsize',14)
    end
    %add to the turn counter
    turn=turn+step;
end
%after all boxes a filled find winner
[m,w]=max(score);
    %if their is only one max
    if length(w)==1
        %title says winners name in their color
        title(['The Winner is ',players{w}],'color',color{w},'fontsize',22)
        %xlabel says their box total
        xlabel(['with ',num2str(m),' boxes'],'fontsize',14)
    %theirs a tie
    else
        %title says theirs a draw
        title('Draw','color','k','fontsize',22)
        %x label says who has the max scores
        xlabel(['between',players{w}],'fontsize',14)
    end
end
