Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792599677;
	b=woFVyy1PpwsMOErRyhS9K+5NN3EH7ze5baR0WDzarBuuGj7o0ZbDWeFtkHqIQK8nocO3
	 tsu1Gf+GGpRfSr+U+nGKPmPX+Fi3EFS8QgpYtVrDQ4LiTzlWqm01aKnaa9IFNOwgRjn5E
	 sdFuK8uUSUBuMKhnoprDoAiAsLCGTqmbmAZElcjV6tj0BTJTExDqIaTLs3Mk35lco0Q7E
	 VA5MxUlSFlcxodPbAFQT3mR7pU2HuYT/cBuEX4WakE5o5e6de6mC4wwMppcKHGbIfwgOL
	 Hzb4pgSSvXJx/AlTfG4ikBHTzOkQKyditx8TasfTUGbhrNE+fHij0gKDOQhAhMBDvow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599677;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Jda2wbT7tqKqGyGksLLtqVGQf3PLsBujqEu3F9DXXMA=;
	b=ZjVkEWsavISwa+A4cVMA/SEXXIXRKDBmWRG4vFKkL/fgY+waA408inPHM3lxfiq+M5YO
	 VvGDvRcLPP3Aq4JYalNdMVvTC/2jSVa7qxh/PiG8vZ6zR6xOHMnzAhTslrKBj6yisEyi3
	 svfzEyAitqGnQx6+pD5UCspyIyT2B7i/CC4FESpemrftRPUzsCKTqPhW+yjxff3W6uZps
	 wLL3qPXLDX+ph/6Xc6eT2Qj8ZPhiC3WR+B8CHZot/0FZJMyPwxo5OQq8rx6KAzvv5DQbz
	 huQkX1lVaw5Mz0wUNbRCiOExtrDfj1k2RQtUyYGUzNLX07KgsaXi51a/g1K2P+Shcxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=BYsSQHgC;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5991B606AD0E;
	Wed, 21 Oct 2026 16:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5991B606AD0E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=BYsSQHgC
Received: from localhost.localdomain (unknown [187.91.217.172])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 753071210C1;
	Wed, 21 Oct 2026 13:21:11 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1792599671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Jda2wbT7tqKqGyGksLLtqVGQf3PLsBujqEu3F9DXXMA=;
	b=BYsSQHgC9fa07Z1VJQkXJ9vKkX5+BJsmT7AuBCE3JGkX7weVG3hPj4B3yAfn4t28zwNbnm
	gP94YUPmc7bVrLzsHe+nfaHT9Bk0m69bWZCjDtgr0qqltWUNIzxlFg7dO0KWS6t01Om6wT
	bolQTRBgsfaU5KFRNJxL53JL8cqypPyYNE78DSjj74GXox6QAb4T9vUzqiGXq5YBBtszao
	kG6Q7JHx4b0eD8wyCNH+6cmSm2L6c3PYLGtAlzrHrppGzGUmQVm6JOE2GfvbacXMZNIIn9
	AvMfs1sqF6Yhk5GRQ7/fS4h3FdVnIP41W7z6gWySfB7+0Ig5TIQBg5iPvZUTZA==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [PATCH] fat: hold truncate_lock in fat_write_failed()
Date: Wed, 21 Oct 2026 13:21:04 -0300
Message-ID: <20261021162105.62525-1-matheus.aalmeida@inf.ufrgs.br>
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

The current fat_write_failed() implementation calls into
fat_truncate_blocks() without holding truncate_lock. Make it so it is
held exclusive while truncating.

Fixes: 459f6ed3b8c7 ("fat: convert to use the new truncate convention.")
Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
---
 fs/fat/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 141276fcf8db..2a16ed415631 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -216,7 +216,9 @@ static void fat_write_failed(struct address_space *mapping, loff_t to)
 
 	if (to > inode->i_size) {
 		truncate_pagecache(inode, inode->i_size);
+		down_write(&MSDOS_I(inode)->truncate_lock);
 		fat_truncate_blocks(inode, inode->i_size);
+		up_write(&MSDOS_I(inode)->truncate_lock);
 	}
 }
 
-- 
2.43.0

