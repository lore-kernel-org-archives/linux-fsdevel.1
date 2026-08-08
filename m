Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A079E400981
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Aug 2026 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786192561; cv=none; b=CZQofArvRIA4BX+Gi4X/6Ecb9dSe3ZU3JkU1998pK4VhfOYbNBtOQs4hc8CBU0MhJhdYRu6hfrk735KpxLFiNY3yDX19+98kHI78u/92sSvdvuNNAXGCUkKZTExfNWhwzLuMvWqfOY2xMe1xpT9W5fbB2lN5XrwOFK6jZzmhpMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786192561; c=relaxed/simple;
	bh=vSaaDCCuVmF2ar8FmCnssqQGcR+EygdT9BnSZy6oW+k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TxVSXI8fFCNZ/n11I57Z9JG2tQIys0SQbxnedvu6GzWoH/JCNGZO1J8VCOmOyAnq8qbmtfT3YcNbxbTerAtsJldMJe4nH8/ct92he19/Qlzy9tcCXDwvcRyRidS/LVzeZ8IjrZcPQ5i8F+q0bi5oOEWHXiLacJva3IPO259nbBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6BOgeVQ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6BOgeVQ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so5415925e9.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Aug 2026 05:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786192554; x=1786797354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jRYshfP9Ina/Q+U65sHRZbbE3Lz3C2G7D9AgZHh97hk=;
        b=d6BOgeVQHqq5vDUaz8W8W3JVB3mneBS9XlBT/pg1zWwvQn0ViyZTq1ibGsqM/A7fLb
         3QniAm0u9LGZQZwZWYECgcoxjL++7J/IMuB68zatYG7X63wNXrL6QxMKHhvog4riGYqf
         ck9EMa6L+zsp+h4/qwEwyS6PYNebZ0qBreP+1iqFx8UR2n04M4PEeYDeQCAoqfv2MrSw
         +SOZGcO6y72MCd7+gT9Cin1/clT4spShrZ6RJpqluov9jDgljKbc4J9Jnulf6yjMMmLL
         O4eR5xqVyvPQCt/8nG0jsBRmHfzuGdbsLZt6MCSiPsOclexKbgbb1D76gi/hFaGvmqE9
         9M+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786192554; x=1786797354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jRYshfP9Ina/Q+U65sHRZbbE3Lz3C2G7D9AgZHh97hk=;
        b=P1A++rHyyFa7zGvpHwWUkN/CI4eRGNRa8Bm6mI4bYUsjyL3dgLYTp8uudfIqAcs3Ah
         XmIHBWPVm198iXhYceb+A6/vFPCx7QstDvBPuwSzxiw7RheH+ficIbKQmTOIuQwGbFfm
         GExSskOoIKotkduD3vl0VfThc5lXFWFno2p+K0s15Tr+6pUBKJx6sO86LHeP2ab75A0a
         IJSXvwok0TDT0+LNnv8CjNgSL5PDUaHTQappt/wQHsGddMAe67WywDjXSZsSCWN2aQns
         EQFCzG5eFM2xvnSndxNRsHGXkE0Ttl/FaowDV0flJfH9JBSaauUXgCzuWXUx4W5fSaRN
         fQlw==
X-Forwarded-Encrypted: i=1; AHgh+RrTHFImBnhHzlMKMMOaZZpAZ3o/YDfYPl0XOa6fsqPFvCBa2rYbgkRYpg6zh2GhYeOHsr7A83AY0yAkw7HM@vger.kernel.org
X-Gm-Message-State: AOJu0YyP943OfIRato4uJAsN+3efzWiiNNrVraIRl4R9PPOyE+mZ2yKc
	0cDoWoHbamzDFLkhY/vZ1b4XBlimlJi1hLWuZ/CzRS4iZZuAgSp3RoUe
X-Gm-Gg: AR+sD11x8Ngr/OZ/gwfHQvVR493sWLDh91KxvrKk46ExK9psZtbrmbYxbeJdCKy7vtp
	yThI5+y21K+71ZCkrtqhgzNZwcpc6eEXEHpRe31mr1IIC49UaH/Thwbe78ttDLo5DcWP1F+yEhR
	pTXBtYHRAQI99eW2pjoF2BvdCiM6D8Mpw5U6M9mF7YLdD7Cs9ymHwVpdytCVLaQd0z0gjyjimZz
	FORDwMuNHMh01xZ7Wu2Qljp4dgREsRIiKUT+V15OwmM0ePfwbJmfeKJkrsB5GzcoNt/px/q09hq
	dvGK2eehF46GQ/lRA3eRAsc0YoVT7MRgaKGXO3+QvKklXqmAmZ1nwiuKubwfjX/N3o9WsL7amCD
	KPaNpIIO7pZCjNNMZj7zOym1Hi2fnVBdTm1jJOnBzxpvs2auGat/hNKQModjeB5pWCw3Aal3aYk
	1lHOJtNZS9UF8ib7p0pzqLty5vfi69TMNFKt7tQCsQ+ZK42be04G6LC6+LuSmUOhRFl24pNDJua
	RvUeTPNJmnjE3N4n0zR+qcYSkelapf2yd+0UVHsGkF+AVu32TIm7HPTVma45wWdN8NTbQjhj7ey
	T3WhvQzhf4oGlfeLybt6
X-Received: by 2002:a05:600c:3ba6:b0:499:48be:3189 with SMTP id 5b1f17b1804b1-4994e6c065fmr360149945e9.0.1786192553857;
        Sat, 08 Aug 2026 05:35:53 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-004-134.77.7.pool.telefonica.de. [77.7.4.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499542858b2sm257587555e9.14.2026.08.08.05.35.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 08 Aug 2026 05:35:52 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] netfs: Fix uninitialized return value in netfs_unbuffered_write()
Date: Sat,  8 Aug 2026 14:34:31 +0200
Message-Id: <20260808123431.73554-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If preparation of the first subrequest fails,
netfs_unbuffered_write() exits its loop before ret is initialized. The
empty-iterator check can do the same.

For synchronous writes, netfs_unbuffered_write_iter_locked() may then
return an unrelated error instead of wreq->error. This is reachable
through CIFS if cifs_prepare_write() fails to reopen the file or obtain
credits.

Initialize ret to 0 so the caller returns wreq->error if no data was
written, or the number of bytes already written otherwise.

Found with Clang's -Wconditional-uninitialized.

Fixes: a0b4c7a49137e ("netfs: Fix unbuffered/DIO writes to dispatch subrequests in strict sequence")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 fs/netfs/direct_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index c16fbad286a17..b04019097ab8d 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -95,7 +95,7 @@ static int netfs_unbuffered_write(struct netfs_io_request *wreq)
 {
 	struct netfs_io_subrequest *subreq = NULL;
 	struct netfs_io_stream *stream = &wreq->io_streams[0];
-	int ret;
+	int ret = 0;
 
 	_enter("%llx", wreq->len);
 
-- 
2.53.0

