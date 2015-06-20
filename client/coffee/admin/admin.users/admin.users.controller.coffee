AdminUsersCtrl = (User, users, $rootScope, $alert) ->

  @users        = users.data.items
  @totalUsers   = users.data.count
  @pageSize     = 10
  @noUsers      = unless @users.length then on else no
  @currentPage  = 1

  @changePage = (newPageNumber) ->
    User
      .getUsersByPage newPageNumber, @pageSize
      .success (res) =>
        @users      = res.items
        @totalUsers = res.count

  @deleteUser = (userId, index) ->
    User
      .deleteUser userId
      .success (res) =>
        $alert content : 'Пользователь успешно удален'
        @users.splice index, 1
        --@totalUsers
      .error (err) -> $alert content : err

  return

AdminUsersCtrl.$inject = ['User', 'users', '$rootScope', '$alert']

module.exports = AdminUsersCtrl
