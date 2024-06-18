function [dim, fobj] = Get_Functions_details_UFLP(F)
    switch F

        case 'Cap41'
            fobj = @(bees) objective(bees, 'Cap41');
            dim = get_dimension('Cap41');
        case 'Cap42'
            fobj = @(bees) objective(bees, 'Cap42');
            dim = get_dimension('Cap42');
        case 'Cap43'
            fobj = @(bees) objective(bees, 'Cap43');
            dim = get_dimension('Cap43');
        case 'Cap44'
            fobj = @(bees) objective(bees, 'Cap44');
            dim = get_dimension('Cap44');
        case 'Cap61'
            fobj = @(bees) objective(bees, 'Cap61');
            dim = get_dimension('Cap61');
        case 'Cap62'
            fobj = @(bees) objective(bees, 'Cap62');
            dim = get_dimension('Cap62');
        case 'Cap63'
            fobj = @(bees) objective(bees, 'Cap63');
            dim = get_dimension('Cap63');
        case 'Cap64'
            fobj = @(bees) objective(bees, 'Cap64');
            dim = get_dimension('Cap64');
        case 'Cap71'
            fobj = @(bees) objective(bees, 'Cap71');
            dim = get_dimension('Cap71');
        case 'Cap72'
            fobj = @(bees) objective(bees, 'Cap72');
            dim = get_dimension('Cap72');
        case 'Cap73'
            fobj = @(bees) objective(bees, 'Cap73');
            dim = get_dimension('Cap73');
        case 'Cap74'
            fobj = @(bees) objective(bees, 'Cap74');
            dim = get_dimension('Cap74');
        case 'Cap81'
            fobj = @(bees) objective(bees, 'Cap81');
            dim = get_dimension('Cap81');
        case 'Cap82'
            fobj = @(bees) objective(bees, 'Cap82');
            dim = get_dimension('Cap82');
        case 'Cap83'
            fobj = @(bees) objective(bees, 'Cap83');
            dim = get_dimension('Cap83');
        case 'Cap84'
            fobj = @(bees) objective(bees, 'Cap84');
            dim = get_dimension('Cap84');
        otherwise
            error('Invalid function name');
    end
end


function dim = get_dimension(Function_Name)
    filepath = strcat('C:\Users\DELL\Desktop\Main Binary Version\G-BPSO\Dataset_UFLP\GBPSO Code/', Function_Name, '.txt');
    if ~isfile(filepath)
        error('The file %s could not be found.', filepath);
    end
    data = readlines(filepath);
    temp = strsplit(strip(data(1)), ' ');
    numOfFactories = str2num(temp{1});
    numOfCustomers = str2num(temp{2});
    dim = numOfFactories;
end

function cost = objective(bees, Function_Name)
    global matris;
    matris = dosya2mat(strcat('C:\Users\DELL\Desktop\Main Binary Version\G-BPSO\Dataset_UFLP\GBPSO Code/', Function_Name, '.txt'));
    if sum(bees) < 1
        cost = Inf;
    else
        bees = bees(:)'; % Ensure bees is a row vector
        cost = sum(matris.fixCost .* bees);
        costAlloc = matris.costAlloc;
        for i = 1:matris.numOfCustomers
            cost = cost + min(costAlloc(i, bees > 0));
        end
    end
end

function matris = dosya2mat(problem)
    data = readlines(problem);
    indx = 1;
    temp = strsplit(strip(data(1)), ' ');
    numOfFactories = str2num(temp{1});
    numOfCustomers = str2num(temp{2});
    fixCost = zeros(1, numOfFactories);
    capacity = zeros(1, numOfFactories);
    demands = zeros(1, numOfCustomers);
    costAlloc = zeros(numOfCustomers, numOfFactories);
    indx = indx + 1;

    for n = 1:numOfFactories
        temp = strsplit(strip(data(indx)), ' ');
        indx = indx + 1;
        if ~strcmp(temp{1}, 'capacity')
            capacity(n) = str2num(temp{1});
        end
        fixCost(n) = str2double(temp{2});
    end

    for n = 1:numOfCustomers
        demands(n) = str2num(data(indx));
        indx = indx + 1;
        count = 1;
        while count <= numOfFactories
            temp = str2double(strsplit(strip(data(indx)), ' '));
            indx = indx + 1;
            num = size(temp, 2);
            costAlloc(n, count:count + num - 1) = temp;
            count = count + num;
        end
    end

    matris.numOfCustomers = numOfCustomers;
    matris.numOfFactories = numOfFactories;
    matris.capacity = capacity;
    matris.fixCost = fixCost;
    matris.demands = demands;
    matris.costAlloc = costAlloc;
end