Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4800F38E5DA;
	Mon,  6 Apr 2026 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775505141; cv=none; b=H0fZxot1qETBquptCVf7NVr8vZMG+OABhkY/nC7tRli/NF/xZvQXcKvnc1zpglbVeud2V1efD26vEtAcHpjW05lPdWmrJgOC5iN+UoKCLErgp6X3pOQggauBFxdlB7E28HgG3PDskbs2RfUEQIOvq/ZaFvkIjUrhaJywWgrPr3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775505141; c=relaxed/simple;
	bh=XWU4EBIeDUAthjp3B+064uSWml0HWurxg6bDCdpauvI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gO8yMkvkbHQH4fF2XH7YxUN4UsVvpqwgYxZAr9yDsulmJIxSVBdhZp1836OK43z6r2gsIDVXWd/5Vy6+362LnFz4CigK81II5XUUzrbKrCWY5zk6Ev524fr+3Mb6cnw8PquZ+8wVIr2vqXSVcMpzogJHbBew/slghYXow+VUdRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGjQykGV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGjQykGV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396C1C4CEF7;
	Mon,  6 Apr 2026 19:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775505140;
	bh=XWU4EBIeDUAthjp3B+064uSWml0HWurxg6bDCdpauvI=;
	h=Date:From:To:Subject:From;
	b=ZGjQykGVck/pLATwB2slD1MwShHv28iVp63CgLEjmblsm4HXToaYt9B0VumbJ87ZC
	 Uj36yVoMutnFEHMFhhmvTZ4PRbnCblfEUcb5q23RKn0JCQutKmYw2/hYtZOuTQi/9O
	 zRyab83Y2zag5Yl7CM+4T6jl/0BArp/8auIdsfpBoJd1040w8PsDAtvkH9ISWX2inl
	 YjMfDSeXT6asZc+7m1+FQTV+fwl6f1gYRAHjQ5kGB9GNwlNLzbMW3pArXI3jbUTppN
	 pob9wJ6Kl1q1G1Iu+Ct3VFeqXYZ12Fa4K7L+WlqqCSOLOPLlUHUPIeYHAM7Mxd4wgi
	 B1jVqecrbt1oA==
Date: Mon, 6 Apr 2026 21:52:16 +0200
From: Helge Deller <deller@kernel.org>
To: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [RFC] [PATCH] Fix warning at fs/dcache.c:430 dentry_free
Message-ID: <adQO8B0rkR2ftusI@p100>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The debian buildd servers for the parisc architecture crash reproduceably when
building the webkit2gtk debian package, shortly after having shown the warning
below.

This patch keeps the lock of the dentry up until when the dentry is given back
to the cache and after having freed the "external dentry name".

I'm not sure if this patch is really correct, but it seems to have fixed the
problem, although more testing is needed.

 kernel: WARNING: CPU: 2 PID: 65 at fs/dcache.c:430 dentry_free+0x15c/0x188
 kernel: Modules linked in: binfmt_misc ipmi_si ipmi_devintf ipmi_msghandler sg configfs nfnetlink autofs4 ex>
 kernel: CPU: 2 UID: 0 PID: 65 Comm: kswapd0 Tainted: G        W  6.18.15+deb14-parisc64 #1 NONE  De>
 kernel: Hardware name: 9000/800/rp4440
 kernel:
 kernel:  IAOQ[0]: dentry_free+0x15c/0x188
 kernel:  IAOQ[1]: dentry_free+0x160/0x188
 kernel:  RP(r2): __dentry_kill+0x2a4/0x338
 kernel: Backtrace:
 kernel:  [<00000000408d9eb0>] __dentry_kill+0x2a4/0x338
 kernel:  [<00000000408dc270>] shrink_dentry_list+0xfc/0x1d0
 kernel:  [<00000000408dcae4>] prune_dcache_sb+0x88/0xc0
 kernel:  [<00000000408a6410>] super_cache_scan+0x2bc/0x440
 kernel:  [<0000000040742f38>] do_shrink_slab+0x254/0x610
 kernel:  [<00000000407449b4>] shrink_slab+0x4d8/0x860
 kernel:  [<000000004073948c>] shrink_one+0x108/0x468
 kernel:  [<000000004073f270>] shrink_node+0xfdc/0x17a0
 kernel:  [<000000004074016c>] balance_pgdat+0x738/0xfb0
 kernel:  [<0000000040740da4>] kswapd+0x3c0/0x788
 kernel:  [<00000000403b35cc>] kthread+0x230/0x430
 kernel:  [<000000004031d020>] ret_from_kernel_thread+0x20/0x28

Signed-off-by: Helge Deller <deller@gmx.de>


diff --git a/fs/dcache.c b/fs/dcache.c
index 7ba1801d8132..c1123787d3bd 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -343,6 +343,7 @@ static void __d_free(struct rcu_head *head)
 {
 	struct dentry *dentry = container_of(head, struct dentry, d_u.d_rcu);
 
+	spin_unlock(&dentry->d_lock);
 	kmem_cache_free(dentry_cache, dentry); 
 }
 
@@ -350,6 +351,7 @@ static void __d_free_external(struct rcu_head *head)
 {
 	struct dentry *dentry = container_of(head, struct dentry, d_u.d_rcu);
 	kfree(external_name(dentry));
+	spin_unlock(&dentry->d_lock);
 	kmem_cache_free(dentry_cache, dentry);
 }
 
@@ -684,9 +686,10 @@ static struct dentry *__dentry_kill(struct dentry *dentry)
 	dentry_unlist(dentry);
 	if (dentry->d_flags & DCACHE_SHRINK_LIST)
 		can_free = false;
-	spin_unlock(&dentry->d_lock);
 	if (likely(can_free))
 		dentry_free(dentry);
+	else
+		spin_unlock(&dentry->d_lock);
 	if (parent && --parent->d_lockref.count) {
 		spin_unlock(&parent->d_lock);
 		return NULL;
@@ -1165,9 +1168,10 @@ void shrink_dentry_list(struct list_head *list)
 			rcu_read_unlock();
 			d_shrink_del(dentry);
 			can_free = dentry->d_flags & DCACHE_DENTRY_KILLED;
-			spin_unlock(&dentry->d_lock);
 			if (can_free)
 				dentry_free(dentry);
+			else
+				spin_unlock(&dentry->d_lock);
 			continue;
 		}
 		d_shrink_del(dentry);
