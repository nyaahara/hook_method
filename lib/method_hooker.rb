# method_hooker
# @autor: Kazuya Hotta (nyanko)
#

class Class
    @@has_pre_method   = false
    @@has_post_method  = false
    @@pre_method_name  = ""
    @@post_method_name = ""

    def pre_execute_method(method_name) 
        return nil if @@has_post_method

        @@pre_method_name = method_name.id2name
        pre_method        = instance_method(@@pre_method_name)

        method_list = instance_methods(false)
        method_list.delete(@@pre_method_name)

        method_list.each do |hook_method_name|
            hook_method = instance_method(hook_method_name)
            define_method(hook_method_name) do |*args|
                pre_method.bind(self).call
                hook_method.bind(self).call(*args)
            end
        end
        @@has_pre_method = true
    end

    def post_execute_method(method_name) 
        return nil if @@has_pre_method

        @@post_method_name = method_name.id2name
        post_method        = instance_method(@@post_method_name)

        method_list = instance_methods(false)
        method_list.delete(@@post_method_name)

        method_list.each do |hook_method_name|
            hook_method = instance_method(hook_method_name)
            define_method(hook_method_name) do |*args|
                hook_method.bind(self).call(*args)
                post_method.bind(self).call
            end
        end
        @@has_post_method = true
    end

    def around_execute_method(*method_names) 
        return nil if (@@has_pre_method || @@has_post_method )

        @@pre_method_name  = method_names[0].id2name
        @@post_method_name = method_names[1].id2name

        pre_method  = instance_method(@@pre_method_name)
        post_method = instance_method(@@post_method_name)

        method_list = instance_methods(false)
        method_list.delete(@@pre_method_name)
        method_list.delete(@@post_method_name)

        method_list.each do |hook_method_name|
            hook_method = instance_method(hook_method_name)
            define_method(hook_method_name) do |*args|
                pre_method.bind(self).call
                hook_method.bind(self).call(*args)
                post_method.bind(self).call
            end
        end
        @@has_pre_method  = true
        @@has_post_method = true
    end

    def has_pre_method
        return @@has_pre_method
    end

    def has_post_method
        return @@has_post_method
    end

    def pre_method_name
        return @@pre_method_name
    end

    def post_method_name
        return @@post_method_name
    end
end
