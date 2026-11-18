Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795026186;
	b=T5Vva6y6WCYpS2GglJifRvQhvi0ISEiO/XqwyZjpwl1g6wX7fyWVEQ6V77Uj6dcqvoC6
	 m9cdDB1O/QobgVSua03irseqz11tSyX7tICYzTrwis/Hybo/MgZnc8u8QPFfWLxn2MuD/
	 y2rBoCusjFqB55EM4d7flPXr92fTJ8GIT2vSdp6fi1H8vy2nI8C7zxquW+BNpJnWSFa3p
	 vo5PO1mtMYwpXjyDALD9ova9pc5hnYIsNinMq28XXlPU2FfQ3/tNDu/AW/h+Y2cIHlF45
	 11AogPpyVJh0q/aebtGUkE2hktm91MNpk9FpKd/UR7ExV+9X4D8IxHbtHsCZWi9ZWuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026186;
	h=Received:DKIM-Signature:Date:To:Cc:From:Message-Id:Subject;
	bh=EU0w2Pj7eYZo7t7cHwVW7q82EN7P2iEY8kXTkymFoF4=;
	b=njbHPoAjo6jsbI5TBM84pedx8fwIGLdZ+r/np3GF75biIsWSFvA9geLIUAe/DlpPZIEt
	 rVSqmwh5UhbZsMcNHibHgOVP5H6z4JHhteupMrXDa2GR7IzMfw/WdmQiq3Phkaj3CdaDy
	 kkj2dbOLkkPuLRg5dgdogfoVB+eaxniFnbSTWs0AQpmC9V/lNPCkaoVCnTzmWkDxyvkvO
	 er6mWDovyuNfuWDdGlsQAYa0O3xEytz6y0luqdpVT5A02xH5G6jNsmF1jOzPkykwIbMoo
	 9pgnDGM1/wb4tJuC7qBcmMHHZH8XhYYbTmXIXyEeUXlRo+XeQpx3eGHUCjy+ytYHuyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b="KWfjA+/O";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3118C60A383D
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 18:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=KWfjA+/O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64531F000D1;
	Wed, 18 Nov 2026 18:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1795026185;
	bh=EU0w2Pj7eYZo7t7cHwVW7q82EN7P2iEY8kXTkymFoF4=;
	h=Date:To:Cc:From:Subject;
	b=KWfjA+/OMvOcJKU7kDKY+pGt1QJ2Z+wc3E2Lk1dFAkFKbiPY0t7/40JEp9Rmukcno
	 b/DPcqypQEYGvEl/sk6k/mdsxqoW6eItFpo4APZsrQ7qS1Nfz0g6NOLxzIxTPDHqoi
	 k8Fu1l3Q+e/5iv1IBlaUP+1+iJrtdVydfZ4+g6Ls=
Date: Wed, 18 Nov 2026 10:23:05 -0800
To: Christian Brauner <brauner@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 syzbot+4324f771847cecb27c54@syzkaller.appspotmail.com,
 Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Miklos Szeredi <mszeredi@redhat.com>
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <00461f0c866d4a4eb9f50792f0e1f3d0.1@linux-foundation.org>
Subject: [PATCH] shmem: consume the reserved xattr space despite remount
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list

From: Andrew Morton <akpm@linux-foundation.org>
Subject: shmem: consume the reserved xattr space despite remount
Date: Thu, 05 Nov 2026 08:08:06 -0800

Creating a tmpfs inode can trigger WARN_ON(ispace) in shmem_initxattrs()
when a concurrent remount sets nr_inodes=0.  With panic_on_warn enabled,
this warning can panic the machine.

shmem_initxattrs() reserves space for the security xattrs while inode
limits are enabled.  It later tests max_inodes again before consuming that
reservation for each installed xattr.  If remount disables the limit
between those steps, successfully installed xattrs leave a nonzero
reservation behind.

Use the remaining reservation, rather than the current mount policy, to
decide whether to subtract the installed xattr's space.  This also leaves
the failure path with only the unconsumed reservation to refund.

An initially unlimited filesystem cannot acquire an inode limit through
remount: shmem_reconfigure() rejects that transition.

Link: https://lore.kernel.org/20261105082717.c459bb33778fcf27e5675082@linux-foundation.org
Fixes: 076e5cef28e2 ("simple_xattr: change interface to pass struct simple_xattrs")
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: <syzbot+4324f771847cecb27c54@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=4324f771847cecb27c54
Tested-by: syzbot+4324f771847cecb27c54@syzkaller.appspotmail.com
Cc: Hugh Dickins <hughd@google.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>
---
Reproduced the warning before the fix and verified its absence
afterward in a Debian 13 guest with SELinux enabled (permissive).

A temporary hook paused file creation after reserving security-xattr
space. Another process completed a real nr_inodes=0 remount before
creation resumed. The unpatched kernel left 94 bytes unconsumed and
triggered WARN_ON(ispace); the patched kernel consumed the reservation
completely. File contents and the security xattr were verified.

Ordinary creation on limited and unlimited tmpfs mounts also passed
on both kernels. No additional KASAN or lockdep reports occurred.

Tested Linux 7.4.0-rc1 with GCC 13.3, KASAN and lockdep, using KVM:
8 GiB RAM, four vCPUs and one virtual NUMA node, backed by a
Threadripper PRO 3995WX. Both kernels had the same diagnostic hook;
the ordering was forced rather than left to random stress.

 mm/shmem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/shmem.c~shmem-consume-the-reserved-xattr-space-despite-remount
+++ a/mm/shmem.c
@@ -4491,7 +4491,7 @@ static int shmem_initxattrs(struct inode
 		if (simple_xattr_add(&sbinfo->xa_cache, &info->xattrs, new_xattr))
 			break;
 
-		if (sbinfo->max_inodes)
+		if (ispace)
 			ispace -= simple_xattr_space(new_xattr->name, new_xattr->size);
 		retain_and_null_ptr(new_xattr);
 	}
_
