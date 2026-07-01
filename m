Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2EA412289
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 22:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782943662; cv=none; b=K9sLgkVsquCv+GpFN1sLgZUb8qmrk3Hi1nEDKHlN3SbY+bGBtY+AWQenvyqBExEyGgG7LwQcS2tt/ryvZ/Z3biZ7G+35lbxSiGn8kizbLeVggTCUux7Fvp+EUx42JbNkLg/nVx+UN7GIeR4+QPMLAPOfeniERyMLJb6SaILz9aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782943662; c=relaxed/simple;
	bh=AJcvxrjgFC/vzLLX5SpDA1f1GuEyqQdgHyLo32ybmW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=leDF+rkdr5dMVZq28EpIP+wLlRalAil0AsfTAs+nUPPR9fSBgrf9c6qRnVL9/g9Mtg/1av+mJY9nBnM5nIz/XU0G/RNN/V+VOBtmGamSc+1UqVGb/tVAbHAlIaCRPOfgIG83oZGZQ//dxokvmADnif5W+kJ49yly95bmHG7174k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oy1pjo9Y; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oy1pjo9Y"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-845ea8924a2so702430b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 15:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782943653; x=1783548453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AtXiHxBOWtzv91/tPtTE+82KTENG8TullCuPYV97qQ4=;
        b=oy1pjo9Yz62Jn34veTzC9iLJh7KjxLi0B2IfkUPCLVI9NAuMEnoy8FkWYonY9U3iJl
         RXj4lstajnBwivDkeu+t/T6LjyqLFCt9U8euvXLo0PHwhKX0smtEzIJK6VoPshsrzDtH
         QSPL5kbi5PHH3ouE+4Ni+KJQ95qliMV0zuEL/0AAiSYV9bNQBgq4McLqnGVAMJCdltDE
         5+RfXfjA2GWMy+Hw+6CDJeMhof1fDRpuCKCfS9Di3nGXJSDoR6XB1CBdJREOu1E16PQ3
         wzqdOHUm7AelNC0+q5KskTKC1icM/qKZXNedfujqZ6yC1XPQwzE5YV6OIESlYdX471wr
         1Xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782943653; x=1783548453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtXiHxBOWtzv91/tPtTE+82KTENG8TullCuPYV97qQ4=;
        b=kPb+o3ovhEEUAuVmpNFNifZmgvnl4QYoc369LlfUEx5KlEtRd/WdBF9N9/PmnK/p22
         kjZmQVE/OIs+9ikWS1IR6Y+vV0rowQysOeFo6wLg/04WAHpAie8eOkhIUyFV/R3GvmQ0
         ZPwIF+wfDgncyZcEeyRRRBKztMBFt5fVbln09E63zP3UvIcK+z7xC1V9g+QWbg/q5sQs
         CYc47lRP8LvfrQ2zhzFtsCnchQPY031JgMdWMcxqSF+PQIfNH4V3tzCUBb+RubcoFV0B
         wrA/XJ4+TWHT2njBr7WQXZTYYx0d1EUwQcmrguFa4/P22HVU8LdWR7rIAicK98RqJu2b
         oFzA==
X-Forwarded-Encrypted: i=1; AHgh+Rr3qa01ahWLJrkcEsmkmz7mgVEmZSr2wgrNN+/rg8fVIZYCHlxUWUPO3KDt4DGhOTSNjwDvOvWHbajDQK2L@vger.kernel.org
X-Gm-Message-State: AOJu0YwF7xvVBNpnN/9zkzi5EKyZO2vOuHf2yDRpnIYL0tl6BFimAmqS
	NgEjOBp82Z/dtn7iRSWwxzXBHd8uoP8ZFYUduXBDOUxczRAHdprI8IgPgqBtehSv
X-Gm-Gg: AfdE7clEbpkM6z7kI1cy6zwYJ1xlsA5TF9BKU1RUph3abCEmMtmop+lsul/eFsIRD0z
	TqcZC/Zb9V2DvW47RM/K3UunZh+B0czVVdJU8LoN/2mX6PdEdPkfPdEb1jwS3qkegSFHb26OnV3
	cCM222QFXm3xBXkIhDOokwIAXsp8b5iTS7tEYNofFvfOk71SG6jX0QWX7wIz+Ce2cA3j+ysWFMZ
	Ji1HwueoAVHi8JG17Ym6CntBZEzGlaO6J4oe6TN+vudAFn+pGVNoIB0a7BQNbZ9Te8hIrI16QcM
	sg1tTDGB7d8P5PJCpvsBnb3QGu48Riwcxu71tJil2QbZy4yCQLKPo0H6c8eTv9zXyFapWGLoyop
	SaOX9lbx1chG16HkJZceRuHiKaffDVv6q9iMAVOmTmrUOHliCBeCUP1GKRW/4NJXV/UlYABEyWd
	JCHiWBRPyZqnBLqJmJPUbnK5QNUMVTnInzC0nB7W1mgIN4iojjAnxLLrjPkrb5I84=
X-Received: by 2002:a05:6a00:4ac7:b0:847:9e62:251 with SMTP id d2e1a72fcca58-847c09ca681mr3305708b3a.54.1782943652943;
        Wed, 01 Jul 2026 15:07:32 -0700 (PDT)
Received: from DESKTOP-L3Q0GIV.localdomain ([203.230.195.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb78d69csm390395b3a.25.2026.07.01.15.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 15:07:32 -0700 (PDT)
From: =?UTF-8?q?=EC=9D=B4=EC=83=81=ED=98=B8?= <kudo3228@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?=EC=9D=B4=EC=83=81=ED=98=B8?= <kudo3228@gmail.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] romfs: detect hard link cycles
Date: Thu,  2 Jul 2026 07:07:29 +0900
Message-ID: <20260701220729.822112-1-kudo3228@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

romfs_iget() follows on-disk hard link entries until it reaches a non-hard
link inode:

	pos = be32_to_cpu(ri.spec) & ROMFH_MASK;

The target position is image-controlled, and the loop does not detect
cycles. A crafted romfs image can make the root inode a hard link. The hard
link can point back to itself and leave mount(2) spinning in the kernel.

Reject excessive hard link indirection with -ELOOP. Normal romfs images do
not need long hard link chains. This bounds corrupted-image traversal.
Propagate romfs_iget() errors from lookup because hard link traversal can
now fail with -ELOOP.

Signed-off-by: 이상호 <kudo3228@gmail.com>
---
 fs/romfs/super.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index 794a6051d0b5..2d42f7f95260 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -240,6 +240,8 @@ static struct dentry *romfs_lookup(struct inode *dir, struct dentry *dentry,
 			if ((be32_to_cpu(ri.next) & ROMFH_TYPE) == ROMFH_HRD)
 				offset = be32_to_cpu(ri.spec) & ROMFH_MASK;
 			inode = romfs_iget(dir->i_sb, offset);
+			if (IS_ERR(inode))
+				return ERR_CAST(inode);
 			break;
 		}
 
@@ -262,6 +262,8 @@ static const struct inode_operations romfs_dir_inode_operations = {
 	.lookup		= romfs_lookup,
 };
 
+#define ROMFS_MAX_HARDLINK_DEPTH 64
+
 /*
  * get a romfs inode based on its position in the image (which doubles as the
  * inode number)
@@ -274,6 +276,7 @@ static struct inode *romfs_iget(struct super_block *sb, unsigned long pos)
 	struct inode *i;
 	unsigned long nlen;
 	unsigned nextfh;
+	unsigned int depth = 0;
 	int ret;
 	umode_t mode;
 
@@ -289,6 +292,9 @@ static struct inode *romfs_iget(struct super_block *sb, unsigned long pos)
 		if ((nextfh & ROMFH_TYPE) != ROMFH_HRD)
 			break;
 
+		if (++depth > ROMFS_MAX_HARDLINK_DEPTH)
+			return ERR_PTR(-ELOOP);
+
 		pos = be32_to_cpu(ri.spec) & ROMFH_MASK;
 	}
 
-- 
2.43.0
