Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83333A63F2
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jul 2026 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783859066; cv=none; b=M39ANkgDMbMLdh6POkcm8GT+j3QqeJngTgMSbmO3dLgdX58S5Ih8Tm+4NvfoBA478EsQQj8SEPccAbDHGbutzDglRfA+LQZLD15wNO+fCOr7Dac+OLnUYF3gqPw6Tth3wfA4j5o46gK5VvnomFyKISKjZgwpdGErYpAhxa9qrfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783859066; c=relaxed/simple;
	bh=KFEh1PHZXjZn5B6U/ju5cvbBd+QnU5QCQZZjOyrckbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WETpFzteXhZ0FbLvVb1EGYdGiS7q1BkzC0anJ6nEvP3r2CVJhGbGEl+oGlwOh5p7IpUx4vee+QQA/jluxqCnpbI1fHPcszJ46SXkmRx4nVFvUISl4o8V7VGaB3c/rPEaYMBBY1TGtCGmTu+YhNhQMZxeOOgkP0acuCfeFDyngLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpkoVoly; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpkoVoly"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69c7ab350e9so896075a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jul 2026 05:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783859063; x=1784463863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eQ1JDM66k0TFLHCRuDdKDddxOWaCzRzzijLyXFQufg4=;
        b=QpkoVolyniTWkaDuAt7T9/0+n8ZcJ8IRDcLufcS8tH4izuhFKr4lY9r4LyEB9QZp8R
         d2oSA0+U7DzMsr0/PBqoT4pLIu2rQiGzhx+531RvKrhNngFVD7atpgQZe9/r4S8eqS1K
         LTDjOKOBup2GSGqVs++gHb4C9GnLM9zLxg1OQNtlnR4hMBpYTAvM119E9p8t9PFy9VGS
         FEtK/UTtdlZCULpKfx4UT7a33xzFooWnJq4ptBt7Jm0HXZtqx3Vs9VTzbMlNDq+ZXRSP
         G0RTyOQVwSEKs2HrnBHQ3LnnkgWMvbAtLcahr1tE+nfzs0Pp6gu6gPAuyO2ilL5Vh1SZ
         biCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783859063; x=1784463863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eQ1JDM66k0TFLHCRuDdKDddxOWaCzRzzijLyXFQufg4=;
        b=ZgSXebB5FTkweZCD1zXhCk8uJWdtSthUtsCIhlT4m73I7kb6GMNrQol0EBN4hTj+KM
         kNI8AaKWRPEl3dKgMorigXchy5N7xnaRF0e16d+76EK1a25mVNmp17zy9zm3+cNcHhBT
         Aqai84/Azju2bQDlKV8gKbvEpXmvMZJc3TgrHqbOOJOmImM0DKgfKhMlBJhdYC+37I3h
         3rS/rKfU6LXPduzIGgRo3JRvkRtLOA/z3ey01QZwFK2OXuiWPyZ14nXEzcgu0NKakg4J
         UjmeB3bE5dD2xF+Spb3pWLybF75LXQ5wXgfzXbALxhwrPH33PvZlI11lNUa+ooSdIcn6
         8hPQ==
X-Forwarded-Encrypted: i=1; AHgh+RphxO6GjH3TU/coOZCUYViHmd+mI9FTgavq4ZbVod1y2Pqwl2tATDDwZ5baMSlto0OxllkS4fNvL6xix2YK@vger.kernel.org
X-Gm-Message-State: AOJu0YyYJCZzIaUxf0kprPnII4W9Mgg004urw4Gbw8L3pFFXkik8Lz62
	oksaV4LqOFkiJ4stWFEkItTqzzkjgz/xeWpR2fsvRRb0/ze9VadEaaQS
X-Gm-Gg: AfdE7clSmFbLdjmii7jlQ3pHwXUXjhZ+0hvKtF+z6SKcyJ8VgE4B8Xrc4XivFPW2brA
	dcpFo8DnIcqmpHzFiQy5dsuChmnLT/PMWBHdK+nWMJXgoDBitxHCHozUqvbpCerbulMImCHnLnm
	4iwkFHdUqvtAe9xLp845TRCMHnxFNpsKx7Ios99HI2m+NUy5ZSMXcVlxrD7q7WfbD5/3keqCg4c
	EwA7DsmsmDwmIHJzjMnvgSy6lfl1UnSQy/jjlaAd0CbbWUCAjNn2Drmytr27e4LaxotFcbm/moa
	5VrmvYaxLT7LT58n5WA8EvHV5iZw2OBgkcRplkXi7iL61iJD0J0WGi97RYNRz4cyc7j3nmqFH2h
	SvMC+FplAlCD60nc7az0nMY1HLt1WMQPk+8WgcQwK95Yvuwdjwk01LzEXUhvcKK41ancejlUM8Y
	hMkvfIXVlHwzTVWsqLipJY7JWm5/1BxjJx7oLTLQ==
X-Received: by 2002:a05:6402:2346:b0:69a:a827:7483 with SMTP id 4fb4d7f45d1cf-69c5f0eae44mr2448709a12.25.1783859062731;
        Sun, 12 Jul 2026 05:24:22 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69aa6dba523sm8106061a12.0.2026.07.12.05.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 05:24:22 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] ovl: check access to copy_file_range source with src mounter creds
Date: Sun, 12 Jul 2026 14:24:21 +0200
Message-ID: <20260712122421.203113-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5dae222a5ff0c ("vfs: allow copy_file_range to copy across devices")
allowed filesystems that implement the copy_file_range() f_op to decide
if they want to access cross-sb copy from/to the same fs type.

The same commit added checks to verify same sb copy for filesystems that
implement ->copy_file_range() and do not support cross-sb copy at the
time, namely, to ceph, fuse and nfs.

The two remaining fs which implement ->copy_file_range(), cifs and
overlayfs started to support cross-sb copy from this time.

While overlayfs does support cross-sb copy when the two underlying files
are on the same base fs, the copy operation on the two real files from
two different overalyfs filesystems is performed with the mounter
creds of the destination overlayfs and the read permission access hook
for the source file was called with the wrong creds.

This could cause either deny of access to copy which would otherwise be
allowed (e.g. with splice) or allow read access to file which would
otherwise be denied.

Fix the latter case by explicitly verifying read access to source file
with the source overlayfs mounter creds.

The former case remains a quirk of cross-sb overlayfs copy, but
userspace could fall back to regular copy so no harm done.

Fixes: 5dae222a5ff0c ("vfs: allow copy_file_range to copy across devices")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Christian,

I am no longer surprised finding more things that are wrong with
copy_file_range().

I have a feeling this is not the last time either.

Thanks,
Amir.

 fs/overlayfs/file.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 27cc07738f33b..f3d97eb146e85 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -528,6 +528,7 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 			    struct file *file_out, loff_t pos_out,
 			    loff_t len, unsigned int flags, enum ovl_copyop op)
 {
+	struct inode *inode_in = file_inode(file_in);
 	struct inode *inode_out = file_inode(file_out);
 	struct file *realfile_in, *realfile_out;
 	loff_t ret;
@@ -551,7 +552,20 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 	if (IS_ERR(realfile_in))
 		goto out_unlock;
 
-	with_ovl_creds(file_inode(file_out)->i_sb) {
+	/*
+	 * For cross-sb copy, vfs_copy_file_range() will verify read access with
+	 * the mounter creds of the dest fs mounter, so we need to explicitly
+	 * verify read access with the source mounter creds.
+	 */
+	if (unlikely(inode_in->i_sb != inode_out->i_sb)) {
+		with_ovl_creds(inode_in->i_sb) {
+			ret = rw_verify_area(READ, realfile_in, &pos_in, len);
+			if (unlikely(ret))
+				goto out_unlock;
+		}
+	}
+
+	with_ovl_creds(inode_out->i_sb) {
 		switch (op) {
 		case OVL_COPY:
 			ret = vfs_copy_file_range(realfile_in, pos_in,
-- 
2.54.0

