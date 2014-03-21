% automatic solve git.io/2048
% I hate this game, try to solve it by machine
clear all
close all
chess=2.^(reshape(randperm(16),4,4)<=2);
oldchess=chess;
chess=log2(chess);
for m=1:5000
    m
    for test=1:200
        predict_step=5;
        thismove=floor(rand(1,predict_step).*4+1);
        firstmove=thismove(1);
        testchess=chess;
        testscore=0;
        for step=1:predict_step
            testchess=movechess(testchess,thismove(step));
            testscore=testscore+chesscore(testchess)*(2^(-step));
            %testchess=move_in_new_chess(testchess,thismove(step))
        end
        testresult(test,:)=[firstmove max(testscore)];
    end
    maxscore=0;
    for i=1:4
        meanscore(i)=(testresult(:,2)'*(testresult(:,1)==i))/(sum((testresult(:,1)==i)));
        if meanscore(i)>=maxscore
            maxscore=meanscore(i);
            bestmove(m)=i;
        end
    end
    mscore(m)=maxscore;
    if maxscore==0
        break;
    end
    nextchess=movechess(chess,bestmove(m));
    chess=nextchess;
end
chess=2.^chess;
displaychess(chess)