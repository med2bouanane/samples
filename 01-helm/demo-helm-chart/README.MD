# Description Content 
- The templates/ directory is for template files. When Helm evaluates a chart, it will send all of the files in the templates/ directory through the template rendering engine. It then collects the results of those templates and sends them on to Kubernetes.

- The values.yaml file is also important to templates. This file contains the default values for a chart. These values may be overridden by users during helm install or helm upgrade.

- The Chart.yaml file contains a description of the chart. You can access it from within a template.

- The charts/ directory may contain other charts (which we call subcharts). Later in this guide we will see how those work when it comes to template rendering.