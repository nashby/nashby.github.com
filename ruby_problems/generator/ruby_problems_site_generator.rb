require 'erubis'

class RubyProblemsSiteGenerator

    def initialize(problems_path, tests_path, erubis_path, html_output)
        @problems_path = problems_path
        @tests_path = tests_path
        @eruby = Erubis::Eruby.new(File.read(erubis_path))
        @html_output = html_output
    end
    
    def generate
        #folders
        problems_folders = Dir.entries(@problems_path) - [".", ".."]
        test_folders = Dir.entries(@tests_path) - [".", "..", 'test_helper.rb']       
        
        problems_folders.each_index do |i|
            
            #files
            problems_files = Dir.entries(File.join(@problems_path, problems_folders[i])) - [".", ".."]
            test_files = Dir.entries(File.join(@tests_path, test_folders[i])) - [".", ".."]
            
            #data for template
            problems = []
            
            problems_files.each_with_index do |file, j|
                hash_problem = {}
                hash_problem[:task] = ""
                hash_problem[:num]  = file[0..-4]
                problem_file = File.open(File.join(@problems_path, problems_folders[i], file))
                test_file = File.open(File.join(@tests_path, test_folders[i], file.insert(0, "test_")))
                code = ""
                test = ""
                hash_problem[:category] = problems_folders[i]
                while (line = problem_file.gets)
                    if line == "#TODO"
                        code << "not yet implemented :( \n Fork it - <a href='https://github.com/nashby/ruby_kick_prologs_ass' style='color:#FFFFFF'>https://github.com/nashby/ruby_kick_prologs_ass</a>"
                    elsif line[0] != "#" and line != "\n"
                        code << line 
                    else
                        hash_problem[:task]  << line if hash_problem[:task].empty?
                    end
                end
                code << "\n                        "
                hash_problem[:task].delete!("#")
                while (line = test_file.gets)
                    if line == "#TODO"
                        test << "not yet implemented :( \n Fork it - <a href='https://github.com/nashby/ruby_kick_prologs_ass' style='color:#FFFFFF'>https://github.com/nashby/ruby_kick_prologs_ass</a>"
                    else
                        test << line if line[0] != "#" and line[1] != "#"
                    end
                end
                hash_problem[:code] = code
                hash_problem[:test] = test
                problems << hash_problem
            end
               
             out = File.new(File.join(@html_output, problems_folders[i])+".html", "w")
             out.puts(@eruby.result(:problems => problems))
             out.close            
        end

    end
    
end

g = RubyProblemsSiteGenerator.new("D:\\Programming\\MyProgramming\\ruby_kick_prologs_ass\\problems", "D:\\Programming\\MyProgramming\\ruby_kick_prologs_ass\\test", "D:\\Programming\\MyProgramming\\ruby_problems_site_generator\\template.eruby", "D:\\Programming\\MyProgramming\\nashby.github.com\\ruby_problems")
g.generate