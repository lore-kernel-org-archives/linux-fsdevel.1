Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88874BFE74
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 22:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789598466; cv=none; b=CHOW4sGyrtn4Je29NXmVpoixXr4EnAKd8gipNbeo3h1GGkw7xq6jnd6Eg5THEtoysxEmy4vvs7+/9EV/pMVFdgM3Wvpjqa8rPGpEAMOyNtEGWSCtJq+BD+9YFwg2L4PEGGBoo0ABX9LgpDRj9/DXkB6s2AVcchR5ppgtNd/fO7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789598466; c=relaxed/simple;
	bh=wmJV7UlkNABprPy5JGp8YnLyxdnU3PP/y/DAmlXHOHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rrep2VdCBG47M1LnumSSqCNfScfMdnRCGN/7BW66IgSC5SPtopZjxAmXWTTRHWpinCGqkAD1InZJQAtb48QPSR0MqlJWyKxeaSwa2JEDGd8QdC+cNZBSq+awfWHmswKCVLSwscezRojEUCiyrGZaY5sO+i6YDeXTkl4fWr60UjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+ca20Tl; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+ca20Tl"
Received: by mail-pz2-f43.google.com with SMTP id 41be03b00d2f7-cc1cea4bfb6so80652a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 15:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789598453; x=1790203253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t5VttPhmwrMHoUqXXmaUFtTG8MKFE+6yQbb1G29GHpw=;
        b=E+ca20TlYAKR7jADSMiSZdYQPNm07r5fQRGxm+goZ6cRTf72Ry5XTX2BKs4GQuvWFG
         jPr005C2MfVFWe/fbn4bzlob7KhOvKMxsYaxXGMarh6EPnwz+Qrdyp6JYHPzHfjwRwU8
         89EKzHODEQeI5uilkq960hbBH10vazjBH7mmfouG4VQsQqlMRG2XKboNOMYv2J+3TTx6
         SIfrkiTK9KITVaq48lacaJMZJMGwNqETnEb14sodkN/Fi7UV69rJI/i6eYg96uk7Pw5s
         zfeUEK8WNdsg5djewlNlhHfr8OpY/RFcikY+kbLLPfg4xQlBaQhX4HHn4++G/Kp1J01m
         lGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789598453; x=1790203253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t5VttPhmwrMHoUqXXmaUFtTG8MKFE+6yQbb1G29GHpw=;
        b=KtUan/d1zG5ACziNqLpfjaMX7c6vbS3tTumCieW2T0f1FL/V7dGXSUqjn73JlbxBZo
         z8jS1Y/SKv6KQMaG5lXTz6mSW0MayoF6LgdCIcBpSjLhC4JAzfmQWvKIXu1uAo9MaYrQ
         VAXZWj/Tg78WAGGbV8/3jAX27UaV4ThK3hSZsp5Z0i3rVB99HsRqJ9tIqw10R8aWYRXx
         QuZexZxt6LQAO6NFJQbBEhqvGktmLW7IzRsga0yGgiLY2U29wFDh1KdKqxnWgBMjGyd5
         FZZpJEPnM1VPG+n6yNVog03ByTs3JH2LaHfBDlCuroZC6wdFyWjc3tv/wGFPUPDzPeOb
         H7RA==
X-Gm-Message-State: AFuF++kTaIWfOOasTinw4Rws8Xt+j7TERcKbEByVrE8+m428WR+yA0Uk
	qfnG3GvRLpjAdN+0k5Lvhm/jM28sCjljcEmhHiUjG0L5r25Xbeo0PqMI
X-Gm-Gg: AYBFou08aZUVkionDvP/AIJcLg8S1r9WDJ2zCwGki4Z4YbYcSwA/FH3o99F4ERfn8h2
	qggDzfsLdX9t14QvoVpQDslHsGBN09sWzncwJfn5D3yFe2eaTR1H9v+RIDPcBThdM7W5K1nSg8t
	eCJgwqwJU4gRVDxRGdZ2DFf6oJZzIf0bk/Xv+EBFbyD8TFWNIJVdcb7QD8rBIXdljlQdWXcoRpF
	a/xjIAHi5OnT8LTSfxcpwGJoqEZAtPVw+JfyYKHADMPy1wUsd4YSqEC5UBMuPksqOexBwCB3ax1
	sPzxWe9wcbsYyMB+h+LjBDMh8oUOATYO8rKd+IOdhwH1NFeZ5rWZjFTDYRP7EJregtmqR2TR9B2
	i3BdOOFZlS86hwtJe6xKGK3hp5/uPUDkoRytEfh8i2x5LHiduCBM9vEMRJZTPg4i4ToVYq/k3Ev
	9RjVaTPl0M4NY5bI1xY4pOIJnxO5iUiIzHaTaG8vCraaYz3gXrCxSxtheYjixoWS+COTUwjusts
	wdB4mcB1fPMkiVDF3WJffqxlG7gzEK+v+d0tWe+1aTVZ7HBXWMenBXk6bfn
X-Received: by 2002:a17:90b:4ece:b0:39d:ba21:fd90 with SMTP id 98e67ed59e1d1-39e1e491176mr13405869a91.16.1789598453080;
        Wed, 16 Sep 2026 15:40:53 -0700 (PDT)
Received: from bazzite ([2804:1830:101:9875:e21:c5c7:50e5:d44d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bfb05e604sm8941720eec.12.2026.09.16.15.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 15:40:52 -0700 (PDT)
From: Davy Felipe <davyfelipe34@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Davy Felipe <davyfelipe34@gmail.com>
Subject: [PATCH] hfs: return -EPERM for unsupported setattr changes
Date: Wed, 16 Sep 2026 19:40:16 -0300
Message-ID: <20260916224016.266800-1-davyfelipe34@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfs_inode_setattr() rejects unsupported UID, GID and mode changes,
but returns the value stored in error when the filesystem is not
mounted with the quiet option.

At this point error is zero, as execution has already passed a
successful setattr_prepare() call. As a result, unsupported attribute
changes are incorrectly reported to userspace as successful even
though the inode remains unchanged.

Return -EPERM for these operations while preserving the existing
behavior for quiet mounts.

A chown test on an HFS image reproduces the problem. Without the fix,
chown 1234:1234 returns success while ownership remains 0:0. With the
fix, the same operation fails with EPERM and ownership remains
unchanged.

Signed-off-by: Davy Felipe <davyfelipe34@gmail.com>
---
 fs/hfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 2aef3c36a150..cce3a7bb95e9 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -663,7 +663,7 @@ int hfs_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	     ((S_ISDIR(inode->i_mode) &&
 	       (attr->ia_mode != inode->i_mode)) ||
 	      (attr->ia_mode & ~HFS_VALID_MODE_BITS)))) {
-		return hsb->s_quiet ? 0 : error;
+		return hsb->s_quiet ? 0 : -EPERM;
 	}
 
 	/* map file permissions to the closest allowable permissions in HFS */
-- 
2.55.0

