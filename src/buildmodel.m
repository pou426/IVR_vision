% build model mean feature vector (Mean) and inverse of covariance matrices
% (Invcors) for Numclass classes given a set of N classified (Classes) observed
% feature vectors (Vecs) of Dim dimension
function [Means,Invcors,Aprioris] = buildmodel(Dim,Vecs,N,Numclass,Classes)

    Means = zeros(Numclass,Dim);
    %Means
    size(Means)
    Invcors = zeros(Numclass,Dim,Dim);
    %Invcors
    for i = 1 : Numclass
        i
        % get means for class i
        samples = find(Classes == i);
        samples
        M = length(samples);       % number of observations
        M
        if M < 2
            ['Error: class ',int2str(i),' has insufficient data']
            Means(i,:) = zeros(1,Dim);
            Invcors(i,:,:) = zeros(Dim,Dim);
            for j = 1 : Dim
              Invcors(i,j,j) = 1;
            end
        else
            classvecs = Vecs(samples,:);
            %classvecs
            mn = mean(classvecs);
            %mn
            size(mn)
            Means(i,:) = mn;
            %Means
            diffs = classvecs - ones(M,1)*mn;
            %diffs
            Invcors(i,:,:) = inv(diffs'*diffs/(M-1));
            %Invcors
        end
        Aprioris(i)=M/N;
        %N
    end

