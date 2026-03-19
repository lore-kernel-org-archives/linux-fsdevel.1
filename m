Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001D423EAB3
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 03:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773890580; cv=none; b=Hezu8RG6tmIuuCjHkwxb60vK71omi9iwPQMDdpWKPYgEljv4JqJXL6gSqWMmhZZr4sfSYbZQHiyfyhXNInr6r7uecNrb+7vf6eb27jUifPR+V63JoV+GrtAhaOg5il6nXP0qRnJ/rh3aIdGSKbNDTxfp/DiyAM0u+Ob1NrgEKSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773890580; c=relaxed/simple;
	bh=MnSoQ/xYMbSKCnblLDKKunVlzrKK3r4bgm7SZXf6j50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RftPIrGnaoB4VXXuo2qoeMuZGH45b5vWFin1E/ff2ieKSwxdrJJBKrtdRIduIMisYiFUhc4MNfv4/F3DJ8NkZcFTQ/f6bhytUv+UXcMK1qxOa1eSp5ldlRsxZl6pvwPUP+xxuH8ShYz6SDr5OLmJW+JZTAAXFSq/jo/84ZgjxD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NNtaA73/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNtaA73/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773890578; x=1805426578;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MnSoQ/xYMbSKCnblLDKKunVlzrKK3r4bgm7SZXf6j50=;
  b=NNtaA73/UiBTQfacJOJFOAEv+55Fmstfsgjh9Zu4BxfYYIvdee9EJ0YH
   y6wPpyhxccpCVH87PSWNGIXcuXPpnNyp7fW/ywHc8Gwjie7N7cQJ+j4PX
   ZqJsUXCK7PhBgu8ofaUQt2jccRCJEOt+63Ehwk9p4l/Ew7di1e7jCkgXL
   l9SJqcqC9xSXu9u9IhU+JPlehurwp6WUJxkdyTabUneGktd3+Q/uqG2HN
   /dcvCX0L8UkhbUBzRtUcWL/hsG9Ag4Q+WBcTzZeFZciJLTGcR/gHcyLts
   AWwTgM6CitzHrPmb44/NvnOrcE7qUL1ZwBBXNpcmcwEJeni4RjpckH2bv
   g==;
X-CSE-ConnectionGUID: cvmOjHkzRMmA5FLwqud9fw==
X-CSE-MsgGUID: lRd3ESzGQuipny6DTQiVmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74654433"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="74654433"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 20:22:58 -0700
X-CSE-ConnectionGUID: CBVFDWW0R3iVMg+DM5G8Mw==
X-CSE-MsgGUID: 0EatfemlTXWDxNNc0bOlaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="222075742"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 20:22:56 -0700
Date: Thu, 19 Mar 2026 11:22:52 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Bernd Schubert <bernd@bsbernd.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v3 7/7] fuse: support FSCONFIG_SET_FD for "fd" option
Message-ID: <abtsDGmmABhIYktu@ly-workstation>
References: <20260316165320.3245526-1-mszeredi@redhat.com>
 <20260316165320.3245526-8-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316165320.3245526-8-mszeredi@redhat.com>

On Mon, Mar 16, 2026 at 05:53:18PM +0100, Miklos Szeredi wrote:
> This is not only cleaner to use in userspace (no need to sprintf the fd to
> a string) but also allows userspace to detect that the devfd can be closed
> after the fsconfig call.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/inode.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index f388d57fdd8f..e53153463e10 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -788,7 +788,7 @@ enum {
>  
>  static const struct fs_parameter_spec fuse_fs_parameters[] = {
>  	fsparam_string	("source",		OPT_SOURCE),
> -	fsparam_u32	("fd",			OPT_FD),
> +	fsparam_fd	("fd",			OPT_FD),
>  	fsparam_u32oct	("rootmode",		OPT_ROOTMODE),
>  	fsparam_uid	("user_id",		OPT_USER_ID),
>  	fsparam_gid	("group_id",		OPT_GROUP_ID),
> @@ -800,9 +800,8 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
>  	{}
>  };
>  
> -static int fuse_opt_fd(struct fs_context *fsc, int fd)
> +static int fuse_opt_fd(struct fs_context *fsc, struct file *file)
>  {
> -	struct file *file __free(fput) = fget(fd);
>  	struct fuse_fs_context *ctx = fsc->fs_private;
>  
>  	if (file->f_op != &fuse_dev_operations)
> @@ -859,7 +858,12 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
>  		return 0;
>  
>  	case OPT_FD:
> -		return fuse_opt_fd(fsc, result.uint_32);
> +		if (param->type == fs_value_is_file) {
> +			return fuse_opt_fd(fsc, param->file);
> +		} else {
> +			struct file *file __free(fput) = fget(result.uint_32);
> +			return fuse_opt_fd(fsc, file);
> +		}
>  
>  	case OPT_ROOTMODE:
>  		if (!fuse_valid_type(result.uint_32))
> -- 
> 2.53.0
>
Hi Miklos Szeredi,

Greetings!

I used Syzkaller and found that there is general protection fault in fuse_opt_fd in linux-next next-20260317.

After bisection and the first bad commit is:
"
6dcceeb72856 fuse: support FSCONFIG_SET_FD for "fd" option
"

All detailed into can be found at:
https://github.com/laifryiee/syzkaller_logs/tree/main/260319_020043_fuse_opt_fd
Syzkaller repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/260319_020043_fuse_opt_fd/repro.c
Syzkaller repro syscall steps:
https://github.com/laifryiee/syzkaller_logs/tree/main/260319_020043_fuse_opt_fd/repro.prog
Syzkaller report:
https://github.com/laifryiee/syzkaller_logs/tree/main/260319_020043_fuse_opt_fd/repro.report
Kconfig(make olddefconfig):
https://github.com/laifryiee/syzkaller_logs/tree/main/260319_020043_fuse_opt_fd/kconfig_origin
Bisect info:
https://github.com/laifryiee/syzkaller_logs/tree/main/260319_020043_fuse_opt_fd/bisect_info.log
bzImage:
https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/260319_020043_fuse_opt_fd/bzImage_8e5a478b6d6a5bb0a3d52147862b15e4d826af19
Issue dmesg:
https://github.com/laifryiee/syzkaller_logs/blob/main/260319_020043_fuse_opt_fd/8e5a478b6d6a5bb0a3d52147862b15e4d826af19_dmesg.log

"
[   19.543111] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000009: 0000 [#1] SMP KASAN NOPTI
[   19.543731] KASAN: null-ptr-deref in range [0x0000000000000048-0x000000000000004f]
[   19.544132] CPU: 1 UID: 0 PID: 739 Comm: repro Not tainted 7.0.0-rc4-next-20260317-8e5a478b6d6a #1 PREEMPT(lazy) 
[   19.544657] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   19.545222] RIP: 0010:fuse_opt_fd+0x5e/0x340
[   19.545481] Code: c1 ea 03 80 3c 02 00 0f 85 91 02 00 00 49 8d 7c 24 48 49 8b 9e 98 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 60 02 00 00 49 81 7c 24 48 20 cf 2e 86 0f 85 d8
[   19.546420] RSP: 0018:ffff888012c879f8 EFLAGS: 00010206
[   19.546703] RAX: dffffc0000000000 RBX: ffff88801fa83380 RCX: ffff888012c8796c
[   19.547073] RDX: 0000000000000009 RSI: ffffffff82986cbf RDI: 0000000000000048
[   19.547443] RBP: ffff888012c87a20 R08: 0000000000000000 R09: 0000000000000001
[   19.547816] R10: 0000000000000001 R11: ffff8880141a8eb8 R12: 0000000000000000
[   19.548185] R13: 0000000000000000 R14: ffff888010e3cc00 R15: ffff888012c87aa8
[   19.548557] FS:  00007fbea1acf600(0000) GS:ffff8880e30aa000(0000) knlGS:0000000000000000
[   19.548976] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   19.549279] CR2: 0000200000001000 CR3: 000000000ef6a006 CR4: 0000000000770ef0
[   19.549650] PKRU: 55555554
[   19.549805] Call Trace:
[   19.549947]  <TASK>
[   19.550073]  fuse_parse_param+0x810/0xcc0
[   19.550296]  ? __pfx_fuse_parse_param+0x10/0x10
[   19.550545]  ? __pfx___sanitizer_cov_trace_const_cmp2+0x10/0x10
[   19.550876]  ? static_key_count+0x69/0x80
[   19.551107]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[   19.551395]  ? security_fs_context_parse_param+0x121/0x150
[   19.551698]  ? __pfx_fuse_parse_param+0x10/0x10
[   19.551942]  vfs_parse_fs_param+0x21e/0x3e0
[   19.552188]  vfs_parse_fs_qstr+0x15d/0x1e0
[   19.552418]  ? __pfx_vfs_parse_fs_qstr+0x10/0x10
[   19.552676]  ? kasan_save_track+0x18/0x40
[   19.552909]  ? kasan_save_alloc_info+0x3c/0x50
[   19.553160]  ? __pfx_vfs_parse_comma_sep+0x10/0x10
[   19.553425]  vfs_parse_monolithic_sep+0x1ab/0x230
[   19.553687]  ? __pfx_vfs_parse_monolithic_sep+0x10/0x10
[   19.553975]  ? fuse_init_fs_context+0x179/0x1f0
[   19.554220]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   19.554512]  ? __pfx_generic_parse_monolithic+0x10/0x10
[   19.554801]  generic_parse_monolithic+0x2e/0x40
[   19.555052]  parse_monolithic_mount_data+0x75/0xa0
[   19.555319]  path_mount+0x707/0x2060
[   19.555526]  ? lockdep_hardirqs_on+0x85/0x110
[   19.555790]  ? __pfx_path_mount+0x10/0x10
[   19.556010]  ? __kasan_slab_free+0x59/0x70
[   19.556236]  ? kmem_cache_free+0x251/0x5c0
[   19.556463]  ? putname+0xc6/0x130
[   19.556655]  ? putname+0xcb/0x130
[   19.556845]  __x64_sys_mount+0x2c3/0x340
[   19.557060]  ? __x64_sys_mount+0x2c3/0x340
[   19.557286]  ? __pfx___x64_sys_mount+0x10/0x10
[   19.557530]  ? __audit_syscall_entry+0x393/0x4f0
[   19.557794]  x64_sys_call+0x2b8/0x21c0
[   19.558009]  do_syscall_64+0xc1/0x1130
[   19.558219]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   19.558490] RIP: 0033:0x7fbea183ee5d
[   19.558699] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
[   19.559633] RSP: 002b:00007ffd9393a858 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
[   19.560035] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fbea183ee5d
[   19.560405] RDX: 0000200000002100 RSI: 00002000000020c0 RDI: 0000000000000000
[   19.560777] RBP: 00007ffd9393a870 R08: 0000200000000080 R09: 0000000000000800
[   19.561155] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffd9393a988
[   19.561526] R13: 0000000000401156 R14: 0000000000403e08 R15: 00007fbea1b18000
[   19.561910]  </TASK>
[   19.562038] Modules linked in:
[   19.562271] ---[ end trace 0000000000000000 ]---
[   19.562525] RIP: 0010:fuse_opt_fd+0x5e/0x340
[   19.562762] Code: c1 ea 03 80 3c 02 00 0f 85 91 02 00 00 49 8d 7c 24 48 49 8b 9e 98 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 60 02 00 00 49 81 7c 24 48 20 cf 2e 86 0f 85 d8
[   19.563698] RSP: 0018:ffff888012c879f8 EFLAGS: 00010206
[   19.563974] RAX: dffffc0000000000 RBX: ffff88801fa83380 RCX: ffff888012c8796c
[   19.564342] RDX: 0000000000000009 RSI: ffffffff82986cbf RDI: 0000000000000048
[   19.564712] RBP: ffff888012c87a20 R08: 0000000000000000 R09: 0000000000000001
[   19.565083] R10: 0000000000000001 R11: ffff8880141a8eb8 R12: 0000000000000000
[   19.565457] R13: 0000000000000000 R14: ffff888010e3cc00 R15: ffff888012c87aa8
[   19.565849] FS:  00007fbea1acf600(0000) GS:ffff8880e30aa000(0000) knlGS:0000000000000000
[   19.566266] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   19.566571] CR2: 0000200000001000 CR3: 000000000ef6a006 CR4: 0000000000770ef0
[   19.566946] PKRU: 55555554
[   19.571014] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000009: 0000 [#2] SMP KASAN NOPTI
[   19.571708] KASAN: null-ptr-deref in range [0x0000000000000048-0x000000000000004f]
[   19.572103] CPU: 1 UID: 0 PID: 740 Comm: repro Tainted: G      D             7.0.0-rc4-next-20260317-8e5a478b6d6a #1 PREEMPT(lazy) 
[   19.572706] Tainted: [D]=DIE
[   19.572871] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   19.573447] RIP: 0010:fuse_opt_fd+0x5e/0x340
[   19.573683] Code: c1 ea 03 80 3c 02 00 0f 85 91 02 00 00 49 8d 7c 24 48 49 8b 9e 98 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 60 02 00 00 49 81 7c 24 48 20 cf 2e 86 0f 85 d8
[   19.574613] RSP: 0018:ffff888019a8f9f8 EFLAGS: 00010206
[   19.574894] RAX: dffffc0000000000 RBX: ffff88801fa83c00 RCX: 1ffffffff0e3262d
[   19.575264] RDX: 0000000000000009 RSI: ffffffff82986cbf RDI: 0000000000000048
[   19.575635] RBP: ffff888019a8fa20 R08: 0000000000000000 R09: 0000000000000000
[   19.576003] R10: 0000000000000000 R11: 000000000000000f R12: 0000000000000000
[   19.576373] R13: 0000000000000000 R14: ffff888010e3ca00 R15: ffff888019a8faa8
[   19.576746] FS:  00007f4b7fb2b600(0000) GS:ffff8880e30aa000(0000) knlGS:0000000000000000
[   19.577161] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   19.577463] CR2: 0000200000001000 CR3: 0000000011acd003 CR4: 0000000000770ef0
[   19.577841] PKRU: 55555554
[   19.577992] Call Trace:
[   19.578134]  <TASK>
[   19.578267]  fuse_parse_param+0x810/0xcc0
[   19.578488]  ? __pfx_fuse_parse_param+0x10/0x10
[   19.578737]  ? __pfx___sanitizer_cov_trace_const_cmp2+0x10/0x10
[   19.579055]  ? static_key_count+0x69/0x80
[   19.579278]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[   19.579577]  ? security_fs_context_parse_param+0x121/0x150
[   19.579881]  ? __pfx_fuse_parse_param+0x10/0x10
[   19.580132]  vfs_parse_fs_param+0x21e/0x3e0
[   19.580368]  vfs_parse_fs_qstr+0x15d/0x1e0
[   19.580597]  ? __pfx_vfs_parse_fs_qstr+0x10/0x10
[   19.580861]  ? kasan_save_track+0x18/0x40
[   19.581087]  ? kasan_save_alloc_info+0x3c/0x50
[   19.581334]  ? __pfx_vfs_parse_comma_sep+0x10/0x10
[   19.581598]  vfs_parse_monolithic_sep+0x1ab/0x230
[   19.581862]  ? __pfx_vfs_parse_monolithic_sep+0x10/0x10
[   19.582151]  ? fuse_init_fs_context+0x179/0x1f0
[   19.582399]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   19.582693]  ? __pfx_generic_parse_monolithic+0x10/0x10
[   19.582978]  generic_parse_monolithic+0x2e/0x40
[   19.583235]  parse_monolithic_mount_data+0x75/0xa0
[   19.583504]  path_mount+0x707/0x2060
[   19.583709]  ? __pfx_path_mount+0x10/0x10
[   19.583931]  ? __kasan_slab_free+0x59/0x70
[   19.584159]  ? kmem_cache_free+0x251/0x5c0
[   19.584383]  ? putname+0xc6/0x130
[   19.584574]  ? putname+0xcb/0x130
[   19.584765]  __x64_sys_mount+0x2c3/0x340
[   19.584986]  ? __x64_sys_mount+0x2c3/0x340
[   19.585210]  ? __pfx___x64_sys_mount+0x10/0x10
[   19.585456]  ? __audit_syscall_entry+0x393/0x4f0
[   19.585717]  x64_sys_call+0x2b8/0x21c0
[   19.585928]  do_syscall_64+0xc1/0x1130
[   19.586138]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   19.586407] RIP: 0033:0x7f4b7f83ee5d
[   19.586613] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
[   19.587548] RSP: 002b:00007ffd113e09a8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
[   19.587946] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4b7f83ee5d
[   19.588319] RDX: 0000200000002100 RSI: 00002000000020c0 RDI: 0000000000000000
[   19.588702] RBP: 00007ffd113e09c0 R08: 0000200000000080 R09: 0000000000000800
[   19.589069] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffd113e0ad8
[   19.589438] R13: 0000000000401156 R14: 0000000000403e08 R15: 00007f4b7fb74000
[   19.589825]  </TASK>
[   19.589952] Modules linked in:
[   19.590475] ---[ end trace 0000000000000000 ]---
"

Hope this cound be insightful to you.

Regards,
Yi Lai

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install 
 
