function A = homoTransMat(Rab, rab)

    A = [Rab, rab;
        zeros(1,3),1];
end