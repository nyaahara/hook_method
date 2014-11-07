# method_hooker
Hook the method call, You can specify the methods, which must be executed before or after the execution of the method.  
This library expand Class-class.  

Version: 1.0.0  
Compliant Rubys Version: 1.9.3, 2.0.0, 2.1.0 (for Linux)  
License: MIT  

## Example Code
<pre>
require 'method_hooker'

class Greet
    @@name = "babe"

    def hello
        puts "Hello, #{@@name}\n\n"
    end

    def goodmorning
        puts "Good Morning, #{@@name}\n\n"
    end

    def goodnight
        puts "Good Night, #{@@name}\n\n"
    end

    def pre
        puts "execute first"
    end

    def post
        puts "execute after"
    end

    pre_execute_method :pre  # Regist the method to be executed first

    #post_execute_method :post  # Regist the method to be executed after

    #around_execute_method :pre, :post   # Regist the method to be executed first and after
end

obj = Greet.new

obj.hello
obj.goodmorning
obj.goodnight

puts "\n"
puts "* Is set the method first run, when execute method?: #{Greet::has_pre_method}"
puts "  => #{Greet::pre_method_name}" if Greet::has_pre_method
puts "\n"
puts "* Is set the method after run, when execute method?: #{Greet::has_post_method}"
puts "  => #{Greet::post_method_name}" if Greet::has_post_method
</pre>

### Result  
<pre>
execute first
Hello, babe

execute first
Good Morning, babe

execute first
Good Night, babe


* Is set the method first run, when execute method?: true
  => pre

* Is set the method after run, when execute method?: false
</pre>
