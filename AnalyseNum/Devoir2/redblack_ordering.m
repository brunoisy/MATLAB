function [Abr]=redblack_ordering(n,A)
%fonction qui renvoit la matrice Abr du reordonnement red-black ordering
%de la matrice A
%
%cas n pair:ex pour n=4
%lignes noires de Abr correspondent aux lignes 2,4,5,7,10,12,13 et 15 de A
%lignes rouges de Abr correspondent aux lignes 1,3,6,8,9,11,14 et 16 de A
%
%cas n impair: lignes noires de Abr correspondent aux lignes pairs de A
%et les lignes rouges de Abr correspondent aux lignes impairs de A
%
% n^2= ordre de la matrice A avec n>=3
Abr=eye(n^2);
%%%%%%%%%%%%%%%%%%%%%%%
%%%% si n est pair %%%%
%%%%%%%%%%%%%%%%%%%%%%%
if mod(n,2)==0 
    e=-1;
    v=3;
    x=1; %numero de ligne
    while x<=(n^2)/2 %LIGNES noires
        if v==1 %si ligne paire
            e=e+1;
            for l=1:n/2
                %%%%%%%%% COLONNES noires
                c=-1;
                s=3;
                y=1;%numero de colonne
                while y<=(n^2)/2 
                    if s==1 %colonne paire
                        c=c+1;
                        for k=1:n/2
                            Abr(x,y)=A(e,c);
                            c=c+2;
                            y=y+1;
                        end
                        c=c-2;
                        s=3;
                    else %colonne impair
                        c=c+3;
                        for k=1:n/2
                            Abr(x,y)=A(e,c);
                            c=c+2;
                            y=y+1;
                        end
                        c=c-2;
                        s=1;
                    end
                end
                %%%%%%%%% COLONNES rouges
                d=0;
                s=1;
                y=(n^2)/2 +1;
                while y<=n^2 
                    if s==3 %colonne paire
                        d=d+3;
                        for k=1:n/2
                            Abr(x,y)=A(e,d);
                            d=d+2;
                            y=y+1;
                        end
                        d=d-2;
                        s=1;
                    else %colonne impair
                        d=d+1;
                        for k=1:n/2
                            Abr(x,y)=A(e,d);
                            d=d+2;
                            y=y+1;
                        end
                        d=d-2;
                        s=3;
                    end
                end
                %%%%%%%%%
                e=e+2;
                x=x+1;
            end
            e=e-2;
            v=3;
        else %si ligne impaire
            e=e+3;
            for l=1:n/2 
                %%%%%%%%% colonnes noires
                c=-1;
                s=3;
                y=1;
                while y<=(n^2)/2 
                    if s==1 %colonne paire
                        c=c+1;
                        for k=1:n/2
                            Abr(x,y)=A(e,c);
                            c=c+2;
                            y=y+1;
                        end
                        c=c-2;
                        s=3;
                    else %colonne impair
                        c=c+3;
                        for k=1:n/2
                            Abr(x,y)=A(e,c);
                            c=c+2;
                            y=y+1;
                        end
                        c=c-2;
                        s=1;
                    end
                end
                %%%%%%%%% colonnes rouges
                d=0;
                s=1;
                y=(n^2)/2 +1;
                while y<=n^2 
                    if s==3 %colonne paire
                        d=d+3;
                        for k=1:n/2
                            Abr(x,y)=A(e,d);
                            d=d+2;
                            y=y+1;
                        end
                        d=d-2;
                        s=1;
                    else %colonne impair
                        d=d+1;
                        for k=1:n/2
                            Abr(x,y)=A(e,d);
                            d=d+2;
                            y=y+1;
                        end
                        d=d-2;
                        s=3;
                    end
                end
                %%%%%%%%%
                e=e+2;
                x=x+1;
            end
            e=e-2;
            v=1;
        end
    end
    f=0;
    w=1;
    x=(n^2)/2+1;
    while x<=n^2 %LIGNES rouges
        if w==3 %si ligne paire
            f=f+3;
            for l=1:n/2
                %%%%%%%%% colonnes noires
                c=-1;
                s=3;
                y=1;
                while y<=(n^2)/2 
                    if s==1 %colonne paire
                        c=c+1;
                        for k=1:n/2
                            Abr(x,y)=A(f,c);
                            c=c+2;
                            y=y+1;
                        end
                        c=c-2;
                        s=3;
                    else %colonne impair
                        c=c+3;
                        for k=1:n/2
                            Abr(x,y)=A(f,c);
                            c=c+2;
                            y=y+1;
                        end
                        c=c-2;
                        s=1;
                    end
                end
                %%%%%%%%% colonnes rouges
                d=0;
                s=1;
                y=(n^2)/2 +1;
                while y<=n^2 
                    if s==3 %colonne paire
                        d=d+3;
                        for k=1:n/2
                            Abr(x,y)=A(f,d);
                            d=d+2;
                            y=y+1;
                        end
                        d=d-2;
                        s=1;
                    else %colonne impair
                        d=d+1;
                        for k=1:n/2
                            Abr(x,y)=A(f,d);
                            d=d+2;
                            y=y+1;
                        end
                        d=d-2;
                        s=3;
                    end
                end
                %%%%%%%%%
                f=f+2;
                x=x+1;
            end
            f=f-2;
            w=1;
        else %si ligne impair
            f=f+1;
            for l=1:n/2 
                %%%%%%%%% colonnes noires
                c=-1;
                s=3;
                y=1;
                while y<=(n^2)/2 
                    if s==1 %colonne paire
                        c=c+1;
                        for k=1:n/2
                            Abr(x,y)=A(f,c);
                            c=c+2;
                            y=y+1;
                        end
                        c=c-2;
                        s=3;
                    else %colonne impair
                        c=c+3;
                        for k=1:n/2
                            Abr(x,y)=A(f,c);
                            c=c+2;
                            y=y+1;
                        end
                        c=c-2;
                        s=1;
                    end
                end
                %%%%%%%%% colonnes rouges
                d=0;
                s=1;
                y=(n^2)/2 +1;
                while y<=n^2 
                    if s==3 %colonne paire
                        d=d+3;
                        for k=1:n/2
                            Abr(x,y)=A(f,d);
                            d=d+2;
                            y=y+1;
                        end
                        d=d-2;
                        s=1;
                    else %colonne impair
                        d=d+1;
                        for k=1:n/2
                            Abr(x,y)=A(f,d);
                            d=d+2;
                            y=y+1;
                        end
                        d=d-2;
                        s=3;
                    end
                end
                %%%%%%%%%
                f=f+2; 
                x=x+1;
            end
            f=f-2;
            w=3;
        end
    end
%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% si n est impair %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%
else 
    for i=1:(n^2-1)/2 %lignes noires
        for j=1:(n^2-1)/2 %colonnes noires
            Abr(i,j)=A(2*i,2*j);
        end
        b=0;
        for j=((n^2-1)/2)+1:n^2 %colonnes rouges
            Abr(i,j)=A(2*i,1+2*b);
            b=b+1;
        end
    end
    a=0;
    for i=((n^2-1)/2)+1:n^2 %lignes rouges
        for j=1:(n^2-1)/2 %colonnes noires
            Abr(i,j)=A(1+2*a,2*j);
        end
        b=0;
        for j=((n^2-1)/2)+1:n^2 %colonnes rouges
            Abr(i,j)=A(1+2*a,1+2*b);
            b=b+1;
        end
        a=a+1;
    end
end
            
    
end