Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AD734E744;
	Wed, 29 Apr 2026 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473186; cv=none; b=iC5a+L7j0rDaUMVnru0pJDnnBTYuYnKIPVvcicaKJGkEx9j7tg/D8VCHD+YK/q2AN0ky2xNFdrFaa6kFTpqOkibIg+jC3KYoWaUxeA5SN9kbxMZ3HOZaC3lKSWMDQyDWVkUh9iNSc0Sg+Db753hl37ORUUiUln7Rnsp+jsby93I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473186; c=relaxed/simple;
	bh=sv81gFpJXyk5LNzlo4KefsOadmpHy09XreVq2JUDJi8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ajmouFUI2N7elgf3atr0GmeYT0lmR7QmxRC8+/TzTodmLUtba27RG175lPE86stkE+SJF90bUKxB0JT96JVlps82gWT/MuBgkJ1MpBuza2k84d5u6hv2ebml8jZJZKXTaYhGdSUCAvD6mMCwA7KbzSzuFtxaR0/qfnqA/39MUYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8s65W+z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8s65W+z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726CFC19425;
	Wed, 29 Apr 2026 14:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473185;
	bh=sv81gFpJXyk5LNzlo4KefsOadmpHy09XreVq2JUDJi8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=e8s65W+zVtzuzE6YmWs43haRVQNQgTDp4mCnP78X+CfZ5Us4mrXpAZos/gk0DjjC+
	 hxR8dX5q/xLfyeI5i63eg/Q5fDxlWiYW46YeN4Qzw6SdO9rTxsNHV18vav5h4PmgRU
	 4bDHSJca9I+B6YEsKdTauSxdbNLWKt6LvzNVug7J6KKit2i8rE6awWREauPGYTEeXJ
	 PyTQJyLF5GfwMkgm3atPKkU6chMNOfSxU3LyrRLJI8nFynZCfO3SYytXGLESeRMW3v
	 pGjvYoBtwZqDwtL7IJoQ2z1RqAeCcMv/N9s3uFgxAW2Y5oifas7uJRk5LyJvWAMiRP
	 vrGrVhgAkFEzQ==
Date: Wed, 29 Apr 2026 07:33:05 -0700
Subject: [PATCH 3/3] fuse: allow setting of root nodeid
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747206187.4103135.11316004307240242988.stgit@frogsfrogsfrogs>
In-Reply-To: <177747206108.4103135.16385179491642925149.stgit@frogsfrogsfrogs>
References: <177747206108.4103135.16385179491642925149.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Provide a new mount option so that fuse servers can actually set the
root nodeid.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h |    2 ++
 fs/fuse/inode.c  |   11 +++++++++++
 2 files changed, 13 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index a9ca0e936524e7..95b37f4660cc1d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -642,6 +642,7 @@ static inline bool fuse_is_inode_dax_mode(enum fuse_dax_mode mode)
 struct fuse_fs_context {
 	struct fuse_dev *fud;
 	unsigned int rootmode;
+	u64 root_nodeid;
 	kuid_t user_id;
 	kgid_t group_id;
 	bool is_bdev:1;
@@ -654,6 +655,7 @@ struct fuse_fs_context {
 	bool no_control:1;
 	bool no_force_umount:1;
 	bool legacy_opts_show:1;
+	bool root_nodeid_present:1;
 	enum fuse_dax_mode dax_mode;
 	unsigned int max_read;
 	unsigned int blksize;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d883c9e3543f5c..d48a76e6d17995 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -816,6 +816,7 @@ enum {
 	OPT_ALLOW_OTHER,
 	OPT_MAX_READ,
 	OPT_BLKSIZE,
+	OPT_ROOT_NODEID,
 	OPT_ERR
 };
 
@@ -830,6 +831,7 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
 	fsparam_u32	("max_read",		OPT_MAX_READ),
 	fsparam_u32	("blksize",		OPT_BLKSIZE),
 	fsparam_string	("subtype",		OPT_SUBTYPE),
+	fsparam_u64	("root_nodeid",		OPT_ROOT_NODEID),
 	{}
 };
 
@@ -950,6 +952,11 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 		ctx->blksize = result.uint_32;
 		break;
 
+	case OPT_ROOT_NODEID:
+		ctx->root_nodeid = result.uint_64;
+		ctx->root_nodeid_present = true;
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -987,6 +994,8 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
 			seq_printf(m, ",max_read=%u", fc->max_read);
 		if (sb->s_bdev && sb->s_blocksize != FUSE_DEFAULT_BLKSIZE)
 			seq_printf(m, ",blksize=%lu", sb->s_blocksize);
+		if (fc->root_nodeid && fc->root_nodeid != FUSE_ROOT_ID)
+			seq_printf(m, ",root_nodeid=%llu", fc->root_nodeid);
 	}
 #ifdef CONFIG_FUSE_DAX
 	if (fc->dax_mode == FUSE_DAX_ALWAYS)
@@ -2052,6 +2061,8 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	sb->s_flags |= SB_POSIXACL;
 
 	fc->default_permissions = ctx->default_permissions;
+	if (ctx->root_nodeid_present)
+		fc->root_nodeid = ctx->root_nodeid;
 	fc->allow_other = ctx->allow_other;
 	fc->user_id = ctx->user_id;
 	fc->group_id = ctx->group_id;

