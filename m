Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98D93DE429
	for <linux-fsdevel@vger.kernel.org>; Sun, 27 Sep 2026 22:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790549409; cv=none; b=dMt3WSr+NQF4QM0FxAHT+adhQAY7nYZfTAwl2V6xETDoyqEyBCwnyejBxVYF5RvVmEVrJcu5OAqT3v+fDxc26UmrdlKbW27gKoYnzhV1+qY9lLGo67CQ/Q6c9QhnIIUcTw/2rXESp2ji+JZWSFSy7lCQ8gR0S036R+dmUUrpMdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790549409; c=relaxed/simple;
	bh=xnMkM0G13d/99Xs7RMKUARa0W6RoJ0+onrZaWW1xL1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fnGaU4NdMTCo502QcOhER1sta2BCUoFDazK5lHXonut30D6unvpWbEeodQ/piRnxsuVhCJVmXcklGdgZCMIfae4wuTPgg1CEVVI8FOkB4Pw/Q1l+H24rk1//CDng66AV9F48PqvwL+1dMvfu3CxMdxgco8T33CurxqVMyB7UQ/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqA2Pw3D; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqA2Pw3D"
Received: by mail-pj2-f40.google.com with SMTP id d9443c01a7336-2e22e123350so1580255ad.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Sep 2026 15:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790549407; x=1791154207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d0ix5EZDXiF2tF+99ranIn+ggS6Fcte418NHD6GLqsA=;
        b=fqA2Pw3DGnsrV85gr+5OFaTlZrj8pSAkAsxkchX6Baa+qbSdfZ7tRnjOfDeGCekdmn
         N6xQtBwJh4c7eTTRBtRezfQj4HQjHVZom1ALX0pSK7iUq1D2TPm95SrTo2jzQz2SWDe7
         R1i0tFDV/z6W8cT0L9DZlefo9novQGUCyP910oDBnkjWnqviQx/JjXeLalMmLivpQr8J
         woUft95zXEJIiw5mPMGIF5/owyLQNPL7OGZEov83m4ScKusHcWjBKWqVxMuxv69OaG9b
         +UMZxeOBT0LKui0zOkTxRYB8dypuUIlruoBEq80iU01WvA7ocfWa7VoP24x6gO3zwK9W
         ePRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790549407; x=1791154207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d0ix5EZDXiF2tF+99ranIn+ggS6Fcte418NHD6GLqsA=;
        b=GTuF34UcQb3l67UoXLW+A4A0ZqDW1JsBdKuUa5U+F0jz1bPxkY8ggrJ2bWMbe4Vt4i
         4YvHh3rgHbd8hpQIlY3zulEoRb9+m9HcyYIPHqm1Qehm+Sq0Q3pStJ00NMhUX/oGZ3g2
         NgEkWr67hBYlHGLVwXF76ozYkLiE5mgJjLmmspPYXlOV3yxfUgyUvbyCUMio96MyqBHU
         24vjKB6LLztj8WzmJAxyr+hIftdIb26E0428ucQqPxGVQIjft1/AfgbFIDQGOy0aIe5Y
         ITVJjJJRTYffnW3rSzPOfkXth+6/WbNNULWUy3rbtEf7pIPFODp2dY1guHoGQmcRPNdC
         NMtQ==
X-Forwarded-Encrypted: i=1; AKwUvByFaXM64IZH84q3mPihiRJ7VyPOLyOcaLEtipAzcAihkA+qYdiOKraB5Kl0leiYzJSW60LX6mbvVe16YZWx@vger.kernel.org
X-Gm-Message-State: AFq9FYLC7v2tIrAJyDJpUNYAP4xIml3f1svawS1r10Jdy9BMQDY7BnnM
	yzv4Ft9YPpp/hj5L9uLPoUknWGT9es/iI59lhcdSTQk13xQy9rtxMvuI
X-Gm-Gg: AYBFou1vEj7iecbXXqYM4r2dEj4Bqyk14Iy0/LyxHBGAxTlwgYbf168o18FP/JWZcrF
	dsueT5bkG2PljnFWsAKb3c7egsBpO2gXhgU44xHdnjtiZI6euVLg79MJpPMJtR+q9g0gi+o/PP2
	v+ohvXMqQkqABEBlTwafdXgaj766ac5+9Uk/fnp3WU/tvtu+4s0328bCxI7Uh+spWWoSh23mOVh
	JODdYSjQozz6imBBFnjS4A8gYS9nDOPqJJfAaw1OiuFjSGn2Aq3uByEGZGw5E+a5lOC/8DmUNAz
	THhl811UtA6vvJL8ffk75GaQjgAzwBMtMnACJJ6O3tQnyVBsCAPNJR/oK4NKEk8rZN4WGVT7V5h
	tTUd/uEzvIPnHJ8M/dpRcK9kCwY0VLxNwHzGHcFh691zV4fx8fiK5n1ziR/ab0gbQWzTMxUsHTw
	TXS5q2LJZIrmS18b7ITzM0Z2nSBc5Q2cKtA6Rw8c5feiyMkF1XOlkPAdT05ZiAsW7Owz7A8Nf9G
	VHZ/xk1yPsjGISoupsaIsYo2Ch5cWp9iWitdlNJqg1f9xC0V17/iaE3KIyfPUaWc69pTw9JzJyn
	GRigNh9KCYI+UrsaMUoHMJVDgZK5rMhl+5m5Ky9Bqpw4LHAD3Dclp06kJG4=
X-Received: by 2002:a17:903:2ac5:b0:2df:b45a:b673 with SMTP id d9443c01a7336-2dfb45ab781mr27172175ad.41.1790549406960;
        Sun, 27 Sep 2026 15:50:06 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df913e13c8sm31971165ad.25.2026.09.27.15.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 15:50:06 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Hui Peng <benquike@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] qnx6: keep the top-level pointer index unsigned in qnx6_block_map()
Date: Mon, 28 Sep 2026 06:50:02 +0800
Message-ID: <20260927225002.509062-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qnx6_block_map()'s top-level index is levelptr = no >> bitdelta,
computed from the 32-bit block number no.  With bitdelta == 0 (a
depth-0 tree) that is just no, and assigning a value above INT_MAX
to the int levelptr narrows it negative; the levelptr >
QNX6_NO_DIRECT_POINTERS - 1 check then passes and di_block_ptr[levelptr]
is indexed out of bounds (UBSan array-index reports index -16777216
and -8 on crafted images).

Reachable with a crafted inode whose i_size is large enough that mpage
asks for block numbers beyond 2^31.

The only other assignment to levelptr, in the loop, is masked to
ptrbits and so is never negative; making levelptr unsigned leaves that
path unchanged and makes the bounds check reject the large values.

This is independent of bitdelta itself being too large to shift by
(depth * ptrbits >= 32), a separate bug in the same function that a
still-pending patch of mine guards against; that guard leaves the
result of a valid shift assigned to the same int levelptr, so it does
not fix the narrowing this patch does.

Fixes: 5d026c724220 ("fs: initial qnx6fs addition")
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 fs/qnx6/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 6de49333acad..7df3eed5142d 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -117,7 +117,7 @@ static unsigned qnx6_block_map(struct inode *inode, unsigned no)
 	unsigned block = 0;
 	struct buffer_head *bh;
 	__fs32 ptr;
-	int levelptr;
+	unsigned int levelptr;
 	int ptrbits = sbi->s_ptrbits;
 	int bitdelta;
 	u32 mask = (1 << ptrbits) - 1;
-- 
2.55.0

