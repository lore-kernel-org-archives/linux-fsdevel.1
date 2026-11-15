Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794765861;
	b=BrL1uJQoLCXh5xEzfclGLt2BfcZxU1cI8xRmr+Ded6ZSqc0GRRvP9OredT+jgXpVn3wW
	 qLKp/Nae+vCyhp/+nX9p+djrinEBoqFeUeQPS8fOw/crXJwDII8MHs5q0427/PmwZ9cv3
	 rdHAs4rfZaMzfaVEjIQ2z+kRaAsQGoNvs8it5hZbhuPY/Xil+v0qB89Mkm5MHJY3UbPjp
	 63WkHvBU8opwtvj15gTaWPYhmcCTRxtHz1MNmsUFUuy4DXBTt3dZM4mxmIY5srX2rNU7c
	 c8k21yqXVrc8BF5IjeyYy4I7aovSR3fmWoUf40J3l/Mhs2PAGXbfnqa4OLapFNv2STQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794765861;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9exNlCCX4l2rTtwsvuunv8f6XU42014IC0sk6D9rr+c=;
	b=bMYt2RM3L7U8uoKwjdd8MAWnFZ/YkkItPfYyOO9/4CkHUtvO0s2VyFLDPkWl7EeoVMK/
	 e+hS2V+uVcGzh6hmEhyHl0nG+yBCUnBpGQ5UzQgPe0wMMfw3mxWw6Ka1MPINgA/uR+d65
	 f/3toY1WwcVxPmqq/Y1sWCqjKmT7DWr7Wmqyy7jc4OT5LHwRV1NN4QcOIfMM5Bgqclj/p
	 EDPSBcMmvUyEmBgsFww+hv5lKB4QJztxXuLH4jM38RPo+GSaiU3VqYzJwhSjAQJkIAdLM
	 wYJNuRQk30U9u+o87ExiNZd3eygFdWykVKWtToH38y+YuCTT9HClYQEEaGNT9sDB5iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Tjhblw/z";
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516C260A6F79
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 18:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 516C260A6F79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tjhblw/z
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4919a880834so1263259f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 10:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794765859; x=1795370659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9exNlCCX4l2rTtwsvuunv8f6XU42014IC0sk6D9rr+c=;
        b=Tjhblw/zNDrCTUsnmg+QTliqsOiTPBtjSSvhZNwngJTmxt/3eD2ylLhtrmi7zyK23m
         cVQ6RDXSZaGQ762m8Kc3kKWwp++aJdLjuV6d81oRiZiscyXgPupsgoie1DECpCqGKAQY
         1zLh72cvLQVBGUgb5TQWquyNIR4Gjva0aEtGMhy176JXLT3en9EQ4WHkxDGrgawtcL1J
         hnEwsjCZY9U/hWGnWK3nCqkTdCyIbiz7xGLEzjiA/xoViDgAbtcK7cVE5YnfuGg0/hhE
         gFda4b9blg47lLk/TsvljJgAsINoIkrkECP++sk8xIHYzJVlTsXn/hMc684pkU11hmpp
         +eIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794765859; x=1795370659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9exNlCCX4l2rTtwsvuunv8f6XU42014IC0sk6D9rr+c=;
        b=gtUDd36SM7nyf6TIhy5GCE7QtNvoQwPYRGJSeDAWHjBw90TFrjmDmpTgVBOMj4gp7j
         eUf8EgC0s6L86SWTRprM25TE4V11/TcremgJ3WjM8oAXEnUe59lUuY3IBJBlczmU1cG4
         5Fs8EawIAID0VTsbSRkxe7LbIdSxjL2M/B8wJQUgs/dPtfUhAfaPlVcxW373F1UgBHHc
         mqv0jPTeS99IeZqtbNHEkk541z3edxXcR/1mUz/uVfuqLwNzCwryM5OODAEayVKGm1WK
         Ck3xnqfMbaIjLpQG1+xw1del/L8+VF6QqOSywRaPi94IZ4d2T3qcADk9HTaCfjb1sjyt
         ewUA==
X-Forwarded-Encrypted: i=1; AL+hErGlXpdxk0h1Ji3GLOrFojKpO5ZydElvl2KLjb+xIfWa2t7VAyUEUlQagzqZzEi7pm/0H8jogJVbSdCwLOkU@vger.kernel.org
X-Gm-Message-State: APuU4Z8hrURJZnbHoUEO5Lp9lKjslfmjnGArQiMz4QCeOApv934FbX4x
	jng8CvlPRHy4aSjHEq/1llfY96T4i8+dY+TNU4VAwAjTv3v4rJHZ7e6i
X-Gm-Gg: AYBFou2ujh3vPjKj17Bc/8kXcNJKBIt2bEuSpaHBtl8CHhA0TjmBsfFTj9hSAL28DGb
	7f1PWwxowoq+FPyKAaO6SZ4imTA8Wr93phg1GYVKCWKXKg0HvhsTxGxig3yw5xnmBmQl7KBBgvW
	3DD8G5OL5XjTRjXWrkLjJEA9zJyDzC4Y+0eCCIp3nLndUrHsux9tOc3IWpcNqOOc+c9tMog1P9H
	v5fd9Grl5hzOOprkJuLaGuTVtw4ngeIDHEX0IseEB0rezqSkwou35rOHiDaX7BEoKwKToE+VZ2A
	3rMUBNsg6dcChSt01vT+98jLrVAEvhrNDadZjODun9nHJgPu0CKrfkMPd0nj60QpIrZ9z2JvPe4
	79fWJI+4ob0wwMHY5eJah5UpM7qOzOt8C9dfWW3uvS+zGbAFzIzox4nIYh/Yj7WPNqr4I8ciwyV
	h7RintJX3fFcLqB5LudN519qXQr8bORDnWc1q01xgVx9jZEmhyIH2RPCJTivc5CJ9wK9BANKQsk
	8fOKajPQWEv31EZSfTyMi77SCxprHIXUf7vwlYtd4ukZeDvCa5LvAc4TKaNHsR1gZYueRHspnuq
	PK6//DDXL90UxjVyizihhtuf
X-Received: by 2002:a05:600c:698d:b0:4a1:88de:9e8b with SMTP id 5b1f17b1804b1-4bb55a3e341mr170083755e9.5.1794765858611;
        Sun, 15 Nov 2026 10:04:18 -0800 (PST)
Received: from infinity ([2001:b07:5d26:7a6a:365a:60ff:fe0d:cfc6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60f8c248sm17980448f8f.58.2026.11.15.10.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 10:04:18 -0800 (PST)
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
Subject: [RFC PATCH v4 09/10] ksmbd: add provenance time (ptime) and map it to CreationTime
Date: Sun, 15 Nov 2026 19:03:42 +0100
Message-ID: <20261115180343.576773-10-koray.fra@gmail.com>
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

Implement provenance time (ptime) in ksmbd, as introduced in a
previous commit ("vfs: add provenance time (ptime)").

Map it to SMB's CreationTime, making it settable by SMB clients. When
reporting CreationTime to clients, prioritize ptime over da.create_time
memorized in the user.DOSATTRIB xattr.

Update smb2_new_xattrs() and smb2_update_xattrs() to accept a stat
argument so they can check whether ptime is supported or already set and
behave accordingly. When ptime is natively supported and saved to the
filesystem, skip storing da.create_time in user.DOSATTRIB to avoid
redundant and desynchronized metadata, while falling back to the xattr
for filesystems without ptime.

Finally, add the ksmbd_vfs_set_ptime() helper to persist ptime to the
underlying filesystem, if supported.

Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.5.7
Signed-off-by: koraynilay <koray.fra@gmail.com>
---
 fs/smb/server/smb2pdu.c | 37 ++++++++++++++++++++++-------------
 fs/smb/server/vfs.c     | 43 +++++++++++++++++++++++++++++++++++++----
 fs/smb/server/vfs.h     |  1 +
 3 files changed, 64 insertions(+), 17 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 63dfbffbb575..f389025dc518 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3814,7 +3814,7 @@ static int smb2_create_truncate(const struct path *path)
 }
 
 static void smb2_new_xattrs(struct ksmbd_tree_connect *tcon, const struct path *path,
-			    struct ksmbd_file *fp)
+			    struct ksmbd_file *fp, struct kstat *stat)
 {
 	struct xattr_dos_attrib da = {0};
 	int rc;
@@ -3825,9 +3825,12 @@ static void smb2_new_xattrs(struct ksmbd_tree_connect *tcon, const struct path *
 
 	da.version = 4;
 	da.attr = le32_to_cpu(fp->f_ci->m_fattr);
-	da.itime = da.create_time = fp->create_time;
-	da.flags = XATTR_DOSINFO_ATTRIB | XATTR_DOSINFO_CREATE_TIME |
-		XATTR_DOSINFO_ITIME;
+	da.itime = fp->create_time;
+	da.flags = XATTR_DOSINFO_ATTRIB | XATTR_DOSINFO_ITIME;
+	if (!(stat->result_mask & STATX_PTIME)) {
+		da.create_time = fp->create_time;
+		da.flags |= XATTR_DOSINFO_CREATE_TIME;
+	}
 
 	rc = ksmbd_vfs_set_dos_attrib_xattr(mnt_idmap(path->mnt), path, &da, true);
 	if (rc)
@@ -3859,7 +3862,8 @@ static bool smb2_parent_compressed(struct ksmbd_tree_connect *tcon,
 }
 
 static void smb2_update_xattrs(struct ksmbd_tree_connect *tcon,
-			       const struct path *path, struct ksmbd_file *fp)
+			       const struct path *path, struct ksmbd_file *fp,
+			       struct kstat *stat)
 {
 	struct xattr_dos_attrib da = {};
 	bool store_dos_attrs = test_share_config_flag(tcon->share_conf,
@@ -3879,7 +3883,8 @@ static void smb2_update_xattrs(struct ksmbd_tree_connect *tcon,
 			 * or compression updates. Fall back to using a non-zero stored time
 			 * for backwards compatibility.
 			 */
-			if ((da.flags & XATTR_DOSINFO_CREATE_TIME) || da.create_time > 0)
+			if (!(stat->result_mask & STATX_PTIME) &&
+			    ((da.flags & XATTR_DOSINFO_CREATE_TIME) || da.create_time > 0))
 				fp->create_time = da.create_time;
 			fp->itime = da.itime;
 		} else {
@@ -5505,7 +5510,9 @@ int smb2_open(struct ksmbd_work *work)
 	if (rc)
 		goto err_out1;
 
-	if (stat.result_mask & STATX_BTIME)
+	if (stat.result_mask & STATX_PTIME)
+		fp->create_time = ksmbd_UnixTimeToNT(stat.ptime);
+	else if (stat.result_mask & STATX_BTIME)
 		fp->create_time = ksmbd_UnixTimeToNT(stat.btime);
 	else
 		fp->create_time = ksmbd_UnixTimeToNT(stat.ctime);
@@ -5517,12 +5524,12 @@ int smb2_open(struct ksmbd_work *work)
 			cpu_to_le32(smb2_get_dos_mode(&stat, le32_to_cpu(req->FileAttributes)));
 
 	if (!created)
-		smb2_update_xattrs(tcon, &path, fp);
+		smb2_update_xattrs(tcon, &path, fp, &stat);
 	if (need_truncate && req->FileAttributes) {
 		dos_attr = le32_to_cpu(req->FileAttributes);
 		fp->f_ci->m_fattr =
 			cpu_to_le32(smb2_get_dos_mode(&stat, dos_attr));
-		smb2_new_xattrs(tcon, &path, fp);
+		smb2_new_xattrs(tcon, &path, fp, &stat);
 	}
 
 	ksmbd_vfs_update_compressed_fattr(path.dentry, &fp->f_ci->m_fattr);
@@ -5544,7 +5551,7 @@ int smb2_open(struct ksmbd_work *work)
 	}
 
 	if (created)
-		smb2_new_xattrs(tcon, &path, fp);
+		smb2_new_xattrs(tcon, &path, fp, &stat);
 
 	fp->create_action = cpu_to_le32(file_info);
 
@@ -8995,6 +9002,7 @@ static int set_file_basic_info(struct ksmbd_file *fp,
 	const struct mnt_idmap *idmap;
 	__le32 attrs_mask = FILE_ATTRIBUTE_DIRECTORY_LE |
 		FILE_ATTRIBUTE_COMPRESSED_LE;
+	bool ptime_saved = false;
 	s64 crtime, time;
 	int rc = 0;
 
@@ -9016,8 +9024,11 @@ static int set_file_basic_info(struct ksmbd_file *fp,
 		return rc;
 
 	crtime = (s64)le64_to_cpu(file_info->CreationTime);
-	if (crtime > 0)
+	if (crtime > 0) {
 		fp->create_time = crtime;
+		if (ksmbd_vfs_set_ptime(idmap, filp, crtime) == 0)
+			ptime_saved = true;
+	}
 
 	time = (s64)le64_to_cpu(file_info->LastAccessTime);
 	if (time > 0) {
@@ -9053,7 +9064,7 @@ static int set_file_basic_info(struct ksmbd_file *fp,
 	}
 
 	if (test_share_config_flag(share, KSMBD_SHARE_FLAG_STORE_DOS_ATTRS) &&
-	    (crtime > 0 || file_info->Attributes)) {
+	    ((!ptime_saved && crtime > 0) || file_info->Attributes)) {
 		struct xattr_dos_attrib da = {0};
 
 		rc = ksmbd_vfs_get_dos_attrib_xattr(idmap, fp->filp->f_path.dentry, &da);
@@ -9066,7 +9077,7 @@ static int set_file_basic_info(struct ksmbd_file *fp,
 		 * itime gets preserved when reading the xattr if already present
 		 * otherwise don't write it as it wasn't asked for by the client
 		 */
-		if (crtime > 0) {
+		if (!ptime_saved && crtime > 0) {
 			da.create_time = fp->create_time;
 			da.flags |= XATTR_DOSINFO_CREATE_TIME;
 		} else if (da.create_time > 0) {
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index da13f13f8980..63453f5d02b9 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -602,7 +602,8 @@ int ksmbd_vfs_getattr(const struct path *path, struct kstat *stat)
 {
 	int err;
 
-	err = vfs_getattr(path, stat, STATX_BASIC_STATS | STATX_BTIME,
+	err = vfs_getattr(path, stat,
+			STATX_BASIC_STATS | STATX_BTIME | STATX_PTIME,
 			AT_STATX_SYNC_AS_STAT);
 	if (err)
 		pr_err("getattr failed, err %d\n", err);
@@ -1909,12 +1910,14 @@ int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
 	};
 
 	rc = vfs_getattr(&path, ksmbd_kstat->kstat,
-			 STATX_BASIC_STATS | STATX_BTIME,
+			 STATX_BASIC_STATS | STATX_BTIME | STATX_PTIME,
 			 AT_STATX_SYNC_AS_STAT);
 	if (rc)
 		return rc;
 
-	if (ksmbd_kstat->kstat->result_mask & STATX_BTIME)
+	if (ksmbd_kstat->kstat->result_mask & STATX_PTIME)
+		time = ksmbd_UnixTimeToNT(ksmbd_kstat->kstat->ptime);
+	else if (ksmbd_kstat->kstat->result_mask & STATX_BTIME)
 		time = ksmbd_UnixTimeToNT(ksmbd_kstat->kstat->btime);
 	else
 		time = ksmbd_UnixTimeToNT(ksmbd_kstat->kstat->ctime);
@@ -1941,7 +1944,8 @@ int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
 			 * or compression updates. Fall back to using a non-zero stored time
 			 * for backwards compatibility.
 			 */
-			if ((da.flags & XATTR_DOSINFO_CREATE_TIME) || da.create_time > 0)
+			if (!(ksmbd_kstat->kstat->result_mask & STATX_PTIME) &&
+			    ((da.flags & XATTR_DOSINFO_CREATE_TIME) || da.create_time > 0))
 				ksmbd_kstat->create_time = da.create_time;
 		} else {
 			ksmbd_debug(VFS, "fail to load dos attribute.\n");
@@ -2524,3 +2528,34 @@ int ksmbd_vfs_set_compression_create(struct ksmbd_work *work,
 {
 	return __ksmbd_vfs_set_compression(work, fp, fmt, false);
 }
+
+/**
+ * ksmbd_vfs_set_ptime() - set provenance time on filesystem
+ * @idmap:	mount idmap
+ * @filp:	open file pointer
+ * @crtime:	creation time in NT time
+ *
+ * Return:	0 on success, otherwise error
+ */
+int ksmbd_vfs_set_ptime(const struct mnt_idmap *idmap, struct file *filp, u64 crtime)
+{
+	struct file_kattr fa = {
+		.fsx_valid = true,
+		.fsx_xflags = FS_XFLAG_PTIME,
+		.fsx_xflags_mask = FS_XFLAG_PTIME,
+		.fsx_ptime = ksmbd_NTtimeToUnix(cpu_to_le64(crtime)),
+	};
+	const struct cred *saved_cred;
+	int rc;
+
+	saved_cred = override_creds(filp->f_cred);
+	rc = mnt_want_write_file(filp);
+	if (rc)
+		goto out;
+
+	rc = vfs_fileattr_set(idmap, filp->f_path.dentry, &fa);
+	mnt_drop_write_file(filp);
+out:
+	revert_creds(saved_cred);
+	return rc;
+}
diff --git a/fs/smb/server/vfs.h b/fs/smb/server/vfs.h
index 21b0d29a3db0..5925d63841f2 100644
--- a/fs/smb/server/vfs.h
+++ b/fs/smb/server/vfs.h
@@ -187,4 +187,5 @@ int ksmbd_vfs_get_compression(struct ksmbd_file *fp, u16 *fmt);
 int ksmbd_vfs_set_compression(struct ksmbd_work *work, struct ksmbd_file *fp, u16 fmt);
 int ksmbd_vfs_set_compression_create(struct ksmbd_work *work,
 				     struct ksmbd_file *fp, u16 fmt);
+int ksmbd_vfs_set_ptime(const struct mnt_idmap *idmap, struct file *filp, u64 crtime);
 #endif /* __KSMBD_VFS_H__ */
-- 
2.56.0

