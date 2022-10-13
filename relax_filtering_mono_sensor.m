function [ IF,Xout ] = relax_filtering_mono_sensor( X,n_sources,win_length,delta,L,step,FFT_len,NA )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
Sig=X;

for i=1:n_sources
[IF(i,:),Xout(i,:)] = FASTEST_IF(Sig,win_length, 1, delta,L,0,0,step,FFT_len,NA);
Sig(NA)=Sig(NA)-Xout(i,NA);
end

Xout1 = ICCD_sparse(X,1,IF,1,3,0,NA);
Xout1=sum(Xout1);
Xoutt=X;
NB=find(X==0);
Xoutt(NB)=Xout1(NB);


%figure; plot(IF.')
%IF1=IF;
%Veccc1=Veccc;
    for i2=1:3
        % IF=IF1;
         %   Veccc=Veccc1;
           
        for i=1:n_sources
            Sig=X;
            %Sig(NA)=X(NA);
            %Sig=X;
            %size(Sig)
            for j=1:n_sources
                
                if i~=j   % REmove all components except i-th
                    [x,~] = TF_filtering(X,IF(j,:),NA);
                    Sig(NA)=Sig(NA)-x(NA);
                    %Sig=Sig-x;
                    
                    %[Sig] = TF_SF_filtering_new(Sig,Xout(i,:),Veccc(j,:));

                end
                
                
            end
            % Restimate i-th component
              [IF(i,:),Xout(i,:)] = FASTEST_IF(Sig,win_length, 1, delta,L,0,0,step,FFT_len,NA);
%I=HTFD_new1(Xout(i,:),3,8,64);
%figure;imagesc(I)
        end
    end
Xout1 = ICCD_sparse(X,1,IF,1,3,1,NA);
Xout1=sum(Xout1);
Xout=X;
NB=find(X==0);
Xout(NB)=Xout1(NB);
%Xout=Xout1;

end

