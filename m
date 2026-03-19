Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7977C28030E;
	Thu, 19 Mar 2026 04:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773894974; cv=none; b=i6qati1hdjnQnWPpxhDFmfG7ih6aGAakjvz1bNoyiWHE6dC7UPOa896s9JiOiBTrzEe3tywrftTD9PJ7gp4xhSJFjy7EfzlVa3/uZOBSlEYl/ETeBOpKEkY/LIPhA9PPBKB8GZYPFc6BAYbuEvjDupLZTK1m/Brv4wHxCpv8oQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773894974; c=relaxed/simple;
	bh=Ew4FRxmNfNQrq9XGyk3qmMGOY2PcKp8E8gHJHUoD68A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b8zH3BuigqWJOJtuTG5I5M5nL8knY2f+ZlZF7qnUHYFbjt8czIxcrzt0cte9VjcsS93YBhM0aLCnV4jEef/qwAIqWSDc4oWqtiURN3ZtXSINnE5eV1EFjGMg4N3htWZBTk2/9zJ+CBnMy6Grzl0ZjH9obICqw04soRxB3FvYRF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=EafgjOeW; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="EafgjOeW"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id B99A11CBC0;
	Thu, 19 Mar 2026 04:36:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me B99A11CBC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1773894971; bh=Ew4FRxmNfNQrq9XGyk3qmMGOY2PcKp8E8gHJHUoD68A=;
	h=From:To:Cc:Subject:Date:From;
	b=EafgjOeWoADLfDfsfkiLBAhd/dqMeAeGuSyfwWMrel/KRUQ5/93i5Aq1GqOM+vweH
	 DgHzdhWPKnhrvz9gdd3V76Ce//c39FpKp4xAoI1v4U4xGk1LaQcHDuxMVNuNVZJycY
	 V5Op6pRlSBPXOsMtV2OQstE0B1id8uhgYQdHbvlw=
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id DDFLGTp9u2kIhQcA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Thu, 19 Mar 2026 04:36:10 +0000
From: David Timber <dxdt@dev.snart.me>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Timber <dxdt@dev.snart.me>
Subject: [PATCH v0 0/1] exfat: add limited FALLOC_FL_ZERO_RANGE support
Date: Thu, 19 Mar 2026 13:35:52 +0900
Message-ID: <20260319043553.301185-1-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.53.0.1.ga224b40d3f.dirty
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is part of my exFAT fragmentation optimisation project.

As exFAT is fundamentally based on linked-list structure, cluster
allocation is not a cheap operation - it involves walking the cluster
chain as well as bitmap so it's not particularly easy on flash devices.

The purpose of VDL is in part addressing the issue by allowing users
to clear the contents of files without changing the cluster layout by
only updating VDL which is O(1) op. I.e. reduced flash wear.

The fallocate support should see applications in recording devices like
dashcams, IP cameras and DVRs(digital video recorders). Such devices
typically implement FIFO-style file rotation. Also, the technique
could be potentially utilise to eliminate the chance of fragmentation
if the device preallocates clusters for large media files.

The `fallocate -d ...` and `cp --sparse=always ...`
commands(util-linux) can be used on the files in exFAT to detect zeros
leading up to EOF and update the VDL accordingly.

David Timber (1):
  exfat: add limited FALLOC_FL_ZERO_RANGE support

 fs/exfat/file.c | 75 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 11 deletions(-)

-- 
2.53.0.1.ga224b40d3f.dirty

