Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794765851;
	b=wvTwis7mUIGT8ZK6Xg8N7cVSSw34XOfR36YrYYeJ3Fw7dpq5tPrZXZxSbIrPzfMIKKR0
	 AB3ODNy6OKnBaJGlhdXu31ERTFz58/hangMxTv9sXa2wgWKBpberWE7VXlUo5lbnEqqjg
	 HF8SH+HZtm6vsCD6vzfnVNPWDs3PFCpKjoWcNyEQrVvgoJ7iAVKf5AdCVQntJQAPOi5fr
	 3RA6uvBRvDUnHBIjlOTS2XGIhuUMO7xsD1qse5f2Kh6n4ooNcKUSYvJwkpDzehuK+b8th
	 7s1o5SPtrbbBklaOLB+s9kTQcNlV1u7IFGIIrKdVwGXseiNeokahSLlsxLhcTXoFxZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794765851;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UA38+n7c+RqbQlIN4Q8phpqWE0RWPQHALE9HzRQmyvE=;
	b=fbq0Xw+3hOwG/GauxjBROnxiLIazJo9i5A/RmyJuNfJSz6VXPQ6bJu/eWCtXbpfizpCa
	 AfDFvzcjmX83cVzdtRbHWa/9LFGmrzW/ngZtaaz/j+RVLie/ZLjO2BSyewg8oy3XAyG2x
	 UotOqI8P5kCh0XZn4OjbxkGyDlyM/moNOOvuOtFuMRsfRIgy+5+uItBav34aHaQ3f7uUz
	 l9n4/l5F/eBN1M0+D8ED0z++Iq/jBfxX2aEI73orzu/rtk4DNDL6EWuEzyr22JBcQ+k2a
	 LWJ7FmyDArDR3wlx/rKPTCc6JlfSILqNSzlHXWnPDb1tcDz7fVP3Gw4YffFe9q56INg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vWsT5qNH;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC1760A3808
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 18:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FC1760A3808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vWsT5qNH
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48e09aa5264so1214548f8f.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 10:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794765848; x=1795370648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UA38+n7c+RqbQlIN4Q8phpqWE0RWPQHALE9HzRQmyvE=;
        b=vWsT5qNHBHS1DVwii+PWCaUBbHAppQCmj2gOj682zzeHiV/k+DiOVZTV4Zl2ufwliV
         XcMy5JwYQTOOTrflDWHklMKFP0ooIAzTXmcrljZcbXEBcGgQJ8AuhPrA2Kdo4FY+A5sq
         RFhUdhdmB/HnkpDHfaoEqGopcQTyaUw/BkwbFNx/miBcx95zanVxTEo04YAIEeC/HESP
         VTbUAbTYu4JhjZfi4+Q1P2yCrswvDMacYAFanAg5eyigD2bOBBTTJke+hK+xYQgFlnL9
         BoGEzGfJ3RScREWw+h4ers02dYcW83csAclxW+91LVfFDsMDpf8UySKYC2UjgIBdPzYJ
         P8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794765848; x=1795370648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UA38+n7c+RqbQlIN4Q8phpqWE0RWPQHALE9HzRQmyvE=;
        b=gMTRfwq6b9cTyrDFeT5XY/ZZOchXgStBvLrt6JpJrn2UY3EwpPdCQwz0dRlUmT3wAk
         TjH8f4ew62yyq7O42Ejogyp88XRsLTobIlXiVUS9G5291j/qYuaiPS3rzqRoiwJqw6kR
         QYRk3Ty2DiR3gjY/vDdsep7CTQvJ+KroMu6TcXsGZ/CcDJ1FLQpPuGQRrGBxWq9+Wk2h
         s0UwDnrErMCNfpKtsPFZzAc/3CZMrqyTxlmQCBiWeJpNSHJ5GijtQqPaYc1laD2IU9vV
         EVQxiB91fvckDIY1z1Z2EQBPVfrcjr47XGmcFqCt8tTl/Ex4XPMtaNl+8WFVrzOBuVrf
         JDNQ==
X-Forwarded-Encrypted: i=1; AL+hErG5Xe7Ikv46yjPf4mcGuKRIOiZS/DIlKfjDe3NuXkvSR1nkgN8SqpLaMjg9/3FnLtSY4D5PWO/3FgBfocAx@vger.kernel.org
X-Gm-Message-State: APuU4Z/58SOQOEM3vIFhTA+K/6wUH3ELanPdYuE2odYWyrxss5blV5aR
	XhCgVrZbVdflqTVeR8rADcgErAJvoFR3ic5t2TdoPt9S+qj6SAlFkVu4
X-Gm-Gg: AYBFou19L6ecsmgrYmXgoZP85CtkOAocqOjvOxWif1p8fmaNZIQ8if4Eks/cKVriaiE
	9JtBBTbSN8kAObmzBxJzpRV7yDOweNZUFlOC0ITSoyNFgqfV8TTbmpvXyQDfBpgomdxR2ECobIl
	DrNsn/TXto7MN2xaBcDNG01IDGaSfA2AFSnCQ1LX6pGAv/FkeSoGa/YLQMv0BKyy/KMOYDSP69B
	SmTQDPDrxtLH/DwzGRSK56xqRfTPx+f9HxHWWd/buSm1hfcNPrUqMMDLvjEjGfkxzWTFADzG7Fw
	xYREwk+fQqmRtAVEqKVFZ36+Lhna1VHuyC/4S656MQ5q0rX/iWJXwFDpkAxc0oZCcB6cIparDoE
	IQlpb+nU8wrG7J8czQl89Awp70R3chaltqw42Hi581AJRZ4T3TuxbAx0HqS92c4gP2bl/QqMbeS
	G0tf4XiwUqA4yQtqybQVEdiLIDHVs7xl6WzS09meKUEz62QZj800iOgeqHvWCgxsXqPoz6dFq8q
	P4IOCGA9mRvt+2e49vkuXYC9WzE0gpdGLE9cnjshWn/fwbYLVVX12w/Af7YQneanGYgceNwSA2u
	1QzGfTZ618NzQ4/rTihe3WACQsLngLJ7nvESgNx8YDNp/w==
X-Received: by 2002:a05:6000:455c:b0:48f:bcf0:2026 with SMTP id ffacd0b85a97d-49c73259e6bmr12985016f8f.13.1794765848134;
        Sun, 15 Nov 2026 10:04:08 -0800 (PST)
Received: from infinity ([2001:b07:5d26:7a6a:365a:60ff:fe0d:cfc6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60f8c248sm17980448f8f.58.2026.11.15.10.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 10:04:07 -0800 (PST)
From: koraynilay <koray.fra@gmail.com>
To: David Sterba <dsterba@suse.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Paulo Alcantara <pc@manguebit.org>
Cc: Chris Mason <mason@kernel.org>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Sean Smith <defendthedisabled@gmail.com>,
	Andrey Albershteyn <aalbersh@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Amir Goldstein <amir73il@gmail.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	exfat@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	koraynilay <koray.fra@gmail.com>
Subject: [RFC PATCH v4 04/10] exfat: make crtime user-settable using ptime
Date: Sun, 15 Nov 2026 19:03:37 +0100
Message-ID: <20261115180343.576773-5-koray.fra@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261115180343.576773-1-koray.fra@gmail.com>
References: <20261115180343.576773-1-koray.fra@gmail.com>
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

Since exFAT supports user-settable file creation timestamps, map
provenance time (ptime) to exFAT file creation time (crtime) using the
newly introduced ptime API (in commit "vfs: add provenance time
(ptime)").

To do this, implement exfat_fileattr_set(), set .fileattr_set to it for
both file_inode and dir_inode operations and update exfat_fileattr_get()
and exfat_getattr().

The timestamp is now retrievable by using file_getattr() or statx(), and
is settable by using file_setattr() with the FS_XFLAG_PTIME flag.

Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.4.7
Signed-off-by: koraynilay <koray.fra@gmail.com>
---
 fs/exfat/exfat_fs.h |  2 ++
 fs/exfat/file.c     | 42 +++++++++++++++++++++++++++++++++++++++++-
 fs/exfat/namei.c    |  1 +
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index eee573d1697c..aff96afa258a 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -619,6 +619,8 @@ int exfat_getattr(const struct mnt_idmap *idmap, const struct path *path,
 		  unsigned int query_flags);
 struct file_kattr;
 int exfat_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
+int exfat_fileattr_set(const struct mnt_idmap *idmap, struct dentry *dentry,
+		       struct file_kattr *fa);
 int exfat_file_fsync(struct file *file, loff_t start, loff_t end, int datasync);
 long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 long exfat_compat_ioctl(struct file *filp, unsigned int cmd,
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 435bbef288b8..02390b03eecd 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -384,15 +384,22 @@ int exfat_getattr(const struct mnt_idmap *idmap, const struct path *path,
 
 	generic_fillattr(idmap, request_mask, inode, stat);
 	exfat_truncate_atime(&stat->atime);
-	stat->result_mask |= STATX_BTIME;
+	stat->result_mask |= (STATX_BTIME | STATX_PTIME);
 	stat->btime.tv_sec = ei->i_crtime.tv_sec;
 	stat->btime.tv_nsec = ei->i_crtime.tv_nsec;
+	stat->ptime.tv_sec = ei->i_crtime.tv_sec;
+	stat->ptime.tv_nsec = ei->i_crtime.tv_nsec;
 	stat->blksize = EXFAT_SB(inode->i_sb)->cluster_size;
 	return 0;
 }
 
+#define EXFAT_SUPPORTED_XFLAGS		(FS_XFLAG_PTIME)
+
 int exfat_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
+	struct inode *inode = d_backing_inode(dentry);
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+
 	/*
 	 * exFAT compares filenames through an upcase table, so lookup
 	 * is always case-insensitive. Long names are stored in UTF-16
@@ -400,6 +407,12 @@ int exfat_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 	 */
 	fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
 	fa->flags |= FS_CASEFOLD_FL;
+
+	fa->fsx_ptime.tv_sec = ei->i_crtime.tv_sec;
+	fa->fsx_ptime.tv_nsec = ei->i_crtime.tv_nsec;
+	fa->fsx_xflags |= FS_XFLAG_PTIME;
+	fa->fsx_xflags_mask |= FS_XFLAG_PTIME;
+
 	return 0;
 }
 
@@ -485,6 +498,32 @@ int exfat_setattr(const struct mnt_idmap *idmap, struct dentry *dentry,
 	return error;
 }
 
+int exfat_fileattr_set(const struct mnt_idmap *idmap, struct dentry *dentry,
+		      struct file_kattr *fa)
+{
+	struct inode *inode = d_backing_inode(dentry);
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+
+	if (fileattr_has_fsx_mask(fa, EXFAT_SUPPORTED_XFLAGS))
+		return -EOPNOTSUPP;
+
+	if (fa->fsx_xflags_mask & ~EXFAT_SUPPORTED_XFLAGS)
+		return -EOPNOTSUPP;
+
+	if (fa->flags & ~FS_CASEFOLD_FL)
+		return -EOPNOTSUPP;
+
+	if (fa->fsx_xflags_mask & FS_XFLAG_PTIME) {
+		ei->i_crtime.tv_sec = fa->fsx_ptime.tv_sec;
+		ei->i_crtime.tv_nsec = fa->fsx_ptime.tv_nsec;
+	}
+
+	inode_set_ctime_current(inode);
+	mark_inode_dirty(inode);
+
+	return 0;
+}
+
 /*
  * modified ioctls from fat/file.c by Welmer Almesberger
  */
@@ -1110,4 +1149,5 @@ const struct inode_operations exfat_file_inode_operations = {
 	.setattr	= exfat_setattr,
 	.getattr	= exfat_getattr,
 	.fileattr_get	= exfat_fileattr_get,
+	.fileattr_set	= exfat_fileattr_set,
 };
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 68ddb9c5504f..15ec7f1942c8 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -1349,4 +1349,5 @@ const struct inode_operations exfat_dir_inode_operations = {
 	.setattr	= exfat_setattr,
 	.getattr	= exfat_getattr,
 	.fileattr_get	= exfat_fileattr_get,
+	.fileattr_set	= exfat_fileattr_set,
 };
-- 
2.56.0

