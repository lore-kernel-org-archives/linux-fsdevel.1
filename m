Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66918475333;
	Fri,  9 Oct 2026 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791566254; cv=none; b=RxAuWmkUW6Im2lzyIPdsKFUPXuvUqAAHr+VShjOhZXCJ3UhP3PyvVVeM6VtBwI0l1uV5nef9zPTGJpYXcT+I6qCcNkri724PE0tbPQEN6NnQ7OFSs0oQ4I2T3AgO+insqYaNneMJ2njttJsgFvntNLNkUkm7Vqm9TiaEXJlSV2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791566254; c=relaxed/simple;
	bh=2axDFS4pHoJnryGCD7Nur2iIi1IbM7kcnFasvpCOyBc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zhxwp+jpxFpFhNlVJPalWIJC3ZS2Pdu+i0wWdvSaf316RGPhd+xPv8Pd3PBQUAENZXwCgzX0Gpy5VFwizAHtHcm70qeDDwnvSwlSbSNXoCdeJMAeyHWLEnlVH+ZepOIg9yuSm/s6vPcwIPKg/XJ+KD8VplE+V1GJG7xX0HFTldw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=uEUpXXr0; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="uEUpXXr0"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id B26E51D6E;
	Fri,  9 Oct 2026 17:18:22 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=uEUpXXr0;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 7E67721AD;
	Fri,  9 Oct 2026 17:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1791566251;
	bh=5pziUlmwea0nTr4GT0KIKMt7mDJ6zBvaDgN4QU/94Tk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=uEUpXXr0Hq/hRvq7lR45Y+xyV8IdyIpIo+4M9f1+9ItBjEMZNQ63gRjIPowYZ34e6
	 w7iS/29UifzREfTuOvU8hevD2hgspl944hZNJNOMDyH8NhG16LoCRT//EdcPrtfcDv
	 dt5iqA5EF05GBumHkHIWOW7ELdl1KizTJKtBAQEQ=
Received: from localhost.localdomain (172.30.20.199) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 9 Oct 2026 20:17:30 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 06/11] fs/ntfs3: add 'ugm' mount option to control storing uid/gid/mode in xattrs
Date: Fri, 9 Oct 2026 19:16:59 +0200
Message-ID: <20261009171704.11379-7-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009171704.11379-1-almaz.alexandrovich@paragon-software.com>
References: <20261009171704.11379-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On file creation ntfs3 stores the owner, group, mode and device
number in the WSL extended attributes $LXUID, $LXGID, $LXMOD and
$LXDEV, and may also write a POSIX ACL. These attributes are
meaningless to Windows, and the packed size of the EAs is recorded in
the directory entry as well, so every created file carries them.

Add a 'ugm' mount option controlling this. It is enabled by default,
preserving the current behaviour; mount with 'ugm=0' to create files
without the WSL attributes.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/inode.c   |  2 +-
 fs/ntfs3/ntfs_fs.h |  1 +
 fs/ntfs3/super.c   | 13 ++++++++++++-
 fs/ntfs3/xattr.c   |  7 +++++++
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index a3b2daaecb4d..7593a93466d9 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1836,7 +1836,7 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 		inode->i_flags |= S_NOSEC;
 	}
 
-	if (!S_ISLNK(mode)) {
+	if (!S_ISLNK(mode) && sbi->options->ugm) {
 		/*
 		 * ntfs_init_acl and ntfs_save_wsl_perm update extended attribute.
 		 * The packed size of extended attribute is stored in direntry too.
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 9321b2608e84..90ccfde951dc 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -111,6 +111,7 @@ struct ntfs_mount_options {
 	unsigned nocase : 1; /* case insensitive. */
 	unsigned delalloc : 1; /* delay allocation. */
 	unsigned ads : 1; /* ads support. */
+	unsigned ugm : 1; /* store user/group/mode in xattr. */
 };
 
 /* Special value to unpack and deallocate. */
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 7fd83027007b..cf67d34568d8 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -275,6 +275,8 @@ enum Opt {
 	Opt_delalloc_bool,
 	Opt_ads,
 	Opt_ads_bool,
+	Opt_ugm,
+	Opt_ugm_bool,
 	Opt_err,
 };
 
@@ -303,6 +305,8 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
 	fsparam_bool("delalloc",	Opt_delalloc_bool),
 	fsparam_flag("ads",		Opt_ads),
 	fsparam_bool("ads",		Opt_ads_bool),
+	fsparam_flag("ugm",		Opt_ugm),
+	fsparam_bool("ugm",		Opt_ugm_bool),
 	{}
 };
 // clang-format on
@@ -345,7 +349,7 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
 		pr_err("ntfs3: unknown option \"%s\". Use uid,gid,umask,"
 		       "dmask,fmask,sys_immutable,discard,force,sparse,"
 		       "nohidden,hide_dot_files,windows_names,showmeta,acl,"
-		       "iocharset,prealloc,nocase,delalloc,ads",
+		       "iocharset,prealloc,nocase,delalloc,ads,ugm",
 		       param->key);
 		return -ENOPARAM;
 	}
@@ -443,6 +447,12 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
 	case Opt_ads_bool:
 		opts->ads = result.boolean;
 		break;
+	case Opt_ugm:
+		opts->ugm = 1;
+		break;
+	case Opt_ugm_bool:
+		opts->ugm = result.boolean;
+		break;
 	default:
 		/* Should not be here unless we forget add case. */
 		return -EINVAL;
@@ -1905,6 +1915,7 @@ static int ntfs_init_fs_context(struct fs_context *fc)
 	opts->fs_fmask_inv = opts->fs_dmask_inv = ~current_umask();
 	opts->prealloc = 1;
 	opts->ads = 1;
+	opts->ugm = 1;
 
 #ifdef CONFIG_NTFS3_FS_POSIX_ACL
 	/* Set the default value 'acl' */
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 2cf45bdd93d5..d6ad06415318 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -1015,6 +1015,13 @@ int ntfs_save_wsl_perm(struct inode *inode, __le32 *ea_size)
 	__le32 value;
 	struct ntfs_inode *ni = ntfs_i(inode);
 
+	if (!ni->mi.sbi->options->ugm) {
+		/* Do not save uid/gid/mode/dev in xattr. */
+		if (ea_size)
+			*ea_size = 0;
+		return 0;
+	}
+
 	ni_lock(ni);
 	value = cpu_to_le32(i_uid_read(inode));
 	err = ntfs_set_ea(inode, "$LXUID", sizeof("$LXUID") - 1, &value,
-- 
2.43.0

