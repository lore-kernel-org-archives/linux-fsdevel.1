Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540F8303C87
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 01:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776217436; cv=none; b=F9aE21y4QPzJzU0bAh8eZVe9uL3YqOuJtmFfWQvamEB/16XychPeWgHAxPFLoB3xEyEUWr5PrZQEYQ0987oOptkVMcxJH78iTSaqlXtVIanT7Go/ePGeOYoL7MvXNBweljnpqGOhjl39klKgGMIS/oBCFbd8J6RgQx7jZUavELY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776217436; c=relaxed/simple;
	bh=rXz81SC4dwM8OJTAE7oRDTvv3L0eXjRm0qZ5WY2yDS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jrm4hR86yHM5uBFp1sNgAvvpXc7ouHOeI6Mc6YUR6MmOQENaw7CB7J7/tnkpyKc7L5yATqb+DE6xTBtKzpefgRwgOLhEu/Vg+UKzv34NVJkEOdeumoRb+aVAsHXrwvhuGUCCDI1DDiF1t6t5rOeFsxSn5Y2+ekSs+P//E6l0r0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeWEXNkh; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeWEXNkh"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35d99031e4eso3552275a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 18:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776217433; x=1776822233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PVlced8ZEbgtrqydV7q14rWr2DPIXOWW1lsRdxcg6Po=;
        b=OeWEXNkhlKJixQCDgGjok3V71VwRzAq6wLwLUNP+T2x+5W6XmMJTz3wGSk0Nt5kI4q
         m4SkpOGCcdzciPdaC7PgGLh60GL+MIUOGTPvOBC34eyItJKw+bUYKeQGpPWZQY7X1uRg
         OZKP2zB/ZPF8pgrzEnJT1diD+arPf3LOa2F4iWOa5kn53ps0jzN/em/8/4LIvLeEMaFh
         kSLMDbF6Mh2d1Fo+egcEFGIIk2r12MpwFj5+KInfHLAO7ICqoT6d9JOwyaGIKJ3zd3Jd
         xj1LPhooPWQGKxBg7MIUbQSBixtUMCcWaegcNQ1zkjkVSAHZY6Z3UXar1FeoqzaDlk+Y
         LI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776217433; x=1776822233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVlced8ZEbgtrqydV7q14rWr2DPIXOWW1lsRdxcg6Po=;
        b=Dfq4UTIXcqaQKU2pZ97jMK9V/0MYV/LTyl81wxqrLge1Tw93QygZvNKSOGZIV96KOj
         ZnMAg1YHxj3wuxi0rTibWsRW0ilp4iGnVM1mFF6en2JfCr5bKxQTo/UDFAhhM/how4rE
         r0udD3+8RA0VYBOzwdQJhbEeQBmhqptpdBFjTcGPy1i87Ieo05anWW/0x4rJ7u2yx0Jg
         g0sBsXibgh+9GDKRr220Svi3+HawaFGDnRSZQmCKq05MCFTulCsXkiqcXhlMrW//5O/p
         I6NAhciuPl0gD1TdR3L01guKbIbXYVYYwJehPEo+Iq+EuOgWbZoTjFUV0NMCuMzPYHbz
         rSrw==
X-Gm-Message-State: AOJu0YyXmob4dhx9r+1SDbhFkYUB2ftr1KPaAM6W9ixSjsR/ovhHr3E5
	fWqVkFC67OMuTplqNPfZCM0iqDtiLjcWuQYEJhUcUAATbZcX1G330kS5IJZSvIAn
X-Gm-Gg: AeBDietj0PzJDJITMEQJ1Prq7FGzj/a8xY3ismyNb5DDjCVZx/ILDOiEc9hdPfaCUxb
	Si4U9CcQ9LTdiyteVQ+NhUt+0+IuThoNs7UX2I4Gx8Hm2O6tsOwx9eg4gsblKw8226ewp9OmR2z
	JWbcYHUwEHo8AMZWF5G+JJ2TVXDM2T99MygtGb/6y0sEqnj0z3YAL6alqQRF6jvIKhRgfOlcEom
	M16r1E/a/yfAwHeehw2laS1RFm4I4FiqFTfENbhkFCuKmxbVS7uGC6ZpvyfOJ26/MOzbeEeJ3Sq
	W7qDpoH1967uvr+/lO504vBtsZx/6BUn36Cf0j5CJPGdQXBBilRhmYT0Op26MHNXCjzhU8bdUSM
	b7J54v3F8lJ8PIgFfiLGcSv4qGNY7Ltyg5NMCSZ1hCHRdVzMQW5x7/IYk0sK8qAvA2naXHf1Eqq
	w2edX6X0iHPLAsWRXuwbzFhDk8WYBnHr4D56pFkonMPFS15RXKIrnAnrCxk3TswDiQ+0qN7j0dj
	ACSmmdGIE1M7G0W
X-Received: by 2002:a17:90b:4d88:b0:35f:ba3f:e04e with SMTP id 98e67ed59e1d1-35fba3fe3ddmr9227139a91.11.1776217433447;
        Tue, 14 Apr 2026 18:43:53 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:836d:58a:d945:24a2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fd2010246sm393749a91.6.2026.04.14.18.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 18:43:52 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Subject: [PATCH v3] hfsplus: fix null-ptr-deref in hfsplus_cat_write_inode
Date: Wed, 15 Apr 2026 07:13:45 +0530
Message-ID: <20260415014345.77796-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a corrupt HFS+ image is mounted where the hidden directory is
absent, hfsplus_fill_super() handles -ENOENT from
hfsplus_get_hidden_dir_entry() silently and continues with
sbi->hidden_dir left as NULL.

hfsplus_link() and hfsplus_unlink() call
hfsplus_cat_write_inode(sbi->hidden_dir) unconditionally without
checking whether hidden_dir is NULL, triggering a general protection
fault caught by KASAN as a null-ptr-deref at offset 0x28.

Other call sites in dir.c already guard against this by checking
hidden_dir for NULL before use. Apply the same guard to the two
unprotected call sites in hfsplus_link() and hfsplus_unlink().

Changes in v3:
  - Correct fix location: guard sbi->hidden_dir before calling
    hfsplus_cat_write_inode() in hfsplus_link() and hfsplus_unlink()
    in dir.c, as suggested by Vyacheslav Dubeyko.

Changes in v2:
  - Fixed commit message: hfsplus_delete_cat() is called from
    multiple callers, not just hfsplus_unlink() as incorrectly
    stated in v1.

Reported-by: syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c0ba772a362e70937dfb
Tested-by: syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/hfsplus/dir.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index d559bf8625f8..a7feef53d8cb 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -362,9 +362,11 @@ static int hfsplus_link(struct dentry *src_dentry, struct inode *dst_dir,
 	if (res)
 		goto out;
 
-	res = hfsplus_cat_write_inode(sbi->hidden_dir);
-	if (res)
-		goto out;
+	if (sbi->hidden_dir) {
+		res = hfsplus_cat_write_inode(sbi->hidden_dir);
+		if (res)
+			goto out;
+	}
 
 	res = hfsplus_cat_write_inode(inode);
 
@@ -431,11 +433,10 @@ static int hfsplus_unlink(struct inode *dir, struct dentry *dentry)
 out:
 	if (!res) {
 		res = hfsplus_cat_write_inode(dir);
-		if (!res) {
+		if (!res && sbi->hidden_dir)
 			res = hfsplus_cat_write_inode(sbi->hidden_dir);
-			if (!res)
-				res = hfsplus_cat_write_inode(inode);
-		}
+		if (!res)
+			res = hfsplus_cat_write_inode(inode);
 	}
 
 	mutex_unlock(&sbi->vh_mutex);
-- 
2.43.0

