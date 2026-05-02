Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C417224AFA
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 May 2026 00:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777682940; cv=none; b=Vt7F9izRQXGu9v2uit/hDFw3X8pQOIaSeH7mr4YMN0GEwRfqJSVWiqkweiYXXcGRz+9ZN6GIUVlFUsc33r8EdYf19TpPD/0lgqFs1yhBdJhrfPfyVkvcDOUrRM0aXatkJIWEUsmrAe40rzKOYHR2kToj31kkjVOfACKqXM5injQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777682940; c=relaxed/simple;
	bh=AEHtC+ETvaK2lmz50YcRV/jLNIU8jkk56VMXFCK1zn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HSa3vGo+Vukd5CzFF9DLFPWv96vNGIqgere5LgX5phxaMKXjCBSv5FLMeSoFA+HQVKdh0eND9nxtwfU1Q8plnaLeH3Q5d0obNbKn62z0E3zgL/bSsbaKmq8nplYTpZ0eXj/1hx7cSMTSe94m2Bsi4qTv/rDB3UbpEeBn69oEdv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZ8dpWSR; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ8dpWSR"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aae4d2d215so1214095ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2026 17:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777682938; x=1778287738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6ChL8A5gfwDt9baobC+l6qF9XfISv6FkLXO1fVsQDnY=;
        b=fZ8dpWSR3gl+elj1yA2lYirC9OG1M2fvBXTmsArDB2AtKqe4OMczsQlixNxFsQTElo
         VWfbRXtcz8aGWWQnuech4lMEye8wJWZsR1NocNd6Wy0pRhC1qRK1CeJ25Ew/KIEoFLOG
         z1JJAgCOP2AL8xy8v/GQBsZVZ/WjkocNtYKVX275zd4dllHGiKzZjnkQJBM5rpM0DqeL
         0HOxbNYYU3Zu/Z0zZVkrAx7zirk3bTqvShRGkyz05I8FYAmdkdD2VAw+4f2qZWADcwDt
         mUtArcQbrS/Xxm2kvmhwOx8c0awBLt+dRx1huO5t1cdRQw89187msYTwnqqvuh1Sz1Pc
         JdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777682938; x=1778287738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ChL8A5gfwDt9baobC+l6qF9XfISv6FkLXO1fVsQDnY=;
        b=YpxRWNvT908XKUGypAxabW0FTEgsgj+8SVVAhSELYTi3p9okmrdGdUkUBrxGp1oqlj
         JzQVXOEPcJMEGGfrXvk913tryelCem6ksW1WgeoE2JYOSAz30WH17MaC7hStL86+PDij
         miPXjJg9u796lJX8qMVckuVqUVjJAwfLl6hEj5erplECuji5trbqGXI1B1U2DpLyP+/a
         LPU2OdS/ttVukO3zQpHB8X3rg+zhU3/iIyXC7Z7pMyHdaSugScWVbgHaY+0Y/5W2tRo9
         skzA0nYA0cy3i0MYQR6rzUQE05WQpi4wl+0T1cVF3hzHfEu4tEVFjDEku1qosi3sK9uA
         qZCw==
X-Gm-Message-State: AOJu0YwyF9SDk8O2VAQFGmmpnuR2G55Ci6drxctiH6jtCeVNb8EgoGdG
	1K4H43X3e1aViwCxXHnkIRmuW84rSB+jqfwbw/IMc5+EJDTfJe20/D4u5cNojZrq
X-Gm-Gg: AeBDieuXgVAGBsUgiIdTKZ+e0PtPkXbUxUF5Bw8AQtgRaagAbYpUFBKiOY5SXlAGrnZ
	+sT+i1kpdrHVWdoQDgBnSS6DAiwPNb5OJVy8Ah6fzN2i5yp2nb41tirmFIekM7kBFzO/6wXnRqr
	g4aS+ZZYEcGSq6/HCp4JRGVFq6Y0Vshe2zOZnP1S36QX93D5KvPD8DWcd+C7to3Li4nLfYm77uf
	QHJylnxIQtT74uE8Y4c7+/CNlHPhnEY8sipgzs53IIDOBaczIVueZsmCfsCTolWqldvkyLao/b5
	yBAaniHC58vr+XH4/gO4Y3sXAo/kD5wz7N0ftSu2aucxpIpfklhpleLFbGAoOvGwtIl7D6dx5l+
	GkvsjdNrGI86HsI4v/XZZlLpSqgJ5YtlcHfqaBVRroYtwACkontRtCCE3ByZjcisRjQeuTLUmXQ
	EgevhtG53uCnjnpn+KJvITWpr/KJc=
X-Received: by 2002:a17:902:d2c9:b0:2ae:cefd:18ce with SMTP id d9443c01a7336-2b9f252e30bmr6999925ad.2.1777682938459;
        Fri, 01 May 2026 17:48:58 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae15fb6sm33435645ad.43.2026.05.01.17.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 17:48:57 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH] ntfs: fix copy length in ntfs_bdev_write() for non-page-aligned start
Date: Sat,  2 May 2026 09:48:52 +0900
Message-ID: <20260502004852.491934-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is not a normal data I/O hot path.  The single in-tree caller is
the $LogFile emptying path used during read-write mount/remount, and
the bug only becomes visible on NTFS volumes whose cluster_size is
strictly smaller than the kernel's PAGE_SIZE (typically 4 KiB on
x86_64).  Per Microsoft's format command documentation, NTFS supports
allocation unit sizes starting at 512 bytes, so 512 B, 1 KiB and 2 KiB
clusters are uncommon but valid on-disk configurations.  When
cluster_size >= PAGE_SIZE every "start" passed in is page-aligned and
the buggy "from != 0" path is never taken.

ntfs_bdev_write() splits the write across one or more block-device
folios.  Inside the loop, "to" is computed as the *end byte offset*
within the current page (0..PAGE_SIZE), and "from" is the start byte
offset within the page (reset to 0 from the second iteration onward).
The copy length should therefore be "to - from", but the current code
uses "to" directly:

	to = min_t(u32, end - offset, PAGE_SIZE);
	memcpy_to_folio(folio, from, buf + buf_off, to);
	buf_off += to;

When "from != 0" (i.e. "start" is not page-aligned) memcpy_to_folio()
copies "from" extra bytes:

  - it reads "from" bytes past the source buffer into kernel heap;
  - it writes "from" bytes past the requested range into the next part
    of the block-device page (or, if "from + to > PAGE_SIZE", past the
    folio boundary entirely, which trips the VM_BUG_ON inside
    memcpy_to_folio() on CONFIG_DEBUG_VM=y kernels).

"buf_off" is then advanced by the wrong amount, so every subsequent
iteration also reads the source buffer at the wrong offset and writes
the wrong content to disk.

ntfs_empty_logfile() calls

	ntfs_bdev_write(sb, empty_buf, NTFS_CLU_TO_B(vol, lcn),
			vol->cluster_size);

with empty_buf sized to vol->cluster_size.  On a sub-PAGE_SIZE-cluster
volume, any $LogFile run whose LCN is not aligned to
PAGE_SIZE / cluster_size reaches the non-page-aligned path.  The
over-copy can read beyond empty_buf and overwrite the sectors following
the requested cluster in the block-device page with unrelated kernel
heap contents while $LogFile is being emptied.

A userspace reducer of the same arithmetic and copy loop confirms the
bug under AddressSanitizer: ASan reports a heap-buffer-overflow read
past the source buffer for the buggy length, and the fixed version is
ASan-clean.

Compute the copy length as "to - from" and advance buf_off by the same
amount.

Fixes: 5218cd102aec ("ntfs: update misc operations")
Link: https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/format
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/bdev-io.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/bdev-io.c b/fs/ntfs/bdev-io.c
index 67e65c88d681..27d7c2767a33 100644
--- a/fs/ntfs/bdev-io.c
+++ b/fs/ntfs/bdev-io.c
@@ -97,6 +97,8 @@ int ntfs_bdev_write(struct super_block *sb, void *buf, loff_t start, size_t size
 		idx_end++;
 
 	for (; idx < idx_end; idx++, from = 0) {
+		u32 len;
+
 		folio = read_mapping_folio(sb->s_bdev->bd_mapping, idx, NULL);
 		if (IS_ERR(folio)) {
 			ntfs_error(sb, "Unable to read %ld page", idx);
@@ -105,9 +107,10 @@ int ntfs_bdev_write(struct super_block *sb, void *buf, loff_t start, size_t size
 
 		offset = (loff_t)idx << PAGE_SHIFT;
 		to = min_t(u32, end - offset, PAGE_SIZE);
+		len = to - from;
 
-		memcpy_to_folio(folio, from, buf + buf_off, to);
-		buf_off += to;
+		memcpy_to_folio(folio, from, buf + buf_off, len);
+		buf_off += len;
 		folio_mark_uptodate(folio);
 		folio_mark_dirty(folio);
 		folio_put(folio);
-- 
2.43.0

