Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F8530BBBF
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2026 21:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776633739; cv=none; b=C7ZbNCIWsXSnl9Q57h6HDKQ5gIR0MRXlZPB1eROh1sxVJqOeIYpLv21htBmpxMsb0PU5HT9sGHUVJe4nolCQh7Z05MuTzGtCv6Jvkpx6xX6OCdAKwvqfWgxk1Ss7Tu5T/p467vgXis5L0y4IuNuKnBY5TSBK0ICzZCHv3tkM7kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776633739; c=relaxed/simple;
	bh=iyYciPGfOWS+PP4eS+FUuE/6DmHsutqvGRb809Gt3a4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/O2y3voWoBqbN6YIDOTo2yS0gu2ybNNzOLidRJa4Ybx5fKoSYGUPDzM9P8szxwXTwDWBRnZII2gX949TL42zcKby6NgwfPGBwjQTFIFTBURVMiq4wb7dhSo1IRhbyecKyGfZ2TCs+0jr7RDlnXUCwYDVfjgR2I9SX36NyHMx3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzHHOgUh; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzHHOgUh"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8d67a483d3eso270823185a.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2026 14:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776633737; x=1777238537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xR/LK1vY5jMYZYpJbaDoVbD4RzkYk8NMN3z+ldfPAwI=;
        b=HzHHOgUhWj+nC27pznyTLokTvYsk54RJ+D0dyQE3u549ihFLTnAUp/1JALCrY80q9s
         eL8Bj4UrOuRWz2ZOYWDTeezP4z8JUMEvOeZdi0s1yEXs78QqtnumGZT9+oSzuUWbqjZE
         ElDUot6NCb6lPGwG9+0vcaJhxQsZyD5nJoMQsc7TzbpF8c3aaFOms0jhVUuxZhRrMERT
         4n6mQZIJHLVOSeyX0opgINAFGacKdg+qHG7nsDOWY6LE3rVj6w/RDEumflNRj/sRXd1m
         RCBURDP+iQVP4hsJLIGdKg8kOuDXwCavgD+b2Qk/SwD7Cy1mnMknjV9rr+sNc1Lbzoyq
         xsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776633737; x=1777238537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xR/LK1vY5jMYZYpJbaDoVbD4RzkYk8NMN3z+ldfPAwI=;
        b=LLIHAwp8V5CLav9enZzfUq4wkRWwB+0Vsb/F8awx64ii/gVxQ2ncgR0c5Vou6RJvl3
         vgGuUjRmzZUk6sbHP1IyKsdM5h6lZhwJzrZ676dNCONtuMo0Y+Rzrh4v57oK3zGz8atz
         kAh8iZp43IP9O3Kw1JUtb+3YVcTW0xKRKO0Ex/fANYB3PGTtz8gNqI6e0j296Vah9ClR
         9n4AdvmlLOaV2HCRY2gSQrpXIX3C20vuQmIz0ET9l+uFi7tg4dOhI5WJ4dRasWyIgJwq
         9pnQ1oA9GUrlA/FmnvXYHC4OhGZzGnx5XLiSGCrrz0zMy0Njx3X7PcIuy8GIL1OTOauH
         byhg==
X-Forwarded-Encrypted: i=1; AFNElJ/EebKm+9NHVwNzfnEaAztEp1JfKMIYhtvGz1kB/Xtmp+YsRWtaz3rRai9jzplLwS5L3op/1gHBJK0idss3@vger.kernel.org
X-Gm-Message-State: AOJu0YzNKwkqzuXXCe84kcpx9kFNoEUt3eakvEZdjCpFOVHfVwA1V0Me
	sMyKsKtB1d5222ZsUjTRY3eoSnHRneAxBmPDmdi98gv3UQQN+0LgIA7U
X-Gm-Gg: AeBDieua5lqO8iV2I9yUs5m+NTUj1lCi2vRPP8AKRaMuePribFoLf8zTlbMjdVSMx+p
	D68A+zsWNdDoygO5tf1OUHDAf2TXfrQ9NGaqEjORXeteSJGde/P9VsK5Wpyju5w+ZyJn8KsW9cq
	eyO/oRBeHNc72IcMXhxj+zNgyYiI7jS72z7FLwhHW8mGC0IEcWXpaLuFWJpwyvmVNdTJnrlUnbp
	jcm6JOYbVGRM14yWUuJkg73SWdsZoInxn3pPmUXbsUnCScoROwEM77qwx/wGAMNS2Z6ssNyWrtB
	1qgZRLRdrSlpnFbPbm0O6GWJkFWHBiTDuRJE/YHzajq0sNYoN8jfc9AjtrKzpQ6IIys5d2zpjU6
	po92sbapz7wiVAWswLYIPjXhNhTAlVL0UpE1sZ52g7UqtP+A5tDnMu+WEz/o5TnNHfQO8D8NNUK
	Q9f4scjNUzcarL+2F7fvqpf1Rx/uY/ksfaX4tDX+pl0V2u8a1oWHd+bilwbokQz2Q6lY8QzoZYp
	wAv9s9DHhxL/gJBL0SBmw+pRgmmIyA=
X-Received: by 2002:a05:620a:44c3:b0:8d6:39c0:e6b2 with SMTP id af79cd13be357-8e793047868mr1577053385a.62.1776633736831;
        Sun, 19 Apr 2026 14:22:16 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d65c1321sm654849185a.15.2026.04.19.14.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 14:22:16 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Edward Adam Davis <eadavis@qq.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] isofs: validate block number from NFS file handle in isofs_export_iget
Date: Sun, 19 Apr 2026 17:21:55 -0400
Message-ID: <20260419212155.2169382-3-michael.bommarito@gmail.com>
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

isofs_fh_to_dentry() and isofs_fh_to_parent() pass an attacker-
controlled block number (ifid->block or ifid->parent_block) from
the NFS file handle to isofs_export_iget(), which only rejects
block == 0 before calling isofs_iget() and ultimately sb_bread().
A crafted file handle with fh_len sufficient to pass the check
added by commit 0405d4b63d08 ("isofs: Prevent the use of too small
fid") can still drive the server to read any in-range block on the
backing device as if it were an iso_directory_record.  That earlier
fix was assigned CVE-2025-37780.

sb_bread() on an out-of-range block returns NULL cleanly via the
EIO path, so there is no memory-safety violation.  For in-range
reads of adjacent-partition data on the same block device, the
unrelated bytes end up in iso_inode_info fields that reach the NFS
client as dentry metadata.  The deployment surface (isofs exported
over NFS from loop-mounted images) is narrow and requires an
authenticated NFS peer, but the malformed-file-handle class is
reportable as hardening next to the existing CVE-2025-37780 fix.

Reject block >= ISOFS_SB(sb)->s_nzones in isofs_export_iget() so
the check covers both isofs_fh_to_dentry() and isofs_fh_to_parent()
call sites with a single line.

Fixes: 0405d4b63d08 ("isofs: Prevent the use of too small fid")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/isofs/export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/isofs/export.c b/fs/isofs/export.c
index 421d247fae52..78f80c1a5c54 100644
--- a/fs/isofs/export.c
+++ b/fs/isofs/export.c
@@ -24,7 +24,7 @@ isofs_export_iget(struct super_block *sb,
 {
 	struct inode *inode;
 
-	if (block == 0)
+	if (block == 0 || block >= ISOFS_SB(sb)->s_nzones)
 		return ERR_PTR(-ESTALE);
 	inode = isofs_iget(sb, block, offset);
 	if (IS_ERR(inode))
-- 
2.53.0

