Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D443BBA17;
	Mon, 13 Apr 2026 10:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077851; cv=none; b=jux4WaeaDR1esoIiV+6UcNcEzuxnoKNyuHdfh85ZJRn/kS0Z0+1nIQPNr2Cy0bp845uzYn9EXvtSvTqwwL7EJPNR3+y8etM/VFrev8mFo4fxyl643FVWCyEnRNLfVte0JBS9zQOvqkXb6FBI+libXQEcW+OVy0A94xePMoriGvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077851; c=relaxed/simple;
	bh=u2egHWP8ia1Dy/ziREu/MdzfbhY6Dr9OLTDesW4wdTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s1fDytW7YIySVbKSkfzKQp1fOSfTLyenngRoRl8t0AgyJJ78P2Sq4v2f+bT1Qm+m9+Q0PVYUu/aCaZpDXtf//QLV/EtqD3Nx3nfvsvuLy1fPEK8Ah3SBH/WUMOD+40K8wSSbT56JOmoRBXZjXFGcD1MbRwXsvR5u5u61V7BaOiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwc68Fjj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwc68Fjj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B885C116C6;
	Mon, 13 Apr 2026 10:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776077851;
	bh=u2egHWP8ia1Dy/ziREu/MdzfbhY6Dr9OLTDesW4wdTY=;
	h=From:To:Cc:Subject:Date:From;
	b=gwc68Fjjz4TqVV2ei+WyJ8tm6LOzzvJuxi59ZnqAs4rR0Nn3bWImiM6zmbLobe7Gm
	 /Mx7LL2GIq+0Msj8O8/i2oLP7X88QTVg0TT3S+ezfbLYui3DrY7/oh+c+1t+ijcKhB
	 7qE1Znty+OVzWGS3c6txkIDOvNs8t8z51U42DftG3j47UkbHjbzxSjqrgCkbOHkARh
	 JqFMkdcB+VyqkVb41W4CF9tTkFgr3H9docg2P5JeABDyCWrfW11fu6Kw7Xh5XUPJTN
	 wzyXsWa8fYLIHNc4WvtuTECD+AZdCdXV3A26aWI7Xw35/L4CiKBQDD8qW781gwNV8Q
	 6en4yaBDPV2MQ==
From: Lorenzo Stoakes <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Hildenbrand <david@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH mm-hotfixes] mm/vma: remove __vma_check_mmap_hook()
Date: Mon, 13 Apr 2026 11:57:13 +0100
Message-ID: <20260413105713.92625-1-ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c50ca15dd496 ("mm: add vm_ops->mapped hook") introduced
__vma_check_mmap_hook() in order to assert that a driver doesn't
incorrectly implement both an f_op->mmap() and a vm_ops->mapped hook, the
latter of which would not ultimately get invoked.

However, this did not correctly account for stacked drivers (or drivers
that otherwise use the compatibility layer) which might recursively call
an mmap_prepare hook via the compatibility layer.

Thus the nested mmap_prepare() invocation might result in a VMA which has
vm_ops->mapped set with an overlaying mmap() hook, causing the
__vma_check_mmap_hook() to fail in vfs_mmap(), wrongly failing the
operation.

This patch resolves this by simply removing the check, as we can't be
certain that an mmap() hook doesn't at some point invoke the compatibility
layer, and it's not worth trying to track it.

Fixes: c50ca15dd496 ("mm: add vm_ops->mapped hook")
Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Closes: https://lore.kernel.org/all/adx2ws5z0NMIe5Yj@shinmob/
Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
---

Andrew -

c50ca15dd496 is in mm-stable, so thought best to do as fix-patch? Will
leave a small bisection hazard (unfortunately) so putting this as close as
possible to the patch it fixes would be ideal.

Thanks!

 include/linux/fs.h |  9 +--------
 mm/util.c          | 10 ----------
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0bdccfa70b44..f3ca9b841892 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2062,20 +2062,13 @@ void compat_set_desc_from_vma(struct vm_area_desc *desc, const struct file *file
 			      const struct vm_area_struct *vma);
 int __compat_vma_mmap(struct vm_area_desc *desc, struct vm_area_struct *vma);
 int compat_vma_mmap(struct file *file, struct vm_area_struct *vma);
-int __vma_check_mmap_hook(struct vm_area_struct *vma);

 static inline int vfs_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	int err;
-
 	if (file->f_op->mmap_prepare)
 		return compat_vma_mmap(file, vma);

-	err = file->f_op->mmap(file, vma);
-	if (err)
-		return err;
-
-	return __vma_check_mmap_hook(vma);
+	return file->f_op->mmap(file, vma);
 }

 static inline int vfs_mmap_prepare(struct file *file, struct vm_area_desc *desc)
diff --git a/mm/util.c b/mm/util.c
index f063fd4de1e8..232c3930a662 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1281,16 +1281,6 @@ int compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
 }
 EXPORT_SYMBOL(compat_vma_mmap);

-int __vma_check_mmap_hook(struct vm_area_struct *vma)
-{
-	/* vm_ops->mapped is not valid if mmap() is specified. */
-	if (vma->vm_ops && WARN_ON_ONCE(vma->vm_ops->mapped))
-		return -EINVAL;
-
-	return 0;
-}
-EXPORT_SYMBOL(__vma_check_mmap_hook);
-
 static void set_ps_flags(struct page_snapshot *ps, const struct folio *folio,
 			 const struct page *page)
 {
--
2.53.0
