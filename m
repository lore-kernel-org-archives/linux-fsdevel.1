Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FC95437D9
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872518; cv=none; b=KWK0yZ/2y5OHsHViWO0326j73hMIEcUKxI9yy0fJQOXd3WAf4Ps5jZuUldE9rjN0nGZfX91ka+zSa1V+nAwgZ+uHuaWsPwsiqGGdBHWP40cYNyS5rwWeaJPn+zytUwWV7LJoSmzCa7vPYb2cmXV2zeIAMLLQmBmWfQuVeo6v1EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872518; c=relaxed/simple;
	bh=S8xSMk+w2F5fNvbcMETD0AQRzl8xsX8oOD3zp3IPPPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SqAvS4U6W5Z+zOSDbAEk2puRASR4u+EqNgzs2dUNO9a4KkW8MdPQcEjJgR0Sut8jguUBPsKZsBUWgjyrjpad1ux2G9htok+YURK5s/EVqIzorzwR6tO/D49UhhD7ycB/uptfBfhiylw2hyjN46txsrZNGNoyKJ3acIYOKcji9v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIkXB6JU; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIkXB6JU"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7f4f53975e6so4305971a34.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 06:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788872512; x=1789477312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KQ0AZMHFceXAUCBkuN/uvZQDFzZ5QbFgf4EreZWRdFs=;
        b=jIkXB6JUntQ4LQ3GxZnrJlgNinZAl2E5vNzI1DDR2VRCaWFBy+ExG+MCf4QJaVkohx
         ouCcjYxscwJiV86sG8JzopqmCRWVmWkR8Rj5lz3I20SY6HceUiGPlqzan2ROLCEdCnjE
         yd3flCdQ9i2x0efd8ko7Wgyz0/s/SIkpqh9nAWh3vXaPRF3hOl5iP4DZWCAoE45qjz5M
         gpoi3AHyduNrFYFTMrWNKR8MTuWMYMXdzlq9cjhtPvglyco105ciSQYlv5DQ6Hbxoo6y
         AsES2z/rh/ckwCIMXMDpJ/In8WddOZNsgiWbFHZKLaphOxCISOEB6yCoDnbygortmT0S
         rQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788872512; x=1789477312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KQ0AZMHFceXAUCBkuN/uvZQDFzZ5QbFgf4EreZWRdFs=;
        b=g+zta8b54FpxoY62MgE1E0ePJhhtEelzIOsJc8IlrhpVhHF8UDAkV2JCcvUMCrFhjR
         BLE947bANbzZae9uCAD+A6FMrs1Y8ICJQ6+oa6Vj5DrUCm7HprLTFE4ciCHZtETULcJd
         UggA/3EEt7jMchDkfTKEsY0eoWXn7B7yHWpD66Kk4xdrL4Dm0VhMOZoR/gstUhGjp0ON
         cWGnL+Ras8FsXh36CfdU8Db6+m8iBp1gfYADtm7e1jxRF9QapMuy1yBfPlZHQPappwE3
         piirPpSJ6v2pqTsn/Hu+Gt6s9f8/C5urVMOzhduaN8SJq+KbabJkg5Mxk7q5jkDVPkAI
         FfoQ==
X-Forwarded-Encrypted: i=1; AKwUvBy+9N144j9opYx/m1b1ZBaI8U7ottaB3wtqmwAriW9o+s1fsRg2AnT5KqeauPkOkxDYnUf4pCG2lLGZ0l//@vger.kernel.org
X-Gm-Message-State: AFuF++kXGE3oEX3dfINZ8Lm4o0GP9Jy8cqV2kGqjoPLpYpkN5TFsEma7
	87sfXwWgkpd5KM7s6L8tkuwKNa7PjWxoxgJaNN4Z/nz74MiTxfIhEajb/pNxPYMG
X-Gm-Gg: AYBFou1bqMNER7nUCGSGrIT2JUzuU/0SsGnNKcETaEwSA4M02d/HCKZu6c2NEDagWKX
	stiepCuq7V9w1OfcpUa63nHjPi10BFwxIqBxh7ieRzmANwpoMbwdAve/s+l8cfg07fi+yLJSxRG
	MTZfKWInh/8YfMSfa3ymjzdOkz/fYOi9Bz8VI8pLED8JDX+blFVTHh08ROqe6IxQDkkTlMLZTgD
	wVr6Ij3D9hEomfCnuGrj+dicsjvlGJbUj7FvAfK4+0Jo861iJXwnkq/b6Upx+YBx98ye45sh2sL
	tVV6t0nk4rgcOoSXhPHTBxaLI6Z+QMOC97CVfSp8nMssQXR3TgdAwEVJbmNV+LsWsGAaurznMZz
	T7bIAmDrH5ZOy2kAkdm0fIuf+Xr9Ejpq4TA0W2OxIIiYpo/k00WSS/6+9b3wM7PPvd6FWnhmybK
	Q75USj+F5eydJhNSeNz9asWhULWXN8A8aY3IVxzc3MT3mxBKOwXO+YpjXIAusSU3y7rkEP
X-Received: by 2002:a05:6a00:853:b0:857:726d:2707 with SMTP id d2e1a72fcca58-8616c549f8emr41960280b3a.19.1788872476115;
        Tue, 08 Sep 2026 06:01:16 -0700 (PDT)
Received: from Lenovo-raylee.lan ([219.142.227.218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86154048df2sm5674696b3a.61.2026.09.08.06.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 06:01:15 -0700 (PDT)
From: Ray Lee <hburaylee@gmail.com>
To: phillip@squashfs.org.uk
Cc: squashfs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	Ray Lee <hburaylee@gmail.com>
Subject: [PATCH] squashfs: fix inode number description in documentation
Date: Tue,  8 Sep 2026 21:01:03 +0800
Message-ID: <20260908130103.272230-1-hburaylee@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation incorrectly described the inode identifier as a
48-bit number.  In reality it is a 64-bit integer where the upper 48
bits hold the location of the compressed metadata block and the lower
16 bits hold the byte offset into the uncompressed block.

Signed-off-by: Ray Lee <hburaylee@gmail.com>
---
 Documentation/filesystems/squashfs.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/squashfs.rst b/Documentation/filesystems/squashfs.rst
index 45653b3228f9..d6397961d16b 100644
--- a/Documentation/filesystems/squashfs.rst
+++ b/Documentation/filesystems/squashfs.rst
@@ -177,9 +177,9 @@ or if the compressed block was larger than the uncompressed block.
 
 Inodes are packed into the metadata blocks, and are not aligned to block
 boundaries, therefore inodes overlap compressed blocks.  Inodes are identified
-by a 48-bit number which encodes the location of the compressed metadata block
-containing the inode, and the byte offset into that block where the inode is
-placed (<block, offset>).
+by a 64-bit number: the upper 48 bits encode the location of the compressed
+metadata block containing the inode, and the lower 16 bits give the byte offset
+into that block where the inode is placed (<block, offset>).
 
 To maximise compression there are different inodes for each file type
 (regular file, directory, device, etc.), the inode contents and length
-- 
2.53.0

