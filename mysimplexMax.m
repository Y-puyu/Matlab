function [x, result_case] = mysimplexMax(c, A, b, x0)

ind_B = find(x0 ~=0);
ind_N = find(x0 == 0);

while (1)
    B = A(:, ind_B);
    N = A(:, ind_N);
    x_B = x0(ind_B);
    x_N = x0(ind_N);
    c_B = c(ind_B);
    c_N = c(ind_N);

    s = c_N - N' * inv(B)' * c_B; 
    %
    if isempty(find(sign(s) > 0))
        % found optimal solution
        x = x0;
        result_case = 0;
        return
    end
    % 保证 s 有正数
    % 选最大的正检验数作为进基变量 q
    [max_q i_q] = max(s);
    q = ind_N(i_q);
    d = B \ A(:, q);
    if isempty(find(sign(d) > 0))
        % unbound case
        x = [];
        result_case = 1;
        break;
    end
    % 保证 d 有正数
    % 选择最小非负ratio 作为离基变量 p
    ratio_array = x_B./d;
    ratio = min(ratio_array((ratio_array > 0)));

    % 更新 x0 的值
    x0(ind_B) = x_B - ratio * d;
    e_iq = zeros(length(x_N), 1);
    e_iq(i_q) = 1;
    x0(ind_N) = x_N + ratio * e_iq;
    % 更新基本量，非基变量集合
    ind_B = find(x0 ~=0);
    ind_N = find(x0 == 0);
end
end

// 20190506
a=[1 2 1 0 0;4 0 0 1 0;0 4 0 0 1];
b0=[8;16;12];
c=[2 3 0 0 0];
x=[1 2 3 4 5;1 1 1 1 1];
[m,n]=size(a);
e=eye(3);
B=e;
xb=zeros(m,1);
xn=[];
cn=[];
cb=zeros(1,m);
xin=0;xout=0;
for j=1:m
    for i=1:n
        if a(:,i)==e(:,j)
            xb(j)=i;
            x(2,i)=0;
            cb(j)=c(i);
        end
    end
end
for i=1:n
    if x(2,i)==1
        xn=[xn;x(1,i)]
        cn=[cn,c(i)];
    end
end
b=b0;
jianyan=c;
jianyanmax=max(jianyan);
kk=1;
while(jianyanmax>0)
    in=find(jianyan==jianyanmax);
    xin=in;
P=B*a(:,in);
    xita=[1000;1000;1000];
    
    for i=1:m
        if P(i)>0
        xita(i)=b(i)/P(i);
        end
    end
    [minxita,out]=min(xita);
    xout=xb(out);
    xb(out)=xin;
    cb(out)=c(xin);
    weizhi=find(xn==xin);
    xn(weizhi)=xout;
    cn(weizhi)=c(xout);
    EE=e;
    EE(:,out)=P;
      E=inv(EE);
      B=E*B;
      bb=b0;
      b=B*bb;
      jianyan=c-cb*B*a;
      jianyanmax=max(jianyan);
      kk=kk+1;
End
