Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019503A4539
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2026 22:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785621692; cv=none; b=fjaItzNrW9tgm3ctda2cX8Wx/O3eeARDDxtUsbFmREMmWlqYYpVb7INYp+f64G7emc2SiysRV44P/1y0XEIslG4evNm3gD3A0NQwecIZYRGT672FjMH+MvxcW2hq87pOLt5p8eY6ziQB23Who9sfDnEypuzq0OLWUZJYd18KtFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785621692; c=relaxed/simple;
	bh=B1aGoafSodbJHnZvQa4U88gzZAbdOk4anLe8al4k4+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SC9G7W3tj9tHKeTEIGDE1N+/gTVmYcmQZGrqdhj+bFy7lGe3Suw8v57j+yYO1EnPD8uaRgKb8wS+ldBr/2MFvdhN2v+KWOQ8sbY+X4HcxK5LBlfu9r3nyTtABU2LlkT96LiQFRzgZmAIU+Yz50JgTMgCMfxdvqcM/dPCv52ayO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNVHRsXU; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNVHRsXU"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8114a4542b2so33656797b3.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Aug 2026 15:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785621684; x=1786226484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fFKjhKiLwW7000gY04FDp9HuhYK5pnv34+ERWpP83n8=;
        b=PNVHRsXUp0XCXnD8Q+OJb7MgdABLPwXgxvpcqQWg4VuxEPmBLymrH5x1rcy08o+/9t
         ZGNL91aWrTxK+/zmIESs8niMIAbrmnsJ8IdweXdnxfTINbPcwllz9HQzaDWZUf/lpUyG
         CG76ga41gnn4KB8Fp5Qfbb4MrLbyOft7dCNVuLy/jKpiqPKmywoBG3iJSi4pn0Ndk+MW
         Z9jHubiQBK9UUscfGZ5iX9eEoUMaASP7WwczxwGJyUQdAIZ7yErDlmdI7JpkNaFHzj0r
         gqJESLFvRnPXoH3zZPAy8K9Ue2PTHvhTBwBPpHDYQpMsDszYEefsqIvEQRkDBVRFKnVs
         Imdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785621684; x=1786226484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fFKjhKiLwW7000gY04FDp9HuhYK5pnv34+ERWpP83n8=;
        b=qzGCtJIR3N9NAes4JYudQWBorH+Jj8Qr0GL3Jhk6R+dllWTj2UaZmjooZ4fE2CdAg+
         4E5gev6b/5jA4cwNpgdfMlM5zw7ZdWFBoik7ifY7qh+/FXByy+/yCAF+rx44UiWXtgKu
         6tQsLC0lUMEHPhOPO6zYCJBZfq6v0vzE6ytNi437lRYBSBgjwd9Ejtqh/DA7sNXJnxBs
         GHtAruSniem3pcCHAaLk0iSGkKFjdAm7TLab+UUy/OHeO/ZZJfIfD7HSkLVi4jfqB9tt
         cOa2dpSxcn9oVnRIlM/97MRs49DtF413ZK30MU37hOpzBZhoJGglFechmxWU3wT3PlRN
         Q8hA==
X-Forwarded-Encrypted: i=1; AHgh+Rri5/RoRxVPjM1qZ5wCvQ+JilrHB21umrtSixt35bchJFPFAiA/dr2St0TE0D6y+IBtSINAS3i/u5PHXv5G@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqu77zkkbFqtSb1SO76pkgwb1Uk5DXsMWfzGthdO3moUsNYDZN
	TGNGCgvpTThEk1D8Rt0+yhHaDSa/6RYnmjnO0OIZ/XthwV2MsmWKb4iI
X-Gm-Gg: AR+sD12X750p5Os0LNwazF5+qHQe1hVVcSQXhzN+pCZRCzQOsU9ILRSAOvSlN+y6Epr
	CezHlWaG5dO53680f8GQD9EldC9o9SNtGPRu8cYlWuHCJ/P1ZxWHhad1jOwnjLdDi+JgTaqI402
	v+UDPVduep2eUXFduIU2aEQmDAiin+0fvWyTotFaYhE8qBU2TaNrH9QIxl7tzERpNb8zDNB+O7W
	G32tRqLAo0qmy2FiTI5zMpxqfzJSRp4YaPSSxZW7ByAmFOiMOTrO1VzFx7UiAZVIQ1fjU9EuJ6/
	vDSNJZwXhff+st3dAV7NLlun3rqcIJTyrUdt1+81JwdjHkJ2u0GAc5QvYSRCQ9HLXOcb9A6AY02
	eqkQ5o35bZlmdGapCUeu4PDTBerqK2NfumLa7agHThuncj80ZReM+I8RIptixkMoncgL20QNlf/
	ZBp4JspPa5RHkOguS5qbnBV9YgU/0SuwNBAAauBLFNfmtA/SnALeKNf6DDwE9tYDooN+KnPqK/5
	a60u8U=
X-Received: by 2002:a05:690c:d8f:b0:80d:a249:4854 with SMTP id 00721157ae682-81fd4b59a06mr68933057b3.17.1785621683893;
        Sat, 01 Aug 2026 15:01:23 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd0d6fbbsm29903767b3.25.2026.08.01.15.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 15:01:23 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Bob Copeland <me@bobcopeland.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-ext4@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	gfs2@lists.linux.dev,
	linux-karma-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>
Subject: [PATCH 10/19] exfat: check for a directory write error with buffer_write_io_error()
Date: Sat,  1 Aug 2026 18:00:54 -0400
Message-ID: <debeabce46c73ff63152dbdb67eba64d60c45c98.1785621505.git.coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785621505.git.coshi036@gmail.com>
References: <cover.1785621505.git.coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

exfat_update_bhs() waits for the writes it issued and then tests
!buffer_uptodate() to find the ones that failed.  That relies on the write
completion handler clearing BH_Uptodate on error, which this series
removes: a buffer whose write failed still holds the data the filesystem
asked to be written, so declaring it not up to date is wrong and makes
callers re-read it.

Test BH_Write_EIO, which is what the completion handler sets and what this
code actually wants to know.

No behaviour change today - a failed write sets BH_Write_EIO and clears
BH_Uptodate together.  It stops being a no-op at the end of the series,
where the new test is the one that still works.

Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 fs/exfat/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
index 6f11a96a4ffa..dfd0bbf31c94 100644
--- a/fs/exfat/misc.c
+++ b/fs/exfat/misc.c
@@ -187,7 +187,7 @@ int exfat_update_bhs(struct buffer_head **bhs, int nr_bhs, int sync)
 
 	for (i = 0; i < nr_bhs && sync; i++) {
 		wait_on_buffer(bhs[i]);
-		if (!err && !buffer_uptodate(bhs[i]))
+		if (!err && buffer_write_io_error(bhs[i]))
 			err = -EIO;
 	}
 	return err;
-- 
2.43.0

