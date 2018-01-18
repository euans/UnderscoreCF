component {
    public function init(obj, underscoreInstance) {
        if (! StructKeyExists(arguments, '_')) {
            arguments._ = new underscore();
        }

        variables._ = arguments._;
        variables.obj = arguments.obj;
        return this;
    }

    public any function value() {
        return variables.obj;
    }

    function onMissingMethod(string missingMethodName, struct missingMethodArguments) {
        var method = variables._[arguments.missingMethodName];
        var parameters = {};
        var count = 0;
        parameters.obj = variables.obj;

        for ( var parameter in getMetaData(method).parameters ) {
            count++;
            if ( count == 1 )
                parameters[parameter.name] = variables.obj;
            else if ( structKeyExists(arguments.missingMethodArguments, parameter.name) )
                parameters[parameter.name] = arguments.missingMethodArguments[parameter.name];
            else if ( structKeyExists(arguments.missingMethodArguments, count-1) ) 
                parameters[parameter.name] = arguments.missingMethodArguments[count-1];
        }

        variables.obj = method(argumentCollection = parameters);
        return this;
    }
}