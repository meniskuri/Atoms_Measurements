function [gr_magn,G,G_max] =  GradF(dat_for_grad) % moxseni comentari da gadaakete func

format long
M         = length(dat_for_grad(:,1));
N         = length(dat_for_grad(1,:));
G         = zeros(M,N);
G_max = 0;

for m = 1:M
    for n=1:N
        %
        if n>1
            eval(['p',int2str(n-1),' = dat_for_grad(',int2str(m),',',int2str(n-1),');']);
        end
        %
        for k =1:2
            
            eval(['p',int2str(n),' = dat_for_grad(',int2str(m),',',int2str(n),');']);
            eval(['delta = p',int2str(n),'*0.01/100'])
            eval(['gr_p1 = p',int2str(n),'+ delta/2'])
            eval(['gr_p2 = p',int2str(n),'- delta/2'])
            %
            if k == 1
                eval(['p',int2str(n),' = gr_p1'])
            else
                eval(['p',int2str(n),' = gr_p2'])
            end
            %
            if n ~= N
                for set_par = n:1:(N-1)
                    eval(['p',int2str(set_par+1),' = dat_for_grad(',int2str(m),',',int2str(set_par+1),');'])
                end
            end
            % <===
            [Z,mat_par] = OPT_FUNC_RUN_SPICE(p1,p2,p3,p4,...
                p5,p6,p7,p8,p9,p10,p11,p12,p13,...
                p14,p15,p16,p17,p18,p19,p20,p21,p22,p23,p24);
            
            if k == 1
                mat_par_plus = mat_par;
            else
                mat_par_minus = mat_par ;
            end
        end
        
        G(m,n) = (mat_par_plus - mat_par_minus)/delta;
        Z;
        
    end
end

for k=1:1:length(G(:,1))
    G_max(k,1) = sqrt(sum(G(k,:).^2));
end

max_dat   = 0;
max_index = 0;
[max_dat,max_index] = max(G_max);
 
G_max = G(max_index,:);  % <=== max gradienti
gr_magn = dat_for_grad(max_index,:);  % <=== max gradientis archeuli parametrebi


