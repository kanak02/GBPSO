clear all 
close all
clc
format short e 
Function_name='Cap41'; 
[dim, fobj] = Get_Functions_details_UFLP(Function_name);
SearchAgents_no=40;
Max_iteration=100;
ConvergenceCurves=zeros(1,Max_iteration);
runs=10;
for i=4
    func_num=i;
    outcome=[];t=[];
    for j=1:runs
        [gBestScore1,gBest1,ConvergenceCurves(1,:),time1]=GBPSO(SearchAgents_no,Max_iteration,1,fobj,dim);
        BestSolutions1(j)=gBestScore1;
        [gBestScore2,gBest2,ConvergenceCurves(2,:),time2]=GBPSO(SearchAgents_no,Max_iteration,2,fobj,dim);
        BestSolutions2(j)=gBestScore2;
        [gBestScore3,gBest3,ConvergenceCurves(3,:),time3]=GBPSO(SearchAgents_no,Max_iteration,3,fobj,dim);
        BestSolutions3(j)=gBestScore3;
        [gBestScore4,gBest4,ConvergenceCurves(4,:),time4]=GBPSO(SearchAgents_no,Max_iteration,4,fobj,dim);
        BestSolutions4(j)=gBestScore4;

        c1(j,:)=ConvergenceCurves(1,:);
        c2(j,:)=ConvergenceCurves(2,:);
        c3(j,:)=ConvergenceCurves(3,:);
        c4(j,:)=ConvergenceCurves(4,:);

        X1(j,:)=gBestScore1;
        X2(j,:)=gBestScore2;
        X3(j,:)=gBestScore3;
        X4(j,:)=gBestScore4;

        [p1,h1]=ranksum(X4,X1);
        [p2,h2]=ranksum(X4,X2);
        [p3,h3]=ranksum(X4,X3);

        bsf_val(j,:)=[gBestScore1,gBestScore2,gBestScore3,gBestScore4];
        outcome = [outcome;bsf_val(j,:)];
    end

    for i=1:Max_iteration
        cc1(i)=mean(c1(:,i));
        cc2(i)=mean(c2(:,i));
        cc3(i)=mean(c3(:,i));
        cc4(i)=mean(c4(:,i));
    end

    Minimum1=min(BestSolutions1);
    Maximum1=max(BestSolutions1);
    Average1=mean(BestSolutions1);
    Std1=std(BestSolutions1);

    Minimum2=min(BestSolutions2);
    Maximum2=max(BestSolutions2);
    Average2=mean(BestSolutions2);
    Std2=std(BestSolutions2);

    Minimum3=min(BestSolutions3);
    Maximum3=max(BestSolutions3);
    Average3=mean(BestSolutions3);
    Std3=std(BestSolutions3);

    Minimum4=min(BestSolutions4);
    Maximum4=max(BestSolutions4);
    Average4=mean(BestSolutions4);
    Std4=std(BestSolutions4);

    time=[time1,time2,time3,time4];
    t=[t;time];

    disp(['G1-BPSO Min=',num2str(Minimum1)]);
    disp(['G1-BPSO Max=',num2str(Maximum1)]);
    disp(['G1-BPSO Avg=',num2str(Average1)]);
    disp(['G1-BPSO Std=',num2str(Std1)]);
    disp(['G1-BPSO Time=',num2str(time1)]);
    disp(['G1-BPSO Pva=',num2str(p1)]);

    disp(['G2-BPSO Min=',num2str(Minimum2)]);
    disp(['G2-BPSO Max=',num2str(Maximum2)]);
    disp(['G2-BPSO Avg=',num2str(Average2)]);
    disp(['G2-BPSO Std=',num2str(Std2)]);
    disp(['G2-BPSO Time=',num2str(time2)]);
    disp(['G2-BPSO Pva=',num2str(p2)]);
    
    disp(['G3-BPSO Min=',num2str(Minimum3)]);
    disp(['G3-BPSO Max=',num2str(Maximum3)]);
    disp(['G3-BPSO Avg=',num2str(Average3)]);
    disp(['G3-BPSO Std=',num2str(Std3)]);
    disp(['G3-BPSO Time=',num2str(time3)]);
    disp(['G3-BPSO Pva=',num2str(p3)]);
    
    disp(['G4-BPSO Min=',num2str(Minimum4)]);
    disp(['G4-BPSO Max=',num2str(Maximum4)]);
    disp(['G4-BPSO Avg=',num2str(Average4)]);
    disp(['G4-BPSO Std=',num2str(Std4)]);
    disp(['G4-BPSO Time=',num2str(time4)]);
end
    figure(1)
    X = outcome;
    h = boxplot(X, {'G1-BPSO', 'G2-BPSO', 'G3-BPSO', 'G4-BPSO'}, 'Color', 'k', 'Notch', 'on');
    ylabel('Fitness value', 'fontsize', 14, 'FontName', 'Times New Roman', 'LineWidth', 2);
    mycolor = [[199,97,20]/255; [0,162,232]/255; [240,138,74]/255; [67,104,207]/255];
    boxobj = findobj(gca, 'Tag', 'Box');
    for i = 1:4
        patch(get(boxobj(i), 'XData'), get(boxobj(i), 'YData'), mycolor(i,:), 'FaceAlpha', 0.5, 'LineWidth', 1.1);
    end
    hold on;
    set(h, 'LineWidth', 1.1);
    set(gca, 'XTickLabelRotation', 30);
    set(gca, 'LineWidth', 2);
    set(gca, 'FontSize', 14, 'FontName', 'Times New Roman', 'LineWidth', 2);
    title(Function_name);
    set(gca, 'LooseInset', [0,0,0.005,0]);
    figure(2)
    p = 1:Max_iteration; 
    marker_interval = 5; 
    plot(p, cc1, 'color', [1 0.5 0], 'LineWidth', 1.5)
    hold on
    plot(p, cc2, 'color', [0,162,232]/255, 'LineWidth', 1.5)
    hold on
    plot(p, cc3, 'color', [0.48 0.4 0.94], 'LineWidth', 1.5);
    hold on
    plot(p, cc4, 'color', 'k', 'LineWidth', 1.5);
    hold on
    plot(p(1:marker_interval:end), cc1(1:marker_interval:end), '>', 'color', [1 0.5 0], 'MarkerFaceColor', [1 0.5 0], 'MarkerSize', 6)
    plot(p(1:marker_interval:end), cc2(1:marker_interval:end), '*', 'color', [0,162,232]/255, 'MarkerFaceColor', [0,162,232]/255, 'MarkerSize', 7)
    plot(p(1:marker_interval:end), cc3(1:marker_interval:end), '<', 'color', [0.48 0.4 0.94], 'MarkerFaceColor', [0.48 0.4 0.94], 'MarkerSize', 6)
    plot(p(1:marker_interval:end), cc4(1:marker_interval:end), 'p', 'color', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 6)
    set(gca, 'GridLineStyle', ':', 'GridColor', 'k', 'GridAlpha', 0.1)
    title(Function_name);
    xlabel('Iterations');
    set(gca, 'LineWidth', 2);
    ylabel('Fitness value');
    set(gca, 'LineWidth', 2);
    set(gca, 'FontSize', 14, 'FontName', 'Times New Roman', 'LineWidth', 2);
    set(gca, 'LooseInset', [0,0,0,0]);
    lgd = legend({'G1-BPSO', 'G2-BPSO', 'G3-BPSO', 'G4-BPSO'}, 'FontSize', 12);
    lgd.NumColumns = 1;