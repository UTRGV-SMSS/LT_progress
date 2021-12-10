using CSV, DataFrames

data = DataFrame(CSV.File("gb.csv"))
lts = DataFrame(CSV.File("learningtargets.csv"))


long_names = names(data)

col_names = replace(long_names) do name
    if contains(name, "-ws") || contains(name, "-ex")
        m = match(r"((.*-ws)|(.*-ex)).*", name)
        return m[1]
    elseif contains(name, "WeBWorK") || contains(name, "Webwork") || 
            contains(name, "Homework") || contains(name, "HW") ||
            contains(name, "homework") || contains(name, "webwork")

        return "hw_grade"
    else
        return name
    end

end

rename!(data, long_names .=> col_names)

# previewusers = findall(contains("previewuser"), data.Username)
# delete!(data, previewusers)


NUMERAL_MAP = Dict(
    "1" => "I",
    "2" => "II",
    "3" => "III",
    "4" => "IV",
    "5" => "V",
    "6" => "VI",
    "7" => "VII",
    "8" => "VIII",
    "9" => "IX",
)

lt_regex = r"(\w+)(\d+)"


function write_student(student, file)
    name = "\\name{" *  student."First Name" * " " * student."Last Name" * "}"
    email = "\\email{" * student."Username" * "}"
    hw_grade = "\\hwgrade{$(student.hw_grade)}"
    write(file, name)
    write(file, email)
    write(file, hw_grade)
    write(file, "\\maketitle\n")
    for lt in lts.Name
        lt_ws = lt * "-ws"
        lt_ex = lt * "-ex"
        m = match(lt_regex, lt)
        lt_roman = "\\"  * m[1] * NUMERAL_MAP[m[2]] * "set"
        if !ismissing(student[lt_ws]) && student[lt_ws] == 1.0
            lt_ws_str = lt_roman * "{1}"
        else
            lt_ws_str = lt_roman * "{0}"
        end
        if !ismissing(student[lt_ex]) && student[lt_ex] == 1.0
            lt_ws_str = lt_ws_str * "{1}\n"
        else
            lt_ws_str = lt_ws_str * "{0}\n"
        end
        write(file, lt_ws_str)
    end
    write(file, "\\input{table}\n")
    write(file, "\\newpage\n")
    write(file, "\n\n")
end


filename = "all_students.tex"
open(filename, "w") do file
    write(file, "\\input{head.tex}\n\n\n")
    for student in eachrow(data)
        write_student(student, file)
    end
    write(file, "\n\n\n\\end{document}")
end



try 
    mkdir("students")
catch IOError
    println("directory 'students' already exists")
end



for student in eachrow(data)
    username = match(r"(.*)@utrgv.edu", student."Username")
    filename = "students/" * username[1] * ".tex"
    open(filename, "w") do file
        write_student(student, file)
    end
end