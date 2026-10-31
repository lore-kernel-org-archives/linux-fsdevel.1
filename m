Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793431335;
	b=SWZTJ61SMCZzGEZB8Wv4hNYix36hZAipc1sgSZ6KB+4lX5nmukdk4PDej9HcEInNVSS5
	 wmYGD/ZDTKky7KWEOHZWSSp16yjJEj4Ou5DG0WnDmMNEc1qzLsKgvL6b7+rjoN95Q95FM
	 GoZiST3QzAHZOVyOFV4khdd9AHWUm8U9pud2fzC1Onb8YFA3qdpZSyWIBPQihcPAuiZ6h
	 emqsyzziIUbbOO3oOPr0YcLKzTQPwPNEJfJApkcP2wTSm+X9SDxqExqzyddgv3wblOkBY
	 pFXPVFfAilprbMfyPWsTBnWVHsEXGSQX9UjHd66r1+moAjZ7/eWXOkqWQI6dMTVIxig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793431335;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5xJ2Aaj5OkzQ8Zqzm1v69zHKFwlKxaSVQ+QJZIXxxzU=;
	b=kyEY+oaZKq1n0sETtE1Bbq84N6I2ErLa4fpsW1zrgev30fwFVBXPpOIKYuM6baGHpFkX
	 NciV6i+4GsVcUd8AQkUtxMI1T/94VG7ZvsYDOoEi1KviLGu/NrCTR3P4whIo5g1JKceWl
	 UzliwiZLsQhL2RywqywLgHCvDZapho7ARbyttQ1YPEqZxBlkdDPAd3kynIyW1r6X+Be7Q
	 CsW6PLbzb5w6id3w05H6aqaDghVJ1CPlIKgZWW/ZJJQRUPIsrBgNpBlCmumFbvSfkEiYX
	 aNlvLH7btsl7VnjQeDTRkBMJmKlF6caoIprJyN05dbTaH83+lbsKJErEUP5c/hfTKIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sUDBAl3R;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010FD606A31C
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 07:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 010FD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sUDBAl3R
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso9203795e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 00:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793431333; x=1794036133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5xJ2Aaj5OkzQ8Zqzm1v69zHKFwlKxaSVQ+QJZIXxxzU=;
        b=sUDBAl3RdCdqV4LujOE/vJNIErc6UaAwV8HQ1kXCA3PtrlRLW5eChfdFxSrMwwq1S9
         rqvMFG1WYDr7CAhRUfBpNHjZj1m+8d4ElM2OUuPtgg3gWfEdoJYdGdTg56kBap36SFmM
         m74k/iSF4SYzgOh/H1tEv9Z8yU/sJDljL0f+sBHBK4H848apG2I9zhcLWOzFwVIxm/6l
         RKp+IQoBmNo8ugmk6gjiBI8t5sIpWJ/N9YhVsuhcpCHvEkwe2HlLva6ojx8GTNKT4phF
         vOuc9CWql0bethLcCHh6xVqnqagqw6l3Pt5xjPyplpoahFwylo6Xmlxq5bTCbllVjbRS
         WrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793431333; x=1794036133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5xJ2Aaj5OkzQ8Zqzm1v69zHKFwlKxaSVQ+QJZIXxxzU=;
        b=Oyy9xlCPU8xGkbluiDj+CMuAtVVG53vCBOut9N0f62YRZta8twuLI9xrR/38lOWMe8
         ijvT/qRnRb8/Lls1rg14Fy7KIfnSq/RPwVDuXLiiPPFLVleCTBsO28wKoxabsUR4dg85
         wcv3yofQAu5Dwu0LR8lhsvF6ntm5FMxMqnAZtfEhCyuRpIZdm1y8T9WZ5hu8wXs4igaM
         U5yFBwfeT2vvkUwgwtMai2M1oOzrexA1X9xMFdDpuoLsm7Wu0W39Z7cqhz32WIaJKTZ4
         rcs4EplSgH33VaVU6jelKJkKTGbnDQEJZBk4/ubSxoNW7u35UhzRc5inL4kscWj8PxUd
         0xKQ==
X-Forwarded-Encrypted: i=1; AKwUvByzDxOLYunmpNtOolkbTBKYrnaBdKw7uksIE8N8nBcQbKZ7DhPrItqgC8a0Jn+E+HTRoZ8wzQxI7OYayZpl@vger.kernel.org
X-Gm-Message-State: AFq9FYJ25Gi2lsp3rD/WQVcEAb395y6Un91zSLVYlfpYjLjUBMI62Ywx
	+frZA7Q6O/xs/xY1n448TPyjNi05n0s/tfgkwju7Ak2crzMzcegAIkgP
X-Gm-Gg: AYBFou21hSdwD6CODwISmLWeLLWVEkLs86NULMkeVcC1uACjn2umaJNqp9RDL4Gcz9M
	Px2g/zSg6hA1Z40Da6ZBa9CHjKeJyHldF/2Y9NRfdlb5dZOTGZC5X/qrUkvuChNfzThNk//RGf+
	bsWK/THH7UatsuC+oLpuAAGyqOi71ZjtpNPr1zkoreS43/zGD5/CcdZ5UpplFHX+m5PREXu2FtZ
	8xe+VgH9v7ayM6gMcgalRKt3WDnLG15OAvJPMtq2lPloNWE80xEinQeByoRVi4tS8dA1jY67Tzy
	96e/8TbycgZgGYZ258VY3AESQ+E3bzOBWOJWYOeiZR4Y5kCoXA+HmbsJq1/NYVY+SKCafC/cEDd
	G3idv6FKdgp0E+T9oopnZMZQaD6DYS7NXf9+FmmumgHKGXn5OoFcsVS8EaFKU7QRGs0OeJTtEoP
	Ff2qvW/oFaEo0axarNlT3OdQ88Oqk5VzidYEpoz9g9j6jjaIRGAyGlmqRgWpVUOhWxi22Mxb6bk
	0/3PotlgvqW8CR90PrRR6uIYwhZvsPKzXuXJnHoO8xhwKQ2uLorz/NlKoMB+kJz1TNPuDZug02v
	oMYFHNYhk2zgLTfCLoSIR+nuEN3dXEYq/KVwoERXASOr
X-Received: by 2002:a05:600d:a:b0:4ac:aae6:6401 with SMTP id 5b1f17b1804b1-4acaae665d8mr56656675e9.12.1793431333162;
        Sat, 31 Oct 2026 00:22:13 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:4773:6f00:c8d4:ec29:293e:f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b723b4sm7709687f8f.17.2026.10.31.00.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 00:22:12 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH] fs: clamp FIONREAD result to int range
Date: Sat, 31 Oct 2026 09:22:09 +0200
Message-ID: <20261031072208.3096100-2-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
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

FIONREAD returns the difference between the file size and the current
position in an int. When the difference is outside the int range, the
result wraps, so a file with 4 GiB remaining can be reported as empty.

Clamp the result to the signed int range before returning it to userspace.
Preserve negative counts for file positions past EOF.

Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 fs/ioctl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 1c152c2b1b67d..ecc2a4cfe6100 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -7,6 +7,7 @@
 
 #include <linux/syscalls.h>
 #include <linux/mm.h>
+#include <linux/minmax.h>
 #include <linux/capability.h>
 #include <linux/compat.h>
 #include <linux/file.h>
@@ -550,8 +551,8 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
 		if (!S_ISREG(inode->i_mode) || IS_ANON_FILE(inode))
 			return vfs_ioctl(filp, cmd, arg);
 
-		return put_user(i_size_read(inode) - filp->f_pos,
-				(int __user *)argp);
+		return put_user(clamp_t(loff_t, i_size_read(inode) - filp->f_pos,
+					INT_MIN, INT_MAX), (int __user *)argp);
 
 	case FS_IOC_GETFLAGS:
 		return ioctl_getflags(filp, argp);

base-commit: 36aad21d50d1af3f6954bb0c988257a908202477
-- 
2.43.0

