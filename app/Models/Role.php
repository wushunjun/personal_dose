<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Zizaco\Entrust\EntrustRole;

class Role extends EntrustRole
{
    protected $table = 'roles';
    protected $guarded = ['_token', 'perm_id'];

    /**
     * 获取角色所对应的权限
     * @return \Illuminate\Database\Eloquent\Relations\BelongsToMany
     */
    public function permissions()
    {
        return $this->belongsToMany('\\App\\Models\\Permission', 'permission_role', 'role_id', 'permission_id');
    }
}
