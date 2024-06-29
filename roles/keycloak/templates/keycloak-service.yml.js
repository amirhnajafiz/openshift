apiVersion: v1
kind: Service
metadata:
  name: keycloak
spec:
  ports:
  - port: 8080
    targetPort: 8080
    protocol: TCP
    name: http
  - port: 8443
    targetPort: 8443
    protocol: TCP
    name: https
  selector:
    app: keycloak
  type: LoadBalancer
