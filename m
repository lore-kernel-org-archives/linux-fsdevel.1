Received: from mail-lr2-f34.google.com (mail-lr2-f34.google.com [74.125.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B27383C86
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 21:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790891597; cv=none; b=pkxNF1il5bufOOytW0eNSdV4Wyau4g4O0dPOHLtC4l+pidi2HhxHKaH8K1So7gfWsXPLg2Mn+v7I47pg4aDPByuYO0xcCAUAdweIpSU5gBaCLpWLvn3WfP73ztxzrQmZ2hwMQ9QgmzsBzZ/+v2yjfO5/1O0gOS3Q0Y6AuuO/CZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790891597; c=relaxed/simple;
	bh=K98gb4QshljAY7E+xVRy8/ZqzUeY5S+H4MfMHowqKVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3XL+xcyuSysfMlYYy4cJSVXTZ4NWLHhtSTYGAXMw4pjDR/1x/EWsW2BoLiejcpjyQEK3D5CP9cReXaDsvLLLE9651MAOk/7kGPkQn9RT9gCUw6nm/QqZTvjeXgMgRqd6Z8PfUhwv0cCpKR2X57TXB1EM62/yhPNeDe25BnRQ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=noroxi.com; spf=pass smtp.mailfrom=noroxi.com; dkim=pass (2048-bit key) header.d=noroxi.com header.i=@noroxi.com header.b=Uk0wHG4S; arc=none smtp.client-ip=74.125.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=noroxi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noroxi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=noroxi.com header.i=@noroxi.com header.b="Uk0wHG4S"
Received: by mail-lr2-f34.google.com with SMTP id 38308e7fff4ca-3a782bdc1dbso14015501fa.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2026 14:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=noroxi.com; s=google; t=1790891594; x=1791496394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ktwzSQw9heRGokOoOy26T3wT6X3rhc72JGOS7UgFoE=;
        b=Uk0wHG4Sd3jQAdBOvco4YKIGkDgWnzhpuoZd8xTWYxSPiKLQ0nQL+IdkU/S7+Dn2J6
         Q+FjpuSAixnsx82ZyBfHAHfQkpTiGY9b6chyfYqUFvxff9pHOsoB1aXDzhFHrf99+Rb2
         x2MQdoobhePrupZMBIITDuWT3FsE7d01/T8wrw9jQquisi6Mu7+kZDHa7iPqitK9e7UX
         pBIOB1Dmw9/LVlmMWwuREK/8YL0bRW7Ibo8EJC9v1QgcqDNUgaKdgS7p29fzWT8Zjp66
         MDf0DgFpYqBIJtFBrVYo0DJoY+2M+jgE1Rp0wZwp1zbTrbYYjXrP4+6OWv6c5dAqbDqB
         Z6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790891594; x=1791496394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+ktwzSQw9heRGokOoOy26T3wT6X3rhc72JGOS7UgFoE=;
        b=m1WSRmu0kOR2ucqMwJNSKbitNbVUfzNIYVO0sw7fwMC/s7oR3ALdXbjX2Jp8Mij3es
         gG2ByvU18QRMXt9t+Kz4TCqQqAFg/8wSHWphk4aAo43rwyuqvUVbuQUrK4FpvPa9sh8S
         3yNThLLQufsTPlUqWMeJUF9ybDQa2A7jw3asFm03xQbRfXII+qdt0IU1Cb6bewvIqNjw
         +DmiJV9LcuuL6HZLCWIqzwdGryi+ZaA/EMcKOgR1tsgkwx7CqdZp1Li53qyhf1ZsEgel
         Xz+3jplnXI3SbeVhNQhrC5k234S0a+CKMZ167xIrSCK+T2AwM0B77qzIsgCoUZJEKlzR
         FIfA==
X-Gm-Message-State: AFq9FYKRTaCisG/r7GVYVI7/BHO3Ysu3JAVzSV4TM85C4xyv14KtmBWa
	0yipZLiMW+QAZB40O0KeNW2JTWR17bAGUW5HAg2sAkqkYdX3jKnk3gw8JtFdGQ8UWCU+JNRY8x2
	LXnhj2q+qVfK3ow==
X-Gm-Gg: AYBFou0dj3Qu2s82XptM9l7sx9OTn6KCOfnjcvANgqx5HB/g5VJLKjAQEahPNzwnPcS
	E2FAhZV2SFNP5/j6qcJNyUu2T61NQKsFkVC76WOnhI2UM+pYgeGytQMQZyakZCPaIyCIbgTEc2e
	gIf/CoR73UzPRxDN+f5xwYD1ihNZ7+fhL87huq8paRkP6AU8CwFMrLLsG0akt8YpeDauEvKQ/bR
	HW/9mSWjLVtv3qoahIEDyaRHvtF00Rna/NSje18N7gChWd3O43R4xAVOepqm1qWMvAXSsBN8pGK
	KnDYgnV6cKeKEgUA9dgCul0INX/RJ+RJ/lnKEKs4Vd+RGSTvCGTsc9ujzSgJCCPGNQbUSKKFP37
	SBsyNM2x70PkoXBrFhiwA8WhvqIohlSo8yTc40+wm/3wEadb4o2khCWVp9EFOe5uBAZfJaTKvZg
	pSfzPUtZjldH9gbZgG7E0IL+9/pAg0evYafDc25JPfLmUQ391z69t46XRZMlLrZuFO1FbSGYfy
X-Received: by 2002:a2e:8a9c:0:b0:3a3:7682:49a1 with SMTP id 38308e7fff4ca-3a8877c09femr1383891fa.22.1790891593483;
        Thu, 01 Oct 2026 14:53:13 -0700 (PDT)
Received: from lab01.. ([2a01:4f9:1a:a462::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a87e310343sm2427401fa.29.2026.10.01.14.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 14:53:13 -0700 (PDT)
From: Mahmut Emin Kurhan <guvenlik@noroxi.com>
To: linux-fsdevel@vger.kernel.org
Cc: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-kernel@vger.kernel.org,
	Mahmut Emin Kurhan <guvenlik@noroxi.com>
Subject: [PATCH v2] hfsplus: annotate extents_lock nesting to silence lockdep false positive
Date: Thu,  1 Oct 2026 23:53:04 +0200
Message-ID: <20261001215304.1520907-1-guvenlik@noroxi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9f8b8dacee5d24c94185bab75ff905eb51a95999.camel@dubeyko.com>
References: <9f8b8dacee5d24c94185bab75ff905eb51a95999.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lockdep reports a possible recursive locking on HFSPLUS_I(inode)->extents_lock
when unlinking a file on a crafted image: hfsplus_file_truncate() holds a
regular file's extents_lock and, while freeing blocks, reads the allocation
file, whose get_block() takes that file's own extents_lock. They are distinct
inodes of the same lock class taken in a fixed order, so it is not a real
deadlock, only a missing nesting annotation.

Give the special inodes (allocation, attributes, catalog) distinct
extents_lock subclasses and take the lock with mutex_lock_nested(), mirroring
hfsplus_btree_lock_class(). Regular files (CNID >= HFSPLUS_FIRSTUSER_CNID) keep
their own subclass so a genuine regular-vs-regular recursion is still detected;
the remaining reserved inodes use a separate subclass instead of being treated
as regular files.

Found via coverage-guided fuzzing (syzkaller + lockdep) by Noroxi.

Signed-off-by: Mahmut Emin Kurhan <guvenlik@noroxi.com>
---
v2:
 - shorten the comment (Slava Dubeyko)
 - rename HFSPLUS_EXTENTS_LOCK_NORMAL to _REGULAR_FILE (Slava Dubeyko)
 - use HFSPLUS_FIRSTUSER_CNID so reserved inodes are not treated as
   regular files; add a separate _OTHER subclass (Slava Dubeyko)
 - hfsplus_extents_lock_class() signature is 74 cols (< 80)
 fs/hfsplus/extents.c    | 12 ++++++++----
 fs/hfsplus/hfsplus_fs.h | 26 ++++++++++++++++++++++++++
 fs/hfsplus/xattr.c      |  3 ++-
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index eb7c11524d..54a05eaa8f 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -150,7 +150,8 @@ int hfsplus_ext_write_extent(struct inode *inode)
 {
 	int res;
 
-	mutex_lock(&HFSPLUS_I(inode)->extents_lock);
+	mutex_lock_nested(&HFSPLUS_I(inode)->extents_lock,
+			  hfsplus_extents_lock_class(inode));
 	res = hfsplus_ext_write_extent_locked(inode);
 	mutex_unlock(&HFSPLUS_I(inode)->extents_lock);
 
@@ -261,7 +262,8 @@ int hfsplus_get_block(struct inode *inode, sector_t iblock,
 	if (inode->i_ino == HFSPLUS_EXT_CNID)
 		return -EIO;
 
-	mutex_lock(&hip->extents_lock);
+	mutex_lock_nested(&hip->extents_lock,
+			  hfsplus_extents_lock_class(inode));
 
 	/*
 	 * hfsplus_ext_read_extent will write out a cached extent into
@@ -454,7 +456,8 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
 		return -ENOSPC;
 	}
 
-	mutex_lock(&hip->extents_lock);
+	mutex_lock_nested(&hip->extents_lock,
+			  hfsplus_extents_lock_class(inode));
 	if (hip->alloc_blocks == hip->first_blocks)
 		goal = hfsplus_ext_lastblock(hip->first_extents);
 	else {
@@ -576,7 +579,8 @@ void hfsplus_file_truncate(struct inode *inode)
 	blk_cnt = (inode->i_size + HFSPLUS_SB(sb)->alloc_blksz - 1) >>
 			HFSPLUS_SB(sb)->alloc_blksz_shift;
 
-	mutex_lock(&hip->extents_lock);
+	mutex_lock_nested(&hip->extents_lock,
+			  hfsplus_extents_lock_class(inode));
 
 	alloc_cnt = hip->alloc_blocks;
 	if (blk_cnt == alloc_cnt)
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 916e6552e3..7e2411b8f1 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -37,6 +37,15 @@ enum hfsplus_btree_mutex_classes {
 	ATTR_BTREE_MUTEX,
 };
 
+/* lockdep subclasses for extents_lock: special inodes nest under regular files */
+enum hfsplus_extents_mutex_classes {
+	HFSPLUS_EXTENTS_LOCK_REGULAR_FILE,
+	HFSPLUS_EXTENTS_LOCK_CATALOG,
+	HFSPLUS_EXTENTS_LOCK_ALLOC,
+	HFSPLUS_EXTENTS_LOCK_ATTR,
+	HFSPLUS_EXTENTS_LOCK_OTHER,
+};
+
 /* An HFS+ BTree held in memory */
 struct hfs_btree {
 	struct super_block *sb;
@@ -568,6 +577,23 @@ hfsplus_btree_lock_class(struct hfs_btree *tree)
 	return class;
 }
 
+static inline unsigned int hfsplus_extents_lock_class(struct inode *inode)
+{
+	if (inode->i_ino >= HFSPLUS_FIRSTUSER_CNID)
+		return HFSPLUS_EXTENTS_LOCK_REGULAR_FILE;
+
+	switch (inode->i_ino) {
+	case HFSPLUS_CAT_CNID:
+		return HFSPLUS_EXTENTS_LOCK_CATALOG;
+	case HFSPLUS_ALLOC_CNID:
+		return HFSPLUS_EXTENTS_LOCK_ALLOC;
+	case HFSPLUS_ATTR_CNID:
+		return HFSPLUS_EXTENTS_LOCK_ATTR;
+	default:
+		return HFSPLUS_EXTENTS_LOCK_OTHER;
+	}
+}
+
 static inline
 bool is_bnode_offset_valid(struct hfs_bnode *node, u32 off)
 {
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 21a1c196c7..7bf4ba8f18 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -264,7 +264,8 @@ static int hfsplus_create_attributes_file(struct super_block *sb)
 						    sbi->sect_count,
 						    HFSPLUS_ATTR_CNID);
 
-	mutex_lock(&hip->extents_lock);
+	mutex_lock_nested(&hip->extents_lock,
+			  hfsplus_extents_lock_class(attr_file));
 	hip->clump_blocks = clump_size >> sbi->alloc_blksz_shift;
 	mutex_unlock(&hip->extents_lock);
 
-- 
2.43.0

