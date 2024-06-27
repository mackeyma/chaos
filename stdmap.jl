using Random

const a = 0.971635
f(x) = (rem2pi(x[1] + x[2] + a*sin(x[1]), RoundDown),
          rem2pi(x[2] + a*sin(x[1]), RoundDown))

X = Tuple{Float64,Float64}[]
for i in 1:50
    global X
    Random.seed!(i)
    x = 2π .* (rand(), rand())
    for i in 1:500
        x = f(x)
        push!(X,x)
    end
end

using Plots
gr(aspect_ratio=1, legend=:none)
fig = scatter(X, markersize=1)
