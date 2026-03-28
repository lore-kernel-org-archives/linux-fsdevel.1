Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1E833D6D6
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774712311; cv=none; b=i/fsM/SKLmIkQgRVwqGnltOO9kJfRwPvBLhdMQXeDXnvD61GFTwJ5J0b3u5octN3mMtFNqP56JVwhJjYcRVjAo8HimUpk9ae6WEIa+M/XKHsjuJd+A17mEFGqVnTiKmPuFgRJ5goJtlE3ysQ+6U3Ph6aqb7yS1Bdb/CsNB0yvDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774712311; c=relaxed/simple;
	bh=gmOLacFBLCNj5VvdypSCbBb3+/owFsIUDBdTNEiM7QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kdy9vBR26OvoA2Oabn1Mtx7TKYYuwFvUDRN5y5QUr2ADFGY/Yq8GGv5WxniPeHaxsZcKM6T35OR9rSFnNRpP4uxkHAqpYb/cTPkAYs1coPmN4h4My10B2YmoqGgkzSm+evz7uAyLIYJ2fQUES6aJx3aryaehjvbQv92l6F+XmmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsKO5nu2; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsKO5nu2"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cf5d14d6eso315141f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 08:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774712308; x=1775317108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQLr+3qAuCwpPc4ueOptHqyuEcLu/FKN06xV1u7l/MM=;
        b=OsKO5nu2vgjueinaqtcweQ0o9XDaX3yPAAJCZxzoRl1HnxU6+2csLTkKu1ZHYV8LQr
         jKXycxLj0P6YWGBwmlQjdQUBPiEjG+EhC5F98xi4R/rzbVqJjSGYLSt8NmJKQxDpKjZQ
         NvVRCb/o7qSfPiEro6CyEZV7xhi4oT7oYAtxr+jPIKH6P1nYK00Lq1DF5PLrtRE/7y+E
         PIsjSrZv5ZDQT5uRXFOFvx+BLXbB2mDhIL6U0hmr2tbtmyxO2Vreadyo/nmHhXFfjq7x
         p1QL45mMEQgKLUdMCOWI3YCOIVo9oe1qAkGsBMvy5yvtFzOXYfiDGEDBv9UuuOuaHIHu
         cSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774712308; x=1775317108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KQLr+3qAuCwpPc4ueOptHqyuEcLu/FKN06xV1u7l/MM=;
        b=Wk8W1UJhVZQDRECrff8SJc9tkpuZmE8OYbDtLnJoPXjqfj/R1n8iwu3/25DZs9IlUz
         TCNeK74W1tH27WynRQHvDTTQtXFS9ihakoK2O96oHox8O9wAvhFqzIkCC+iq2vgypYdQ
         x+kcJrnUHrgyC1gh08kwVhTgBGhqucV8CFsPfNR5AdY9GQNlQvtocf9GZ1jLdvBHqyIF
         UcH2VImfA1OlQovmOb9WnKrAVby1/4oT3MsgnI6JqG1PZvQJl5Yy9dzfvd1XsRWhtRG2
         nRzOzc5J3PKPPy6D3mPl1nw05THXvhlqGkAXBNmfjYqP41vA/M16zV8KmPiuCiTDb0if
         mxEg==
X-Forwarded-Encrypted: i=1; AJvYcCUuEETrENwF9CATjGoj5KpOSepFIbj3SoMp+MQsSNPZPG0gaDpIt6uNQ55xfllpSXclylDhzZcqpF5jBOSb@vger.kernel.org
X-Gm-Message-State: AOJu0YzVcrTdzpT8S5RW5/3Ge32Z78GpTl1sct0MhfgRqy9aBusgLftO
	nt7Nx2GNuzr236XTleuBcp23Q833S46RAPd4EG+tC54gK2yFWS6OUAJc
X-Gm-Gg: ATEYQzwILpEx7oxHI+pY2yd509CF3syPvWzxXgXFezZ+KjEUGRvV2cRmEaKCNygQoNP
	P1NC1SmLamzZAQI5ywJtsewvs1it7AzOXv4MQ/RaGLXvn6RpHqXQUfXAFD+WIZ47uVoJ3EYn2Fh
	fuSIn4FlaYpiIBv6sz98VjoukTyYMys3zLoDuHiPatKR+2C7nXsmE2u6t+PRRy8AhYIPqgTIXsz
	QY61fEXTCkd0NZ2tXgUyEgOqwQ1LzWEew3T8acz0TVvQOX2VX8nf2vqSCPdP1y3xUwlnSyn5ZCh
	6SlL/EOv4ig18l1m0PM1gTsUghgEIJxrgiv+gNzd0RLC7JebiFX6aL11B1xNEZzwWXLuXXW2q74
	HdO39so9Zg1J4VWH/HT9uzmXVZwE+QHo3HmN/M/SCCNhSq2OoQy0E2FCoMIAeAmXHEMOoPQUcI6
	qjMVM1VGQvsoq8OEW7rdTEI3bfnl3cdKBJ0v9pT1MsJqhW1ahy94CG5tU+omn/QKN83wdiF9z+H
	50+RKNBV1Hs
X-Received: by 2002:a05:6000:2311:b0:43b:6a16:17e with SMTP id ffacd0b85a97d-43b9e9da63dmr10805829f8f.11.1774712307989;
        Sat, 28 Mar 2026 08:38:27 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf247102dsm7196887f8f.27.2026.03.28.08.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 08:38:27 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 5/5] fs: locklessly bump refs in igrab as long as it does not transition 0->1
Date: Sat, 28 Mar 2026 16:38:07 +0100
Message-ID: <20260328153807.3368975-6-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328153807.3368975-1-mjguzik@gmail.com>
References: <20260328153807.3368975-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bump is gated by I_FREEING | I_WILL_FREE, but these flags can only
legally show up if the count is 0. Consequently if the value is at least
1 and it succesfully CAS'ed to something higher, the flags must not be
there.

I verified all places which look at the refcount either only care about
it staying 0 (and have the lock enforce it) or don't hold the inode lock
to begin with. Thus the patch retains the invariant for correct consumers
and does not make things worse for the rest.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/inode.c         | 5 +++++
 include/linux/fs.h | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index fc6045e6d43f..17b925887382 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1580,6 +1580,11 @@ EXPORT_SYMBOL(iunique);
 
 struct inode *igrab(struct inode *inode)
 {
+	if (atomic_add_unless(&inode->i_count, 1, 0)) {
+		VFS_BUG_ON_INODE(inode_state_read_once(inode) & (I_FREEING | I_WILL_FREE), inode);
+		return inode;
+	}
+
 	spin_lock(&inode->i_lock);
 	if (!(inode_state_read(inode) & (I_FREEING | I_WILL_FREE))) {
 		__iget(inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 07363fce4406..119e0a3d2f42 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2234,8 +2234,8 @@ static inline int icount_read_once(const struct inode *inode)
 }
 
 /*
- * returns the refcount on the inode. The lock guarantees no new references
- * are added, but references can be dropped as long as the result is > 0.
+ * returns the refcount on the inode. The lock guarantees no 0->1 or 1->0 transitions
+ * of the count are going to take place, otherwise it changes arbitrarily.
  */
 static inline int icount_read(const struct inode *inode)
 {
-- 
2.48.1

