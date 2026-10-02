Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF9F4F4CF8
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2026 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790958770; cv=none; b=cU0NAVVaaF6N4Pe3aq0SkB8niB1021GbGQLUKb1yJS3OrDmWO4c4LwfTRMqGx2dp2qiGzJ0QksAtGtIwQccMeU8f+e4FzAWNfHsks9Pq1v//urVRZgO1Z85z/PA94AuJ424zh0ma3vToaggUy9JqWmIaPDGAMsa05eoX6Kf52tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790958770; c=relaxed/simple;
	bh=N3Sw95isyGvSarl68AMJlF9w5oVAyiVHl0q2JfWbxgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgarMucou0RlCaAW03KMX6OICImdPu8+7XD0wydTxH36gKII5BwQJKOJIi9xGMTb7qNqYr4v9ThIp4mILka98Z8iJZq7hmWevBuIpeGsDU4Ak83T0ePhIwbJmdzWyTmYCs6aAXHmHFJjkcWtHJQ8/RnNFp3qYDahsB/BNWNiEOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scrivano.org; spf=pass smtp.mailfrom=scrivano.org; dkim=pass (2048-bit key) header.d=scrivano.org header.i=@scrivano.org header.b=dMFMif75; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mczOcf8B; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scrivano.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scrivano.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scrivano.org header.i=@scrivano.org header.b="dMFMif75";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mczOcf8B"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 300431D0008E
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2026 12:32:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 02 Oct 2026 12:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scrivano.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1790958766; x=
	1791045166; bh=bLlFNyLES89kSOlmtwvFoUcTN1nanflkHkAilWAo9mE=; b=d
	MFMif75YDTKoLlfsRYsINfjsxJRIHv/7zP492L9PPnkw1Od7ACwBt+aEPB1ARB0I
	5syuNIserULVdtqaOJFFPYdFv9ABACjChXGihBgcJZDGQcS4Mcc+fv2O/x6q9OJP
	uNj3ULrBt+34INHfkIp3w2VUT/r0dszfNn2dsI0MwJ42z3VWBKdOukkJK6/5zM0j
	osW8mS2y8D8/iNuurQ9UfxGdURkysF8BQANQoam36AMk1j/beMAF4L7OoqQofDtm
	ud5F78GN19V9A5evvUY9CGsM2aZfVj0gr9CJGZsfH6WFFLGCaIbJhprFm4fcW0eH
	MoHTslZuzoq4GS2BntCVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790958766; x=1791045166; bh=b
	LlFNyLES89kSOlmtwvFoUcTN1nanflkHkAilWAo9mE=; b=mczOcf8BwR9OWU2ny
	gsgXfZNaOtnLqyHjo7CNASa+7QA1iLvENcG0an4zmZiqmBaAiSoNRv2qa2WFCS9J
	S/uMUeGWRwBYd3unwIKsyXNWVpwOjBMvbNVohp+XNx5HuOedEowh6Ys2ROywjfyZ
	Wy90dbeoWP3VgwFmH0ZR/bj6r9NAH6NMowh0ZTkRUBt7NvI/qgAFoHbTYoZwo4ik
	1j6xonxLJ+nMwO1jQbZSJlQBIe+euF6xD+FyQpV5H0Tyujv8Wa8HdDj0ExirrqHz
	mCFAUM4d/JFfI6jiLSj87wD0UpDHj/IXYoMcsB+XpbxTSWQELO1zp1OPBKn/k3GY
	lHpKg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=scrivano.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790958766; d=scrivano.org;
	mf=PGdpdXNlcHBlQHNjcml2YW5vLm9yZz4=;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:GIysrqEK+4EFdCR+9fiETUh2t92CwvBWTSqHSipfMZJtpdj
	S26PoGMWdKEzppQ4MAAJXNogL3EFeHhscubRbP+VCfGcqGAXWdxDmaGw1/1iw7ZY
	A4juPol4fX+SJEeeT+nif6XqhhR/QBgd2/tXB53KtctSvj1queKk2j/ED9rGJxPe
	U07+3wxW+E8DUEY2gRepSSwDK4QT6X71/7HdWapExxREDDvwBBID+Wa5tQK9iHky
	5OyG1UqqFOXQkF1qi/cBxsfaMCOA1zpnS1e7TT8X/Y1P96iz/E6IFhcZ7YY8/HrB
	ljPvP8w9ce1l1fr4cSjcNR9JWnXt/eN56AsXtKw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:BBguvoBHHeUPQqMPBNig9J/FWOr6LAV+iyFpwaTIEas=:N3Sw95isyGvSarl68AMJlF9w5oVAyiVHl0q2JfWbxgQ=;
X-ME-Sender: <xms:rty_aln2Yom3RG4fYtywV8vujjG4LUX4tz7rSFqyFpa-OdJSGzD08Q>
    <xme:rty_atbATigpxB4Md27Ur4GQflKgi1heCWorEiZe88g7yjygWIUzzTIJDEk3qgvgX
    qbaxbnnI4HH5DSrgVD_41hPEG2p7xEE78ayymCuDr1HtMuLNCsTq9n5>
X-ME-Received: <xmr:rty_agGYtrfgiWWeujZdj9EMqvph85jZRCPG_mI51XOgZ5iJyt-25Rq8HBgTNPz7RkHIW8xDgtGio0gltyHdAYWufe-O>
X-ME-Proxy-Cause: dmFkZTGpcdZr82zIt6fgZxi9urCO+3/2tVuu1d+3QpkcSi4YEnNBtosC1a+OEANXk8cKdM
    58XU5VZHD8/IuvAeof7fh01ekMSuaIdB0CdD9pVP7PfJl/O2yH4tpRew4oN79SigyESPMG
    u0UEDCPY21zKcrVF5l811I5kBL+3oOzBXlWfFyMQXzS+ksx/HAKuDgybockLiBtC/H2bnZ
    I9084l35tmqbFmVAhpSuZZ+N/pmYnxx5ZBLA0iXxl1BpiLZdhQCirKOfO2wefAL8HUz7RS
    NfQVU4wN1pA10kYxTzq8gEuK+f/nd3OvmSRDX9mvhvyUiRpsuGvPZmAtwiEh8o1mw+52He
    xdccJJpMX91kwYwH20hPPIoI0Wh7KvmFZaVQpHjjJ7tP5oNdy2GfZmdAndu3vzrBQYJxe1
    BHgpcJ1nEQKtQ58gtKkz+DI03fHLKVcM4oYFjq6/HKnpywkqs6xSNNdw2bchT2xKic6m1X
    bFw6CXHd7yM/tVTk8BFQ7Aky2ENYk0YaaKY9cgwOJaGHY7jAVWEweSl1qtxsdziJEvaI2G
    WwqNkvCtNIqDh/uBzlLtalW3or/VyQSG7nsYGJ0cXHHMwehlI5mrPM7+eB+amVcnQ4XUE2
    +NUsDXJKrdZWJdUr31dfpnPjImHYuxlB6x9TrA+BumPS2SKp9Qs3JNn7dx+A
X-ME-Proxy: <xmx:rty_asafsHQ4W9AhBvYAl5Aji9nJBYVQ3mtQ2VtgdhPW0mPe8DJqbA>
    <xmx:rty_akzDZbmPWX7VlS5zK2liAGUEaB4i3VI5b3Igvh_BSjH8gFQ5xw>
    <xmx:rty_auTm3Cgmrykx9YmX6X93sYyuHUFLXKWghLwWxxlBjqqcgcacVQ>
    <xmx:rty_ahKQbwO9luCvnzmUW-jV-cUyU1GDwd0gXXBNi8UKqSrHjidjJw>
    <xmx:rty_aoo_j0KIAHYZ6UMtunG0x9G-qVYWsbRzzA3bvT4jAY41rsaILd6x>
Feedback-ID: i8e6e4897:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 12:32:46 -0400 (EDT)
From: Giuseppe Scrivano <giuseppe@scrivano.org>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	giuseppe@scrivano.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	hch@infradead.org
Subject: [PATCH v7 2/2] erofs: reuse superblock for file-backed mounts
Date: Fri,  2 Oct 2026 18:31:44 +0200
Message-ID: <20261002163225.1258203-3-giuseppe@scrivano.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002163225.1258203-1-giuseppe@scrivano.org>
References: <20261002163225.1258203-1-giuseppe@scrivano.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the same file-backed image is mounted multiple times (via path or
fd) with the superblock_share mount option, reuse the existing
superblock instead of creating a new one.  This allows multiple mounts
of the same image to share in-kernel data structures more efficiently.

The backing file is identified by its inode and fsoffset.  If mount
options conflict or extra devices are used, a separate superblock
is created transparently as a fallback.  Remount is not allowed on
shared superblocks.

Tested by mounting a 177M Fedora EROFS image 20 times with full
traversal:

  #!/bin/sh
  IMG=${1:-/root/fedora.erofs}
  OPTS=${2:+-o $2}
  N=20
  DIR=$(mktemp -d)
  trap "umount $DIR/m* 2>/dev/null; rm -rf $DIR" EXIT

  sync; echo 3 > /proc/sys/vm/drop_caches
  INODES_BEFORE=$(grep erofs_inode /proc/slabinfo | awk '{print $2}')
  MEM_BEFORE=$(grep ^Slab: /proc/meminfo | awk '{print $2}')

  for i in $(seq 1 $N); do
      mkdir $DIR/m$i
      mount -t erofs $OPTS "$IMG" $DIR/m$i
      find $DIR/m$i > /dev/null
  done

  echo "Superblocks: $(grep $DIR /proc/self/mountinfo | \
      awk '{print $3}' | sort -u | wc -l)"
  echo "erofs_inode delta: +$(( $(grep erofs_inode /proc/slabinfo | \
      awk '{print $2}') - INODES_BEFORE ))"
  echo "Slab delta: +$(( $(grep ^Slab: /proc/meminfo | \
      awk '{print $2}') - MEM_BEFORE )) kB"

without superblock_share:

  # time ./test.sh /root/fedora.erofs
  Superblocks: 20
  erofs_inode delta: +45864
  Slab delta: +37448 kB
  real	0m2.311s
  user	0m0.222s
  sys	0m1.998s

with superblock_share:

  # time ./test.sh /root/fedora.erofs superblock_share
  Superblocks: 1
  erofs_inode delta: +2044
  Slab delta: +284 kB
  real	0m0.679s
  user	0m0.157s
  sys	0m0.469s

The time difference shows that sharing the superblock also benefits
the page cache and inode cache, as subsequent mounts of the same image
avoid re-reading the backing file.  This is particularly useful for
container hosts running multiple containers from the same base image.

Signed-off-by: Giuseppe Scrivano <giuseppe@scrivano.org>
---
 Documentation/filesystems/erofs.rst |  7 ++++
 fs/erofs/internal.h                 |  1 +
 fs/erofs/super.c                    | 56 +++++++++++++++++++++++++++--
 3 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index d301d9ac946a..02caf3b061fe 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -139,6 +139,9 @@ inode_share            Enable inode page sharing for this filesystem.  Inodes wi
                        page cache.
 source=%s              (For file-backed mounts) Specify the backing image as a path
                        or as an already-opened file descriptor.
+superblock_share       (For file-backed mounts) Share the superblock when the same
+                       backing file is mounted more than once with compatible
+                       options.  Remount is not allowed on shared superblocks.
 ===================    =========================================================
 
 File-backed mounts
@@ -156,6 +159,10 @@ Only regular files are accepted as backing files; to mount an image that
 resides on a block device, use the traditional block device mount path
 instead.
 
+When superblock_share is specified, multiple mounts of the same backing
+file at the same fsoffset with compatible mount options can share a single
+superblock.  Remount is not allowed on shared superblocks.
+
 Sysfs Entries
 =============
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 12e3a5b80a5a..da58053c1116 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -150,6 +150,7 @@ struct erofs_sb_info {
 #define EROFS_MOUNT_DAX_NEVER		0x00000080
 #define EROFS_MOUNT_DIRECT_IO		0x00000100
 #define EROFS_MOUNT_INODE_SHARE		0x00000200
+#define EROFS_MOUNT_SUPERBLOCK_SHARE	0x00000400
 
 #define clear_opt(opt, option)	((opt)->mount_opt &= ~EROFS_MOUNT_##option)
 #define set_opt(opt, option)	((opt)->mount_opt |= EROFS_MOUNT_##option)
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 0967aace9f7f..16fa3b853f1b 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -386,7 +386,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
 enum {
 	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
 	Opt_device, Opt_domain_id, Opt_directio, Opt_fsoffset, Opt_inode_share,
-	Opt_source,
+	Opt_source, Opt_superblock_share,
 };
 
 static const struct constant_table erofs_param_cache_strategy[] = {
@@ -415,6 +415,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 	fsparam_u64("fsoffset",			Opt_fsoffset),
 	fsparam_flag("inode_share",		Opt_inode_share),
 	fsparam_file_or_string("source",	Opt_source),
+	fsparam_flag("superblock_share",	Opt_superblock_share),
 	{}
 };
 
@@ -560,6 +561,12 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		else
 			set_opt(&sbi->opt, INODE_SHARE);
 		break;
+	case Opt_superblock_share:
+		if (!IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE))
+			errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
+		else
+			set_opt(&sbi->opt, SUPERBLOCK_SHARE);
+		break;
 	case Opt_source:
 		return erofs_fc_parse_source(fc, param);
 	}
@@ -667,6 +674,16 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		errorfc(fc, "FSDAX is not allowed when inode_share is on");
 		return -EINVAL;
 	}
+	if (test_opt(&sbi->opt, SUPERBLOCK_SHARE) &&
+	    test_opt(&sbi->opt, INODE_SHARE)) {
+		errorfc(fc, "superblock_share is not allowed when inode_share is on");
+		return -EINVAL;
+	}
+	if (test_opt(&sbi->opt, SUPERBLOCK_SHARE) &&
+	    sbi->devs->extra_devices) {
+		errorfc(fc, "superblock_share does not support extra devices");
+		return -EINVAL;
+	}
 
 	sbi->blkszbits = PAGE_SHIFT;
 	if (erofs_is_fileio_mode(sbi)) {
@@ -794,6 +811,35 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	return 0;
 }
 
+/*
+ * The function is used only with a sbi that has SUPERBLOCK_SHARE set,
+ * so that the memcmp later ensures new_sbi is also shareable.
+ */
+static int erofs_sb_share_test_super(struct super_block *sb,
+				     struct fs_context *fc)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct erofs_sb_info *new_sbi = fc->s_fs_info;
+
+	if (sb->s_iflags & SB_I_RETIRED)
+		return 0;
+	if (!sbi->dif0.file || !new_sbi->dif0.file)
+		return 0;
+	return file_inode(sbi->dif0.file) == file_inode(new_sbi->dif0.file) &&
+	       sbi->dif0.fsoff == new_sbi->dif0.fsoff &&
+	       !memcmp(&sbi->opt, &new_sbi->opt, sizeof(sbi->opt));
+}
+
+static int erofs_file_get_tree(struct fs_context *fc)
+{
+	struct erofs_sb_info *sbi = fc->s_fs_info;
+
+	if (!test_opt(&sbi->opt, SUPERBLOCK_SHARE))
+		return get_tree_nodev(fc, erofs_fc_fill_super);
+
+	return get_tree_super(fc, erofs_sb_share_test_super, erofs_fc_fill_super);
+}
+
 static int erofs_fc_get_tree(struct fs_context *fc)
 {
 	struct erofs_sb_info *sbi = fc->s_fs_info;
@@ -809,7 +855,7 @@ static int erofs_fc_get_tree(struct fs_context *fc)
 			errorfc(fc, "source is unsupported");
 			return -EINVAL;
 		}
-		return get_tree_nodev(fc, erofs_fc_fill_super);
+		return erofs_file_get_tree(fc);
 	}
 
 	ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
@@ -827,7 +873,7 @@ static int erofs_fc_get_tree(struct fs_context *fc)
 
 		if (S_ISREG(file_inode(sbi->dif0.file)->i_mode) &&
 		    sbi->dif0.file->f_mapping->a_ops->read_folio)
-			return get_tree_nodev(fc, erofs_fc_fill_super);
+			return erofs_file_get_tree(fc);
 	}
 	return ret;
 }
@@ -840,6 +886,10 @@ static int erofs_fc_reconfigure(struct fs_context *fc)
 
 	DBG_BUGON(!sb_rdonly(sb));
 
+	/* Shared superblocks must not be reconfigured.  */
+	if (test_opt(&sbi->opt, SUPERBLOCK_SHARE))
+		return -EBUSY;
+
 	if (new_sbi->domain_id)
 		erofs_info(sb, "ignoring reconfiguration for domain_id.");
 
-- 
2.55.0

