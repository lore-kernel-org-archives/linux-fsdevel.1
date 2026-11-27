Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795739898;
	b=f3goZLl3kA+NCI+HkJ3Mc07nKin14EoFhFUqd9XwX9js5CwTprRkHr8OaaMR7Ph4u3Nt
	 5iLOyKzLPbaSU5ZyBcNZHjgVkOdVoZ8a6XIu53Q+UXzuxdlPA6nHw5xCaAhs2ujAJHVNP
	 l46NoY3SBJS0i0Hy7aEzYHqlIzNY3YEhLzcPRti3ECQUZN8OYsoDX0CzeETG9t75hJd8y
	 jYuqKX5j8i8+hPh2tXxoWM0VKf1zhdIqtcwwGorJPoCBulXNjQ2SzYuqCm0k+qHoXaHc+
	 K5oxbL2wTS1KJjPgJkFhwWXfp6C9ikJpCwzexAqAZN0SQGLOY+8Vw8gKIX3YQeybdrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795739898;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lQlv7s7MQZyUZyhC7qochRPM3hW5uEIxO4smyUjfENM=;
	b=4L4GHy2CotHRcMsHRZUuO1fjw5s1p9FHQSjWGkNt/oG7xEFiVDbtHQEudDJYHhBMtz9N
	 EjM84QyX4dWvGPV2aGzdxtx7OwS9YajNbdvC8uSOH/cBsJ7HLLKFkkEr6/zFrmS2BmB8M
	 lraSARKF11MQGsmu2ZeP1yN9Viv2B1/WiWa3d9bjJZchBU/HSR3ooAyIldv4LZ7Zhb+oe
	 8K2rcPxf/V0mBjLjxqovwyepauouz47YXIRcF2N4AzNVItyyBVyMdDY9DIR5w3jAnLAnS
	 vipHjbTIIkQDz4YGUSde0IBxjCrJirtxMrhY3329yM/rqvIvf8Nnx9ateacM6Q7KtTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IRQB+qnp;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF324606A324
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 00:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF324606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IRQB+qnp
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so76259665e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 16:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795739896; x=1796344696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lQlv7s7MQZyUZyhC7qochRPM3hW5uEIxO4smyUjfENM=;
        b=IRQB+qnpQOM6w547YodUkuBshBcOSoW4iAkPYWNOgfsJc4P4nwnTrsQjvRZOIQCc8y
         CtmRwUMEOKcQn1ygE1gV0npjdjzgGZzAUM2NgVCeJcWXM0TXHELPXwpgQS6YIZYrjA1H
         dJds97Gw4Kntosj4J77hwnrYuoDmzGd9ua/b4MBAQHUrncVxgW5belQlP7HCNOfiFyo4
         Jqhj5StFkNfkIJU2U6OoMJaSnrbA7wIHKbzTYT9CCeaJJYt5odQUC7VkxNj54vQKYUOB
         hiZ5P+KDSmpVE2J7efzORd0A65e5vB4E1w8aM0RMDlWFs7Sht598ME6QmWe8TMCX/6Id
         rzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795739896; x=1796344696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lQlv7s7MQZyUZyhC7qochRPM3hW5uEIxO4smyUjfENM=;
        b=0YRhSFNmAmMBu3a+WqTOzMQ0WqYymv34N1EXj9KC7jURmNrUxOXXwmunvfp/X6d+eS
         +83URh1eGMSQ3rwiTZuZbZB6H6SlyU5sC7MG8x9GuR9OU5k1G3fyusgltN57Q6cyowcn
         +pPLHXzsi1tMZPiA8PWkZXxyq3g/SHT/3vwYkECmjazGdgb+SVXemxyecc9wkHfm/AHB
         akHOAzalxRSBQ7scUBnR+L5Wk588OM1Qi66845cfyH13eJOF5Aot9JpwUJlPL31omeg0
         bTdIZb636nk4NgF+OvrPDXqdJ4SaMyb9k8VBh4Hp0MEbUceufJBKknJ/kNnI59L56Z/v
         Z9Hw==
X-Forwarded-Encrypted: i=1; AL+hErFiYRSJ5qOcVRF5PjBhpbpUFlolkpKjSaAs8uAZxqE14P/IyM7z9GRrwq6sP6/7aEqfG1ea18JHtX2t1t7Z@vger.kernel.org
X-Gm-Message-State: APuU4Z/M11L8FClxwWBjpOI6xdchcPpM33EyRh3mWoWMZEXS0bZBjg2G
	c46NBlULR97y6UmaxxatNhDo4Jca4T1cw1D5AZ9Xj8W1wtMFIdnpPBkB
X-Gm-Gg: AZFdTZe3zTqs6LT4yYz7n0IDdwfOmef9FMYnO8+3TO3ivjPMQsUKxNcl6cXstpu0ljx
	zDAd11mmrpgloC8p/f1aPviVXu0fIxmg3AOGDYhfEkiP5qutgvvtVrYeeNj9yWttmaNPineh5j7
	v/Jbifu0Q4K5a8Vi1HcAjOLtt1sVW+GtLXrgNOH3CUoM6KzI3zCx5o/VeDnVcsm8APWt2YG5GNC
	UWHwovCAiiMVAnvWtiDrCbuddAyggLfcjWP8os6orwY4StRlmgkMRa2Pe0oaCC7CEUD1exwfQBV
	Z2YRgGIOiHsvrqc8jR4nnkqIMsNvNkOcyLsiQVjHGt0CrjoKlcBKIjlFSPdcUzqkqATwLeAyoNl
	WmPl4O9curjseAnNRp4vlSm7J4Bzgn6ps8vIgrloAniluV/4GdBhg1vityahpyWt8A+m+ylX/r3
	9Xoq3AIPSXktyLttZJqwbmx0CYhtjdj1DGQqSsPbeeAiGxLeHWEsSpZt17o/qNiwEjB+XlhtVpg
	AYPjZRx41M1MNbjf7N0KX1R4//Ai3i3+YabKPWMBYDITwtQ8O5S673KylhYr+uZAqK5T3j2H7LA
	bTMdvyNVODKBIVhWFbwH6ZaFrEHQtadHvbx/Bqwc3sSfwl//3iCDRYCAl+0UjMcxSASlmEnaPmo
	syXXsNF3n7w==
X-Received: by 2002:a05:600c:c173:b0:4a1:813f:2a60 with SMTP id 5b1f17b1804b1-4bb88800134mr434979265e9.11.1795739895727;
        Thu, 26 Nov 2026 16:38:15 -0800 (PST)
Received: from mohamedali-HP-EliteBook-840-G8-Notebook-PC.. ([197.21.14.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2c8csm44693592f8f.2.2026.11.26.16.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 16:38:15 -0800 (PST)
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
Subject: [PATCH v3 1/1] docs: filesystems: update filesystem type, superblock and inode documentation
Date: Fri, 27 Nov 2026 01:32:36 +0100
Message-ID: <20261127003236.20196-2-mohamedalibouhaouala@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127003236.20196-1-mohamedalibouhaouala@gmail.com>
References: <sashiko-outbox-234265@kernel.org>
 <20261127003236.20196-1-mohamedalibouhaouala@gmail.com>
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

Update the VFS documentation to reflect changes in
file_system_type, super_operations, inode_operations structs.

Refresh the documented structure members and callback signatures
for super_operations and inode_operations, including missing
members from documented structs such as sync_inode_metadata(),
remove_bdev(), shutdown(), report_error(), and fiemap().

Clarify inode allocation and destruction semantics, RCU requirements,
inode eviction behavior, filesystem freezing, and block device
removal handling.

Also fix outdated terminology, callback descriptions, and
documentation references.

Signed-off-by: Mohamed Ali Bouhaouala <mohamedalibouhaouala@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 Documentation/filesystems/vfs.rst | 181 +++++++++++++++++++++---------
 1 file changed, 130 insertions(+), 51 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 1824462a4371..b44fefa2d826 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -129,6 +129,8 @@ members are defined:
 		struct lock_class_key i_mutex_key;
 		struct lock_class_key invalidate_lock_key;
 		struct lock_class_key i_mutex_dir_key;
+
+		struct lock_class_key d_lookup_key;
 	};
 
 ``name``
@@ -156,14 +158,15 @@ members are defined:
 	for internal VFS use: you should initialize this to THIS_MODULE
 	in most cases.
 
-``next``
-	for internal VFS use: you should initialize this to NULL
+``list``
+	for internal VFS use: this should be zero-initialized,
+	with ``next`` and ``pprev`` set to NULL.
 
 ``fs_supers``
 	for internal VFS use: hlist of filesystem instances (superblocks)
 
   s_lock_key, s_umount_key, s_vfs_rename_key, s_writers_key,
-  i_lock_key, i_mutex_key, invalidate_lock_key, i_mutex_dir_key: lockdep-specific
+  i_lock_key, i_mutex_key, invalidate_lock_key, i_mutex_dir_key, d_lookup_key: lockdep-specific
 
 The Superblock Object
 =====================
@@ -186,15 +189,16 @@ filesystem.  The following members are defined:
 
 		void (*dirty_inode) (struct inode *, int flags);
 		int (*write_inode) (struct inode *, struct writeback_control *wbc);
+		int (*sync_inode_metadata)(struct inode *inode, struct writeback_control *wbc);
 		int (*drop_inode) (struct inode *);
 		void (*evict_inode) (struct inode *);
 		void (*put_super) (struct super_block *);
 		int (*sync_fs)(struct super_block *sb, int wait);
-		int (*freeze_super) (struct super_block *sb,
-					enum freeze_holder who);
+		int (*freeze_super)(struct super_block *sb, enum freeze_holder who,
+			    const void *owner);
 		int (*freeze_fs) (struct super_block *);
-		int (*thaw_super) (struct super_block *sb,
-					enum freeze_wholder who);
+		int (*thaw_super)(struct super_block *sb, enum freeze_holder who,
+			const void *owner);
 		int (*unfreeze_fs) (struct super_block *);
 		int (*statfs) (struct dentry *, struct kstatfs *);
 		void (*umount_begin) (struct super_block *);
@@ -206,12 +210,15 @@ filesystem.  The following members are defined:
 
 		ssize_t (*quota_read)(struct super_block *, int, char *, size_t, loff_t);
 		ssize_t (*quota_write)(struct super_block *, int, const char *, size_t, loff_t);
-		struct dquot **(*get_dquots)(struct inode *);
+		struct dquot __rcu **(*get_dquots)(struct inode *);
 
 		long (*nr_cached_objects)(struct super_block *,
 					struct shrink_control *);
 		long (*free_cached_objects)(struct super_block *,
 					struct shrink_control *);
+		int (*remove_bdev)(struct super_block *, struct block_device *);
+		void (*shutdown)(struct super_block *);
+		void (*report_error)(const struct fserror_event *);
 	};
 
 All methods are called without any locks being held, unless otherwise
@@ -219,23 +226,46 @@ noted.  This means that most methods can block safely.  All methods are
 only called from a process context (i.e. not from an interrupt handler
 or bottom half).
 
+Exceptions:
+
+* ``->free_inode`` is called from an RCU callback and must not block.
+* ``->drop_inode`` is called with ``inode->i_lock`` held and must not block.
+
 ``alloc_inode``
 	this method is called by alloc_inode() to allocate memory for
 	struct inode and initialize it.  If this function is not
 	defined, a simple 'struct inode' is allocated.  Normally
 	alloc_inode will be used to allocate a larger structure which
 	contains a 'struct inode' embedded within it.
+	A filesystem that defines ->alloc_inode must also define
+	->free_inode or ->destroy_inode (see below), because the VFS
+	default would free the inode into its own cache.
 
 ``destroy_inode``
-	this method is called by destroy_inode() to release resources
-	allocated for struct inode.  It is only required if
-	->alloc_inode was defined and simply undoes anything done by
-	->alloc_inode.
+   This method is called by :c:func:`destroy_inode` to release resources
+   allocated for ``struct inode``. It is called synchronously, before
+   the inode memory is freed.
+
+   The VFS handles inode memory as follows:
+
+   * If ``->free_inode`` is defined, the VFS frees the inode through an
+     RCU callback that invokes ``->free_inode``. In this case,
+     ``->destroy_inode``, if defined, must release only other resources
+     and must not free the inode itself.
+
+   * If ``->destroy_inode`` is defined without ``->free_inode``, it is
+     responsible for freeing the inode memory, including deferring
+     reclamation until it is safe to do so.
+
+   * If neither is defined, the VFS frees the inode to its own cache.
+     This is only correct when ``->alloc_inode`` is also not defined.
 
 ``free_inode``
-	this method is called from RCU callback. If you use call_rcu()
-	in ->destroy_inode to free 'struct inode' memory, then it's
-	better to release memory in this method.
+	this method is called from RCU callback, after
+	``->destroy_inode`` (if any), and must free the memory of the inode.
+	It must not block.  Prefer it over calling  :c:func:`call_rcu` from
+	``->destroy_inode``: if ``->free_inode`` is defined, the VFS does the
+	:c:func:`call_rcu` for you.
 
 ``dirty_inode``
 	this method is called by the VFS when an inode is marked dirty.
@@ -251,18 +281,30 @@ or bottom half).
 	disc.  The second parameter indicates whether the write should
 	be synchronous or not, not all filesystems check this flag.
 
+``sync_inode_metadata``
+	called by the writeback code to synchronize inode metadata
+	that was previously written asynchronously.
+	The writeback_control argument describes the writeback mode.
+
+	Optional.
+
 ``drop_inode``
 	called when the last access to the inode is dropped, with the
-	inode->i_lock spinlock held.
+	``inode->i_lock`` spinlock held; it must not block.
 
 	This method should be either NULL (normal UNIX filesystem
-	semantics) or "inode_just_drop" (for filesystems that do
-	not want to cache inodes - causing "delete_inode" to always be
-	called regardless of the value of i_nlink)
+	semantics) or ``inode_just_drop`` (for filesystems that do
+	not want to cache inodes).
+
+	A non-zero return value makes the VFS evict the inode immediately,
+	regardless of the value of i_nlink:
+	``->evict_inode`` is called if the filesystem provides it,
+	otherwise the VFS truncates the page cache and clears the inode
+	itself.
 
-	The "inode_just_drop()" behavior is equivalent to the old
-	practice of using "force_delete" in the put_inode() case, but
-	does not have the races that the "force_delete()" approach had.
+	The :c:func:`inode_just_drop` behavior is equivalent to the old
+	practice of using :c:func:`force_delete` in the :c:func:`put_inode` case, but
+	does not have the races that the :c:func:`force_delete` approach had.
 
 ``evict_inode``
 	called when the VFS wants to evict an inode. Caller does
@@ -281,11 +323,13 @@ or bottom half).
 	should wait until the write out has been completed.  Optional.
 
 ``freeze_super``
-	Called instead of ->freeze_fs callback if provided.
-	Main difference is that ->freeze_super is called without taking
-	down_write(&sb->s_umount). If filesystem implements it and wants
-	->freeze_fs to be called too, then it has to call ->freeze_fs
-	explicitly from this callback. Optional.
+	Called instead of ``->freeze_fs`` callback if provided.
+	Main difference is that ``->freeze_super`` is called without taking
+	down_write(``&sb->s_umount``).  The second parameter identifies the
+	freeze holder, and the third identifies the owner of the freeze.
+	If filesystem implements it and wants ``->freeze_fs`` to be called too,
+	then it has to call ``->freeze_fs`` explicitly from this callback.
+	Optional.
 
 ``freeze_fs``
 	called when VFS is locking a filesystem and forcing it into a
@@ -332,6 +376,7 @@ or bottom half).
 
 ``get_dquots``
 	called by quota to get 'struct dquot' array for a particular inode.
+	Managed under RCU rules. More info in Documentation/RCU/whatisRCU.rst.
 	Optional.
 
 ``nr_cached_objects``
@@ -339,16 +384,17 @@ or bottom half).
 	return the number of freeable cached objects it contains.
 	Optional.
 
-``free_cache_objects``
+``free_cached_objects``
 	called by the sb cache shrinking function for the filesystem to
 	scan the number of objects indicated to try to free them.
 	Optional, but any filesystem implementing this method needs to
-	also implement ->nr_cached_objects for it to be called
+	also implement ``->nr_cached_objects`` for it to be called
 	correctly.
 
-	We can't do anything with any errors that the filesystem might
-	encountered, hence the void return type.  This will never be
-	called if the VM is trying to reclaim under GFP_NOFS conditions,
+	The VFS cannot do anything with errors the filesystem might
+	encounter, so no error code is returned: the return value is the
+	number of objects freed.  This will never be called if the VM
+	is trying to reclaim under GFP_NOFS conditions,
 	hence this method does not need to handle that situation itself.
 
 	Implementations must include conditional reschedule calls inside
@@ -357,8 +403,32 @@ or bottom half).
 	about whether implementations will cause holdoff problems due to
 	large scan batch sizes.
 
-Whoever sets up the inode is responsible for filling in the "i_op"
-field.  This is a pointer to a "struct inode_operations" which describes
+``remove_bdev``
+	Called when a block device backing the filesystem is being
+	removed. Filesystems that support graceful removal of a
+	device and can continue read-write operations should
+	implement this callback.
+
+	Return 0 if the filesystem can continue read-write
+	operations. A non-zero return value, or the absence of
+	this callback, causes the filesystem to be shut down as usual.
+
+	Optional.
+
+``shutdown``
+	Called when the filesystem needs to be shut down following
+	block device removal.
+
+	Optional.
+
+``report_error``
+	Called to report a filesystem error. The callback receives
+	a pointer to an error event describing the error.
+
+	Optional.
+
+Whoever sets up the inode is responsible for filling in the ``i_op``
+field.  This is a pointer to a ``struct inode_operations`` which describes
 the methods that can be performed on individual inodes.
 
 
@@ -410,7 +480,7 @@ struct inode_operations
 -----------------------
 
 This describes how the VFS can manipulate an inode in your filesystem.
-As of kernel 2.6.22, the following members are defined:
+The following members are defined:
 
 .. code-block:: c
 
@@ -433,8 +503,9 @@ As of kernel 2.6.22, the following members are defined:
 		int (*setattr) (const struct mnt_idmap *, struct dentry *, struct iattr *);
 		int (*getattr) (const struct mnt_idmap *, const struct path *, struct kstat *, u32, unsigned int);
 		ssize_t (*listxattr) (struct dentry *, char *, size_t);
-		void (*update_time)(struct inode *inode, enum fs_update_time type,
-				    int flags);
+		int (*fiemap)(struct inode *, struct fiemap_extent_info *, u64 start, u64 len);
+		int (*update_time)(struct inode *inode, enum fs_update_time type,
+			unsigned int flags);
 		void (*sync_lazytime)(struct inode *inode);
 		int (*atomic_open)(struct inode *, struct dentry *, struct file *,
 				   unsigned open_flag, umode_t create_mode);
@@ -460,16 +531,18 @@ otherwise noted.
 ``lookup``
 	called when the VFS needs to look up an inode in a parent
 	directory.  The name to look for is found in the dentry.  This
-	method must call d_add() to insert the found inode into the
-	dentry.  The "i_count" field in the inode structure should be
+	method returns ``d_splice_alias(inode, dentry)``;
+	(or :c:func:`d_add` plus return NULL for non-directories,
+	and for negative dentries).
+	The ``i_count`` field in the inode structure should be
 	incremented.  If the named inode does not exist a NULL inode
 	should be inserted into the dentry (this is called a negative
 	dentry).  Returning an error code from this routine must only be
 	done on a real error, otherwise creating inodes with system
-	calls like create(2), mknod(2), mkdir(2) and so on will fail.
+	calls like ``create(2)``, ``mknod(2)``, ``mkdir(2)`` and so on will fail.
 	If you wish to overload the dentry methods then you should
-	initialise the "d_dop" field in the dentry; this is a pointer to
-	a struct "dentry_operations".  This method is called with the
+	initialise the ``d_dop`` field in the dentry; this is a pointer to
+	a struct ``dentry_operations``.  This method is called with the
 	directory inode semaphore held
 
 ``link``
@@ -487,28 +560,29 @@ otherwise noted.
 	d_instantiate() just as you would in the create() method
 
 ``mkdir``
-	called by the mkdir(2) system call.  Only required if you want
+	called by the ``mkdir(2)`` system call.  Only required if you want
 	to support creating subdirectories.  You will probably need to
-	call d_instantiate_new() just as you would in the create() method.
+	call :c:func:`d_instantiate` just as you would in the :c:func:`create` method
+	but preferably :c:func:`d_instantiate_new`.
 
-	If d_instantiate_new() is not used and if the fh_to_dentry()
+	If :c:func:`d_instantiate_new` is not used and if the :c:func:`fh_to_dentry`
 	export operation is provided, or if the storage might be
 	accessible by another path (e.g. with a network filesystem)
-	then more care may be needed.  Importantly d_instantate()
-	should not be used with an inode that is no longer I_NEW if there
+	then more care may be needed.  Importantly :c:func:`d_instantiate`
+	should not be used with an inode that is no longer ``I_NEW`` if there
 	any chance that the inode could already be attached to a dentry.
 	This is because of a hard rule in the VFS that a directory must
 	only ever have one dentry.
 
 	For example, if an NFS filesystem is mounted twice the new directory
 	could be visible on the other mount before it is on the original
-	mount, and a pair of name_to_handle_at(), open_by_handle_at()
-	calls could instantiate the directory inode with an IS_ROOT()
+	mount, and a pair of :c:func:`name_to_handle_at`, :c:func:`open_by_handle_at`
+	calls could instantiate the directory inode with an :c:func:`IS_ROOT`
 	dentry before the first mkdir returns.
 
 	If there is any chance this could happen, then the new inode
-	should be attached with d_splice_alias().  The returned
-	dentry (if any) should be returned by ->mkdir().
+	should be attached with :c:func:`d_splice_alias`.  The returned
+	dentry (if any) should be returned by ``->mkdir()``.
 
 ``rmdir``
 	called by the rmdir(2) system call.  Only required if you want
@@ -587,6 +661,11 @@ otherwise noted.
 	called by the VFS to list all extended attributes for a given
 	file.  This method is called by the listxattr(2) system call.
 
+``fiemap``
+	called by the VFS to report the extent layout of a file
+	via the FIEMAP ioctl.
+	More info in Documentation/filesystems/fiemap.rst.
+
 ``update_time``
 	called by the VFS to update a specific time or the i_version of
 	an inode.  If this is not defined the VFS will update the inode
-- 
2.43.0

