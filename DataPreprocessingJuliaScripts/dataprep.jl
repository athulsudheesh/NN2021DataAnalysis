
using DataFrames
using CSV


function cleanData(file=filename)
    datapath = joinpath(pwd(), "..", "rawData")
    filepath = joinpath(datapath,file)
    rawdata = CSV.read(filepath, DataFrame)

    # We only need 3 columns: Student Name, Correct & Problem ID
    sliceddata = select(rawdata, [Symbol("Student Name"), :Correct, Symbol("Problem ID")])

    # Converting from long-form data to wide-form
    itemresponses = unstack(sliceddata, Symbol("Problem ID"), :Correct)
    #X = unstack(Exam1responses, Symbol("Problem ID"), :Correct)
    
    # Dropping the student names
    select!(itemresponses, Not(:"Student Name"))

    # Replacing missing values with 0
    coalesce.(itemresponses, 0)
end 

X1 = cleanData("E1.csv")
X2 = cleanData("E2.csv")
X3 = cleanData("E3.csv")
X4 = cleanData("FE.csv")
cleandatapath = joinpath(pwd(), "..", "cleanData")
CSV.write(joinpath(cleandatapath,"X1.csv"), X1)
CSV.write(joinpath(cleandatapath,"X2.csv"), X2)
CSV.write(joinpath(cleandatapath,"X3.csv"), X3)
CSV.write(joinpath(cleandatapath,"FE.csv"), X4)

H1 = cleanData("HW1.csv")
H2 = cleanData("HW2.csv")
H3 = cleanData("HW3.csv")
CSV.write(joinpath(cleandatapath,"HW1.csv"), H1)
CSV.write(joinpath(cleandatapath,"HW2.csv"), H2)
CSV.write(joinpath(cleandatapath,"HW3.csv"), H3)


