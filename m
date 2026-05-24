Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B81438D017
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 May 2026 05:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779601368; cv=none; b=aaQ4Jx3zYuy7bkK3vofj5C7ZbAH5b/zvkIBBrjNldOUsMoKOexEushkfqXyxlMnhj8pgTKgRp/AyPwnZffNAlaJ6Xoi+PSHMqL0JIpMXTfG+lZbx20H59mLy9V1oSmAYTokP34IESN3sGCwm5rpHPtQpaE5ibAmu/Zj1X9+nYkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779601368; c=relaxed/simple;
	bh=G9Y04Vr5T7wG0e0exZw7O24VZHQbDNIe+7kN4TkOKKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRQneowNuRR2wSxrPeKcLHMf916S5UDE+RYVXFz1pomySXLM2mF2hTprWMvZDVg09gSNvPoli7lsOZ+axJSTW9PetbINp5jZthPjb5WHzcU20KEpgdxPIXNZlQ7VTw1vN/YpGsNIPkkfIL0YDVrhoQZ1ny+rGzhfo3qXONairWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQQI7+Ou; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQQI7+Ou"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c8239019aa5so439065a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 22:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779601366; x=1780206166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meZqVzUjollE5pQHgO4NuBh2AucH33iC2AvQiTWocGU=;
        b=XQQI7+OudhC48bK0xUwCBtW/fRfD6gU4g5iD8YVP3xzUsyYP0Cfl7jxCjpnPFCvr/Q
         66ctAcynCaBoS5FleM4a1FsBke6/FtuVsh6jgZXxFuJJaf+QwSS9YaqnynNQWCZP43z9
         oNaNI1lqajSjOh56CYhx/ap6yrjuAy/hcY0xMIrDpx611RXGDV6FkkipkOKoY6qBEgEA
         sQCHdGntFbb8Bz5gabvE3tUeM/4IjdCp8/kyTzTp0FrZ9MmBQEuujUnbi906RTTuPH5S
         ep7TAtiT+2JjkvPz+kabzPgYwI1LPyv00GosD7GLqlANw2fFg3fU9rdtViJy88aJOPHZ
         v+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779601366; x=1780206166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=meZqVzUjollE5pQHgO4NuBh2AucH33iC2AvQiTWocGU=;
        b=E0eUqyr6eDsLCIOrATC+NrcOvc0ey2P9HOvgCEldsvG4RVJf9Z4JjxP52ISb/MgmDe
         n+po9TzNvu0CvNxbJUPSNPNQexH861LWePlbf047L3Bqmk36F4QkiqxMVHDeN8o1OoBC
         VhZlVLOjIKARkhFRPPwamBP+/y75Ap0BZDfIJSISIEPP8YQ7q5IMv49BAiXL6AHr5rx6
         aV5sWz9/ZgGZNpNLkgl11UxMOuxPlYEgC/htI8ze8GVfpkzx/2QAQxyl5sm/Y3jiI20G
         H4BeRp/Nzva937Ry8JzuiaO8yDeyEtKtpqI+dVMH97ZgjHKWE96vRiRGbeVESGBqQEcW
         Qhig==
X-Gm-Message-State: AOJu0YxO7qvEWBThSuzSEtcRV5eiEEeE9HfVNcQY8AkmLaCuxk/FTYt0
	EOtiH9n8Os/deOGxe/RJMsSksQzWOYqs/cBF9iEgIKw23blAoOgH+UrY
X-Gm-Gg: Acq92OEzfmIWgBhmQk/Nv9psmXhxj6KUIIW2hWNkswKnSZPjb+y8qJLstLQVZMgSsn3
	3+faYvZmfzHc39iDSACz3zBo97T3jiWtwES9sjgWjFj/0aZq5kEXnD9E7/Lzb/BEpwihrZP+e/4
	U/J2yBxZnyuYJzNl89l3yMUKjzECm9PcAZJvonf7LB/rl8eEn10bscz0Qh/HgRG+6rCSjGh6L97
	qDGQ16cgcU9mifJByG05ed1aNy1kEawoC/XlH+f8uXuukzMFQ0w8wCi0shrazDiw+RJDJGhx2R8
	ObBbwjbnEo38a4aya5LNY/kWTT9MI/Z1EtN5el0YAmFXkwRijTMaVxkRIiVqrLyJ+ZeXsYl8y3h
	3lpAXL763pAo+MZXZchw81kOL+zxcF+PZfGVVbJe5wYfwBOyKfvNSHWJOsvGcBoaHiVRHDffTLF
	YLy1VWhxterjP7AHAg
X-Received: by 2002:a05:6a00:2d83:b0:835:36f2:7332 with SMTP id d2e1a72fcca58-8415f0d7b2dmr5242919b3a.2.1779601366503;
        Sat, 23 May 2026 22:42:46 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ff7d80sm6726848b3a.56.2026.05.23.22.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 22:42:45 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH 1/2] ntfs: free link name from ntfs_name_cache
Date: Sun, 24 May 2026 14:42:37 +0900
Message-ID: <20260524054238.3129288-2-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260524054238.3129288-1-charsyam@gmail.com>
References: <20260524054238.3129288-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_link() converts the new link name with ntfs_nlstoucs() using
NTFS_MAX_NAME_LEN. In this case ntfs_nlstoucs() allocates the result
from ntfs_name_cache, and its contract requires callers to release the
buffer with kmem_cache_free(ntfs_name_cache, ...).

All other ntfs_nlstoucs() callers in namei.c do that, but ntfs_link()
uses kfree(), which mismatches the allocator for successfully converted
names.

The conversion failure path reaches the common out label with uname ==
NULL. That was harmless for kfree(), but kmem_cache_free() does not
provide the same NULL contract. Return directly on conversion failure
and free successful conversions with ntfs_name_cache.

Fixes: af0db57d4293 ("ntfs: update inode operations")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/namei.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index c4f82846c58c..9c1c36acfad2 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -1532,8 +1532,7 @@ static int ntfs_link(struct dentry *old_dentry, struct inode *dir,
 	if (uname_len < 0) {
 		if (uname_len != -ENAMETOOLONG)
 			ntfs_error(sb, "Failed to convert name to unicode.");
-		err = -ENOMEM;
-		goto out;
+		return -ENOMEM;
 	}
 
 	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
@@ -1563,7 +1562,7 @@ static int ntfs_link(struct dentry *old_dentry, struct inode *dir,
 	mutex_unlock(&ni->mrec_lock);
 
 out:
-	kfree(uname);
+	kmem_cache_free(ntfs_name_cache, uname);
 	return err;
 }
 
-- 
2.43.0

