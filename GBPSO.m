function [gBestScore,gBest,ConvergenceCurve,time]=GBPSO(noP,Max_iteration,GBPSO_num,CostFunction,noV)
tic
wMax=0.9;wMin=0.4;c1=2;c2=2;Vmax=6;
Velocity=zeros(noP,noV);Position=zeros(noP,noV);pBestScore=zeros(noP);pBest=zeros(noP,noV);
gBestScore=inf;gBest=zeros(1,noV);
ConvergenceCurve=zeros(1,Max_iteration); 
for i=1:size(Position,1) 
    for j=1:size(Position,2) 
        if rand<=0.5
            Position(i,j)=0;
        else
            Position(i,j)=1;
        end
    end
end
for i=1:noP
    pBestScore(i)=inf;
end
for iter=1:Max_iteration
    for i=1:size(Position,1)  
        fitness=CostFunction(Position(i,:));
        if(pBestScore(i)>fitness)
            pBestScore(i)=fitness;
            pBest(i,:)=Position(i,:);
        end
        if(gBestScore>fitness)
            gBestScore=fitness;
            gBest=Position(i,:);
        end
    end
    w=wMax-iter*((wMax-wMin)/Max_iteration);
    for i=1:size(Position,1)
        for j=1:size(Position,2) 
            Velocity(i,j)=w*Velocity(i,j)+c1*rand()*(pBest(i,j)-Position(i,j))+c2*rand()*(gBest(j)-Position(i,j));
            if(Velocity(i,j)>Vmax)
                Velocity(i,j)=Vmax;
            end
            if(Velocity(i,j)<-Vmax)
                Velocity(i,j)=-Vmax;
            end  
            if GBPSO_num==1
                G=(exp(-Velocity(i,j).^2)); %Gaussian 1 G1 transfer function
            end
            if GBPSO_num==2
                G=(exp(-Velocity(i,j).^2/2)); %Gaussian 2 G2 transfer function            
            end
            if GBPSO_num==3
                G=(exp(-Velocity(i,j).^2/3)); %Gaussian 3 G3 transfer function             
            end
            if GBPSO_num==4
               G=(exp(-Velocity(i,j).^2)/4); %Gaussian 4 G4 transfer function
            end            
            if GBPSO_num<=4 %G-shaped transfer functions
                if rand<G 
                    Position(i,j)=1;
                else
                    Position(i,j)=0;
                end
            end
        end
    end
    ConvergenceCurve(iter)=gBestScore;
     time=toc; 
end
end


