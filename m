Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794701733;
	b=sgMp790zMshgBurDLeL0REEUDbSUsvGJuxgWA1bPsC6px1lWvLnaXB6kMjZOwJ5swdd8
	 w6hrzegPXTd/a8BJYlQEPocb8GV8OrOjDQabUM1gt3beLjUi73IDRJHiKkJVdblWKa0AA
	 5qcLGk9BNOblXh21DK0LuEyLDXukxQ/jvWS1m4TpZuEIDn/1mJWQ+mz3vYuD3mix5Jiea
	 Jbx02HFogkDmelWcDFLddOwGTjssaNKPxIxQzXnVEhCW578c0V2lEP+NnwHh152VLymxc
	 5+C8WvcIPvw5W83+LVuo88CwerPzR/Q2fMgF8uKPLIRhgzya/f14fRAaJfhuZqiuf2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794701733;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xqr6MyIodV9h4/OO0jWOPYjNv1F5SYtqgxsNyjc0I/0=;
	b=d+QYl8KSrqcq758qJKdCigMOTq2B4hHcNGoq44wCB81FNcdDB/2WpOW1AEhHkd3SFui5
	 3x6U1Su1Wceol0Lt4cUdjl4ANZQQkQ8xLuILwWz6Zb7S4emYs6dTcG/AyCPGMvi06ZTIo
	 G2N4uFjdGnMymxmpxRJSdtlQBE2K/rRYFGTRoOsrxe0EfKeby1H1UQgQcjJ/7hoH1FR9Q
	 YILqbol8TiNJRSz6SN0WKuZpqMeMMLTDeGIbfw4LwNJrAwRnSq/N0F3yKU0fkcEvMNFgm
	 4bRU59hJMAruTjpVuijepIXTwJqpzOCLaXmccLdGISiDqeu3rWdTWlur7Mq2Uz6UkOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vAvdXk+N;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDD4606A327
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 00:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CDD4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vAvdXk+N
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so11340095e9.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 16:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794701731; x=1795306531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xqr6MyIodV9h4/OO0jWOPYjNv1F5SYtqgxsNyjc0I/0=;
        b=vAvdXk+Nsm2uO9FB7pApMcnR2H7ccHnIpr6ZjueivXGHNOX+I/Mb0rvAauTeSD3PuT
         /laJalAJdiJJyACEiISutFQTQmnai/UVcGTLnyvQApS8Ijrjz0xUfVdr1BxdOFNv/U6m
         gJA9Hq+Jglp/CLmlPrWjA7sF3zcngwrvGNsrH0ts1V8sTXZvKcFTVXZ59oUkH+84q1Xc
         +PRK4Ayf6zhbiCt/JfbwWhO+fQP92y1NfPMT+oBCaCwr/aCgsU2ItYBmnHXaiMGGXh9Z
         lgKBme69JS7jyNS1gnuZALUXe/mVZguGZOI87wHoymZGn1TSRDwLHKsUwiTXA5hwQ0xW
         dxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794701731; x=1795306531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xqr6MyIodV9h4/OO0jWOPYjNv1F5SYtqgxsNyjc0I/0=;
        b=hkVMp9n9HJXW5M/gyrT49nEampeeNEJDNA0EIWBWKbYdUg7fWYlvk5YLBcNgVqnzJn
         2h2ct8k42hIJ4t/6/yDL9/3PUWCefN4TonlHro9nYLuCyVzYEELXlKSkr9N7d8pu6akW
         Palbgk4WoVnv7X0OaiIWzNcEx440zMHR+ol4APWhgmSN0jj9FSS56KT0X53CDSKx6NUQ
         z2JXPwJR15U9MZEr7wYtYT3QycGS0wnxYTID8e7w9u7uS9EWov1JJ6/MC8CMXXAYExSd
         4A4m2xYhYmIVuB0TGJBhxgzgE3k2CmWgzALqqBo8nnL7xfrd4EGMCbAxN8q/oIa1J//M
         dvAg==
X-Forwarded-Encrypted: i=1; AL+hErG/KGPLgn0q4j7jinXcF5Hv4j2WlcxZ6n9yeW0z3ROtVaRcWQtAi3+wfpIc9yZ9/Ai7K8fC8gVdBeayihkQ@vger.kernel.org
X-Gm-Message-State: APuU4Z+kEP+y/TTja0OoSFxhTnl8FSafvryEJIqOJpTynTb4GQuB9ntd
	KIHvy5V6/WqCulviglymDFurqdB4iTBDPUd7eLTiobF93N5c7AExh1Cr
X-Gm-Gg: AYBFou1ZB6L5oJ7NN2GKCOe8UHPv84m/DsPZD6wlgujUDI/djhxvAO+H1DmMxoufm9h
	CXSBmuZIh/bPmQFhxSXV3+gwozS7pkRjGyGRJAUYHFI4FCw4LdBx1wSp+4S/hq2bx7M2ZBi2ZOm
	n6PaGXTN6TZsEIynxmTTjBqIoYmmOepkv9DlGyCxfjkbAjFTyIg801NHgNAkR5QLTcSGVkgVL/9
	wDlF0aO6OZu8t+hAnZaR5lIII8HiAYRCQ6i4Ug3frhtbHxJfyLUxCHGejBhn/VAUYoZ3ts8LZAC
	70OKtRsWP4IO20fAv3jukjOy6zrk6QW16SsO0cdnE+AtnnunZbS9OeS8UVa9ooIrKY249VKA9Ea
	ruj6qMXg0XNde5UcuggK11ZANHArUd9eiUnftgkxiDrdKORj/cfzojnAMjUsG36qGVUh24B8rr/
	W7/i1RfdkTOEJlcp180mgP1f4WE7XdbHU3Uz6n73BoMASQnE591kBRabFk3CAtEuLvsqvjQ5v+1
	kYhlApCp5fJhCFVnXwsbnpZBTvHzaEgPh0frjAHqDgAAn/bYDf7P8tI2PfD6a2/KuM4naY7muGq
	aljr3iOXtXZEDIlHPBiRDW9VMqp3OLUr3kI2V+B+ogyR6N0wJwGsrXZCY4FZyBtK9F5jspmSZQu
	0/X2AWSerkOc=
X-Received: by 2002:a05:600c:c16d:b0:4ba:495c:2f5d with SMTP id 5b1f17b1804b1-4bb55a3e3f0mr132213105e9.9.1794701730929;
        Sat, 14 Nov 2026 16:15:30 -0800 (PST)
Received: from mohamedali-HP-EliteBook-840-G8-Notebook-PC.. ([197.18.115.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ae4414sm177925125e9.9.2026.11.14.16.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 16:15:29 -0800 (PST)
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
Subject: [PATCH v3 1/1] docs: filesystems: update VFS locking documentation
Date: Sun, 15 Nov 2026 01:13:34 +0100
Message-ID: <20261115001334.23026-2-mohamedalibouhaouala@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261115001334.23026-1-mohamedalibouhaouala@gmail.com>
References: <20261114235426.20408-1-mohamedalibouhaouala@gmail.com>
 <20261115001334.23026-1-mohamedalibouhaouala@gmail.com>
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

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Mohamed Ali Bouhaouala <mohamedalibouhaouala@gmail.com>
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

