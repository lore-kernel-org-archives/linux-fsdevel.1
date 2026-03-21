Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0EF349B1D;
	Sat, 21 Mar 2026 08:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774080103; cv=none; b=rG7j5bNRFSrsg2auRTQtu7eKc6t+cs9FurGgl7Vct/vlxzDN5TcbTWAxzKUzXesRNiSSDYquogDQFdl3+mHDYGZhcvSufUXrCmr9k0U0HZnCuMyNvRy6l/ZqHc+opUXhvlPnTYrsk6oV/c2REB5XqP+zgB535hVqyJ1Sujod6jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774080103; c=relaxed/simple;
	bh=1qXSdM62P16mSyppaNyUZXTAI558+C3hnVS+s+PRU4I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m1GQEKuML+Qx9qegTIslhTCCTQvRyVV7z85RAIOLRrlaD422sQWHGzrzEtjej8ltBjpzpWtanOUrnFn6jbQNhsQYBgrwhNV5crq4rJttD5CtvT7LIdE13vN/TdXSgBFbDa9nkujUZU+GhghxkEPLzKA1Ezf80XN6tRETyyQDIF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=KCTWOm5j; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="KCTWOm5j"
Received: from DESKTOP-SUEFNF9.tailb3ad3b.ts.net (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 37c8ce119;
	Sat, 21 Mar 2026 16:01:32 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: slava.dubeyko@ibm.com
Cc: akpm@linux-foundation.org,
	frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	jianhao.xu@seu.edu.cn,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slava@dubeyko.com,
	zilin@seu.edu.cn
Subject: [PATCH v4 0/2] hfsplus: fix lock leak and refactor hidden dir search
Date: Sat, 21 Mar 2026 16:01:28 +0800
Message-Id: <20260321080130.1292216-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d0f69e83003a1kunmf3bcb71e291d68
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZH04ZVh5JTh9OHR0ZHxhDGlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
DKIM-Signature: a=rsa-sha256;
	b=KCTWOm5jUQgveaeTHHo7yi7zeKZdhPHVm1oxK05e5KFNgX7e5vX1N9vg7mCxpLGxFX3CxKGymiERBYhnCKk2qyTb8uzIpRlV075dl8+qgTbaiKuwPvDELqusa7FD20N6Kpm7f0HFqQ02/Qr1oavUuOOM2hNTbUHFFM4/WEoCPlI=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=nrENhknAF3jMnzttcsF/codmqM6qS/BVJc4QMBUDukI=;
	h=date:mime-version:subject:message-id:from;

This series updates hidden-directory lookup handling in
hfsplus_fill_super().

Patch 1 fixes a B-tree lock leak on an error path in hidden-directory
lookup.

Patch 2 refactors the lookup path into a helper to encapsulate resource
lifetime and simplify error handling.

Changes in v4:
- Refactor hidden-dir lookup branch handling in hfsplus_fill_super().

Changes in v3:
- Use unlikely(err) for hfs_find_init() and hfsplus_cat_build_key() checks.
- Map hfs_brec_read() errors to -ENOENT to preserve existing behavior.

Changes in v2:
- Add patch 2 to extract hidden-directory lookup into a helper function.

Zilin Guan (2):
  hfsplus: fix held lock freed on hfsplus_fill_super()
  hfsplus: extract hidden directory search into a helper function

 fs/hfsplus/super.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

-- 
2.34.1

