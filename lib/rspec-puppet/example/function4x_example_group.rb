# FIXME: This only works if future parser is enabled, or the Puppet Version is
# 4.0 or greater.
module RSpec::Puppet
  module Function4xExampleGroup
    # Inherit all behaviors of the existing function example group. We'll
    # override what needs to change.
    #
    # FIXME: This is extremely dangerous. and brittle.
    include FunctionExampleGroup

    # This adapter object conforms a 4x function to part of the interface
    # presented by a 3x function. This is a gross hack, but it allows us to
    # avoid re-implementing the FunctionMatchers for the time being.
    #
    # Components conformed:
    #
    #   - The scope attribute
    #   - The name attribute
    #   - The call method
    #
    # The wrapped 4x function is available via the `function` attribute.
    Function4Adapter = Struct.new(:function, :scope, :name) do
      def call(args)
        # Ensure that the arguments are wrapped in an enclosing array. This
        # allows:
        #
        #   - Calling the Function in the 3x manner: call([arg_one, arg_two])
        #   - Calling the Function in the 4x manner: call(arg_one, arg_two)
        function.call(scope, *Array(args))
      end
    end

    def subject
      function_name = self.class.top_level_description.downcase

      vardir = setup_puppet

      node_name = nodename(:function)
      function_scope = scope(compiler, node_name)

      # The "private environment laoder" is not "private" in the API sense, it
      # can see objects that have restricted visibility --- such as functions.
      # In the future, this will support a "private" keyword in the Puppet
      # Laguange, hence the name.
      loader = function_scope.compiler.loaders.private_environment_loader

      # Return the method instance for the function.  This can be used with
      # method.call
      function = loader.load(:function, function_name)
      FileUtils.rm_rf(vardir) if File.directory?(vardir)

      return nil if function.nil?
      Function4Adapter.new(function, function_scope, function_name)
    end

  end
end
