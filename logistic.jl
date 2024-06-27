using Plots: plot, plot!, scatter, theme
using Printf

function logistic(x, rvalue)
    return rvalue * x * (1.0 - x)
end

function check_str2(a)
    return tryparse(Float64, a) !== nothing
end

function run()
    ncols = 500
    niters = 100
    npts = ncols * niters
    ndiscarded = 100

    r = zeros(npts)
    y = zeros(npts)

    rstart = 2.0
    rend = 4.0
    rstep = (rend - rstart) / ncols

    rr = rstart

    for i in 1:ncols
        yy = 0.01

        for j in 1:ndiscarded
            yy = logistic(yy, rr)
        end

        index = trunc(Int, (i - 1) * niters)

        for j in 1:niters
            yy = logistic(yy, rr)

            y[index+j] = yy
            r[index+j] = rr
        end

        rr += rstep
    end

    r_wanted = 2.5 # - single solution
    # r_wanted = 3.25 # - period 2 regime
    # r_wanted = 3.55 # - period 4 regime
    # r_wanted = 3.83 # - inside window

    yvals = zeros(Float64, niters)
    colindex = trunc(Int, ((r_wanted - rstart) / rstep) * niters)
    for l in 1:niters
        yvals[l] = y[colindex+l]
    end

    display(plot(yvals, label="", xlabel="Time(s)", ylabel="y",
        title=@sprintf("r = %6.4f", r_wanted)))

    # plot the map
    display(scatter(r, y, label="", marker=:dot, markersize=0.1, xlabel="r", ylabel="y",
        title="Logistic Map", xlim=[rstart, rend], ylim=[0.0, 1.0]))

# while true
#         print("Enter value of r to get time series: (-1 to quit):")
#         str = readline()
#         fstr = chomp(str)

#         if !check_str2(fstr)
#             println("an invalid number was input")
#             continue
#         else
#             r_wanted = parse(Float64, fstr)
#         end

#         if r_wanted < 0
#             println("Exiting program")
#             break
#         elseif r_wanted < rstart || r_wanted > rend
#             println("Out of range value for r: ", r_wanted)
#             continue
#         end

#         println("r_wanted = ", r_wanted)
#         yvals = zeros(niters)
#         colindex = trunc(Int, ((r_wanted-rstart)/(rend-rstart)*ncols*niters))
#         println("colindex = ", colindex)
#         for l in range(1, niters)
#             yvals[l] = y[colindex + l]
#         end

#         plot(yvals, label="", xlabel="Time(s)", ylabel="y",
#              title=@sprintf("rstart = %6.4f", r_wanted))
#         println("Plot should be done")
#     end
end

run()