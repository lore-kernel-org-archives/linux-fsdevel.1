Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121EB3793AA
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 14:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789481752; cv=none; b=Qc625gQK5mTQq2wC4n2VhD/JyR2OYtT93u8DBZXDyUgNGIDIak4nNjT4Xdn/6tfljSIIymOAeNtQIn/rWkSZJbEO/Oyv4SUYkk7ea13g7qgORRuKOvDaoQfiJnRRGgdMgdNZ4UEQUjF2yiTxzJGNjsFAjec3GUnVjzX1sPNtFUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789481752; c=relaxed/simple;
	bh=rp9xGLJoVTbX/Bo3f7RiBLcFONxwv536yPbHGAGENOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uzgbpm1sKv9Mb+uZ/tqi68o1DSXFWjRYigiBKw/s5PHRtF6UvpSMW0np+Pe/Rdd1gK49jheet7r89lM3rONiKCc3PLjesDzM6RjFUd0Dtv931Tuq2gv4eFz8RcZy6zkLJrTcvahpVsdyD0U5RoSHK434u3PUmbXWB5YRu2Cd+h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7kaYotR; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7kaYotR"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b9184fa80so3616189a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 07:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789481749; x=1790086549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kOMN7WbXNoD/8k1zWl/hwVthFpjXE395mG1LMqSNTGo=;
        b=N7kaYotRYGnRDbdR6fWmxkU4dvmahICBUEbO9jlgUiC4ldTqiVMZ6CvyANuiVx2rSS
         cxvXTyqMwoGWdo+aYDzOJSUatYDFvK5oRPR4IcgyX47mHUsq+XvoTVw6t/uTn7JzdbvU
         G5m4V6KqkRn0pxO4hGqYxKWeqjYUDB4v38HG4mCivJJOgZemWhbC1c1Qm61tLtW0t2ry
         DI02iG6y8skHAikoOVsligRUpx/5Pywpip2EBqXTlxazOsZvAK/2secmjL49XxsY8qyS
         Bd2u+pZ45hlbLVeQiCQ+JZTcgtuG0O3HrmlaSKuBDkiyQNLGoiqBDEoW938qPisE+d/A
         OsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789481749; x=1790086549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kOMN7WbXNoD/8k1zWl/hwVthFpjXE395mG1LMqSNTGo=;
        b=vuFNIkD91cSTAQHZ1lE0PsnCxZChdHhEr0PcOhP+SFcSyyT84errwvL4cbMKSZdja4
         MyabHc+QykwzoBGjf7pZVc0/OzlcVRYoUs6Jvd1X78ZJ1mYU+vD5mPcUjusnGUwKRaKA
         +bYLxiIcWSvac5VRGj1rEKke88lbAXlGlgYfEqD2J3OXq8rooNZbFSEzhtvkGAM2RsDA
         abvWXvHh4CC8DfW8Lcdbei/J6+38tq8xf7M7G62SZwQfu28us2JyA0WQmC6Bsxdgt1cS
         RHEYbganqDkBzcJ78XjdHxo8vZwb8hlvdHIs/A7ZjezVEEipgTo0Or83UALzmfzYhchr
         u6Lg==
X-Forwarded-Encrypted: i=1; AKwUvBxm/Z7a+VBrKpwdDBicGBjHnmIT9++xQwqoUaKJ6f1rK6Su3rZvmA8kNjDIC+w+PCpc6DOJ+YsHcYasHeyI@vger.kernel.org
X-Gm-Message-State: AFuF++lQdQmieYIq6G9M+vbwOhGzWr/Da3C4bvtk3a8Ji7tm3UYkxIkz
	i7OFJIHPVS9ZQQOJHg1m6BQ/8NiQ5LGGD5iJDzQaRdEba/Pw8B4xHHUz
X-Gm-Gg: AYBFou2IODpN24/mgkjvstvfZXET3+TCR7egjEtmEdFjYSqpHxcoJXdACaXCGiIDDgP
	K3IVecMT1ANx7iEHGFLOOkZ3YIyiaqNA4UReUOQkPBOMA2mwcB7e5LMsoTdcuNo/oEFCiGLQx8M
	2dxBWuuEbYJ3qIF8yeDpHcvmuy2/mCK1s36DW0DR7IpOce4oDx+1cYia044fLAyFgOpvrkg0AZ3
	fnNthram/B5J9OfytrriVPiJfnO6CLWETvXPblMHzpE+HcneSxjxbpVxgnUh5W0igGUgqzZ8vc4
	psYrGgYqtChOE65ELeNZ9+0W/WGZRLSyzUQRkRkSskD1mau5LRitDNLXWOaR55HdkvwQAAb2VgL
	DQTCGT+sJjL/933iEfDyWTTtOsG3gnGQdqZWlwG+n6P/f74IbBGuUvUIPonVlngMLjKV+XPx4Qy
	zHZ5E1Q9NgGYtAzh+Zdjw/yihIkrAGypnx/JPrlRWvW17/8wLnT3G9dSUAwGylNmlvk2E8n0/iu
	L0WRFsZi1HN+pfkjNTKdp1Afp2W
X-Received: by 2002:a17:90a:1182:b0:39d:ec76:585 with SMTP id 98e67ed59e1d1-39dec76710emr10758844a91.24.1789481749129;
        Tue, 15 Sep 2026 07:15:49 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:2bac:b2b4:e60b:1459])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfdb3045bsm6603220a91.17.2026.09.15.07.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 07:15:48 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+f8ce6c197125ab9d72ce@syzkaller.appspotmail.com,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Subject: Re: [PATCH v4 2/2] hfsplus: validate b-tree fork extents at mount time
Date: Tue, 15 Sep 2026 21:15:43 +0700
Message-ID: <20260915141543.24335-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cbc98010b9f6657e162cfcc6ac5ba6032e7b729d.camel@dubeyko.com>
References: <cbc98010b9f6657e162cfcc6ac5ba6032e7b729d.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Slava,

Thanks again for the review, replies inline, v5 diff (applies on top
of the v5 1/2 I just sent) at the bottom.

> If we return error code for corrupted fork (that makes more sense),
> then we don't need in switch here.
>
> > +     case -EIO:
> > +             pr_err("%s (cnid 0x%x) fork's first extent is
> > corrupt\n",
> > +                     hfs_btree_name(id), id);
> > +             goto free_inode;
> > +     case 1:
>
> I don't see the point returning 1 from the function. It should be error
> code.

Agreed, done. hfsplus_check_fork() now returns 0 (consistent),
-EUCLEAN (corrupt past the first extent, tree still locatable, mount
read-only), or -EIO (first extent corrupt, or no used extent at all --
see below). hfs_btree_open() now just checks the return value with
if/else instead of switching on it.

> Why not struct hfsplus_fork_raw here for check?

I looked into this, but the b-tree's inode only keeps the decoded
first_extents/first_blocks fields (see hfsplus_iget()), not the raw
hfsplus_fork_raw (total_size/clump_size/total_blocks as a struct) --
that only exists transiently while reading the volume header. Passing
the raw fork through would mean plumbing it from hfsplus_fill_super()
into hfs_btree_open() as an extra argument, which felt like a bigger
restructuring than this patch should take on. I'd rather scope that as
a follow-up than guess at it here -- let me know if you disagree and
I'll take a pass at it.

> Ditto. Related to hardcoded value.
>
> > +     for (i = 0; i < 8; i++, ext++) {

Uses HFSPLUS_EXTENT_COUNT now too (same constant added in patch 1/2).

> I think that current logic of check looks complicated. [...] For
> example, fork cannot be completely empty. Could we rework the logic
> to be more clear? Maybe, we need to introduce the function for extent
> check, function for checking the extents are logically contiguous?

Fixed the empty-fork case: hfsplus_check_fork() now tracks seen_used
and returns -EIO if no extent was ever in use. Note hs_btree_open()
already guarded against this indirectly via its existing
`!first_blocks` check right before calling hfsplus_check_fork(), so
this makes the function correct on its own instead of relying on that
caller-side check.

I held off on splitting per-extent-check and contiguity-check into
separate functions -- the loop is short and the two conditions
(garbage in an unused slot vs. a used extent overflowing/following a
hole) share the same start/count/seen_hole state per iteration, so
splitting it looked like it'd add indirection without really
clarifying anything. Happy to revisit if you still think it's worth
it.

> Ditto. Related to 1. I prefer to have error code instead.

Same fix as above (-EUCLEAN).

> I don't want to say that this direction is wrong. However, we have
> flags: [...] Potentially, we can introduce the HFSPLUS_I_CORRUPT_TREE.

Done -- dropped struct hfs_btree.corrupt, added HFSPLUS_I_CORRUPT_TREE
next to the existing HFSPLUS_I_*_DIRTY flags, tested via a new
HFSPLUS_TREE_IS_CORRUPT(tree) helper macro on the tree's own inode.

> Currently, only hfsplus_fill_super() can detect the b-tree
> corruption. Why do we have the check here? Do you mean that xattr
> b-tree can be created and to be corrupted?

No -- corruption is only ever detected once, in hfs_btree_open() at
initial mount. The hfsplus_reconfigure() check isn't detecting
anything new; it's re-reading the flag hfs_btree_open() already set,
so that a remount to rw can't silently clear SB_RDONLY on a volume
that was already known to be corrupt at mount time. Added a short
comment there to make that explicit.

> If we fail to check any b-tree, then logic should stop. Why haven't
> we checked the error code of hfs_btree_open()?

I checked -- hfsplus_fill_super() already does check every
hfs_btree_open() call (out_close_ext_tree / out_close_cat_tree /
out_close_attr_tree gotos) before it ever looks at
HFSPLUS_TREE_IS_CORRUPT(), so no change was needed there.

One more from the previous mail I noticed while redoing this: there
was also a checkpatch --strict alignment nit on the pr_err()
continuation line in hfs_btree_open() itself (not one you'd flagged,
but same category), fixed that too while I was in there.

Thanks again for the thorough review -- v5 below.

---
Changes since v4:
 - hfsplus_check_fork() returns real error codes (0/-EUCLEAN/-EIO)
   instead of 0/1/-EIO; hfs_btree_open() uses if/else instead of a
   switch.
 - A fork with no used extent at all is now treated as corrupt.
 - Use HFSPLUS_EXTENT_COUNT instead of hardcoding 8.
 - Track per-tree corruption as an HFSPLUS_I_CORRUPT_TREE inode flag
   instead of a bool on struct hfs_btree.
 - Comment explaining the corrupt-tree check in hfsplus_reconfigure().
 - Fixed a checkpatch --strict alignment nit in hfs_btree_open().
(all per Slava's review)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 2ea8cd5658e1..2dbbb8096575 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -274,6 +274,7 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 	struct inode *inode;
 	struct page *page;
 	unsigned int size;
+	int res;

 	tree = kzalloc_obj(*tree);
 	if (!tree)
@@ -293,6 +294,17 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 		goto free_inode;
 	}

+	res = hfsplus_check_fork(sb, HFSPLUS_I(tree->inode)->first_extents);
+	if (res == -EIO) {
+		pr_err("%s (cnid 0x%x) fork's first extent is corrupt\n",
+		       hfs_btree_name(id), id);
+		goto free_inode;
+	} else if (res) {
+		pr_warn("%s (cnid 0x%x) fork has corrupt extents, forcing read-only.\n",
+			hfs_btree_name(id), id);
+		set_bit(HFSPLUS_I_CORRUPT_TREE, &HFSPLUS_I(tree->inode)->flags);
+	}
+
 	mapping = tree->inode->i_mapping;
 	page = read_mapping_page(mapping, 0, NULL);
 	if (IS_ERR(page))
diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index f3a4b8fd567f..d98261c01b13 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -101,6 +101,39 @@ static bool hfsplus_ext_fork_full(struct hfsplus_extent *ext)
 	return true;
 }

+/*
+ * Validate a fork's extents. Returns 0 if consistent, -EUCLEAN if only
+ * extents past the first are corrupt (safe to mount read-only), or
+ * -EIO if the first extent is corrupt or the fork has no used extent.
+ */
+int hfsplus_check_fork(struct super_block *sb, struct hfsplus_extent *ext)
+{
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
+	bool seen_hole = false;
+	bool seen_used = false;
+	int i;
+
+	for (i = 0; i < HFSPLUS_EXTENT_COUNT; i++, ext++) {
+		u32 start = be32_to_cpu(ext->start_block);
+		u32 count = be32_to_cpu(ext->block_count);
+		bool bad;
+
+		if (!count) {
+			bad = start != 0;
+			seen_hole = true;
+		} else {
+			bad = seen_hole || start + count < start ||
+			      start + count > sbi->total_blocks;
+			seen_used = true;
+		}
+
+		if (bad)
+			return i ? -EUCLEAN : -EIO;
+	}
+
+	return seen_used ? 0 : -EIO;
+}
+
 static int __hfsplus_ext_write_extent(struct inode *inode,
 		struct hfs_find_data *fd)
 {
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 7c53832f2784..3290812c0fea 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -230,10 +230,15 @@ struct hfsplus_inode_info {
 #define HFSPLUS_I_EXT_DIRTY	2	/* has changes in the extent tree */
 #define HFSPLUS_I_ALLOC_DIRTY	3	/* has changes in the allocation file */
 #define HFSPLUS_I_ATTR_DIRTY	4	/* has changes in the attributes tree */
+#define HFSPLUS_I_CORRUPT_TREE	5	/* tree's fork had corrupt extents at open time */

 #define HFSPLUS_IS_RSRC(inode) \
 	test_bit(HFSPLUS_I_RSRC, &HFSPLUS_I(inode)->flags)

+/* Test HFSPLUS_I_CORRUPT_TREE on the tree's own inode */
+#define HFSPLUS_TREE_IS_CORRUPT(tree) \
+	test_bit(HFSPLUS_I_CORRUPT_TREE, &HFSPLUS_I((tree)->inode)->flags)
+
 static inline struct hfsplus_inode_info *HFSPLUS_I(struct inode *inode)
 {
 	return container_of(inode, struct hfsplus_inode_info, vfs_inode);
@@ -443,6 +448,7 @@ int hfsplus_free_fork(struct super_block *sb, u32 cnid,
 		      struct hfsplus_fork_raw *fork, int type);
 int hfsplus_file_extend(struct inode *inode, bool zeroout);
 void hfsplus_file_truncate(struct inode *inode);
+int hfsplus_check_fork(struct super_block *sb, struct hfsplus_extent *ext);

 /* inode.c */
 extern const struct address_space_operations hfsplus_aops;
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index ff7d6b3336a6..a1669bd45701 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -400,6 +400,14 @@ static int hfsplus_reconfigure(struct fs_context *fc)
 			pr_warn("filesystem is marked journaled, leaving read-only.\n");
 			sb->s_flags |= SB_RDONLY;
 			fc->sb_flags |= SB_RDONLY;
+		} else if (HFSPLUS_TREE_IS_CORRUPT(sbi->ext_tree) ||
+				HFSPLUS_TREE_IS_CORRUPT(sbi->cat_tree) ||
+				(sbi->attr_tree &&
+				 HFSPLUS_TREE_IS_CORRUPT(sbi->attr_tree))) {
+			/* Re-checks the flag hfs_btree_open() set at mount */
+			pr_warn("a b-tree fork was corrupt at mount time, leaving read-only.\n");
+			sb->s_flags |= SB_RDONLY;
+			fc->sb_flags |= SB_RDONLY;
 		}
 	}
 	return 0;
@@ -564,6 +572,11 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 	sb->s_xattr = hfsplus_xattr_handlers;

+	if (HFSPLUS_TREE_IS_CORRUPT(sbi->ext_tree) ||
+	    HFSPLUS_TREE_IS_CORRUPT(sbi->cat_tree) ||
+	    (sbi->attr_tree && HFSPLUS_TREE_IS_CORRUPT(sbi->attr_tree)))
+		sb->s_flags |= SB_RDONLY;
+
 	inode = hfsplus_iget(sb, HFSPLUS_ALLOC_CNID);
 	if (IS_ERR(inode)) {
 		pr_err("failed to load allocation file\n");
--
Thanks,
Nguyen Ngoc Thang
