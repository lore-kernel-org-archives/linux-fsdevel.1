Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DA43A7F7A
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781281276; cv=none; b=NkQyWBiLis1RRPVCjdS/WEdHa6QeLtmLvcwOyzN3BBGCLm0GUDB56mAy/b893U9ej3/JEoj/kz5YI3dIuNM3Zbk1GDnZczJJhoAEPt5X94xz+x3tZCgyFFpTyOQyvxNvhdq/BDOy133IB4XNGT3O0RI3v+XOpJgwWgJA6qxm2VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781281276; c=relaxed/simple;
	bh=389ZRsl6oAV6U69C4rhBAu5KlNKEA5xSCzZTIbr1aZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u2jNArHRgngvTsoXNb8o5kQvJQ3sEbkDkQw125oO3uub62qtpvw0njbWorugdnaz2mYk4L4BDBSBqxmwGK/QIpvisjzbyOn757sjr6g4UrVrGFdUQlBZQcVCTOZMc6G+OEpTwRRsPqpFA+9VrPLlxGyogiqycavEYCg/QOCWoG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YR9TQngW; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YR9TQngW"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso14008975e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 09:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781281269; x=1781886069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xDOccp5+lRvv1suHq8/ojoYasAfDQKeRBKLjPPl/9pM=;
        b=YR9TQngWpA6NidOFtC9WZyNIOj3mX308cwzjnNK7X15BHmj6XhTogOSBLcffjETLBJ
         d0mSNoUcsfWYBB6nJGpLlrbFAyqJ7aN2191jVy15cqqAPAe4CVF7jhrhLi56RVUrGR36
         sj9/Fph9J5m1cWDoweP2DegdFjmYhvkLyBttJob8Trv8wHltiRhVgymOLGh24C7NhGXa
         +EbedRyi9YTCYachzDdOBIFDCUPwyglgHiwJFn46yKeIl+/tULoDAz4me+SonsvSe3wQ
         bWCcmUy/nm5PWLQrFI+Ef/n+pxiW3FzN9CZ71ReSY4rHBx6Ws7M+pzjjOWXPRgtpbZOO
         rjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781281269; x=1781886069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDOccp5+lRvv1suHq8/ojoYasAfDQKeRBKLjPPl/9pM=;
        b=prhrQ2V3wjSfimFYxoTiIaGdljQVmM/1OJVIwJ1ILc3YhCsPH/neRQxZp1VAzzou09
         1EwH8cjPvUj3M/oPWpe7hUCuVP5CgtiAkqZ+26Fk3BU86hUz0/r7WIw3Zo3qJulONDFO
         Nacu9cL9Iqwsx8CuRXffvdPV1apMaxwAOhZTcLVisScSXHdnFdw++09lQ6AVCVUwfXvt
         uQxNv/D2XVuvbOy3X3R/7rmrqrgMV3QMMIIVkrGCxi+O3+xIA630lOdbGAbXIoMKHJuj
         tiEOsU6qe8LzyGZByHk3YgrkgZT7pCfUuFtyFUkyLxuhN+Jv5HLmgD/WTV5cT9mllL0C
         p99w==
X-Forwarded-Encrypted: i=1; AFNElJ9yOr3iUwU2FbOsmGAk9z1Xa7Q/qo5WffYKJZ8W4hIndDr3ai2l0cUGWzDZthd7HV+bvaYSyG23s4+nySQr@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+AG4lS4xJgzZzl7SlfTS8IbK9SOcTncLOFO8nAJAx6qy5ixuS
	99xV/xQaeDSyZAiJwpAT4sZbrS380ECOiqm7gjKfkTrZqjfj3pp7Y0pT
X-Gm-Gg: Acq92OH9QVwZGTlgqSZWVTKYRR8MmESD+OprdYILV4rYOkrzJOkyIOLYtl/SuwHzS2x
	ufhl29aXD1exr6n0UcYtNS35RlyIXS7f8MLpqOYPnG8oOY145gOUBsOK0R6EO10C2pqQeQmPKVi
	k7/f0vudY5TS0WBJ1fS/lIhD2cpFjqz2upQCKwE8mm4vMOxH8qlzPWoYuWsItAlrTaxkU34Yxyw
	P0R1yeNXi/TN/pEgI0iS8Q0LYcsWp1EnmEidEbmjBdnr+n8csI32EgmZbF+VBm4zJbiVkmDO772
	bzD0pXd0LLxa9S0WPbeBSTCx6dnr/XkYciwr1t1qqWyYqeHLVdc4QwuLfRepby1kpqIWxCvYuT8
	4thMhIO5RQ23z1WFjiRL4Hf0PqTcTVsnUcqhBfuUlCTjODYswPrD4G1L7d1mHLcq1ICpD+Pf8lM
	0IIyztNzjT2oheIggCekhmzAIYMrk913o650YJsD8jEFhYI+XcFyMQllZ0VX7rG7RT9FvJyOtCL
	lmyZo7JlEilQFzkMZ3S7GlBpSGSkZAGduVhrmNGcn+4eyqXWUer9GFPvTrdTakGKSLRo57v7hGT
	Yp8zKkF7Ag==
X-Received: by 2002:a05:600c:17d5:b0:490:b4e5:ce7e with SMTP id 5b1f17b1804b1-49220104e46mr950365e9.25.1781281268491;
        Fri, 12 Jun 2026 09:21:08 -0700 (PDT)
Received: from instance-20260604-012959.europe-west1-b.c.project-2c9d95d2-bf4e-4d5a-ac6.internal (250.69.76.34.bc.googleusercontent.com. [34.76.69.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea4a399fsm57899195e9.0.2026.06.12.09.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 09:21:08 -0700 (PDT)
From: David Maximiliano Hermitte <davemadmaxxx@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Maximiliano Hermitte <davemadmaxxx@gmail.com>
Subject: HFS syzbot BUG: test patch validating metadata before hfs_write_inode()
Date: Fri, 12 Jun 2026 16:20:43 +0000
Message-ID: <20260612162043.1524591-1-davemadmaxxx@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Slava,

I followed the direction you pointed out and tested a small HFS validation patch for the syzbot crash path.

This is not intended as a final upstream patch yet. I am sending it as a test patch to demonstrate the crash direction and to ask whether this is the right validation point. If the direction is correct, I would appreciate guidance on the preferred upstream placement and syntax before a formal submission.

My understanding is that the BUG() in hfs_write_inode() is the endpoint, not the root cause. This test patch keeps hfs_write_inode() intact and rejects corrupted HFS metadata earlier in hfs_read_inode() and hfs_brec_read().

Local QEMU result:

BEFORE_UNPATCHED:
- repro_started=true
- kernel_bug_seen=true
- verdict=BEFORE_BUG_REPRODUCED

AFTER_V04_PATCHED:
- repro_started=true
- clean_hfs_rejects=50
- kernel_bug=False
- oops=False
- kasan=False
- hfs_write_inode=False
- verdict=AFTER_REPRO_RAN_NO_BUG_SEEN

checkpatch.pl --strict:
- 0 errors, 0 warnings

The test patch is included below inline. Full QEMU serial logs are available if useful.

Please let me know whether this validation direction matches what you expect, or whether the fix should be placed differently.

Best regards,
David

--- test patch follows ---

diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index d56e47b..5f56cab 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -174,8 +174,10 @@ int hfs_brec_read(struct hfs_find_data *fd, void *rec, u32 rec_len)
 	res = hfs_brec_find(fd);
 	if (res)
 		return res;
+	if (fd->entryoffset < 0 || fd->entrylength <= 0)
+		return -EFSCORRUPTED;
 	if (fd->entrylength > rec_len)
-		return -EINVAL;
+		return -EFSCORRUPTED;
 	hfs_bnode_read(fd->bnode, rec, fd->entryoffset, fd->entrylength);
 	return 0;
 }
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 878535d..beefb47 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -369,6 +369,8 @@ static int hfs_read_inode(struct inode *inode, void *data)
 	rec = idata->rec;
 	switch (rec->type) {
 	case HFS_CDR_FIL:
+		if (be32_to_cpu(rec->file.FlNum) < HFS_FIRSTUSER_CNID)
+			return -EFSCORRUPTED;
 		if (!HFS_IS_RSRC(inode)) {
 			hfs_inode_read_fork(inode, rec->file.ExtRec, rec->file.LgLen,
 					    rec->file.PyLen, be16_to_cpu(rec->file.ClpSize));
@@ -390,6 +392,9 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		inode->i_mapping->a_ops = &hfs_aops;
 		break;
 	case HFS_CDR_DIR:
+		if (be32_to_cpu(rec->dir.DirID) < HFS_FIRSTUSER_CNID &&
+		    be32_to_cpu(rec->dir.DirID) != HFS_ROOT_CNID)
+			return -EFSCORRUPTED;
 		inode->i_ino = be32_to_cpu(rec->dir.DirID);
 		inode->i_size = be16_to_cpu(rec->dir.Val) + 2;
 		HFS_I(inode)->fs_blocks = 0;
