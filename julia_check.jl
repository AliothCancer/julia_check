#!~/.juliaup/bin/julia


using Pkg
using JET
using Dates 

println("PWD: $(pwd()) \n\n")
# --- Configurazione ---
target_file = joinpath(pwd(), ARGS[1])
println("target file is: $target_file")
project_dir = pwd()

# --- Attivazione Ambiente ---
println("Attivando l'ambiente in: $project_dir")
Pkg.activate(project_dir)
println("Ambiente attivato.")

# --- Funzione per eseguire l'analisi ---
function run_analysis(file_path)
    println("\n$(Dates.now()): Rilevata modifica, eseguo analisi JET per: $file_path")

    println(report_package(target_defined_modules=true))

end

# --- Loop di Monitoraggio ---

println("Avvio monitoraggio del file: $target_file")
println("Premi Ctrl+C per uscire.")

last_modified = 0.0
function watch()
    global last_modified
    try
        while true
            current_modified = mtime(target_file) # Data di ultima modifica

            if current_modified > last_modified
                run(`clear`)
                run_analysis(target_file)
                last_modified = current_modified
            end


            sleep(0.5)
        end
    catch InterruptException
        println("Program terminated by the user")
        return 0
    end
end

function get_file_path()::Union{String,Nothing}
    if length(ARGS) > 0
        println("Arguments received:")
        for (i, arg) in enumerate(ARGS)
            println("  Argument $i: '$arg' (Type: $(typeof(arg)))")
        end

        arg_len = length(ARGS)
        # Example: Accessing a specific argument by index
        if arg_len == 1
            first_arg = ARGS[1]
            println("\nFirst argument is: '$first_arg'")
            return first_arg
        elseif arg_len > 1
            println("Too much args provided, only need 1 arg")
            return "TooMuchArgs"
        end

    else
        println("No arguments were provided.")
    end
end

file_path = get_file_path()

if !isnothing(file_path) && file_path != "TooMuchArgs"
    run(`clear`)
    println("Running JET analysis... please wait! first run is slow")
    run_analysis(target_file)
    watch()
else
    println("File path not received, exiting...")
end
