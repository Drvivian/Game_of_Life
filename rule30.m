clear;
clc;

mapSize.height = 20;
mapSize.length = 30;

inMap = zeros(mapSize.height,mapSize.length);
inMap(8,16) = 1;
inMap(9,17) = 1;
inMap(10,15:1:17) = 1;


padMap = zeros(mapSize.height+2, mapSize.length+2);
nextArr = zeros(mapSize.height,mapSize.length);
nextState = 0;


while 1
    
    image(255*(uint8(inMap)));
    drawnow;
    pause(0.1);
    
    %%inserts inMap into padmap, surrounded by square of zeroes
    padMap(2:(mapSize.height+1), 2:(mapSize.length+1)) = inMap;
    %Accounts for wrap around, placing bottom row of inMap on top of padMap
    padMap(1,2:mapSize.length+1) = inMap(end,:);
    %places first row of inMap on bottom of padMap
    padMap(end, 2:mapSize.length+1) = inMap(1,:);
    padMap(2:mapSize.height+1, 1) = inMap(:, end);
    padMap(2:mapSize.height+1,end) = inMap(:,1);

    for j = 2:mapSize.height+1
        for i = 2:mapSize.length+1
            cell = padMap(j, i);
            %adding the neighbours around cell
            top = padMap(j-1,(i-1):(i+1));
            bottom = padMap(j+1,(i-1):(i+1));
            sides = [padMap(j,i-1),padMap(j,i+1)];
            cellNebs = sum(top) + sum(bottom) + sum(sides);
            
            switch cell
                case 0
                    if cellNebs == 3
                        nextState = 1;
                    else
                        nextState = 0;
                    end
                    
                case 1
                    if (cellNebs < 2)||(cellNebs > 3)
                        nextState = 0;
                    else
                        nextState = 1;
                    end
            end
            
            nextArr(j-1,i-1) = nextState;
        end
    end
    inMap = nextArr;
end

