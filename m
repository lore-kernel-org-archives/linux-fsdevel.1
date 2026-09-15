Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F084B0CBA;
	Tue, 15 Sep 2026 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475977; cv=none; b=BQabYyIfz5/TG5ywbVHRm7rB9p30UZo1dkzfHNR3dVaJDZjASkVGzk3nTi5jGu5OyjTIiyEM4umVGllCT6zIrcVI05UZ0CF3aKD7aXHhXumwMqZG2I6IsJwea9Dgt7bTU2805odHJe9hR1RptorjjQxDwe+ImR0G088Ew7GA12M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475977; c=relaxed/simple;
	bh=lq0lngLduJ8mrV1/1eiEUfTOeeHqY0gl9RVWMP4lI98=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OsKRxz7HZJHr+rEA/iqBtURdAgMSQotoWn/wjiVCYWOmEabgN003BDuxDv+uIbUheGn+khZ/+Bq48hA+P3F0RmPhwM/GxF9cfp23PUcJo3KIbgUXnXgqtSy88yCFyoM2s9jCOA2IqYElfz6+eMoo69U1R7JI12LvfSTe8EHRZNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=LRGFUVnE; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="LRGFUVnE"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ee6kjmbWRCPeHlhXi3JMY359javdTigKTF/zq5fK0vQ=;
	b=LRGFUVnEkvR1LI1Y50Bwuo6Ckh0gYGC7iXD6ubPLbDvKogNVshK6k0YvVfuq/smUJdXEC8UZr
	Ukgor+71FN7lpwC9z6A54X7jOyil/PNcFsj5rNoGmWENMkYvVM/ngNL+SDemj/WcyS/cXrIleZD
	9svGpNDSWXbapv5uUClWwXY=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4hkhBJ2SLszcb3H;
	Tue, 15 Sep 2026 20:28:08 +0800 (CST)
Received: from whupemo200006.china.huawei.com (unknown [7.152.185.252])
	by mail.maildlp.com (Postfix) with ESMTPS id 278A040579;
	Tue, 15 Sep 2026 20:39:18 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 whupemo200006.china.huawei.com (7.152.185.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 15 Sep 2026 20:39:16 +0800
Subject: Re: [PATCH RFC v4 23/25] fs: start all kthreads in nullfs
To: Christian Brauner <brauner@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, <linux-kernel@vger.kernel.org>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jann Horn
	<jannh@google.com>
References: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
 <20260601-work-kthread-nullfs-v4-23-77ee053060e0@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <15174353-3f4a-a1ca-5bd1-ea2a4c77828e@huawei.com>
Date: Tue, 15 Sep 2026 20:39:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260601-work-kthread-nullfs-v4-23-77ee053060e0@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 whupemo200006.china.huawei.com (7.152.185.252)

Hi Christian,

On 2026/6/1 21:56, Christian Brauner wrote:
> Point init_task's fs_struct (root and pwd) at a private nullfs instance
> instead of the mutable rootfs. All kthreads now start isolated in nullfs
> and must use scoped_with_init_fs() for any path resolution.
> 
> PID 1 is moved from nullfs into the initramfs by init_userspace_fs().
> Usermodehelper threads use userspace_init_fs via the umh flag in
> copy_fs(). All subsystems that need init's filesystem state for path
> resolution already use scoped_with_init_fs() from earlier commits in
> this series.
> 
> This isolates kthreads from userspace filesystem state and makes it
> hard to perform filesystem operations from kthread context.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/namespace.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index fe919abd2f01..43ca4838d451 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -6173,12 +6173,14 @@ static void __init init_mount_tree(void)
>  	struct path root;
>  
>  	/*
> -	 * We create two mounts:
> +	 * We create three mounts:
>  	 *
>  	 * (1) nullfs with mount id 1
>  	 * (2) mutable rootfs with mount id 2
> +	 * (3) private nullfs for kthreads (SB_KERNMOUNT)
>  	 *
> -	 * with (2) mounted on top of (1).
> +	 * with (2) mounted on top of (1). The init_task's root and pwd
> +	 * are pointed at (3) so all kthreads start isolated in nullfs.
>  	 */
>  	nullfs_mnt = vfs_kern_mount(&nullfs_fs_type, 0, "nullfs", NULL);
>  	if (IS_ERR(nullfs_mnt))
> @@ -6218,12 +6220,14 @@ static void __init init_mount_tree(void)
>  		init_mnt_ns.nr_mounts++;
>  	}

|	LOCK_MOUNT_EXACT(mp, &root);
|	if (unlikely(IS_ERR(mp.parent)))
|		panic("VFS: Failed to mount rootfs on nullfs");
|	scoped_guard(mount_writer)
|		attach_mnt(real_mount(mnt), mp.parent, mp.mp);

>  
> +	nullfs_mnt = kern_mount(&nullfs_fs_type);
> +	if (IS_ERR(nullfs_mnt))
> +		panic("VFS: Failed to create private nullfs instance");
> +	root.mnt	= nullfs_mnt;
> +	root.dentry	= nullfs_mnt->mnt_root;

The following lockdep splat can be triggered on mainline, which is built
with arm64's defconfig plus

	CONFIG_SHRINKER_DEBUG
	CONFIG_PROVE_LOCKING
	CONFIG_FTRACE

.  Reverting this patch (as pointed out by AI) makes this warn disappear.
Please have a look :-) .

Thanks,
Zenghui

---8<---

 ======================================================
 WARNING: possible circular locking dependency detected
 7.3.0-rc3+ #17 Not tainted
 ------------------------------------------------------
 rasdaemon/4449 is trying to acquire lock:
 ffff80008246cb78 (namespace_sem){++++}-{4:4}, at: lock_mount_exact+0x4c/0x308

 but task is already holding lock:
 ffff002080496980 (&sb->s_type->i_mutex_key#17){++++}-{4:4}, at: lock_mount_exact+0x3c/0x308

 which lock already depends on the new lock.


 the existing dependency chain (in reverse order) is:

 -> #3 (&sb->s_type->i_mutex_key#17){++++}-{4:4}:
        down_read+0x48/0x164
        lookup_slow+0x30/0x68
        lookup_noperm_unlocked+0x58/0x5c
        debugfs_change_name+0xd4/0x33c
        shrinker_debugfs_rename+0xa8/0x118
        setup_bdev_super+0x130/0x260
        get_tree_bdev_flags+0x12c/0x1ec
        get_tree_bdev+0x14/0x20
        ext4_get_tree+0x18/0x24
        vfs_get_tree+0x28/0xec
        path_mount+0x3ec/0xbb8
        __arm64_sys_mount+0x190/0x2d8
        invoke_syscall+0x54/0x110
        el0_svc_common.constprop.0+0x40/0xe0
        do_el0_svc+0x1c/0x28
        el0_svc+0x4c/0x3a4
        el0t_64_sync_handler+0xa0/0xe4
        el0t_64_sync+0x198/0x19c

 -> #2 (shrinker_mutex){+.+.}-{4:4}:
        __mutex_lock+0x90/0x870
        mutex_lock_nested+0x24/0x30
        shrinker_alloc+0x158/0x4a0
        sget_fc+0x2fc/0x7b8
        get_tree_nodev+0x2c/0xb8
        nullfs_fs_get_tree+0x18/0x24
        vfs_get_tree+0x28/0xec
        vfs_kern_mount.part.0+0xcc/0x130
        mnt_init+0x12c/0x470
        vfs_caches_init+0x120/0x294
        start_kernel+0x824/0x93c
        __primary_switched+0x88/0x90

 -> #1 (&type->s_umount_key#2/1){+.+.}-{4:4}:
        down_write_nested+0x34/0xcc
        sget_fc+0x14c/0x7b8
        get_tree_nodev+0x2c/0xb8
        nullfs_fs_get_tree+0x18/0x24
        vfs_get_tree+0x28/0xec
        vfs_kern_mount.part.0+0xcc/0x130
        mnt_init+0x2b0/0x470			-> kern_mount()
        vfs_caches_init+0x120/0x294
        start_kernel+0x824/0x93c
        __primary_switched+0x88/0x90

 -> #0 (namespace_sem){++++}-{4:4}:
        __lock_acquire+0x1490/0x21b8
        lock_acquire+0x1d8/0x404
        down_write+0x38/0xd0
        lock_mount_exact+0x4c/0x308
        finish_automount+0x70/0x134
        __traverse_mounts+0xd4/0x22c
        step_into_slowpath+0x2ec/0x390
        path_openat+0x2b0/0x8d4
        do_file_open+0x98/0x158
        do_sys_openat2+0x78/0xfc
        __arm64_sys_openat+0x70/0xbc
        invoke_syscall+0x54/0x110
        el0_svc_common.constprop.0+0x40/0xe0
        do_el0_svc+0x1c/0x28
        el0_svc+0x4c/0x3a4
        el0t_64_sync_handler+0xa0/0xe4
        el0t_64_sync+0x198/0x19c

 other info that might help us debug this:

 Chain exists of:
   namespace_sem --> shrinker_mutex --> &sb->s_type->i_mutex_key#17

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&sb->s_type->i_mutex_key#17);
                                lock(shrinker_mutex);
                                lock(&sb->s_type->i_mutex_key#17);
   lock(namespace_sem);

  *** DEADLOCK ***

 locks held by rasdaemon/4449: 1, last CPU#95:
  #0: ffff002080496980 (&sb->s_type->i_mutex_key#17){++++}-{4:4}, at: lock_mount_exact+0x3c/0x308

 stack backtrace:
 CPU: 95 UID: 0 PID: 4449 Comm: rasdaemon Not tainted 7.3.0-rc3+ #17 PREEMPT
 Hardware name: Huawei TaiShan 2280 V2/BC82AMDDA, BIOS 1.05 09/18/2019
 Call trace:
  show_stack+0x18/0x24 (C)
  dump_stack_lvl+0x90/0xd0
  dump_stack+0x18/0x24
  print_circular_bug+0x294/0x378
  check_noncircular+0x164/0x178
  __lock_acquire+0x1490/0x21b8
  lock_acquire+0x1d8/0x404
  down_write+0x38/0xd0
  lock_mount_exact+0x4c/0x308
  finish_automount+0x70/0x134
  __traverse_mounts+0xd4/0x22c
  step_into_slowpath+0x2ec/0x390
  path_openat+0x2b0/0x8d4
  do_file_open+0x98/0x158
  do_sys_openat2+0x78/0xfc
  __arm64_sys_openat+0x70/0xbc
  invoke_syscall+0x54/0x110
  el0_svc_common.constprop.0+0x40/0xe0
  do_el0_svc+0x1c/0x28
  el0_svc+0x4c/0x3a4
  el0t_64_sync_handler+0xa0/0xe4
  el0t_64_sync+0x198/0x19c
