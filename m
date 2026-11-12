Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794500512;
	b=ocOhaRQ4zpMwGAkFVGuUdBkzFlc0vAW7xR9//PA5Lk1FqiNcgSuFKWXkRH6IlEmXG127
	 DTF+e0+qASuwWyS0CLSsohR3SH0y9cSrPrEjFTgDcH4F5/ivJrUQYFF6qJZkK0QfFZ3HZ
	 6FD689NqozKNN/TDzlqgZXh7IKcoA/w5kKBDRLnX4W85nI7rQIKlpsIthu5y2+J+Co+NV
	 Gx8rdX49IYUvz4/rrBUWMfeOFgMZxoS2Fm8Siixe0uVp8TgxPl3Ts8HkwUCWVJEuQeWMp
	 xz/80H3ZG+NHsmVykK6QCGR/kYb2ShEr0UOhW22NT/7dXBPjUXy9OphXwiWUriITNLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500512;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jvGNkEQXxpCGRnxugPg2OroUq4ixAzACPllCORFjj2w=;
	b=A+CqNXWUwDk40Q/7LTbhruJO1Mj3ggXNl1Jw9fGj5Z68vkFBAwkjkbifG7lQm7QAelDo
	 lWCshGWdiZgJEU+tGMgnBoxtkIf3asDia5XIAn2mC+0fmUUCJjpTr8oNbW00KCgAiqzdr
	 70hwo/k6cHTf5NG9rM/2v4RjjhKvFzKD2JKJcow10M6hMO87UM+Yej8uBgJ+CkKKAdDUK
	 XqcuzSYAv+YYt3B5coF4xasL2lMK5QMv2d8Pc8MfO0XVebyad9rHsAipqK+09qP3Hyoh1
	 /rUCMOsLKLOh9pSr1NbGwn9CixkAXZ3uFPAalLnFBeBW3rY1TdEX9GwOX2I2bimCIfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eXwROFE+;
	arc=none smtp.remote-ip=74.125.225.130
Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B805606A32A
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 16:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B805606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eXwROFE+
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-4a21339d376so1821075e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 08:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794500510; x=1795105310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jvGNkEQXxpCGRnxugPg2OroUq4ixAzACPllCORFjj2w=;
        b=eXwROFE+hg2htu4HuRIHEzizvRbOQ6hiaEWuBxRWFWrxLT65V2weXKbRZuAEie+pUQ
         Os+sFbGNkpcgd/vblW/O0GCJldJFliHi3CSGtCfTHsMZcGhhVHVZD/aexg0++FzU2KHW
         oTmCn+6c2AhTFXX3GmeSuKM44yttafHv0zZIoLw+suMhx6wtjrce+qE3BLyTH2XY4dvM
         T3Z+u1vhBkTquvStFlarKzSMupg0x/bCnPAGk0DnPKHbEJ/LlN7T4c/Jh4FHJuNGKUuA
         nhTwz9SnPT/bG5ub5K4jCGqMbDIzsNa+0/8YkPcA8sc7/hoNrq8QqcfUhvWApV3uSiaM
         uQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794500510; x=1795105310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jvGNkEQXxpCGRnxugPg2OroUq4ixAzACPllCORFjj2w=;
        b=XB9xrDDV3MyDpXZPvSUeF8QnVbVFJrraJSRQ64wJXa7RnYysvKorq9PZCDMurlt+Q5
         oHs16j3So3LCSHDqVrKQkv5x49ZltrgCGBbWw9yJDVd/0IaDkMcDGkDCV6Uj6yAiaFu7
         Uwj0Pz8PVSLOX9ZuIjoCXIqdtFvSqZV3rKruJclOMGkZFE3TeQowi+vadBvzNjgjFyoK
         MGfvpbWzeMYFwWS6ABJOuuMa1XMNiCVtzxvlxvPn4QDaRl5gOyqSN3SOLd6/D7tOGRyM
         b9tvyreZid6OTfwtkCJl44Cknaw4pUHD+6GS/IzSDq2OKHkEJv9gHxjIhJtG1zYsGuu3
         75jg==
X-Forwarded-Encrypted: i=1; AL+hErGx+fTUDbxJ4GGVITY0jicH/BkyN5k14HNG3dc9XrF5L8n5uNmr4bOtFNW3h7OEu+hx4YBpCLXlS9iduXQT@vger.kernel.org
X-Gm-Message-State: APuU4Z+qom7N61T6PTnCm5e5C0WwZlWK35mtDgf7XAmB2o9I20HR3NOu
	Tlg/LQUEwa6Af8JMyUasOc7b0WudAbJ7IjP2btBnLuGC92p+bWvwqK/V
X-Gm-Gg: AYBFou16PplsryggD3QsZtXCM86GhwBnx/yGPbKAC6awXZl71V2uvjoDacmnVPT+pIx
	ARkIgo4pZLP3vWPXxCA6q48UaLlN7jG5uEIEU4ep7XJ4+FGSTh8qxYhgrbBUxd62bE4aHHU+cGJ
	g0qd/TGbOM49iojd0szu/qwHfdFX/+A6tha41bJ5xNx5m+iyJXUq7XxRYO8r62AQ95Xh300SAwO
	m3hmwLtf7r/AUQ1sLDsa9rBJxJG0hLIKPh9fbqAHPWTmPfbAP4AqaGBq9SnxCsW/i6zHuhkC4ax
	9aMitsfXmvgjAqhtISsH19uvQsIzALakyjWkfC1xKLnfiOCkc6OOyCUFu4eTDLoD2Tdiy3Or4iJ
	bkCdQIY3oXgmOhFkDJV49SCteaa0nmVoAsV2fqX1vVEFTZLffYsAPZVXMdazoJBTCyIRMD/hap0
	4lfQ3a8WvE4s754acQsbM/RPgsumkLjjRjV01DNSg710o0+eUNQ049Gvlwi0X+Hpj/u0a7Z0GRk
	azXFzk2wzTugbOGIqiFVZlZssQcUJCRqC0y/b1+yl/Ly9L10kbcDDYCOMLI/zUhRyz89WSc16xT
	6iiSupXrgMX7EsSnq0ntUdXedZsIpCRM2LCzlHsU8bc6ag8wIrreNlPvcIGIHYPiE47sRBhQ5zK
	IOw==
X-Received: by 2002:a05:600c:37c8:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4bb4e28d48emr67944075e9.13.1794500509593;
        Thu, 12 Nov 2026 08:21:49 -0800 (PST)
Received: from localhost.localdomain ([196.178.27.147])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e28c882sm83116425e9.6.2026.11.12.08.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:21:49 -0800 (PST)
From: mohamedalibouhaouala@gmail.com
To: willy@infradead.org,
	jack@suse.cz,
	corbet@lwn.net
Cc: skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	Mohamed Ali Bouhaouala <mohamedalibouhaouala@gmail.com>
Subject: [PATCH v2] docs: filesystems: update VFS locking documentation
Date: Thu, 12 Nov 2026 17:21:29 +0100
Message-ID: <20261112162129.77610-1-mohamedalibouhaouala@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111160516.30458-1-mohamedalibouhaouala@gmail.com>
References: <20261111160516.30458-1-mohamedalibouhaouala@gmail.com>
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

From: Mohamed Ali Bouhaouala <mohamedalibouhaouala@gmail.com>

Update outdated VFS operation prototypes in locking.rst to
match their current definitions.

Add the missing d_prune and sync_inode_metadata callbacks,
and correct the signatures of existing operations.

Update the locking table to include sync_inode_metadata.

Signed-off-by: Mohamed Ali Bouhaouala <mohamedalibouhaouala@gmail.com>
---
v2:
- Use the contributor's full name in the author and sign-off fields.
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

