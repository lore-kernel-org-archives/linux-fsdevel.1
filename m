Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF00C175A75
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Mar 2026 12:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774184396; cv=none; b=s2qLYkB+V2QDgGnN705NusZBe9PjBcvrv88xHcKIfWCxDJBZvqPjLxVD4mDQBCPQtF6AaxPForB7nht0PpiWS2ROl8Z1NO9qjWrTBYUsLSE1PruIEDJmvGOP0EDX3q8sIpp3zzsgnga64hQecNPpy1sClLFQwjahx9DBfUmNCjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774184396; c=relaxed/simple;
	bh=W5pBgTVVpPwT+q1KxFqj0Yi2JSg1p3p4Veqwb3x66P4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AI4CQoAKHNna/O4fx7/Vg8VEjgQrVlt3AW072aODnZzXXqt8V9jFYEKXwqId90ezlNDM03HVUgMl95I0uuNz6XekuaDaUaK2ndkb4c7HEqpcgGf1uh9f3OyaZWqdvj1HPmKsmqsWQ+JiK3MSD5KG3CkQfZrRUB8ldICv5cPY6ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=f8Pq/CC3; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="f8Pq/CC3"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id DCF651D490;
	Sun, 22 Mar 2026 12:59:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me DCF651D490
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1774184394; bh=W5pBgTVVpPwT+q1KxFqj0Yi2JSg1p3p4Veqwb3x66P4=;
	h=From:To:Cc:Subject:Date:From;
	b=f8Pq/CC32pJjqX4GMIQDJr2gj5miyV/U0/Nalvj36+CKcpx/W4T3/9vSQbPPmPSCG
	 eLIrsZZGfbpC7gcrxmuN+jsqIJlEMHUh8HDhyllSsVMD+gLfiQSRHa5uB2c4vKbtO6
	 i1Gh6WLPIsUgOQ2UL1z3aGlhFj9pPdtux6N1JokU=
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id lqYlIcjnv2lhwwgA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Sun, 22 Mar 2026 12:59:52 +0000
From: David Timber <dxdt@dev.snart.me>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>
Cc: Yuezhang Mo <yuezhang.mo@sony.com>,
	linux-fsdevel@vger.kernel.org,
	David Timber <dxdt@dev.snart.me>,
	syzbot@syzkaller.appspotmail.com
Subject: [PATCH v1 0/1] exfat: add limited FALLOC_FL_ZERO_RANGE support
Date: Sun, 22 Mar 2026 21:59:43 +0900
Message-ID: <20260322125944.48541-1-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.53.0.1.ga224b40d3f.dirty
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes

 - returning to userspace w/ inode lock being held in sync mode
 - Errors in commit message

Davo

Tested-by: syzbot@syzkaller.appspotmail.com

David Timber (1):
  exfat: add limited FALLOC_FL_ZERO_RANGE support

 fs/exfat/file.c | 75 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 11 deletions(-)

-- 
2.53.0.1.ga224b40d3f.dirty

