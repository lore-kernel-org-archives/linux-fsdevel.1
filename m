Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11CD421255
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 07:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790233686; cv=none; b=UY2UMlnasW8J4OEl3TmwTqj4QlfHAoPoTxaYKHxBVQ2ln/FIfDzoO1fQFvynBDaMh6Fjy3LmD/2N3BdynoBMOidp9IRARGTz5AItCY/QseZDoyDWI55lkDXQos3u/rtjYzydjvUdmjh72S5CxAFDdExuEBFs9NX15VEyOZ+5CtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790233686; c=relaxed/simple;
	bh=vcPUZbFrBI9CL60zx721prFO1FCW3vFMLr0evu9pNyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UG0qfSPgk40EabH3u+K8ytAljI/jZHKoa2g03H9boGRTO/6FVIF6ar2AtMnqhwAtYrowX+yCvKIafXk+pq+XLg/VZ18jMH2r2WYFCp9b5o66EdH9NEcLuN0q2Y0XPuJpiZHkqBTvQwh8jnoolm31aKipLrsPVO6Re1o5cjCFxwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rjsiEF9J; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjsiEF9J"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db18fe459dso7366205ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 00:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790233679; x=1790838479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A5R0eORI8KBwokh6UjkxTkUhIY7LnGT/YgU3s5d7Wnk=;
        b=rjsiEF9JoDc8Xmw2s7hjfQwfQTHYDY9krWnuwLiU7m4ZQvdg0pnsjLM3z0nKUoYkDI
         r+Jjb+FY5JTts1ZVscxfj/ubs2CTHbjXNhtIzsllBw8DpOOGPtQ/bUyXzYyOK4MeTktC
         DLsu9kE/1bXISxdCgpbFalxuKXkYMGcoUq/dZL0rzP1wuuizNv2zeQIoMXB2ZTijOg4u
         uiVew1fShdhz5q2w8BrLCAaRbohaIsZDHbU+1VeQrAqMckq5iqHPYRRmIayQC87j02hI
         IWwQODcLQ8KgTNkEGeWhLrWg7lc7aCegkCx9EQy5tQfEk8MzXCsROK5FOJO3sZ6gWAjd
         p3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790233679; x=1790838479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A5R0eORI8KBwokh6UjkxTkUhIY7LnGT/YgU3s5d7Wnk=;
        b=Kf3DTL980E+b8APZBq42nh/kWQpzsjOHYq09ifIUlEy+eMIVRu03shKaoSiYyYdGx7
         /BpfbWBln6Gs842JyuXiOpotSnEpCzc5xHm41s7/wBX71NXZuADMt1o9syJ3Qi7yMbP4
         mOw2TdD+dRhuLqy7hDZF3Pa8eP/3RdYCXjvG0uGjIBsTdit0p6bk4cShr2OFMCJwmf/7
         4q4/F9kMIyQf1FU71WFxX3uWa5qYRlZ5EVB0VhsrFOHbwO67QItVlUBbYJxB0k4XTAcM
         xhNmhk3TZs8oGo6qiKzafBxSvRQuyM+Ha9X4rc3+eM+VvEh5hbRxYCMxqgLoN1e+QVew
         WXGw==
X-Gm-Message-State: AFuF++npwIndhW4vFeJM8um5jjUUJVJCPn152FDOMCk805mCvzkKXFRJ
	b+ACj4UsTciVQCPysScKHS4F+tCQrESYtUN/Y/iXZSAzjdwZcbYOhjoo
X-Gm-Gg: AYBFou170/zX+6+viFCJMMvpvUPV+FpYh1yck1ZqY4OJq/OVnV3KMQ0IL3+3XX51SFZ
	wyG+aO+CtAlQnp+yD0t5VGxJdvD5fxn3dtYtATLOYIa8mnFw5JutvYHzY5gskmQIb+iOaESr/MA
	ir2je3FFqavMPFg5VEtYm9ypbkOcooTkHS7VLChZXZfprxaO8DdH9t4byOTQ7wmRn1sF7YtvL2Q
	0hBfj04xWh+k5id7sXUZaERttlDbTawJZUsHWBLb48cPn73Bd2LY2s0tHEFu2t5sQLwkLEAeFMi
	FrlGO2t8P6WZ5GHLsbqy/Odz0vRmxroPgMUFb64GQeMIt1opTQaNYNFh4NN7O9vyl351dg0pFdz
	m+vVyM9hvCvGjGtxo7O5DWhFGdirP9kIgwZprDaULpsNAocHVtwVN+DdpkqOFM1qff2UtrSCN8B
	hQR9/I/o1Q2oTAKHjQ2xoHZd/+geVwMtj4ZnfCP9fSFmOEsVvMFZ4yiACvELjWyf4idX+go38nK
	XfegNczRtKGk0s3BTIK4BpsjvQP1rtnDGeW0svHNHfxKzQY5JtfzfsSJVIONM3+hVE0jX0WK8uk
	02mZ5W/sfA==
X-Received: by 2002:a17:903:94e:b0:2dd:4f83:eef9 with SMTP id d9443c01a7336-2df7da60be9mr14149235ad.4.1790233678960;
        Thu, 24 Sep 2026 00:07:58 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6afc80easm21832025ad.30.2026.09.24.00.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:07:58 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v2] hfsplus: validate inline xattr record size against entrylength
Date: Thu, 24 Sep 2026 07:07:57 +0000
Message-ID: <20260924070757.2646279-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In __hfsplus_getxattr(), record_length is read from the on-disk
hfsplus_attr_inline_data header and only checked against
HFSPLUS_MAX_INLINE_DATA_SIZE without verifying that fd.entrylength is
large enough to hold the inline header and record_length bytes of
raw_bytes. A corrupted attribute B-tree node where record_length exceeds
fd.entrylength causes hfs_bnode_read() to read past the end of the B-tree
record (and potentially across the bnode boundary).

Validate fd.entrylength before reading xattr_record_type, length, and
raw_bytes.

Tested in QEMU against Linux 7.3.0-rc3 by mounting a crafted HFS+ image
containing an inline xattr record where record_length (100) exceeded
fd.entrylength (4): on the unfixed kernel, __hfsplus_getxattr() read past
the end of the B-tree record; whereas with this fix applied,
__hfsplus_getxattr() rejects the malformed record with "invalid xattr
record size" (-EIO).

Fixes: 127e5f5ae51e ("hfsplus: rework functionality of getting, setting and deleting of extended attributes")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Drop the hidden_dir cleanup hunk (already covered by Deepanshu
  Kartikey's patch series) and focus solely on the __hfsplus_getxattr()
  entrylength validation, as requested by Viacheslav Dubeyko.

 fs/hfsplus/xattr.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 21a1c196c71f..10aae766ea42 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -649,15 +649,28 @@ ssize_t __hfsplus_getxattr(struct inode *inode, const char *name,
 		goto out;
 	}
 
+	if (fd.entrylength < sizeof(xattr_record_type)) {
+		pr_err("invalid xattr record size\n");
+		res = -EIO;
+		goto out;
+	}
 	hfs_bnode_read(fd.bnode, &xattr_record_type,
 			fd.entryoffset, sizeof(xattr_record_type));
 	record_type = be32_to_cpu(xattr_record_type);
 	if (record_type == HFSPLUS_ATTR_INLINE_DATA) {
+		if (fd.entrylength < offsetof(struct hfsplus_attr_inline_data,
+					      raw_bytes)) {
+			pr_err("invalid xattr record size\n");
+			res = -EIO;
+			goto out;
+		}
 		record_length = hfs_bnode_read_u16(fd.bnode,
 				fd.entryoffset +
 				offsetof(struct hfsplus_attr_inline_data,
 				length));
-		if (record_length > HFSPLUS_MAX_INLINE_DATA_SIZE) {
+		if (record_length > HFSPLUS_MAX_INLINE_DATA_SIZE ||
+		    offsetof(struct hfsplus_attr_inline_data, raw_bytes) +
+		    record_length > fd.entrylength) {
 			pr_err("invalid xattr record size\n");
 			res = -EIO;
 			goto out;
-- 
2.55.0.1082.g2b9226bbc0-goog
