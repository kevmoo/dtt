I want to create tools and libraries that make it easy for a Dart developer deploy a (Google) Cloud Run service (function) that responds to a Trigger from (Google) Event Arch



My initial thoughts:



(1) we'd want to be able to enumerate all of the available triggers in the event arch project

(2) we'd want to be able to discover the "types" (likely protobuf, grpc) associated with a trigger and generate the associated Dart code

(3) we'd want to stub out a Dart handler for a given event and make it easy for the user
to write the logic that handles the event.

(4) Make it easy to deploy the cloud run service to Google Cloud Run with the associated
event/trigger configuration.

- I'm thinking using terraform might be a good path here, but we should research.


We have a BUNCH of existing code that can likely help here, including bits on https://github.com/googleapis/google-cloud-dart/



Let's make a plan!
