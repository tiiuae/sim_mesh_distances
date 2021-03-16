#ifndef _SIM_MESH_DISTANCES_HPP_
#define _SIM_MESH_DISTANCES_HPP_

#include <sys/types.h>
#include <sys/socket.h>
#include <rclcpp/rclcpp.hpp>

class SimMeshDistPrivate;

class SimMeshDist : public rclcpp::Node
{
public:
    SimMeshDist();
    virtual ~SimMeshDist();

    void udp_poll();
    void get_address(std::string &addr, uint16_t &port);
private:
    std::unique_ptr<SimMeshDistPrivate> _impl;
};

#endif // _SIM_MESH_DISTANCES_HPP_
