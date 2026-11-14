Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794700483;
	b=2bDe+QcDyfsaFDREp9EnxRt4I7Qpv3BcjNXeIaSwM/UdWuD6crqw/eegmLAGr/DYaayG
	 WJ2I7FB64XAQoNBr4aMYXPbQonnWJSCioqGkmFXvZbPSwNEBxSVOh4+SXYAWtA7rZ2A7V
	 O2m16IjcLgPTEMmHS0ZOshiXTpV5IxNGAyniW7iCc5MX1MAhwHXCo3acLBhTafEpeD+3m
	 g+L4dmfYi6chIq3GecZZyF3feFRMuJv/KpkpqCDMt9eJSnaPg316X6xxBWdsKawhawCRj
	 UD5iT9tkPtDOyBjp7vA+2kf9qN7083TAAPmX10MOmz8qKf1TCP+TzDQ0AxkKOPSH+8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794700483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jvGNkEQXxpCGRnxugPg2OroUq4ixAzACPllCORFjj2w=;
	b=Tpzeb/CrNH39XsL2SqYhbzYtn6zc6TH27LFvdxxSKma2MmdmBRQ5Ux0RBB2wSWDXmTpR
	 hwjKHZ8Mt4GHSa9O5/rPFF+XUEEkiQ2Ku4phEOsBQpzLxBilzrAdzdQ+39gSd8cRyrZjU
	 TT4cjYpjfTUH5d28pUBjFmqhDdrcvbperlsfQeAg2NiVIfdjLRNfoog0hqK5gi0wm5yrG
	 krQs64bViU7M3TRhlovhUoqld9IbDQIHAh9FBIEr9L/2f/D9SepPCNSxcHG9LCmpOK3tI
	 Ur+YW8sV0BulkPkccn3m62Awfx3MOq8GZcWvWYX/iFVL+vP/hKK0GM3Za4N/fOGoLNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RRyifVlA;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31976606A327
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 23:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31976606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RRyifVlA
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-49134c8509fso2332196f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 15:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794700481; x=1795305281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jvGNkEQXxpCGRnxugPg2OroUq4ixAzACPllCORFjj2w=;
        b=RRyifVlAILb5Ufk+snoymOOPCtSpgU7v+hLBVv1xvPD8dAeD3dJXaGhW6FuKIdQ6Ok
         tMPRBHaZ2U36LsQ305KzPnGZNMow7KbLNFnfaykUMBgNDXrulin7Y5S4aQFeg7tTJiNP
         Ux+ZAUUIjzysM0sitGZc/lBXZ3jL4TTGOs8476jLaRZL1tznf9z0YIVTpWSTuldmvTfg
         SmrEvebZGkyMSQA9Xty/8G62/2r1yVyLonNdysEAMXg+Q6t1RrFFnoxP2A7w2L/Ag0V0
         aUTLZ2a80GKzIujwR8MEmBA7Tqs3v6/4qySfPf2RaaQGfH19ZjkYUtBy5J0AGwAwxrQb
         zoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794700481; x=1795305281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jvGNkEQXxpCGRnxugPg2OroUq4ixAzACPllCORFjj2w=;
        b=UHTFM47sSJb3T5kLV1enYkoai9GVWGMqrcxD5R9u0UPnamnbv9/wqK28UQQqLMC3rl
         t2lBVedw/r5wZrQOaeL13P8Mkq9fpz1lHgyi0PBh14fRTOY7tQEhRTuS8T7GEMU/gVsq
         JXVo7gJjjNnXuqA5ePaPto00AUIfpjm+IQgItUw/5xBIdtUac5elh7R1Ff47e7I6GWlZ
         9jid2DUPAYiyIWBNLEJRIvuBW07iIbC3C42/5F2pwiE2NW7n5wxZDNkLgLCrOO0BrmUM
         r2gYNiwvePUg/+Lw7+h/PjyB4vsd3m9IxEf+wTGoZ7qDAVfA4Km2kDlwiAJ2C5sPCBgH
         Ygjw==
X-Forwarded-Encrypted: i=1; AL+hErEIq9fGVT3uRuz+Ge/UHhMthjfO1gtpkRhvNvduOyMUdmcT8F5r4ABnI5JO3PnFAU2X+EyyrqV8BU/3QS0h@vger.kernel.org
X-Gm-Message-State: APuU4Z8bsR2BoRlNz8e8qimwSuy/D7YHPVqWiyc7/3SWwRBwoH9R/iR5
	nJa7nNkfvVLlJOfsRC9h4j22F/+LAxHIEtw2nvG+CBbSxgVALrBzrhf0
X-Gm-Gg: AYBFou2Jo/U8BULUEZVIZ7A6ZWxSSjvXsV1RIRFCQLLuwU2mGWTloimzbzf6ebsD6YG
	RKnp0F/ob4qKWgSe2VISRUDZDf/Je5VaKx8JwphrexPgfWPh2L+gXzLWCsZT8LJZSNTBrqHFSaR
	3ZeJNx9ycWVO+LHrq37DRsR/wKv172t42NRjTmoZ/EguhG5GBEdPdsoZ5ldGN4ZEDI1OppezSgx
	QLqVLn7tAoD7Myg1669egyhtdiRYANbLipdiL2KKP/SMfva73vIV1vOPzQDUKZ6lIqZZgqnCBGm
	hTf6GZumtzsR6sMUQgiaE5M/w8I1QVdTpvtF3kRD7xkXb+e1IOH36L8amB4Mb5QGDFqS3U+hbrt
	y8qmb16UUjlPVLAhI4MQMkfNzTXirecwCleMbMEdOBH6a0nE9qr8v7bojspNeH8zouwhhmEa4kl
	AyK63K2cc3T/cIwKoFSTfwDORE8lZtsBj6Dx+Pb4g0CNUVhmvgKy8MgsUHEAqAyVnvoeqAeIBsR
	7a6J1uFyOgTUCrVF6BJcwAyEkYxu3G2M4tpJpqFnqhdCa83ySzspAzFHfk+IX/hvGpjHHLVcvoS
	X5+v6k6SpZL1J9DbNwfSFn9cD+alqCXaTrR8uUFAn/K2sp/xbv/NcLpeDg39DQtlJE4wAH5oAUT
	ir7EgTGvhMxQUYKpImLPAcM1BxZAJzQsg
X-Received: by 2002:a05:6000:4201:b0:48e:870:7791 with SMTP id ffacd0b85a97d-49c71e3d623mr16407297f8f.26.1794700481355;
        Sat, 14 Nov 2026 15:54:41 -0800 (PST)
Received: from mohamedali-HP-EliteBook-840-G8-Notebook-PC.. ([197.18.115.238])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c608d10b2sm23069680f8f.44.2026.11.14.15.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 15:54:40 -0800 (PST)
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
Date: Sun, 15 Nov 2026 00:54:26 +0100
Message-ID: <20261114235426.20408-1-mohamedalibouhaouala@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3aaboixwh6lpo4s67dv7lssqj2vwlp4qp5cq2ysimqi36r3bm2@fb5lmoo33ktf>
References: <3aaboixwh6lpo4s67dv7lssqj2vwlp4qp5cq2ysimqi36r3bm2@fb5lmoo33ktf>
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

