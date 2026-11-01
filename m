Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793498250;
	b=PwZI7cef6sj8XfX/ovkVz9IQOQ/SfTib8xkGwXAYhIL0VD5Awvt2udv7J7jBGQ9lwxze
	 bbz94eRJnQ6bo6jUzes+ilvCm2V6bxXkTnjoYWlr1fYzUttGYkAn05lHOwjfZjvg0Lann
	 liyvJlHBSGZ/qYFNCKqml/HTn0Y5k9l4/rdGLg0GsMrX80rkAjpynlltFp1Q9X2xq3h+C
	 5IC0CFBqCYl54yv5WFyvJqPUwmbJr8ixb21+hlqV2kYY9wfMq4Tq3XgQqdRxR0DtxCiY1
	 9hEDhDK9PAgylxu8L7ZaLvnuLFqfLEm3QwouQ7zReJaO8gjeWFVAnW5qZ1Lq+phtXTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793498250;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Z5MG08yt3Dfb74iEQhSFMIkh2RLd3WaV8uSunF8a+30=;
	b=mJj1r1U2WLFndWQFpIpO4dNc3siz6hxhn2St7emtCENQvNiknTPttodx1PXTkBozqCjs
	 61oZ9vty0iqBAe+zmmxta9RyCx8Kn3v3S39zENUWPPaZFGDK6anJq6PggUEHi3Nt9gM1l
	 Sv1stAZaRQjVnAmLI1ASZEHkgnyu20DIQVDDEF6VMJjuDvbSixhu7Dga4uNuud/bykGW9
	 1GFOe3eKVNncFKWgFm1lwAnErcPAHxrl4TAhaaUtD3m7z8Vyc+4rlM+nNtOboO/v3Inrx
	 Q+oP0+tFeZuU2EMG5iLFCLZlULT08w5Nn2e5e2lOdD0C1UqWi7ExPJRQrNkWOaUWUdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="BsuMTcX/";
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD0D60A2625
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2026 01:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAD0D60A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BsuMTcX/
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so19809055e9.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 18:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793498248; x=1794103048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z5MG08yt3Dfb74iEQhSFMIkh2RLd3WaV8uSunF8a+30=;
        b=BsuMTcX/BjdxIN1q3x96RSbSUJhcQimg9AITR+6CL0Jk0S52NUmp2phDSjd9arPfrG
         SyC/+LPuBtqBdhxAhqypEFo1DMutXeqtJVZIrB36WKs+5+A2aT3QmuRxQn7GWMdYnit0
         UIkhudzFiZjSp/8PytPE0qRP/nQv/GeMwXqNfCfDidbW/TSEyMc8NpHF3IILfV0IxPYj
         /LAfNVTcTLQMV3z3wsdEuTHMkFY4Bqk9Co8VRDbXglFKwGY6NZDIEwQnOsotnkrFEJ4/
         WivLN1GoM1uxHzydbRxByfB5XEoIG3GmEOw8gh1zOXULD+II7ZwqSRJT4VNoINdioqDH
         LTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793498248; x=1794103048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z5MG08yt3Dfb74iEQhSFMIkh2RLd3WaV8uSunF8a+30=;
        b=jqSdPn2lvgqDRl7eRgVqxMRMfTsaJV3lLdwq3CdEeLDVgERSHqL2DlwGGmjJlVVp+1
         lF5Nm5XBtDV2joqiU2wcQ/QobAUMf5RnZHRgnF3oBIn0l0iEeNZ06z28kyq9LxkvqFkg
         12IcWn+SWTEhECzKxg6V4y8AwSnaWeCFwfAleSnMOEPPCrMTn36PzgFRaOtW9Nc3zTqr
         KYc/kBK5G+u9YHfG5otuVx+61+Gof5Kxw05k/g0k5kWUF1DpL3xf2Eh2AGRlob2rEAwg
         gGg4vXxXdXrGd0atkkK54cqhumzm0hfy8Z6uUjI4YgvT1/whqJJRy63oQxAH04xSl1c4
         8USA==
X-Forwarded-Encrypted: i=1; AKwUvBwRpFJnO5ScowaFIauzRMhWYH2ni4pnEDp5DgJSuEy5ML0Y4kpYRtJ0efyfGM58K0KkEUdXKXs+6nzH67xX@vger.kernel.org
X-Gm-Message-State: AFq9FYLYwbKWgK2rLqeJP+t9fzFE0cOz9tm46/aKE+vgJyOp176ihje+
	irWKi82OLLBlgk2nPuelXQN9mNX5MOLdhGvesiF/Qd0co7AI3MUKV/eG
X-Gm-Gg: AYBFou0PrOlb43P17vJ2rPlcdCTpZLdpivjuREmILqb/ock6CoEcl05ezHf0Em9qDC7
	m35kPlopqZIjn2mH5OAA26iQoPAnZ/kWfX+gZx7x0yQVaH8RxcjuEws/SkEpzPeM9W73RA6JVWm
	F+YPABoue5NoXbzBQ4F+HWdIpjbukV89RpBD9TxpeZNCYRkOTNOlvBYRocLeYIi82TyS+5mnqI1
	o2ArKxdLOtap/mVZUf6cAm5FVvl/jLarU3M7GZD4E4i4LhxQiV7CiWlh7+i2J77i28SfJYh0GSg
	HdnVA28r0xb+bGsTT3EcSTtTDcNJUBuk6fPsN9egVUxNTDEX7CdSY2nj1kU2BGNrdDtwm3vSSWC
	KQNM9A5A91URSwjqaB+saA4pgkyx9Rus9EqQdDl7bvmliaqpXVF/OW7rq4BCYaI/+ehewNqIr6d
	D1rnMY/uwHbAiLS8rABmaTp3VFdeOF+orxRS3ZddhcbPUMmrevTs+ZGk5QqO0Fb9FnupdGfzi+p
	8586tHQDvIfWRGQhfupxdV1XcOQriWRVK064H0+khJFnGnBZmXeU6lAXV6JKQl3meODg5fW3Is8
	6gRjZrE6GXV0rtfh770GeZNS
X-Received: by 2002:a05:600c:46d1:b0:4a3:59c9:a754 with SMTP id 5b1f17b1804b1-4ac187a72f4mr145723175e9.22.1793498247899;
        Sat, 31 Oct 2026 18:57:27 -0700 (PDT)
Received: from infinity ([2001:b07:5d26:7a6a:365a:60ff:fe0d:cfc6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81b7fe80sm273532835e9.11.2026.10.31.18.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 18:57:26 -0700 (PDT)
From: koraynilay <koray.fra@gmail.com>
To: David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Chris Mason <mason@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chuck Lever <cel@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Sean Smith <defendthedisabled@gmail.com>,
	Andrey Albershteyn <aalbersh@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Amir Goldstein <amir73il@gmail.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	exfat@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-api@vger.kernel.org,
	koraynilay <koray.fra@gmail.com>
Subject: [RFC PATCH v3 3/5] ntfs3: make crtime user-settable using ptime
Date: Sun,  1 Nov 2026 02:55:49 +0100
Message-ID: <20261101015551.786044-4-koray.fra@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101015551.786044-1-koray.fra@gmail.com>
References: <20261101015551.786044-1-koray.fra@gmail.com>
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

Since NTFS supports user-settable file creation timestamps, map
provenance time (ptime) to NTFS file creation time (crtime) by using the
newly introduced ptime API (in commit "vfs: add provenance time
(ptime)").

To do this, update ntfs_fileattr_[gs]et(), ntfs_getattr() and make it
persist to disk in ni_write_inode().

The timestamp is now retrievable by using file_getattr() or statx(), and
is settable by using file_setattr() with the FS_XFLAG_PTIME flag.

Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.4.7
Signed-off-by: koraynilay <koray.fra@gmail.com>
---
 fs/ntfs3/file.c    | 14 ++++++++++++--
 fs/ntfs3/frecord.c |  8 +++++++-
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 1624f9b014e0..b334449e9beb 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -124,6 +124,10 @@ int ntfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 
 	fileattr_fill_flags(fa, flags);
 
+	fa->fsx_ptime.tv_sec = ni->i_crtime.tv_sec;
+	fa->fsx_ptime.tv_nsec = ni->i_crtime.tv_nsec;
+	fa->fsx_xflags |= FS_XFLAG_PTIME;
+
 	return 0;
 }
 
@@ -142,7 +146,7 @@ int ntfs_fileattr_set(const struct mnt_idmap *idmap, struct dentry *dentry,
 	if (unlikely(is_bad_ni(ni)))
 		return -EINVAL;
 
-	if (fileattr_has_fsx(fa))
+	if (fileattr_has_fsx_mask(fa, FS_XFLAG_PTIME))
 		return -EOPNOTSUPP;
 
 	if (flags & ~(FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NODUMP_FL))
@@ -154,6 +158,11 @@ int ntfs_fileattr_set(const struct mnt_idmap *idmap, struct dentry *dentry,
 	if (flags & FS_APPEND_FL)
 		new_fl |= S_APPEND;
 
+	if (fa->fsx_xflags & FS_XFLAG_PTIME) {
+		ni->i_crtime.tv_sec = fa->fsx_ptime.tv_sec;
+		ni->i_crtime.tv_nsec = fa->fsx_ptime.tv_nsec;
+	}
+
 	inode_set_flags(inode, new_fl, S_IMMUTABLE | S_APPEND);
 
 	/* Save nodump flag to return in ntfs_getattr. */
@@ -275,8 +284,9 @@ int ntfs_getattr(const struct mnt_idmap *idmap, const struct path *path,
 	if (unlikely(is_bad_ni(ni)))
 		return -EINVAL;
 
-	stat->result_mask |= STATX_BTIME;
+	stat->result_mask |= (STATX_BTIME | STATX_PTIME);
 	stat->btime = ni->i_crtime;
+	stat->ptime = ni->i_crtime;
 	stat->blksize = ni->mi.sbi->cluster_size; /* 512, 1K, ..., 2M */
 
 	if (inode->i_flags & S_IMMUTABLE)
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 16ac847de48d..5e4f743a5930 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3215,6 +3215,13 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 		}
 
 		/* Update the access times if they have changed. */
+		ts = ni->i_crtime;
+		dup.cr_time = kernel2nt(&ts);
+		if (std->cr_time != dup.cr_time) {
+			std->cr_time = dup.cr_time;
+			modified = true;
+		}
+
 		ts = inode_get_mtime(inode);
 		dup.m_time = kernel2nt(&ts);
 		if (std->m_time != dup.m_time) {
@@ -3250,7 +3257,6 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 		    (modified || (ni->ni_flags & NI_FLAG_UPDATE_PARENT))
 		    /* Avoid __wait_on_freeing_inode(inode). */
 		    && (sb->s_flags & SB_ACTIVE)) {
-			dup.cr_time = std->cr_time;
 			/* Not critical if this function fail. */
 			re_dirty = ni_update_parent(ni, &dup, sync);
 
-- 
2.56.0

