Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795559946;
	b=jeex3nmJIaGiQWvQdSBV2iU+VanPYOtczUv+2LjLgKekvkwM1DuAW45meUQuDoWLsqYf
	 kvJuWPGY3F9+aDsEJPe84Kkon9FVjgqdzbPfDiYd3Hj2tgJ40keZpUmOO0lEWR8cVXW2A
	 eWiOxSRDZhKronngpqhWPb1AEl6eC5o4pgRmFTcRwaaRy7wlrYtfVc0t1UU8gC+giiYev
	 WTMKvlsF9qobsqA26BCW+s5+ptBQ7MFxix1NKGTX+D/R75dKF4uRFE8bwxU2BLw8jw8lK
	 2pb8cmUCpogNq5gbSqKMRHwTE1+Xk2FmmKN6nLi5uXCwC20UD42YVYGZxCX/vYEp+dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795559946;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xxisPRU76epkJqBWYTOk/RRq8HtvboTSfe3gDitjQJo=;
	b=q5YX0JXq9fvsC/KqFOt/9F3DuWcbNAPIYcfFsATBTcX86rJI34EyKGlZByjttKxUWSQW
	 hL5e/ZbpRNiv/xv4W0rZl+/DBn1hAGi3G/dAgq/odMoQp7tuy1ZmJYMzT2oZi+kRdCU+v
	 DXTUIM6WrCgEICPBFIXM7zYwjLRvutmSDgROrji/6IiCXeI8yfh1GYx1AZZsyMjd08pvn
	 gO99iZdJXpHgd6kKtj8bGSyC2DvI7RdEJrcOZdT1LLWqQ7w+lKNxZvbG22doUsG0iIDmK
	 PCeGoKIxda8h7NMr049ObITjNTSz0YbsgQtT2prytgI8hqcgqTkwQnqT4vm7yXaIsyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cWp0QmNj;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1917F606A31E
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 22:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1917F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cWp0QmNj
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb61185057so33273125e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 14:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795559943; x=1796164743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xxisPRU76epkJqBWYTOk/RRq8HtvboTSfe3gDitjQJo=;
        b=cWp0QmNj2rBF3IXsUKTErrbQ8LQ9OuXoSez2HmnDH+AGW5hpVwLcrqJ1jC3LiGssEc
         3o4tjScCQKQob6pJq3aosAmTcjRGexdzn/8T8nuwRdiDn+dFpAfPzHGknAo/eyzpc/AW
         QyqDLYaCLoY47aIvoU1MSFRSsgZxcAzkvx6sOpcHix/mglY6sAiHEGCTdt7cGsEsXVnf
         tLHRNjndmKoSylxdtlMD/pBE2hnItP5cAliMfT2pBfwJK8jHG7qaY695coK3b/jp8DSv
         JI3M+DN0snBlh8k2UVzpRag+ogDzaHzmti0RT4QilGwvXn+TvYj6DyXUcw5aa9tTjAL4
         JaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795559943; x=1796164743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xxisPRU76epkJqBWYTOk/RRq8HtvboTSfe3gDitjQJo=;
        b=paumpheDYWBfWSTxJFVVB4DIRcv5+kWSe6nHeU/5jPKCGOaqKhnT7/ZqtmGGnQ9rDc
         h7W4LYxhCQ7fbSImv99RIclSubfUHJlXlfg1ZPQXVKwWJa9vILerDjTzH2jj3vtvXGVD
         TLyC8jhknXcCeSlMbS4JbzABFSAAyHIgHXWgM1DaCDT1hwTCSOIeZQnztIajGoz5SI4b
         VkguMEfR0K6tMy7bZScvdEa2hg8ga4w3mOs4ms2zLk5HYdFJqQe8m1LcBEmVo5QbsYBv
         IBzebCyWuGA58ojEZLKJN6aHNKiKMfX0CyLN5v2uehvKNLCrVHxfxXIdeneEyskUTt07
         SCrQ==
X-Forwarded-Encrypted: i=1; AL+hErGHlLYIqpmbTVCJyYtiis6II7qqpiaa/CbhaQ0AWqUvPEIXdzbacSKWPJ+af6YbSdpUVtzFqqcXcyTqlXm0@vger.kernel.org
X-Gm-Message-State: APuU4Z+cN5tdHn0XIrBo5rikktVXDhYm8LF4VpmJhZX+/fDenHl2/HUX
	RNhS5dJ07NidjVntNdb101x/N22asz+KvYDod/GinK5tnx6Jb7XbWpbk
X-Gm-Gg: AZFdTZfukofAwvyYWG2F7r92LBa9L9fiti1A4TnvZGZwN3JyjtWW9mczNVV5Ya0lnWX
	XqTigBj4mynPDh9B5ywfWt1StyVEHjsHLfv3GysKdeN8QOGxPWL8W5REtKyJA+4LhNrqOR+bD++
	el4pKBPcIEu93Zbcik3NBnFKi+Y7+bcr+yokXAprtdP5G/U1paxze9Q6xTKjz5oPflXayPveEsV
	ObstKBW5mE6vYCbYeyLfoFlW+bPZel1d/zGuGdp6ck9Fow9JTw/hZ/viCQgngbqh0IVngsErHA1
	5mHrQxSX0ba3/hRE/COMIRyaqe5yZkr4hSmmhPIpCavl5Eq7NFzF1QHsKSV7B0AWjZLsPTOo3rf
	grTePLQTW1TQFdNAiBlvLHVcM8fZNM60P2dXXiK3K33JkGy84SgsF6LtaO6JpzmgNlZpQw970bU
	bLIjYaHsbWYBdydkEFqBa1jUJVf+jRvlKlDvKsfYBk48msVwefhmyasGOrVqWN2F+/LCDyiXAXM
	6onoVGVuJ35i9TuDFedsSLhfGz4CM/YfR43v9rOaPv37VMgHoIKM5rWjOWbe5Um/Xf0PBaIAuWz
	aiUd3mf9wY6Lw1n42hJEHzBVbscafm9gBKy9vBtb9On+Oo+54TFVKSb0KqBwWE8dHZcTKhyQ9Bb
	yLz2uYWx8IA==
X-Received: by 2002:a05:600c:64c9:b0:4bb:8701:bb14 with SMTP id 5b1f17b1804b1-4bb88804d1cmr356715265e9.5.1795559943054;
        Tue, 24 Nov 2026 14:39:03 -0800 (PST)
Received: from mohamedali-HP-EliteBook-840-G8-Notebook-PC.. ([197.21.41.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab5ffcad11sm29362193f8f.0.2026.11.24.14.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 14:39:02 -0800 (PST)
From: mohamedalibouhaouala@gmail.com
To: jack@suse.cz
Cc: corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	mohamedalibouhaouala@gmail.com,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org,
	willy@infradead.org
Subject: [PATCH v2] docs: filesystems: update filesystem type, superblock and inode documentation
Date: Tue, 24 Nov 2026 23:38:41 +0100
Message-ID: <20261124223841.45091-1-mohamedalibouhaouala@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <47rkrhjkulqvgfkp3ssvgrrmsfmeof6adtjrght2fcmq6ykbn3@dis6c75io7ri>
References: <47rkrhjkulqvgfkp3ssvgrrmsfmeof6adtjrght2fcmq6ykbn3@dis6c75io7ri>
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
members from documented structs  such as sync_inode_metadata(),
remove_bdev(), shutdown(), report_error(), and fiemap().

Clarify inode allocation and destruction semantics, RCU requirements,
inode eviction behavior, filesystem freezing, and block device
removal handling.

Also fix outdated terminology, callback descriptions, and
documentation references.

Signed-off-by: Mohamed Ali Bouhaouala <mohamedalibouhaouala@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 Documentation/filesystems/vfs.rst | 178 +++++++++++++++++++++---------
 1 file changed, 128 insertions(+), 50 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 1824462a4371..da4aefb1cc90 100644
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
@@ -156,14 +158,14 @@ members are defined:
 	for internal VFS use: you should initialize this to THIS_MODULE
 	in most cases.
 
-``next``
+``list``
 	for internal VFS use: you should initialize this to NULL
 
 ``fs_supers``
 	for internal VFS use: hlist of filesystem instances (superblocks)
 
   s_lock_key, s_umount_key, s_vfs_rename_key, s_writers_key,
-  i_lock_key, i_mutex_key, invalidate_lock_key, i_mutex_dir_key: lockdep-specific
+  i_lock_key, i_mutex_key, invalidate_lock_key, i_mutex_dir_key, d_lookup_key: lockdep-specific
 
 The Superblock Object
 =====================
@@ -186,15 +188,16 @@ filesystem.  The following members are defined:
 
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
@@ -206,12 +209,15 @@ filesystem.  The following members are defined:
 
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
@@ -219,23 +225,46 @@ noted.  This means that most methods can block safely.  All methods are
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
@@ -251,18 +280,30 @@ or bottom half).
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
@@ -281,11 +322,13 @@ or bottom half).
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
@@ -332,6 +375,7 @@ or bottom half).
 
 ``get_dquots``
 	called by quota to get 'struct dquot' array for a particular inode.
+	Managed under RCU rules. More info in Documentation/RCU/whatisRCU.rst.
 	Optional.
 
 ``nr_cached_objects``
@@ -339,16 +383,17 @@ or bottom half).
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
@@ -357,8 +402,32 @@ or bottom half).
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
 
 
@@ -410,7 +479,7 @@ struct inode_operations
 -----------------------
 
 This describes how the VFS can manipulate an inode in your filesystem.
-As of kernel 2.6.22, the following members are defined:
+The following members are defined:
 
 .. code-block:: c
 
@@ -433,8 +502,9 @@ As of kernel 2.6.22, the following members are defined:
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
@@ -460,16 +530,18 @@ otherwise noted.
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
@@ -487,28 +559,29 @@ otherwise noted.
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
@@ -587,6 +660,11 @@ otherwise noted.
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

