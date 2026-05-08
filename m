Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE7C37C921
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778225386; cv=none; b=NRcNmnsGlp9QgDcCZ04LMZy8LPGpOZWRNLyP+lh0fs069wIN2BC6DWprojHcKxKBH4jMUSJMWv+ARZ/w/ASwl6Pe3RKHGkD7mC/lf+TuQf6tWqaHPCsNzFqbZURbSn5iBjIY/7aMcO6ACmbUKypJzJd15iuF8NMs4Wr4HFgUuiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778225386; c=relaxed/simple;
	bh=ZgrXGqpaDT/J0urZZBGJCBmmlHto5IvLWqZnYCnml38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+d8/LYcnFeclhWOSvhHHSWBP/u8CdZEawFI5SBcOW5WspkhKdkeAQhDXEnYZXcWmizeXtgyVfbfhR8Bg0kfnO7P+VzFU0F/1BjVKMqCH/I9icFU4lD6lu5ySne89CqIznp8rWvtvjNgt0qc1CgJ536CdMYmVOwZuERFS3wRaRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcVrs3p+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcVrs3p+"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ba17c8cfacso17157105ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2026 00:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778225381; x=1778830181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sGrET6MfLhRsKAL/g+VL/AvixebTV1us/He7UBP6No=;
        b=KcVrs3p+Jxbp5Gfp1WNs3/1mFstCczFytmXFszqw3B/++s45NBZ/j4whTSMArqzTTU
         GqEAqJEf6XCpOqxgbuObKzK+Dssz095nqvU94RzleSK2QAwuZQtCyzl7hzHJ13Uz3XPZ
         Cfv1dN5Ko0+BQfzl6Mw3kulWLDk46KQAbivVCc5rH28AxZ9umQJRPpDAxtmzA5vsEWNm
         fU+i2MesHmBnMIYyNAMBPXnmSPDW7iw9I5tnTMuu/eCmsx1EYm1y8Yo+mfg3fzOi7+bE
         n78iEl+lOliZSp9VLr4SCjeIOmy6xFpnWytsv8HV1E2TT4r7MQF8vyGpkePhyNubxxg/
         JXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778225381; x=1778830181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1sGrET6MfLhRsKAL/g+VL/AvixebTV1us/He7UBP6No=;
        b=BgnBHDFXycbHTg5CrtiExe4jUoiF6hgPkm65uYPPMFfFbizKldmtXReZdNHtSIUx5W
         C7Mo0f68fW7r8Eh7U6Vd0DrKijDdvdQch19y0Ys2KpPEEKSPFpJRwKsY99biw9C8Jj6b
         EPotkEaZaBkl6ruIYQKaE/Q2/hVv7PPg7ipX5Tm0yMAlN7j2VFrAvUG11Z1yODEA2l+C
         EblS2MwrOvLowbHDExHZdo8djVow5cgFJ+lzQSLFadxdF/fqwz4tE5pa0ranBaRxCoN/
         0cUuBqibWgg6r5AX3NuNzntB9ivrYElWZ/8v9+6t2dK/iKCVCe6yJQ7lajan6eKLZjXR
         Ri2w==
X-Gm-Message-State: AOJu0Yws6c6M59MW3OrmDhLA8Tul+00rk1Z742/rMmNx53jhFI83j6kJ
	4H9wf40GLIt2nK2kmqthAjFZhOq5RPl/5T5oZ5rUSvXqNAkWZWPv88qy
X-Gm-Gg: Acq92OGY2llL9c9jGIKYXSJ4/T6dumomagu7FnWTWtNlgUI6ehCNWOnSo1OSiN5gv4Y
	B+u5OpgEp52bdX3kAi9tdcfvBCfKbzZ1F57sHAwK1eO3fpwWG5OWU2oHcBm34XNXPJ4IMU3T71j
	yIrDm4HRFecakM6we9+jtNndHn4LRwnmGZ5TPYWDK1XOJd8YjDDW5kj+3cNlcgZD8g3E6cCa0uY
	d022fGet+0K2047A27EP4QcaA/mWp1o+Nl51AwBJCQLp4VxJTxOHXOy+rSmS06IfHGxdfSjeI6q
	5/E3kwnPthnwSm0K25t8FXgDCNeMZpwjVasZ8KAKBA0r323aWtk2TnHZmZBY0Xw2+s6xkGLSofc
	Gak2ye8S8GymN3Pv85UpRimnybFGTb2IKQrDgQ+9QKKn1i/FMSHkOeAEkRoiTeN/LtGT6r/dnMk
	w+4XkH7/+H1RoBbQG5XGJ1S8vHDtQQuhPTjWOAvZ1LQEm8jZaNIe8XK7fgAQ==
X-Received: by 2002:a17:903:2f07:b0:2b2:4fcc:2687 with SMTP id d9443c01a7336-2ba79bf5da9mr125351735ad.31.1778225380496;
        Fri, 08 May 2026 00:29:40 -0700 (PDT)
Received: from DESKTOP-MOQC9AF.mioffice.cn ([43.224.245.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e35632sm12053365ad.53.2026.05.08.00.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 00:29:40 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: [PATCH v2] ntfs: fix missing kstrdup() error check in ntfs_write_volume_label()
Date: Fri,  8 May 2026 15:29:34 +0800
Message-ID: <20260508072934.75939-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANFS6bYFbn_z7f3Maxze0GsZbsHnV7kS=q-gLw0U3Bwf+75s_g@mail.gmail.com>
References: <CANFS6bYFbn_z7f3Maxze0GsZbsHnV7kS=q-gLw0U3Bwf+75s_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_write_volume_label() does not check the return value of
kstrdup().  If the allocation fails, vol->volume_label is set to
NULL while the function returns success.  A subsequent
FS_IOC_GETFSLABEL then returns an empty string even though the
on-disk label was updated correctly.

Fix by allocating the new label before taking vol_ni->mrec_lock and
updating any on-disk metadata, so an -ENOMEM from kstrdup() leaves
both the in-memory and on-disk labels untouched and consistent.  On
success the preallocated copy replaces the old vol->volume_label.
Also move mark_inode_dirty_sync() into the success path so that it
is not called when no metadata was actually modified.

Fixes: 6251f0b0de7d ("ntfs: update super block operations")
Suggested-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 fs/ntfs/super.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 22dc7865eca7..ba99c497ee38 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -413,6 +413,7 @@ int ntfs_write_volume_label(struct ntfs_volume *vol, char *label)
 {
 	struct ntfs_inode *vol_ni = NTFS_I(vol->vol_ino);
 	struct ntfs_attr_search_ctx *ctx;
+	char *new_label;
 	__le16 *uname;
 	int uname_len, ret;
 
@@ -425,7 +426,7 @@ int ntfs_write_volume_label(struct ntfs_volume *vol, char *label)
 		return uname_len;
 	}
 
-	if (uname_len  > NTFS_MAX_LABEL_LEN) {
+	if (uname_len > NTFS_MAX_LABEL_LEN) {
 		ntfs_error(vol->sb,
 			   "Volume label is too long (max %d characters).",
 			   NTFS_MAX_LABEL_LEN);
@@ -433,11 +434,22 @@ int ntfs_write_volume_label(struct ntfs_volume *vol, char *label)
 		return -EINVAL;
 	}
 
+	/*
+	 * Allocate the in-memory label copy up front. If kstrdup() fails we
+	 * bail out before touching on-disk metadata, so the in-memory label
+	 * and the on-disk label stay in sync.
+	 */
+	new_label = kstrdup(label, GFP_KERNEL);
+	if (!new_label) {
+		kvfree(uname);
+		return -ENOMEM;
+	}
+
 	mutex_lock(&vol_ni->mrec_lock);
 	ctx = ntfs_attr_get_search_ctx(vol_ni, NULL);
 	if (!ctx) {
 		ret = -ENOMEM;
-		goto  out;
+		goto out;
 	}
 
 	if (!ntfs_attr_lookup(AT_VOLUME_NAME, NULL, 0, 0, 0, NULL, 0,
@@ -450,12 +462,14 @@ int ntfs_write_volume_label(struct ntfs_volume *vol, char *label)
 out:
 	mutex_unlock(&vol_ni->mrec_lock);
 	kvfree(uname);
-	mark_inode_dirty_sync(vol->vol_ino);
 
 	if (ret >= 0) {
 		kfree(vol->volume_label);
-		vol->volume_label = kstrdup(label, GFP_KERNEL);
+		vol->volume_label = new_label;
+		mark_inode_dirty_sync(vol->vol_ino);
 		ret = 0;
+	} else {
+		kfree(new_label);
 	}
 	return ret;
 }
-- 
2.43.0

