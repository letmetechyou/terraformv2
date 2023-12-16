This Lab creates a hub and spoke network using terraform.  This creates everything needed to get the peering connections for both spoke networks to communicate with the hub network.

If you would like to get this to fully communicate with both spoke networks, watch my youtube video here or follow these steps.

1. Create 2 route tables
2. Assign a route table to both spoke subnets
3. In both subnets create a route that points to the other sides ip cidr range allowing all ports and protocols
4. In the azure firewall make a rule collection that allows for both routes to communication back and forth on all ports and protocols.