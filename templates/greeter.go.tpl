# This is important! We don't want to create a greeter.go file

{{- $_ := file.Skip "Generates multiple files" }}
{{- define "greeter" -}}
{{- $greeting := .greeting }}
package greeter

import "fmt"

func main() {
    fmt.Println("{{$greeting}}, world!")
}

{{- end -}}

{{- range $_, $greeting := stencil.Arg "greetings" }}

# Create a new $greeting.go file

{{- file.Create (printf "greeter/%s.go" $greeting) 0600 now }}

# We'll render the template greeter with $greeting as the values being passed to it

# Once we've done that we'll use the output to set the contents of the file we just created.

{{ file.SetContents (stencil.ApplyTemplate "greeter" (dict "greeting" $greeting)) }}
{{- end }}
