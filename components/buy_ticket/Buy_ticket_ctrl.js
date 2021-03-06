(function() {
    'use strict';
    angular.module('GT_Movie.controller')
    .controller('Buy_ticket_ctrl', ['$scope', 'socket', 'current_user_info', '$location', function($scope, socket, current_user_info, $location) {
        $scope.select = {};
        $scope.select.Tid = 0;
        $scope.search = {};
        $scope.search.Result = [];
        socket.emit('get_preferred_theaters', current_user_info.user.Username);
        socket.on('preferred_theaters', function(data) {
            $scope.preferred_theaters = data;
            console.log("preferred_theaters: ", data)
        })
        $scope.goto = function(path) {
            $location.path(path);
        }
        $scope.select_theater = function(theater) {
            console.log(theater);
            current_user_info.ticket = {};
            if (theater == undefined) {
                current_user_info.ticket.Tid = $scope.select.Tid;
                current_user_info.selected_theater = $scope.preferred_theaters.filter(function(e) {
                    if (e.Tid == current_user_info.ticket.Tid.toString()) {
                        return true
                    }
                    return false
                })[0];
            } else {
                current_user_info.ticket.Tid = theater.Theater_id;
                current_user_info.selected_theater = theater
            }
            $scope.search.Result.forEach(function(theater) {
                if (theater.Saved) {
                    var preferred_relationship = {User: current_user_info.user.Username, Tid: theater.Theater_id.toString()}
                    socket.emit('add_preferred_theater', preferred_relationship);
                }
            })
            console.log('Buy ticket: ' + current_user_info.user.Username + " select " + current_user_info.ticket.Tid)
            $location.path('/select_time')
        }
        $scope.search_theater = function() {
            var keyword = '%' + $scope.search.Keyword + '%';
            console.log('search_theater: ' + current_user_info.user.Username + ' search ' + keyword )
            socket.emit('search_theater', keyword)
        }
        socket.on('search_theater_result', function(data) {
            $scope.search.Result = data;
            console.log('search_result:\n', data)
        })
    }])
})()