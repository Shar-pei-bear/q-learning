% init our Q-table
Qvalue = zeros(25,4);
s = [5,5];%
% cannot go up in the first row
I = ones(1,5);
J = 1:5;
linearInd = sub2ind(s,I,J);
Qvalue(linearInd,3) = -Inf;
% cannot go down in the last row
I = 5*ones(1,5);
J = 1:5;
linearInd = sub2ind(s,I,J);
Qvalue(linearInd,4) = -Inf;
% cannot go left in the first column
I = 1:5;
J = ones(1,5);
linearInd = sub2ind(s,I,J);
Qvalue(linearInd,1) = -Inf;
%c cannot go right in the last column
I = 1:5;
J = 5*ones(1,5);
linearInd = sub2ind(s,I,J);
Qvalue(linearInd,2) = -Inf;
% where the enemy is
EnemyInd = sub2ind(s,[2,2,4,4],[2,4,2,4]);
% where the princess is
PrincessInd = sub2ind(s,5,3);
% exploration rate
epsilon = 1;
decay = 0.999;
% learning rate
alpha = 1;
% discount
discount = 0.9;
iteration = 1;
while iteration < 1000
% initial state
    state = randi(size(Qvalue,1));
    while all(state ~= EnemyInd) && all(state ~= PrincessInd)
        % choose an action a
        if rand > epsilon
            [~,action] = max(Qvalue(state,:)); % exploitation
        else
            action = randi(size(Qvalue,2)); % exploration
        end
        [state_I, state_J] = ind2sub(s,state);
        % perform action
        if action == 1
            state_J = state_J - 1;
        elseif action == 2
            state_J = state_J + 1;
        elseif action == 3
            state_I = state_I - 1;
        elseif action == 4
            state_I = state_I + 1;
        end
        % check if index is out of range
        if state_J < 1 || state_J > s(2) || state_I > s(1) || state_I < 1
            continue;
        end
        % measure reward
        state_new = sub2ind(s,state_I,state_J);
        if any(state_new == EnemyInd)
            reward = -100;
        elseif any(state_new == PrincessInd)
            reward =  100;
        else
            reward = -1;
        end
        % update the Q-value table
        Qvalue(state,action) = Qvalue(state,action) + alpha*(reward + discount*max(Qvalue(state_new,:)) -Qvalue(state,action));
        % move to the next state
        state = state_new;
    end
    iteration = iteration +1;
    epsilon = epsilon * decay;
end