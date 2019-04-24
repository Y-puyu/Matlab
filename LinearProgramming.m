f = [-2; -3; 5];
a = [-2, 5, -1;1 ,3 ,1];
b= [-10;12];
aeq = [1,1,1];
beq = 7;
[x, y] = linprog(f, a, b, aeq, beq, zeros(3,1));
a





f = [3; -4; 2; -5];
a = [1, 1, 3, -1; 2, -3, 1, -2];
b= [14; -2];
aeq = [4, -1, 2, -1];
beq = -2;
[x, y] = linprog(f, a, b, aeq, beq, zeros(3,1));
x, y = -y


// 处理无约束项时   zeros = [0,0,0,-inf]  以下界无穷小作为约束，ok