function [ avgauc ] = avgauc( pred, target )
   avgauc = 0;
   for i=1:size(pred,2)
        y = pred(:,i);
        t = target(:,i);
        if mean(t) == 1 || mean(t) == -1 
            if mean(t) == 1
                auc_tmp = 1;
            else
                auc_tmp = 0;
            end
        else
            
           [~,~,~,auc_tmp] = perfcurve(t,y,1);
        end
        avgauc = avgauc + auc_tmp/size(pred,2);
    end

end

