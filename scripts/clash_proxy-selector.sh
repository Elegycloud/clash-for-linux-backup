#!/bin/bash

# Clash API地址
api_url="http://localhost:9090"
Secret="填写Clash Secret"

# 获取Clash代理节点列表
get_proxy_list() {
    # 使用您的命令获取代理节点列表
    proxies=$(curl -s -XGET -H "Content-Type: application/json" -H "Authorization: Bearer ${Secret}" $api_url/proxies | jq -r '.proxies.Proxy.all[]')
}

# 获取Clash代理模式列表
get_mode_list() {
    # 使用您的命令获取代理模式列表，例如：
    # modes=$(your_command_to_get_mode_list)
    # 将代理模式列表保存到变量modes中
    modes=("Global" "Rule")
}

# 显示菜单选项
show_menu() {
    echo "========== Clash代理配置 =========="
    echo "1. 选择代理模式"
    echo "2. 选择代理节点"
    echo "3. 退出"
    echo "==================================="
}

# 选择代理节点
select_proxy() {
    local mode=$1
    if [ -z $mode ]; then
	mode="Proxy"
    fi
    get_proxy_list
    echo "========== 代理节点列表 =========="
    i=1
    for proxy in $proxies; do
        echo "$i. $proxy"
        i=$((i+1))
    done
    echo "==================================="
    read -p "请选择代理节点（输入编号）：" proxy_index
    proxy=$(echo "$proxies" | sed -n "${proxy_index}p")
    if [[ -n $proxy ]]; then
        # 更新Clash的代理节点设置
        curl -X PUT -s "$api_url/proxies/$mode" -H "Content-Type: application/json" -H "Authorization: Bearer ${Secret}" --data "{\"name\":\"$proxy\"}" > /dev/null
	
        echo "代理节点已更新为：$proxy"
    else
        echo "无效的选择！"
    fi
}

# 选择代理模式
select_mode() {
    get_mode_list
    echo "========== 代理模式列表 =========="
    i=1
    #for mode in $modes; do
    for mode in ${modes[@]}; do
        echo "$i. $mode"
        i=$((i+1))
    done
    echo "==================================="
    read -p "请选择代理模式（输入编号）：" mode_index
    mode=$(echo "${modes[$(($mode_index -1))]}") 
    if [[ -n $mode ]]; then
        # 更新Clash的代理模式设置
        curl -XPATCH -s "$api_url/configs" -H "Content-Type: application/json" -H "Authorization: Bearer ${Secret}" -d '{"mode":"'"${mode}"'"}' > /dev/null
        echo "代理模式已更新为：$mode"

        # 根据新的代理模式更新节点配置
        update_nodes "$mode"
    else
        echo "无效的选择！"
    fi
}

update_nodes() {
    local mode=$1
    if [ $mode == "Rule" ]; then
    	mode=Proxy
	select_proxy $mode
    fi
    if [ $mode == "Global" ]; then
    	mode=GLOBAL
	select_proxy $mode
    fi
    # 根据代理模式更新节点配置
    # TODO: 根据实际需求进行更新节点配置的操作
    echo "已根据代理模式 $mode 更新节点配置"
}

# 主程序
while true; do
    show_menu
    read -p "请选择操作（输入编号）：" choice
    case $choice in
        1) select_mode;;
        2) select_proxy;;
        3) break;;
        *) echo "无效的选择！";;
    esac
    echo
done

