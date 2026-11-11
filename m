Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413136;
	b=hIKXTszIz6ABLAdV0l9mY868m4R770ELPepCwQFl0W7h+bcO82YCSAvxNQwxwSj3ohX4
	 YMJv8rafcni+qNdoZ7FWZPeCZ7rgN1hzBAJv53omVYz9/ulT3VZWYh9+NsQBA/wXRe9au
	 lTrkQjgTU298oTeiq5egzCMfzizLrPU7Usm81nrg17QOdq6PtPNyM1QLw+Q7jzYy+b+0+
	 G5BLMjBFleoon2jrU7wXpStyClt/kBZtfW11A84EHQv+h0IadF3S+OM7u9AGyUDnOwHSx
	 sCR6MLofOckctwMivg/KVD0nHcdgVkM9ssgbP5K/waPHviQNRFXFE2VJlB/BmpOi/0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lRiUlywrwld98ENTQ9ryYYw6DTlHnImGRe3UChrbN5g=;
	b=dl7Ip2kLvmDysDYae4WeKCxpqUL66RQqOpNuOPCGm5fcyFpGQL0fkZX/UUJS2l7S9TGV
	 Zu/jF0PxMXBHztN+AdE8kuAKCN9ReGQoKxHi8Fqkoxa6PMp7QIpGexBTzT8m7fXQ1qL2s
	 m1D82zeNoVd+X5T4DXw4SVffCpas7W9ppKpxZ++oIRjQhqtuU0FdKlC9X+r9SENm3/714
	 gwP5+fPNXnEcM4OQpislmh5vkmlD2oc/EUKvgUH6LvKJ3GbgxcYydnXEqbj8KtWPH7v84
	 j9N80vomBJwqNYBIJR/3G8/mfBE9phxgpAbLDT/nWhFAhKg0+IaYIi0yhkDoy35Nuxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DZpfwrxf;
	arc=none smtp.remote-ip=74.125.225.75
Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD858606A32A
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 16:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD858606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DZpfwrxf
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-4901ac93584so1549334f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 08:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794413134; x=1795017934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lRiUlywrwld98ENTQ9ryYYw6DTlHnImGRe3UChrbN5g=;
        b=DZpfwrxfItonON6JeJwmvGe3xqgK+5wH3SOsWdhxB6VeeKmW6YgyZB1I5OPIOtvHHd
         hrAeW0o5peoZdhN27BKml8BnfL6EFGLmg/cr5EC4VsyL0lOmZvH8k/+bC5SvPDSkIPpa
         MhFMgdCSmygmGPYvIxxdAxjJOmOrvH3V7rti9fZ99yEj8Qmf9y6KK2QxH14DTGNqI/ob
         WbiGOL/UxU28ZwooAG6QBDGhdKygG4us8wzXmwGVemFBPYS5SKypmXvDjBcfC/elB8Ps
         JuGLUaDwMnlp6uzRADhD81Xy+DEGK86UsVQws5YoqXdKxLBjkOz6slzbGaGwkV4HDwQC
         NzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794413134; x=1795017934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lRiUlywrwld98ENTQ9ryYYw6DTlHnImGRe3UChrbN5g=;
        b=ANX6zixzibO7M+oV2PoH5YCit87ygS4u8MXWmL4fKtFMdHJSRu4BK9aK851FuiaTVW
         ZjAWAioD2ElS5CxY8+3tBCp3XxB6H50VPio4qmqaFdiwL2ll3EhUtrcBypAaWv2CkZDC
         ipNXokUyvNhP0N5KozbiLjUUaDT7vJAAsATMMjb4cDQCpw0XomUiLxveU9W49csrYOVk
         F67g7Bx+6tstfemUapOwQ/XVSS959ta5l+bMgWYA4FDA6yiPbBgd76TRBi7vIHI6V72G
         s/zbxNc08wWdb/NgeoWjGcJJfC73QqLrL8Siqd4Lq6uBH5eZal29QqUNp76DbqXd+9EO
         VQxQ==
X-Forwarded-Encrypted: i=1; AL+hErGqUwzeevZoRN3gIdbjRAZQNhcCdYTHBO/e1+ss88JeSrY8h7k+eDXzJ8mk0v2yluFasK0fWxn+UVI8IGlR@vger.kernel.org
X-Gm-Message-State: APuU4Z9rPDsEAu9s0GYGadqqLp6p29HsXY5m6u4RS6s2f1Gf+PYv2L/v
	0zqRLfzk8ZHfCXsKW8RGIdbii33X0Y/mT67J1LtiKfQMI2AHskB2hTU0+MfxL88M4iAY3Q==
X-Gm-Gg: AYBFou3VSlWPBK9kwkYz3IUr6+zp6+ux8KQGWeFaynbgXQbmYPMHdWDPqUov5b0yDmO
	u+xsUpIhkvqnYe2g1yJ+m45jx/oYXWJ+I0E2fs5rbgO4TlBh6YTlWtRx0djA16qcWblmtBOc0Js
	/ZdYMRkbt9OimtBaa24RQ1RjOQ2Sd6SEyTFsJ82qMt6UfvMGbYqssr7Vf5Bs7Ul9tLZYJCRT/4t
	Kk4tZBOHlQk+klmOiY8wYKH6h8guMlqn/eWFpG7YtIQbGuLrScfRQdRpxWpjer1pfhSBNKy4dWL
	XspmvJSCql4l/Ly6orP82yr00LspvzkEhRl173XCWHBIrEUq2WVNuxW2LrVqYHmgYt0Jh4BREwH
	w6+t8jNwIcJJl/Ox0vxNRHtZ1PVZhKA14IZpi/bAbpq/62EhZTeMNZQnzlFmieIfeuXmaVctsSy
	uNN9Qj5B3eTDLmSGH9UkIbT+0Tz8uOnfyZ5D/I322RmYpoPltO1bNfq1baCG5bK+lQM5yq+CO+j
	o4LCsU9BW0Xa/Z3vMOrbKd/kmBa1E5gsMdDT+eQ+L3AyRNXiTSIZGf/eu9yz+AcdZM++tdpLlBE
	RyBcOX5dHYhEc/xXJqIsqbIHefc2ulWdpda2GzRUsd+zA11X1zZSz/YJOl1//5vxM7nA4TlApeG
	+3UFJZ/zPX/QGV92Y3V2SJbVgOQ==
X-Received: by 2002:a05:600c:46d2:b0:4ba:73f:ef5 with SMTP id 5b1f17b1804b1-4ba093b1bcfmr49437235e9.34.1794413133588;
        Wed, 11 Nov 2026 08:05:33 -0800 (PST)
Received: from mohamedali-HP-EliteBook-840-G8-Notebook-PC.mshome.net ([196.203.210.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4c55f667sm4955755e9.15.2026.11.11.08.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:05:32 -0800 (PST)
From: mohamedalibouhaouala@gmail.com
To: willy@infradead.org,
	jack@suse.cz,
	corbet@lwn.net
Cc: skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	MohamedAliBouhaouala <mohamedalibouhaouala@gmail.com>
Subject: [PATCH] docs: filesystems: update VFS locking documentation
Date: Wed, 11 Nov 2026 17:05:15 +0100
Message-ID: <20261111160516.30458-1-mohamedalibouhaouala@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: MohamedAliBouhaouala <mohamedalibouhaouala@gmail.com>

Update outdated VFS operation prototypes in locking.rst to
match their current definitions.

Add the missing d_prune and sync_inode_metadata callbacks,
and correct the signatures of existing operations.

Update the locking table to include sync_inode_metadata.

Signed-off-by: MohamedAliBouhaouala <mohamedalibouhaouala@gmail.com>
---
 Documentation/filesystems/locking.rst | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index f7363ad770c7..a6a011858ada 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -26,6 +26,7 @@ prototypes::
 	int (*d_delete)(struct dentry *);
 	int (*d_init)(struct dentry *);
 	void (*d_release)(struct dentry *);
+	void (*d_prune)(struct dentry *);
 	void (*d_iput)(struct dentry *, struct inode *);
 	char *(*d_dname)(struct dentry *dentry, char *buffer, int buflen);
 	struct vfsmount *(*d_automount)(struct path *path);
@@ -80,8 +81,8 @@ prototypes::
 	int (*getattr) (const struct mnt_idmap *, const struct path *, struct kstat *, u32, unsigned int);
 	ssize_t (*listxattr) (struct dentry *, char *, size_t);
 	int (*fiemap)(struct inode *, struct fiemap_extent_info *, u64 start, u64 len);
-	void (*update_time)(struct inode *inode, enum fs_update_time type,
-			    int flags);
+	int (*update_time)(struct inode *inode, enum fs_update_time type,
+			    unsigned int flags);
 	void (*sync_lazytime)(struct inode *inode);
 	int (*atomic_open)(struct inode *, struct dentry *,
 				struct file *, unsigned open_flag,
@@ -173,6 +174,7 @@ prototypes::
 	void (*destroy_inode)(struct inode *);
 	void (*dirty_inode) (struct inode *, int flags);
 	int (*write_inode) (struct inode *, struct writeback_control *wbc);
+	int (*sync_inode_metadata)(struct inode *inode, struct writeback_control *wbc);
 	int (*drop_inode) (struct inode *);
 	void (*evict_inode) (struct inode *);
 	void (*put_super) (struct super_block *);
@@ -196,6 +198,7 @@ free_inode:				called from RCU callback
 destroy_inode:
 dirty_inode:
 write_inode:
+sync_inode_metadata:
 drop_inode:				!!!inode->i_lock!!!
 evict_inode:
 put_super:		write
@@ -255,7 +258,7 @@ prototypes::
 				loff_t pos, unsigned len, unsigned copied,
 				struct folio *folio, void *fsdata);
 	sector_t (*bmap)(struct address_space *, sector_t);
-	void (*invalidate_folio) (struct folio *, size_t start, size_t len);
+	void (*invalidate_folio) (struct folio *, size_t offset, size_t len);
 	bool (*release_folio)(struct folio *, gfp_t);
 	void (*free_folio)(struct folio *);
 	int (*direct_IO)(struct kiocb *, struct iov_iter *iter);
@@ -265,7 +268,7 @@ prototypes::
 	bool (*is_partially_uptodate)(struct folio *, size_t from, size_t count);
 	int (*error_remove_folio)(struct address_space *, struct folio *);
 	int (*swap_activate)(struct swap_info_struct *sis, struct file *f, sector_t *span)
-	int (*swap_deactivate)(struct file *);
+	void (*swap_deactivate)(struct file *);
 
 locking rules:
 	All except dirty_folio and free_folio may block
@@ -455,14 +458,15 @@ prototypes::
 	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
 	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
 	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
-	int (*iopoll) (struct kiocb *kiocb, bool spin);
+	int (*iopoll)(struct kiocb *kiocb, struct io_comp_batch *,
+			unsigned int flags);
 	int (*iterate_shared) (struct file *, struct dir_context *);
 	__poll_t (*poll) (struct file *, struct poll_table_struct *);
 	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
 	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
 	int (*mmap) (struct file *, struct vm_area_struct *);
 	int (*open) (struct inode *, struct file *);
-	int (*flush) (struct file *);
+	int (*flush) (struct file *, fl_owner_t id);
 	int (*release) (struct inode *, struct file *);
 	int (*fsync) (struct file *, loff_t start, loff_t end, int datasync);
 	int (*fasync) (int, struct file *, int);
@@ -475,7 +479,7 @@ prototypes::
 			size_t, unsigned int);
 	ssize_t (*splice_read)(struct file *, loff_t *, struct pipe_inode_info *,
 			size_t, unsigned int);
-	int (*setlease)(struct file *, long, struct file_lock **, void **);
+	int (*setlease)(struct file *, int, struct file_lease **, void **);
 	long (*fallocate)(struct file *, int, loff_t, loff_t);
 	void (*show_fdinfo)(struct seq_file *m, struct file *f);
 	unsigned (*mmap_capabilities)(struct file *);
-- 
2.43.0

