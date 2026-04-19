Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8FF2E92B7
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2026 21:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776633738; cv=none; b=e6rYoHFvjEgGWdsfTC4VSZ9FFhYrlu67TMLrIjrn2GTx1SO/JUZW6yYauyrjYZDqy32t/fgXthRfYCIrKOgjCYDImHWSlU6emcRQBWPttT0Eybu9Y+2PP4F6XDk42RU8wRrNnm9B8Tu5NHnKvrZ7yUwu2akSi7eMESDQsVjS4+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776633738; c=relaxed/simple;
	bh=8bXWAUwuXeHpNnD3ARKgWX+5UoBQj6FtEd1TUTI+88U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhy+29XBWE5hyKFrloiuncZcs8fNkC6lG3vBBjvazY91xMgZsTMGcJW4nSZziELxqiFVg45wBY72XJXUabfUDSoeL2uu7haPgCJysGDg6ibW6krONz7iPhe0zr63gOguPJtPwL5Ozpny8Xlo4F5YjsQ3CIV4SHOgJl7DoPR2/Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvKoPMlO; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvKoPMlO"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8d424af6282so257475285a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2026 14:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776633736; x=1777238536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgjr9000CxEsC1rRZgD66eWlAXXvm6i1E9C0yOGBCjc=;
        b=kvKoPMlOq0FxaF4Qz+PxUC41kJKOfrGEYO+vtH9oVeyo3fRqfJbEVjmnwGYZQ92WyW
         GHF8XHkC3LOGCx0vdeuYwWj9WTkIDnEg4SEPeWX1JCtXtICEAxJ9Qslnvmz949PdmrVl
         lVu179JZyZtWLnM/RMQFZbHMSaMJBhxmXnK01+KSxLaeEA9nogOwc6EsDcmSCbzyxvH8
         SwlajIGxieouBbmC3Oocj/n/u+3zcdIwHUBDLjC1RMy/GzK8dFXrGYOx6+Mwl28nsJ51
         UZ4AdNsbWaUoMfnpiDJzI9CJHMmrztXHYwDq5oT9LnEQILBkiMEZTyEeU8AgL9It9bWJ
         Q5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776633736; x=1777238536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lgjr9000CxEsC1rRZgD66eWlAXXvm6i1E9C0yOGBCjc=;
        b=eti0hom9CPu7WMPp55tIaetDqEzBTRaoKTXg3dZeJ4UWDpA07D0oAlVYSz/iAHX6dx
         H7P/3hv5eD8ee4d27pOwIuhXLAg+GOT77W9+aTsPvi0xSCZHTTAUtnrFfrLVEhTzIt3n
         4BaV6t1crGWsdu1tiZccvLgNmP7CKy2QhLl9kTW7MNG+DjqYJdDwMcWAtDs0IkernWy1
         nSRiUWGcFaBZdpeMQpsGXmHbSq/O9KRldETZTJyGo7d3e1JJcQj3AB5fKJzYixw3fe5H
         /zpepfINgibX3CvYQjHtVjmhDlFLEEx1Ey5CgA4JL5mpvJ8nf/WuKm1zMmD3mCurKiRl
         uZfg==
X-Forwarded-Encrypted: i=1; AFNElJ+Ewz2IjFZwWoLDT747Ts312TrJyT9C3PcrZXLW4rXhQI3y7TZFegfkdKtblqwhkuL/G+3bKQyTrqMye3Ot@vger.kernel.org
X-Gm-Message-State: AOJu0YxP1pWfMUQZO5K2h0pD99+BR1IVbxN7WXjjUTyBcjKt8SqCHyRT
	/yzmh9eRBIRr9T8gYthXqqeokg0VnfxG/WrJu60kfI98Bztp0/lQgaWV
X-Gm-Gg: AeBDiesxVRDLaYpewfRVEPgFRiPzmrrWOjkqHsT8Aw+zf1kKFaFApPt+vdxfb6TMJz3
	K86KiUfhxMZoG+uERntQzWATifQQxy6w856T2QK8YPEeKGOTSEPlJqJGIvdJjQvqToOq06kvjMK
	oFRASR4ROBBnJioKQEMom5mIyw3RN6VcY5C1HDRe4sy//Xm5GqOLkVyrpg9zagR2D/HCYn6e0we
	3dVbii7rp1n1QmkRLOFgPKWImnFSVcAvk1a2bN55/DWLYGQkQ+gqK8OR8NhZ8+qzYPdiHk0mhWO
	3ennpz1vOTypqfay7//WzSifazMwBSCRmdlf/eI1csNc5Dj5jzDhVIRHWdd+sJk09ALBlfUG9uR
	xrvie/KAkLRowzFdLKPzp0LZ7zlHdj8x2sydcKe394Xb4+2hiuIqL8+fJ/4SiCa/aCZbvbC6NZu
	1Dr4vRjgsh99WfI9pWD6JfFELPOOi4CvCz5OzyGainEuGcnBp0sD49StkMb8wcDEPCNgNL8tVLx
	ws7DnrKe7x8u/0+cTAnXFuVAwte/SnVRpPUewk1Vw==
X-Received: by 2002:a05:620a:4489:b0:8dc:5094:ea79 with SMTP id af79cd13be357-8e79189e3c1mr1524677385a.39.1776633735681;
        Sun, 19 Apr 2026 14:22:15 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d65c1321sm654849185a.15.2026.04.19.14.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 14:22:14 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Edward Adam Davis <eadavis@qq.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] isofs: validate Rock Ridge CE continuation extent against volume size
Date: Sun, 19 Apr 2026 17:21:54 -0400
Message-ID: <20260419212155.2169382-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260419212155.2169382-1-michael.bommarito@gmail.com>
References: <20260419212155.2169382-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rock_continue() reads rs->cont_extent verbatim from the Rock Ridge CE
record and passes it to sb_bread() without checking that the block
number is within the mounted ISO 9660 volume.  commit e595447e177b
("[PATCH] rock.c: handle corrupted directories") added cont_offset
and cont_size rejection for the CE continuation but did not validate
the extent block number itself.  commit f54e18f1b831 ("isofs: Fix
infinite looping over CE entries") later capped the CE chain length
at RR_MAX_CE_ENTRIES = 32 but again left the block number unchecked.

With a crafted ISO mounted via udisks2 (desktop optical auto-mount)
or via CAP_SYS_ADMIN mount, rs->cont_extent can therefore point at
an out-of-range block or at blocks belonging to an adjacent
filesystem on the same block device.  sb_bread() on an out-of-range
block returns NULL cleanly via the block layer EIO path, so there
is no memory-safety violation.  For in-range reads of adjacent-
filesystem data, the CE buffer is parsed as Rock Ridge records and
only the text of SL sub-records reaches userspace through
readlink(), which makes the info-leak channel narrow and difficult
to exploit; still, rejecting the malformed CE outright matches the
rejection shape already present in the same function for
cont_offset and cont_size.

Add an ISOFS_SB(sb)->s_nzones bounds check to rock_continue() next
to the existing offset/size rejection, printing the same
corrupted-directory-entry notice.

Fixes: f54e18f1b831 ("isofs: Fix infinite looping over CE entries")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/isofs/rock.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
index 6fe6dbd0c740..1232fab59a4e 100644
--- a/fs/isofs/rock.c
+++ b/fs/isofs/rock.c
@@ -101,6 +101,15 @@ static int rock_continue(struct rock_state *rs)
 		goto out;
 	}
 
+	if ((unsigned)rs->cont_extent >= ISOFS_SB(rs->inode->i_sb)->s_nzones) {
+		printk(KERN_NOTICE "rock: corrupted directory entry. "
+			"extent=%u out of volume (nzones=%lu)\n",
+			(unsigned)rs->cont_extent,
+			ISOFS_SB(rs->inode->i_sb)->s_nzones);
+		ret = -EIO;
+		goto out;
+	}
+
 	if (rs->cont_extent) {
 		struct buffer_head *bh;
 
-- 
2.53.0

