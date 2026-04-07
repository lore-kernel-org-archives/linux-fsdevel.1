Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783EA191F91
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 00:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775523045; cv=none; b=ERc7AXFp2HJv3NzGpx3DNeej/9QShKq0JnWo7gkZa2/TSYDotmKLkQwuYLNUzQvp0FlA49AG55PVVi7FKCqOY4TGIBvGrCL/01qaycRBU6GgIFho+WNRNgNhHDdJffY9TJ8edRCUQIX0Nf26lZRZbGsDN/gHF4AuR5mh7rBNA/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775523045; c=relaxed/simple;
	bh=rM71AlIbIon6p85Me6yhca1tQNMnAKKcUbVyjHxH0/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WhwRMWh78mfJc4xFPm3xvurZyy1q727HphkIhBWhyAXuhKGFiU8Rk5p8g4Qf3BNdpiN8Dkws096XTX23YKWr3F1m8Mx0vBVaZtbC/IDNwAxpj90XtyYESLJ04UOAKXW+puwKFEriwYKDWel51As3zgEmU64EsSh9La1YCkaF2LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fR7XY90F; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fR7XY90F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=h92IoAXLkTvTxAEFJjrJBOtrnMIjBpNnI8fujZwR0hI=; b=fR7XY90Foe/nWpCbM3pL/fU9zR
	B3sXfmopbn6EZYOknlVbPdocx/L2rDRyjpyCukge88SIw8RkQMjfgOMvw0MvMRg91PHgKIBywuB/p
	iQL5rW+yU9M3/WSzCXQGk2TrSUE1xjZwhNx9CpY9rF/iViK6JKZzBMzH2eJXYSU58k3OgfBvZUH2f
	6m6IY0PkQpXJ0jfZ1KU4dRye++edXrlYwLGOG8EhHcIMjg2j2hroG8GmeogqdM2iWj1+iRDC83y/o
	vDaqbIM7N3pbmOEpCheDVfuxeipmlD9Vc0wIHqr+GtRdYjxZ4TM2dtC5aMiPbgcclx5ozYkk0cm3E
	eLK5C19g==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9ueP-00000005ff8-2oiM;
	Tue, 07 Apr 2026 00:50:41 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH 3/3 v2] fuse: fuse_i.h: clean up kernel-doc comments
Date: Mon,  6 Apr 2026 17:50:40 -0700
Message-ID: <20260407005040.1929492-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407005040.1929492-1-rdunlap@infradead.org>
References: <20260407005040.1929492-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert many comments to kernel-doc format to eliminate around 20
kernel-doc warnings like these:

Warning: fs/fuse/fuse_i.h:374 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
 * A Fuse connection.
Warning: fs/fuse/fuse_i.h:817 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
 * Get a filled in inode
Warning: fs/fuse/fuse_i.h:859 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
 * Send RELEASE or RELEASEDIR request
and more like this.

Also add struct member and function parameter descriptions to avoid
these warnings:

Warning: fs/fuse/fuse_i.h:1071 struct member 'epoch_work' not described in 'fuse_conn'
Warning: fs/fuse/fuse_i.h:1071 struct member 'rcu' not described in 'fuse_conn'
Warning: fs/fuse/fuse_i.h:1423 function parameter 'fc' not described in 'fuse_reverse_inval_inode'
Warning: fs/fuse/fuse_i.h:1423 function parameter 'nodeid' not described in 'fuse_reverse_inval_inode'
Warning: fs/fuse/fuse_i.h:1423 function parameter 'offset' not described in 'fuse_reverse_inval_inode'
Warning: fs/fuse/fuse_i.h:1423 function parameter 'len' not described in 'fuse_reverse_inval_inode'
Warning: fs/fuse/fuse_i.h:1436 function parameter 'fc' not described in 'fuse_reverse_inval_entry'
Warning: fs/fuse/fuse_i.h:1436 function parameter 'parent_nodeid' not described in 'fuse_reverse_inval_entry'
Warning: fs/fuse/fuse_i.h:1436 function parameter 'child_nodeid' not described in 'fuse_reverse_inval_entry'
Warning: fs/fuse/fuse_i.h:1436 function parameter 'name' not described in 'fuse_reverse_inval_entry'
Warning: fs/fuse/fuse_i.h:1436 function parameter 'flags' not described in 'fuse_reverse_inval_entry'

Convert struct fuse_file, struct fuse_submount_lookup, struct fuse_inode,
and struct fuse_conn to kernel-doc.

Convert these to plain comments:
Warning: fs/fuse/fuse_i.h:1423 expecting prototype for File(). Prototype was for fuse_reverse_inval_inode() instead
Warning: fs/fuse/fuse_i.h:1436 expecting prototype for File(). Prototype was for fuse_reverse_inval_entry() instead

Change some "/**" to "/*" since they are not kernel-doc comments.

The changes above fix most kernel-doc warnings in this file but
these warnings are not fixed and still remain:
Warning: fs/fuse/fuse_i.h:1428 No description found for return value of 'fuse_fill_super_common'
Warning: fs/fuse/fuse_i.h:1455 No description found for return value of 'fuse_ctl_add_conn'

Binary build output is the same before and after these changes.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: rebase and resend

Cc: Miklos Szeredi <miklos@szeredi.hu>

 fs/fuse/fuse_i.h |  455 ++++++++++++++++++++++++++-------------------
 1 file changed, 272 insertions(+), 183 deletions(-)

--- linux-next-20260406.orig/fs/fuse/fuse_i.h
+++ linux-next-20260406/fs/fuse/fuse_i.h
@@ -71,137 +71,166 @@ extern unsigned int max_user_congthresh;
 
 struct fuse_forget_link;
 
-/* Submount lookup tracking */
+/**
+ * struct fuse_submount_lookup - Submount lookup tracking
+ */
 struct fuse_submount_lookup {
-	/** Refcount */
+	/** @count: Refcount */
 	refcount_t count;
 
-	/** Unique ID, which identifies the inode between userspace
-	 * and kernel */
+	/**
+	 * @nodeid: Unique ID, which identifies the inode between userspace
+	 * and kernel
+	 */
 	u64 nodeid;
 
-	/** The request used for sending the FORGET message */
+	/** @forget: The request used for sending the FORGET message */
 	struct fuse_forget_link *forget;
 };
 
-/** Container for data related to mapping to backing file */
+/* Container for data related to mapping to backing file */
 struct fuse_backing {
 	struct file *file;
 	struct cred *cred;
 
-	/** refcount */
+	/* refcount */
 	refcount_t count;
 	struct rcu_head rcu;
 };
 
-/** FUSE inode */
+/**
+ * struct fuse_inode - FUSE inode
+ */
 struct fuse_inode {
-	/** Inode data */
+	/** @inode: Inode data */
 	struct inode inode;
 
-	/** Unique ID, which identifies the inode between userspace
-	 * and kernel */
+	/**
+	 * @nodeid: Unique ID, which identifies the inode between userspace
+	 * and kernel
+	 */
 	u64 nodeid;
 
-	/** Number of lookups on this inode */
+	/** @nlookup: Number of lookups on this inode */
 	u64 nlookup;
 
-	/** The request used for sending the FORGET message */
+	/** @forget: The request used for sending the FORGET message */
 	struct fuse_forget_link *forget;
 
-	/** Time in jiffies until the file attributes are valid */
+	/** @i_time: Time in jiffies until the file attributes are valid */
 	u64 i_time;
 
-	/* Which attributes are invalid */
+	/** @inval_mask: Which attributes are invalid */
 	u32 inval_mask;
 
-	/** The sticky bit in inode->i_mode may have been removed, so
-	    preserve the original mode */
+	/**
+	 * @orig_i_mode: The sticky bit in inode->i_mode may have been removed,
+	 * so preserve the original mode
+	 */
 	umode_t orig_i_mode;
 
-	/* Cache birthtime */
+	/** @i_btime: Cache birthtime */
 	struct timespec64 i_btime;
 
-	/** 64 bit inode number */
+	/** @orig_ino: 64-bit inode number */
 	u64 orig_ino;
 
-	/** Version of last attribute change */
+	/** @attr_version: Version of last attribute change */
 	u64 attr_version;
 
 	union {
 		/* read/write io cache (regular file only) */
 		struct {
-			/* Files usable in writepage.  Protected by fi->lock */
+			/**
+			 * @write_files: Files usable in writepage.
+			 * Protected by fi->lock
+			 */
 			struct list_head write_files;
 
-			/* Writepages pending on truncate or fsync */
+			/**
+			 * @queued_writes: Writepages pending on truncate or
+			 * fsync
+			 */
 			struct list_head queued_writes;
 
-			/* Number of sent writes, a negative bias
-			 * (FUSE_NOWRITE) means more writes are blocked */
+			/**
+			 * @writectr: Number of sent writes, a negative bias
+			 * (FUSE_NOWRITE) means more writes are blocked
+			 */
 			int writectr;
 
-			/** Number of files/maps using page cache */
+			/** @iocachectr: Number of files/maps using page cache */
 			int iocachectr;
 
-			/* Waitq for writepage completion */
+			/** @page_waitq: Waitq for writepage completion */
 			wait_queue_head_t page_waitq;
 
-			/* waitq for direct-io completion */
+			/** @direct_io_waitq: waitq for direct-io completion */
 			wait_queue_head_t direct_io_waitq;
 		};
 
-		/* readdir cache (directory only) */
+		/** @rdc: readdir cache (directory only) */
 		struct {
-			/* true if fully cached */
+			/** @cached: true if fully cached */
 			bool cached;
 
-			/* size of cache */
+			/** @size: size of cache */
 			loff_t size;
 
-			/* position at end of cache (position of next entry) */
+			/**
+			 * @pos: position at end of cache (position of next
+			 * entry)
+			 */
 			loff_t pos;
 
-			/* version of the cache */
+			/** @version: version of the cache */
 			u64 version;
 
-			/* modification time of directory when cache was
-			 * started */
+			/**
+			 * @mtime: modification time of directory when cache was
+			 * started
+			 */
 			struct timespec64 mtime;
 
-			/* iversion of directory when cache was started */
+			/**
+			 * @iversion: iversion of directory when cache was
+			 * started
+			 */
 			u64 iversion;
 
-			/* protects above fields */
+			/** @lock: protects above fields */
 			spinlock_t lock;
 		} rdc;
 	};
 
-	/** Miscellaneous bits describing inode state */
+	/** @state: Miscellaneous bits describing inode state */
 	unsigned long state;
 
-	/** Lock for serializing lookup and readdir for back compatibility*/
+	/**
+	 * @mutex: Lock for serializing lookup and readdir for back
+	 * compatibility
+	 */
 	struct mutex mutex;
 
-	/** Lock to protect write related fields */
+	/** @lock: Lock to protect write-related fields */
 	spinlock_t lock;
 
 #ifdef CONFIG_FUSE_DAX
-	/*
-	 * Dax specific inode data
+	/**
+	 * @dax: Dax specific inode data
 	 */
 	struct fuse_inode_dax *dax;
 #endif
-	/** Submount specific lookup tracking */
+	/** @submount_lookup: Submount specific lookup tracking */
 	struct fuse_submount_lookup *submount_lookup;
 #ifdef CONFIG_FUSE_PASSTHROUGH
-	/** Reference to backing file in passthrough mode */
+	/** @fb: Reference to backing file in passthrough mode */
 	struct fuse_backing *fb;
 #endif
 
-	/*
-	 * The underlying inode->i_blkbits value will not be modified,
-	 * so preserve the blocksize specified by the server.
+	/**
+	 * @cached_i_blkbits: The underlying inode->i_blkbits value will not
+	 * be modified, so preserve the blocksize specified by the server.
 	 */
 	u8 cached_i_blkbits;
 };
@@ -231,61 +260,64 @@ struct fuse_conn;
 struct fuse_mount;
 union fuse_file_args;
 
-/** FUSE specific file data */
+/**
+ * struct fuse_file - FUSE-specific file data
+ */
 struct fuse_file {
-	/** Fuse connection for this file */
+	/** @fm: Fuse connection for this file */
 	struct fuse_mount *fm;
 
-	/* Argument space reserved for open/release */
+	/** @args: Argument space reserved for open/release */
 	union fuse_file_args *args;
 
-	/** Kernel file handle guaranteed to be unique */
+	/** @kh: Kernel file handle guaranteed to be unique */
 	u64 kh;
 
-	/** File handle used by userspace */
+	/** @fh: File handle used by userspace */
 	u64 fh;
 
-	/** Node id of this file */
+	/** @nodeid: Node id of this file */
 	u64 nodeid;
 
-	/** Refcount */
+	/** @count: Refcount */
 	refcount_t count;
 
-	/** FOPEN_* flags returned by open */
+	/** @open_flags: FOPEN_* flags returned by open */
 	u32 open_flags;
 
-	/** Entry on inode's write_files list */
+	/** @write_entry: Entry on inode's write_files list */
 	struct list_head write_entry;
 
-	/* Readdir related */
+	/** @readdir: Readdir-related */
 	struct {
-		/* Dir stream position */
+		/** @pos: Dir stream position */
 		loff_t pos;
 
-		/* Offset in cache */
+		/** @cache_off: Offset in cache */
 		loff_t cache_off;
 
-		/* Version of cache we are reading */
+		/** @version: Version of cache we are reading */
 		u64 version;
 
 	} readdir;
 
-	/** RB node to be linked on fuse_conn->polled_files */
+	/** @polled_node: RB node to be linked on fuse_conn->polled_files */
 	struct rb_node polled_node;
 
-	/** Wait queue head for poll */
+	/** @poll_wait: Wait queue head for poll */
 	wait_queue_head_t poll_wait;
 
-	/** Does file hold a fi->iocachectr refcount? */
+	/** @iomode: Does file hold a fi->iocachectr refcount? */
 	enum { IOM_NONE, IOM_CACHED, IOM_UNCACHED } iomode;
 
 #ifdef CONFIG_FUSE_PASSTHROUGH
-	/** Reference to backing file in passthrough mode */
+	/** @passthrough: Reference to backing file in passthrough mode */
 	struct file *passthrough;
+	/** @cred: passthrough file credentials */
 	const struct cred *cred;
 #endif
 
-	/** Has flock been performed on this file? */
+	/** @flock: Has flock been performed on this file? */
 	bool flock:1;
 };
 
@@ -372,102 +404,135 @@ struct fuse_sync_bucket {
 };
 
 /**
- * A Fuse connection.
+ * struct fuse_conn - A Fuse connection.
  *
  * This structure is created, when the root filesystem is mounted, and
  * is destroyed, when the client device is closed and the last
  * fuse_mount is destroyed.
  */
 struct fuse_conn {
-	/** Lock protecting:
-	    - polled_files
-	    - backing_files_map
-	    - curr_bucket
+	/**
+	 * @lock: Lock protecting:
+	 * - polled_files
+	 * - backing_files_map
+	 * - curr_bucket
 	 */
 	spinlock_t lock;
 
-	/** Refcount */
+	/** @count: Refcount */
 	refcount_t count;
 
-	/** Current epoch for up-to-date dentries */
+	/** @epoch: Current epoch for up-to-date dentries */
 	atomic_t epoch;
 
+	/** @epoch_work: Used to invalidate dentries from old epochs */
 	struct work_struct epoch_work;
 
+	/** @rcu: Used to delay freeing fuse_conn, making it safe */
 	struct rcu_head rcu;
 
-	/** The user id for this mount */
+	/** @user_id: The user id for this mount */
 	kuid_t user_id;
 
-	/** The group id for this mount */
+	/** @group_id: The group id for this mount */
 	kgid_t group_id;
 
-	/** The pid namespace for this mount */
+	/** @pid_ns: The pid namespace for this mount */
 	struct pid_namespace *pid_ns;
 
-	/** The user namespace for this mount */
+	/** @user_ns: The user namespace for this mount */
 	struct user_namespace *user_ns;
 
-	/** Maximum read size */
+	/** @max_read: Maximum read size */
 	unsigned max_read;
 
-	/** Maximum write size */
+	/** @max_write: Maximum write size */
 	unsigned max_write;
 
-	/** Maximum number of pages that can be used in a single request */
+	/**
+	 * @max_pages: Maximum number of pages that can be used in a
+	 * single request
+	 */
 	unsigned int max_pages;
 
-	/** Constrain ->max_pages to this value during feature negotiation */
+	/**
+	 * @max_pages_limit: Constrain ->max_pages to this value during
+	 * feature negotiation
+	 */
 	unsigned int max_pages_limit;
 
-	/* transport layer object */
+	/** @chan: transport layer object */
 	struct fuse_chan *chan;
 
-	/** The next unique kernel file handle */
+	/** @khctr: The next unique kernel file handle */
 	atomic64_t khctr;
 
-	/** rbtree of fuse_files waiting for poll events indexed by ph */
+	/**
+	 * @polled_files: rbtree of fuse_files waiting for poll events
+	 * indexed by ph
+	 */
 	struct rb_root polled_files;
 
-	/** Number of background requests at which congestion starts */
+	/**
+	 * @congestion_threshold: Number of background requests at which
+	 * congestion starts
+	 */
 	unsigned congestion_threshold;
 
-	/** Connection failed (version mismatch).  Cannot race with
-	    setting other bitfields since it is only set once in INIT
-	    reply, before any other request, and never cleared */
+	/**
+	 * @conn_error: Connection failed (version mismatch).  Cannot race with
+	 * setting other bitfields since it is only set once in INIT
+	 * reply, before any other request, and never cleared
+	 */
 	unsigned conn_error:1;
 
-	/** Connection successful.  Only set in INIT */
+	/** @conn_init: Connection successful.  Only set in INIT */
 	unsigned conn_init:1;
 
-	/** Do readahead asynchronously?  Only set in INIT */
+	/** @async_read: Do readahead asynchronously?  Only set in INIT */
 	unsigned async_read:1;
 
-	/** Return an unique read error after abort.  Only set in INIT */
+	/**
+	 * @abort_err: Return an unique read error after abort.
+	 * Only set in INIT
+	 */
 	unsigned abort_err:1;
 
-	/** Do not send separate SETATTR request before open(O_TRUNC)  */
+	/**
+	 * @atomic_o_trunc: Do not send separate SETATTR request before
+	 * open(O_TRUNC)
+	 */
 	unsigned atomic_o_trunc:1;
 
-	/** Filesystem supports NFS exporting.  Only set in INIT */
+	/**
+	 * @export_support: Filesystem supports NFS exporting.
+	 * Only set in INIT
+	 */
 	unsigned export_support:1;
 
-	/** write-back cache policy (default is write-through) */
+	/** @writeback_cache: write-back cache policy (default is write-through) */
 	unsigned writeback_cache:1;
 
-	/** allow parallel lookups and readdir (default is serialized) */
+	/**
+	 * @parallel_dirops: allow parallel lookups and readdir (default is
+	 * serialized)
+	 */
 	unsigned parallel_dirops:1;
 
-	/** handle fs handles killing suid/sgid/cap on write/chown/trunc */
+	/**
+	 * @handle_killpriv: handle fs handles killing suid/sgid/cap on
+	 * write/chown/trunc
+	 */
 	unsigned handle_killpriv:1;
 
-	/** cache READLINK responses in page cache */
+	/** @cache_symlinks: cache READLINK responses in page cache */
 	unsigned cache_symlinks:1;
 
-	/* show legacy mount options */
+	/** @legacy_opts_show: show legacy mount options */
 	unsigned int legacy_opts_show:1;
 
-	/*
+	/**
+	 * @handle_killpriv_v2:
 	 * fs kills suid/sgid/cap on write/chown/trunc. suid is killed on
 	 * write/trunc only if caller did not have CAP_FSETID.  sgid is killed
 	 * on write/truncate only if caller did not have CAP_FSETID as well as
@@ -480,196 +545,217 @@ struct fuse_conn {
 	 * and hence races in setting them will not cause malfunction
 	 */
 
-	/** Is open/release not implemented by fs? */
+	/** @no_open: Is open/release not implemented by fs? */
 	unsigned no_open:1;
 
-	/** Is opendir/releasedir not implemented by fs? */
+	/** @no_opendir: Is opendir/releasedir not implemented by fs? */
 	unsigned no_opendir:1;
 
-	/** Is fsync not implemented by fs? */
+	/** @no_fsync: Is fsync not implemented by fs? */
 	unsigned no_fsync:1;
 
-	/** Is fsyncdir not implemented by fs? */
+	/** @no_fsyncdir: Is fsyncdir not implemented by fs? */
 	unsigned no_fsyncdir:1;
 
-	/** Is flush not implemented by fs? */
+	/** @no_flush: Is flush not implemented by fs? */
 	unsigned no_flush:1;
 
-	/** Is setxattr not implemented by fs? */
+	/** @no_setxattr: Is setxattr not implemented by fs? */
 	unsigned no_setxattr:1;
 
-	/** Does file server support extended setxattr */
+	/** @setxattr_ext: Does file server support extended setxattr */
 	unsigned setxattr_ext:1;
 
-	/** Is getxattr not implemented by fs? */
+	/** @no_getxattr: Is getxattr not implemented by fs? */
 	unsigned no_getxattr:1;
 
-	/** Is listxattr not implemented by fs? */
+	/** @no_listxattr: Is listxattr not implemented by fs? */
 	unsigned no_listxattr:1;
 
-	/** Is removexattr not implemented by fs? */
+	/** @no_removexattr: Is removexattr not implemented by fs? */
 	unsigned no_removexattr:1;
 
-	/** Are posix file locking primitives not implemented by fs? */
+	/** @no_lock: Are posix file locking primitives not implemented by fs? */
 	unsigned no_lock:1;
 
-	/** Is access not implemented by fs? */
+	/** @no_access: Is access not implemented by fs? */
 	unsigned no_access:1;
 
-	/** Is create not implemented by fs? */
+	/** @no_create: Is create not implemented by fs? */
 	unsigned no_create:1;
 
-	/** Is bmap not implemented by fs? */
+	/** @no_bmap: Is bmap not implemented by fs? */
 	unsigned no_bmap:1;
 
-	/** Is poll not implemented by fs? */
+	/** @no_poll: Is poll not implemented by fs? */
 	unsigned no_poll:1;
 
-	/** Do multi-page cached writes */
+	/** @big_writes: Do multi-page cached writes */
 	unsigned big_writes:1;
 
-	/** Don't apply umask to creation modes */
+	/** @dont_mask: Don't apply umask to creation modes */
 	unsigned dont_mask:1;
 
-	/** Are BSD file locking primitives not implemented by fs? */
+	/** @no_flock: Are BSD file locking primitives not implemented by fs? */
 	unsigned no_flock:1;
 
-	/** Is fallocate not implemented by fs? */
+	/** @no_fallocate: Is fallocate not implemented by fs? */
 	unsigned no_fallocate:1;
 
-	/** Is rename with flags implemented by fs? */
+	/** @no_rename2: Is rename with flags implemented by fs? */
 	unsigned no_rename2:1;
 
-	/** Use enhanced/automatic page cache invalidation. */
+	/** @auto_inval_data: Use enhanced/automatic page cache invalidation. */
 	unsigned auto_inval_data:1;
 
-	/** Filesystem is fully responsible for page cache invalidation. */
+	/**
+	 * @explicit_inval_data: Filesystem is fully responsible for page cache
+	 * invalidation.
+	 */
 	unsigned explicit_inval_data:1;
 
-	/** Does the filesystem support readdirplus? */
+	/** @do_readdirplus: Does the filesystem support readdirplus? */
 	unsigned do_readdirplus:1;
 
-	/** Does the filesystem want adaptive readdirplus? */
+	/** @readdirplus_auto: Does the filesystem want adaptive readdirplus? */
 	unsigned readdirplus_auto:1;
 
-	/** Does the filesystem support asynchronous direct-IO submission? */
+	/**
+	 * @async_dio: Does the filesystem support asynchronous direct-IO
+	 * submission?
+	 */
 	unsigned async_dio:1;
 
-	/** Is lseek not implemented by fs? */
+	/** @no_lseek: Is lseek not implemented by fs? */
 	unsigned no_lseek:1;
 
-	/** Does the filesystem support posix acls? */
+	/** @posix_acl: Does the filesystem support posix acls? */
 	unsigned posix_acl:1;
 
-	/** Check permissions based on the file mode or not? */
+	/**
+	 * @default_permissions: Check permissions based on the file mode
+	 * or not?
+	 */
 	unsigned default_permissions:1;
 
-	/** Allow other than the mounter user to access the filesystem ? */
+	/**
+	 * @allow_other: Allow other than the mounter user to access the
+	 * filesystem ?
+	 */
 	unsigned allow_other:1;
 
-	/** Does the filesystem support copy_file_range? */
+	/** @no_copy_file_range: Does the filesystem support copy_file_range? */
 	unsigned no_copy_file_range:1;
 
-	/** Does the filesystem support copy_file_range_64? */
+	/**
+	 * @no_copy_file_range_64: Does the filesystem support
+	 * copy_file_range_64?
+	 */
 	unsigned no_copy_file_range_64:1;
 
-	/* Send DESTROY request */
+	/** @destroy: Send DESTROY request */
 	unsigned int destroy:1;
 
-	/* Delete dentries that have gone stale */
+	/** @delete_stale: Delete dentries that have gone stale */
 	unsigned int delete_stale:1;
 
-	/** Do not create entry in fusectl fs */
+	/** @no_control: Do not create entry in fusectl fs */
 	unsigned int no_control:1;
 
-	/** Do not allow MNT_FORCE umount */
+	/** @no_force_umount: Do not allow MNT_FORCE umount */
 	unsigned int no_force_umount:1;
 
-	/* Auto-mount submounts announced by the server */
+	/** @auto_submounts: Auto-mount submounts announced by the server */
 	unsigned int auto_submounts:1;
 
-	/* Propagate syncfs() to server */
+	/** @sync_fs: Propagate syncfs() to server */
 	unsigned int sync_fs:1;
 
-	/* Initialize security xattrs when creating a new inode */
+	/** @init_security: Initialize security xattrs when creating a new inode */
 	unsigned int init_security:1;
 
-	/* Add supplementary group info when creating a new inode */
+	/**
+	 * @create_supp_group: Add supplementary group info when creating
+	 * a new inode
+	 */
 	unsigned int create_supp_group:1;
 
-	/* Does the filesystem support per inode DAX? */
+	/** @inode_dax: Does the filesystem support per inode DAX? */
 	unsigned int inode_dax:1;
 
-	/* Is tmpfile not implemented by fs? */
+	/** @no_tmpfile: Is tmpfile not implemented by fs? */
 	unsigned int no_tmpfile:1;
 
-	/* Relax restrictions to allow shared mmap in FOPEN_DIRECT_IO mode */
+	/**
+	 * @direct_io_allow_mmap: Relax restrictions to allow shared mmap
+	 * in FOPEN_DIRECT_IO mode
+	 */
 	unsigned int direct_io_allow_mmap:1;
 
-	/* Is statx not implemented by fs? */
+	/** @no_statx: Is statx not implemented by fs? */
 	unsigned int no_statx:1;
 
-	/** Passthrough support for read/write IO */
+	/** @passthrough: Passthrough support for read/write IO */
 	unsigned int passthrough:1;
 
-	/* Use pages instead of pointer for kernel I/O */
+	/** @use_pages_for_kvec_io: Use pages instead of pointer for kernel I/O */
 	unsigned int use_pages_for_kvec_io:1;
 
-	/* Is link not implemented by fs? */
+	/** @no_link: Is link not implemented by fs? */
 	unsigned int no_link:1;
 
-	/* Is synchronous FUSE_INIT allowed? */
+	/** @sync_init: Is synchronous FUSE_INIT allowed? */
 	unsigned int sync_init:1;
 
-	/** Maximum stack depth for passthrough backing files */
+	/** @max_stack_depth: Maximum stack depth for passthrough backing files */
 	int max_stack_depth;
 
-	/** Negotiated minor version */
+	/** @minor: Negotiated minor version */
 	unsigned minor;
 
-	/** Entry on the fuse_conn_list */
+	/** @entry: Entry on the fuse_conn_list */
 	struct list_head entry;
 
-	/** Device ID from the root super block */
+	/** @dev: Device ID from the root super block */
 	dev_t dev;
 
-	/** Key for lock owner ID scrambling */
+	/** @scramble_key: Key for lock owner ID scrambling */
 	u32 scramble_key[4];
 
-	/** Version counter for attribute changes */
+	/** @attr_version: Version counter for attribute changes */
 	atomic64_t attr_version;
 
-	/** Version counter for evict inode */
+	/** @evict_ctr: Version counter for evict inode */
 	atomic64_t evict_ctr;
 
-	/* maximum file name length */
+	/** @name_max: maximum file name length */
 	u32 name_max;
 
-	/** Called on final put */
+	/** @release: Called on final put */
 	void (*release)(struct fuse_conn *);
 
 	/**
-	 * Read/write semaphore to hold when accessing the sb of any
+	 * @killsb: Read/write semaphore to hold when accessing the sb of any
 	 * fuse_mount belonging to this connection
 	 */
 	struct rw_semaphore killsb;
 
 #ifdef CONFIG_FUSE_DAX
-	/* Dax mode */
+	/** @dax_mode: Dax mode */
 	enum fuse_dax_mode dax_mode;
 
-	/* Dax specific conn data, non-NULL if DAX is enabled */
+	/** @dax: Dax specific conn data, non-NULL if DAX is enabled */
 	struct fuse_conn_dax *dax;
 #endif
 
-	/** List of filesystems using this connection */
+	/** @mounts: List of filesystems using this connection */
 	struct list_head mounts;
 
-	/* New writepages go into this bucket */
+	/** @curr_bucket: New writepages go into this bucket */
 	struct fuse_sync_bucket __rcu *curr_bucket;
 
 #ifdef CONFIG_FUSE_PASSTHROUGH
-	/** IDR for backing files ids */
+	/** @backing_files_map: IDR for backing files ids */
 	struct idr backing_files_map;
 #endif
 };
@@ -814,7 +900,7 @@ extern const struct file_operations fuse
 
 extern const struct dentry_operations fuse_dentry_operations;
 
-/**
+/*
  * Get a filled in inode
  */
 struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
@@ -856,44 +942,44 @@ int fuse_finish_open(struct inode *inode
 void fuse_sync_release(struct fuse_inode *fi, struct fuse_file *ff,
 		       unsigned int flags);
 
-/**
+/*
  * Send RELEASE or RELEASEDIR request
  */
 void fuse_release_common(struct file *file, bool isdir);
 
-/**
+/*
  * Send FSYNC or FSYNCDIR request
  */
 int fuse_fsync_common(struct file *file, loff_t start, loff_t end,
 		      int datasync, int opcode);
 
-/**
+/*
  * Notify poll wakeup
  */
 int fuse_notify_poll_wakeup(struct fuse_conn *fc,
 			    struct fuse_notify_poll_wakeup_out *outarg);
 
-/**
+/*
  * Initialize file operations on a regular file
  */
 void fuse_init_file_inode(struct inode *inode, unsigned int flags);
 
-/**
+/*
  * Initialize inode operations on regular files and special files
  */
 void fuse_init_common(struct inode *inode);
 
-/**
+/*
  * Initialize inode and file operations on a directory
  */
 void fuse_init_dir(struct inode *inode);
 
-/**
+/*
  * Initialize inode operations on a symlink
  */
 void fuse_init_symlink(struct inode *inode);
 
-/**
+/*
  * Change attributes of an inode
  */
 void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
@@ -910,7 +996,7 @@ u32 fuse_get_cache_mask(struct inode *in
 int fuse_ctl_init(void);
 void __exit fuse_ctl_cleanup(void);
 
-/**
+/*
  * Simple request sending that does request allocation and freeing
  */
 ssize_t __fuse_simple_request(struct mnt_idmap *idmap,
@@ -938,7 +1024,7 @@ void fuse_dentry_tree_cleanup(void);
 
 void fuse_epoch_work(struct work_struct *work);
 
-/**
+/*
  * Invalidate inode attributes
  */
 
@@ -961,7 +1047,7 @@ u64 fuse_time_to_jiffies(u64 sec, u32 ns
 
 void fuse_change_entry_timeout(struct dentry *entry, struct fuse_entry_out *o);
 
-/**
+/*
  * Initialize fuse_conn
  */
 void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
@@ -970,16 +1056,17 @@ void fuse_conn_init(struct fuse_conn *fc
 int fuse_send_init(struct fuse_mount *fm);
 
 /**
- * Fill in superblock and initialize fuse connection
+ * fuse_fill_super_common - Fill in superblock and initialize fuse connection
  * @sb: partially-initialized superblock to fill in
  * @ctx: mount context
  */
 int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx);
 
-/*
- * Remove the mount from the connection
+/**
+ * fuse_mount_remove - Remove the mount from the connection
+ * @fm: fuse_mount to remove
  *
- * Returns whether this was the last mount
+ * Returns: whether this was the last mount
  */
 bool fuse_mount_remove(struct fuse_mount *fm);
 
@@ -997,23 +1084,25 @@ void fuse_conn_destroy(struct fuse_mount
 void fuse_mount_destroy(struct fuse_mount *fm);
 
 /**
- * Add connection to control filesystem
+ * fuse_ctl_add_conn - Add connection to control filesystem
+ * @fc: Fuse connection to add
  */
 int fuse_ctl_add_conn(struct fuse_conn *fc);
 
 /**
- * Remove connection from control filesystem
+ * fuse_ctl_remove_conn - Remove connection from control filesystem
+ * @fc: Fuse connection to remove
  */
 void fuse_ctl_remove_conn(struct fuse_conn *fc);
 
-/**
+/*
  * Is file type valid?
  */
 int fuse_valid_type(int m);
 
 bool fuse_invalid_attr(struct fuse_attr *attr);
 
-/**
+/*
  * Is current process allowed to perform filesystem operation?
  */
 bool fuse_allow_current_process(struct fuse_conn *fc);
@@ -1030,7 +1119,7 @@ void fuse_flush_writepages(struct inode
 void fuse_set_nowrite(struct inode *inode);
 void fuse_release_nowrite(struct inode *inode);
 
-/**
+/*
  * Scan all fuse_mounts belonging to fc to find the first where
  * ilookup5() returns a result.  Return that result and the
  * respective fuse_mount in *fm (unless fm is NULL).
@@ -1040,13 +1129,13 @@ void fuse_release_nowrite(struct inode *
 struct inode *fuse_ilookup(struct fuse_conn *fc, u64 nodeid,
 			   struct fuse_mount **fm);
 
-/**
+/*
  * File-system tells the kernel to invalidate cache for the given node id.
  */
 int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
 			     loff_t offset, loff_t len);
 
-/**
+/*
  * File-system tells the kernel to invalidate parent attributes and
  * the dentry matching parent/name.
  *
@@ -1068,7 +1157,7 @@ void fuse_try_prune_one_inode(struct fus
 int fuse_do_open(struct fuse_mount *fm, u64 nodeid, struct file *file,
 		 bool isdir);
 
-/**
+/*
  * fuse_direct_io() flags
  */
 
