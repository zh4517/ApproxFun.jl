module ApproxFun
    using Base, NumericExtensions

export Fun,IFun,FFun,Interval,evaluate,values,points,chebyshevtransform
export pad!,pad,sample,chop!,complexroots,roots,plot,svfft
export multiplybyx,IntervalDomain,fasttimes

##Testing
export bisectioninv, clenshaw
export coefficients, integrate



abstract AbstractFun


## Helper routines
alternatingvector(n::Integer) = 2*mod([1:n],2)-1

function pad!(f::Vector,n::Integer)
	if (n > length(f))
		append!(f,zeros(n - length(f)))
	else
		resize!(f,n)
	end
end


function pad(f::Vector,n::Integer)
	if (n > length(f))
        [f,zeros(n - length(f))]
	else
        f[1:n]
	end
end

#TODO:padleft!

function padleft(f::Vector,n::Integer)
	if (n > length(f))
        [zeros(n - length(f)),f]
	else
        f[end-n+1:end]
	end
end



include("Domains.jl")

include("bary.jl")

##Chebyshev Routines
include("clenshaw.jl")
include("ultraspherical.jl")
include("IFun.jl")


##Fourier Routines
include("ShiftVector.jl")
include("FFun.jl")

include("Interval.jl")
include("PeriodicInterval.jl")
include("Circle.jl")


include("Operator.jl")
include("specialfunctions.jl")

include("VectorFun.jl")
include("Fun2D.jl")

include("sample.jl")


##Following routine decides
# whether input is IFun or FFun
Fun(x)=IFun(x)
Fun(x,d::IntervalDomain)=IFun(x,d)
Fun(x,d::PeriodicDomain)=FFun(x,d)
Fun(x,d)=IFun(x,d)
Fun(x,d::IntervalDomain,n::Integer)=IFun(x,d,n)
Fun(x,d::PeriodicDomain,n::Integer)=FFun(x,d,n)
Fun(x,d::Vector,n::Integer)=IFun(x,d,n)



## Other domains

include("Line.jl")

end #module


