Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAAC276038;
	Mon, 10 Aug 2026 03:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786332471; cv=none; b=Z2pcxupaKTU/NOIxsBEZxjE1519LV95jDSqZLqlrafiDFSfCEqTMlsNu9WwvYKcNFcQbx+q0SRdsaXkFm+WAr79jWm0QrEcZM0jJ0yoQCe/U5CO8Ablq/yq/S+Op8iJlg78lOuBL3ozwoE+E0I0XlkIwsiITMjGw0e/yWTv/2HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786332471; c=relaxed/simple;
	bh=SUAJyG8sAGegkzdVMX8XNJyMgnM+7Suf4pleeKxpjFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wv5XYu8hXLK1q+ZDS9cmVpe9OUloR17CHXb5KOjR2LbnfagGZcxo2fLBSUkNF7SyHyImbKaQ+h0yLWAzRA470K7CDZJPNEBNTXVQ7EoY2h2ArSxX58V4DLwwBANtjGK+0VE9s2Q2Dy5CX8Q9syPnsH+EN3ca3bE4DI549FfSHz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JWHLzZs0; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JWHLzZs0"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786332460; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RltvstWMISkjJuKT54guWYGQEyrvCdpUtxrBNdY2+wM=;
	b=JWHLzZs0dGU648/5dU0awke0idUpiglQ7HgzYiMAX56AwEyKbqohCWKcjcgZlnI1Si5hkrzpxm9bGlbPffbm3KYOp8qLM4zPXzpGFn1Jo/5B9QYu0cy9NiFdt7QbhMy6WtiEkTyR5pJ98DTxHgBrsV0yWdA3kFwJk+mn/XiRv6A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X8cKNVE_1786332458;
Received: from 30.221.149.42(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0X8cKNVE_1786332458 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Aug 2026 11:27:39 +0800
Message-ID: <1292d1d9-138b-4d51-9282-9b6cff092324@linux.alibaba.com>
Date: Mon, 10 Aug 2026 11:27:38 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fuse: check for NULL root inode in
 fuse_fill_super_submount
To: Baokun Li <libaokun@linux.alibaba.com>, fuse-devel@lists.linux.dev
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, mreitz@redhat.com
References: <20260808041339.1687459-1-libaokun@linux.alibaba.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20260808041339.1687459-1-libaokun@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/8/26 12:13 PM, Baokun Li wrote:
> fuse_iget() can return NULL when its inode allocation fails, but
> fuse_fill_super_submount() passed the result straight to get_fuse_inode()
> and decremented fi->nlookup without checking it:
> 
>         root = fuse_iget(sb, parent_fi->nodeid, ...);
>         fi = get_fuse_inode(root);
>         fi->nlookup--;
> 
> Inside fuse_iget() the inode allocation can fail and return NULL.  The
> submount root takes the iget5_locked() path, whose alloc_inode() can fail
> under memory pressure (the auto-submount branch can fail the same way in
> new_inode() or fuse_alloc_submount_lookup()):
> 
>         inode = iget5_locked(sb, nodeid, fuse_inode_eq, fuse_inode_set,
>                              &nodeid);
>         if (!inode)
>                 return NULL;
> 
> A NULL root makes get_fuse_inode() a container_of() on NULL and the
> nlookup decrement a write to a bogus address, oopsing the mount.  With
> CONFIG_KASAN the following null pointer dereference is reported when the
> root inode allocation of an auto-submount fails (e.g. under memory
> pressure):
> 
> ==================================================================
> BUG: KASAN: null-ptr-deref in fuse_get_tree_submount+0x656/0x8b0
> Read of size 8 at addr 00000000000002b0 by task ls/942
> CPU: 0 PID: 942 Comm: ls Tainted: G W 6.6 #15
> Call Trace:
>  <TASK>
>  fuse_get_tree_submount+0x656/0x8b0
>  vfs_get_tree+0x48/0x140
>  fc_mount+0x13/0x50
>  fuse_dentry_automount+0x7a/0xb0
>  __traverse_mounts+0xca/0x330
>  step_into+0x339/0xac0
>  path_lookupat+0xc5/0x2f0
>  filename_lookup+0x163/0x2a0
>  vfs_statx+0xd5/0x200
>  do_statx+0x83/0xd0
>  __x64_sys_statx+0xa0/0xc0
>  do_syscall_64+0x37/0x90
>  entry_SYSCALL_64_after_hwframe+0x78/0xe2
>  </TASK>
> ==================================================================
> 
> Return -ENOMEM instead; the caller tears down the partially built
> superblock on error, matching the other error returns in this
> function.
> 
> Fixes: 1866d779d5d2 ("fuse: Allow fuse_fill_super_common() for submounts")
> Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>

LGTM.

Reviewed-by: Jingbo Xu \<jefflexu@linux.alibaba.com\>

> ---
> Changes since v1:
>  * Correct the Fixes tag.
> 
> v1: https://patch.msgid.link/20260806152134.1594639-1-libaokun@linux.alibaba.com
> 
>  fs/fuse/inode.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index d975073c6029..455c7feba057 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1639,6 +1639,8 @@ static int fuse_fill_super_submount(struct super_block *sb,
>  	fuse_fill_attr_from_inode(&root_attr, parent_fi);
>  	root = fuse_iget(sb, parent_fi->nodeid, 0, &root_attr, 0, 0,
>  			 fuse_get_evict_ctr(fm->fc));
> +	if (!root)
> +		return -ENOMEM;
>  	/*
>  	 * This inode is just a duplicate, so it is not looked up and
>  	 * its nlookup should not be incremented.  fuse_iget() does

-- 
Thanks,
Jingbo

