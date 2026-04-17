Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F7D15A864
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 19:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776454758; cv=none; b=CrJeOXe5ss6mXTl5s8o6+AnLZdEOOeMkHUKqX64faLhDOb0iBBbpFdyHDWoF3bmEzRAfXwJjUVbYmhGPyuV/QJIvgh5Rd+xYe72J8d/8AZGKrb3gWGwbM/zYDW5atMt1CH39SqgFU4XkhWzQFFdl0fwuoTz6tptxWJiPo5i2OAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776454758; c=relaxed/simple;
	bh=NJ6/CANuGl3odwtb7ysxZy/MRZxYmQz1gQeHADHI/i4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fl86NgM44bBvtn12LvHkX7VghPAvK0Gb11ntxmgcdoBmaKXbj9aMYG5wjxSst3gVj/sbkrI9RO+cAGjk69OMGKPNTdbkZ6zOHG1qU+2ZJ762Xr++WV6mokL51lkPorUR7Rv1SM2iXLPNFGxadKxKMTE9QfO6amLAZAFrNqFmDDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDvWN9va; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDvWN9va"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so15445115e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 12:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776454754; x=1777059554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T+guEPCIISTmp6PybkOSuXnNzgmVvlfkjaLWc09D5zw=;
        b=VDvWN9vaZTGPFxrTfm7EVkvoF4Y3X/GVXZZuXNsfEbnR6r8ymhgUpDi6hwYjAZE6Kc
         9lQhEhY+CgkHuGejfYTKfDOtsEEbrLVWuWB9yYQhFbh5tT3aezUcqAhiknhmYrGHvjGm
         QQzHJrK457Rf1HANYgZ061i6mwpAxRYVPE2Ermk5k6DEhCMnNEZqOXZhAKxfreY4jTMc
         ryi8HV+LTMFICIo4oNVieIDS0cTlZDd+ToHNOXtYBe8bw2XM/rJibQhV1GOyi5pPoVDI
         nTwAApzwMwAtVhLk+Fhab88Jiimb5HLCkzxdALRXdx8ocDx0kRTcWq7w0RdBgvYyuOkT
         OYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776454754; x=1777059554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+guEPCIISTmp6PybkOSuXnNzgmVvlfkjaLWc09D5zw=;
        b=qn8y2etZOh5IyQ5WjWuiggv1HHApfheXlZqRuhSsGuzzBDEnbu+eqGmLbpU/A1X7UC
         VtQ3ajyM97EcZ5mm4PqL63CIgV4dbHSY0rex38Z49KBAjtgn+8fs9Y3SZTzJC12bRKsb
         9PK83KHfNMA75Myvc/tXq++NZJugXqJTZhSwzorKc9J/qdDHFkMKWxq/y+XURO+1ykcl
         0MJasJpd87599OnwBWpl3wHYVcKMe38N14Yw4VHjor4QkTZgy0qfVAv6uLc9kiLtQY5P
         V9crBM00dtxHiV2x2O4uKAqACvHBHwC05nW9XDwPFCO2ZnzbtfARtBZrVaZHkGUkwuFn
         s4pA==
X-Gm-Message-State: AOJu0YxOugiRnJcCB+hJAkdC6o/9Scmnu7+eEuhLbq1k9Ml+UE96ctHf
	iUj0YP6RkkBEssJjHTmcwP/j8+GoR4GzVvL7rtCvNa37KlfCedYbiMs=
X-Gm-Gg: AeBDieu4mHrxcdVw7IJ3H7if9zPDSsh9XGqbSl6kN2UEwjotwJkmqdda0Jt1KTputOX
	iIqARap12kveIWeU4e0z7MQQhcFmJq3xaELsXM6WJjrgiGibk4x2WyemOKpyuwHKNph/gXP2Dwj
	fI9eQ6WtkBD0jCZg0WSM+jH/WCybIYNDBjvBVQTTNO5SAyUwPUmL1DufS6RLRg/K7ZArKRqbmvx
	D1mt3p4sNvROfIH2YilezAQiQ321fOfhzOFv68nArC63001YCk1JIiaAeMLXwz87WsFFaFR3V0X
	wTcCpi++CxXfZTUuFibohdLHx514eaZguLAkfJyvp+z+TtXWZnjiKL3kSkWWnw7Eon9Z5PvD8yu
	pl7m7+O7dOnX4wV8pAlhJxm09eSfx5UOBgGKxKiEa9RTCwP9FmNQ+gMJSAEIQpgcXrdy1kkFHIJ
	KMI3mBgjvTOnsxRgpl
X-Received: by 2002:a05:600c:1da1:b0:488:f453:b976 with SMTP id 5b1f17b1804b1-488fb7844c5mr70072535e9.27.1776454754460;
        Fri, 17 Apr 2026 12:39:14 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc140c82sm62834555e9.12.2026.04.17.12.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 12:39:13 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+217eb327242d08197efb@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] hfsplus: zero-initialize data buffer in hfs_bnode_read_u16 and hfs_bnode_read_u8
Date: Fri, 17 Apr 2026 19:39:13 +0000
Message-ID: <20260417193913.338982-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfs_bnode_read_u16() and hfs_bnode_read_u8() declare local data
variables without initialization, then pass them to hfs_bnode_read().

When hfs_bnode_read() returns early due to an invalid offset on a
corrupted HFS+ image (the is_bnode_offset_valid() check), the data
buffer is never written and the functions return uninitialized stack
data.  KMSAN flags this as a use of uninitialized memory.

Zero-initialize both data variables so that an early return from
hfs_bnode_read() produces a deterministic zero value instead of
stack garbage.

Reported-by: syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=217eb327242d08197efb
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 fs/hfsplus/bnode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 14f4995588ff..4404cd35c192 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -96,7 +96,7 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
 
 u16 hfs_bnode_read_u16(struct hfs_bnode *node, int off)
 {
-	__be16 data;
+	__be16 data = 0;
 	/* TODO: optimize later... */
 	hfs_bnode_read(node, &data, off, 2);
 	return be16_to_cpu(data);
@@ -104,7 +104,7 @@ u16 hfs_bnode_read_u16(struct hfs_bnode *node, int off)
 
 u8 hfs_bnode_read_u8(struct hfs_bnode *node, int off)
 {
-	u8 data;
+	u8 data = 0;
 	/* TODO: optimize later... */
 	hfs_bnode_read(node, &data, off, 1);
 	return data;
-- 
2.47.3

