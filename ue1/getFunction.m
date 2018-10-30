function f = getFunction(filename)
X = table2array(readtable(filename));
len = size(X,1);
%X = X(1:len,:);
if mod(len,2) ~= 0
    X = X(1:len-1,:);
end
    
count = 1;

for i = 1:2:size(X,1)
    X(count,:) = 0.5*( X(i,:) + X(i+1,:));
    count = count + 1;
end

x = X(:,1);
y = X(:,2);

f = fit(x,y,'poly4');
plot(f,x,y);