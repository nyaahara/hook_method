# method_hooker
# @autor: Kazuya Hotta

class Class
  @@hooked = []
  def pre_execute_method(execute_method_name, hook_method_name)
    return if @@hooked.any?{|hook| hook.strategy == :pre && hook.execute_method_name == execute_method_name && hook.hook_method_name == hook_method_name}
    @@hooked << OpenStruct.new(strategy: :pre, execute_method_name: execute_method_name, hook_method_name: hook_method_name)
    pre_method = instance_method(execute_method_name.id2name)
    hook_method = instance_method(hook_method_name.id2name)
    define_method(hook_method_name) do |*args|
      pre_method.bind(self).call
      hook_method.bind(self).call(*args)
    end
  end

  def post_execute_method(execute_method_name, hook_method_name)
    return if @@hooked.any?{|hook| hook.strategy == :post && hook.execute_method_name == execute_method_name && hook.hook_method_name == hook_method_name}
    @@hooked << OpenStruct.new(strategy: :post, execute_method_name: execute_method_name, hook_method_name: hook_method_name)
    post_method = instance_method(execute_method_name.id2name)
    hook_method = instance_method(hook_method_name.id2name)
    define_method(hook_method_name) do |*args|
      hook_method.bind(self).call(*args)
      post_method.bind(self).call
    end
  end
end
