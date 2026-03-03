Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB68837B013;
	Tue,  3 Mar 2026 03:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507751; cv=none; b=nLmmd+iZzUlGH0QGmGG8cSvB/2oZnEtDp5xYdJeYfSYPjz+3kKXYqa/7sOdaxSUD1130l2LJU4qDjfuZkAtronzDLaDvkAPvB33KhH+WFDiNjJUVyZoXtsi61Tkm1wEbj5U1CQXdSbUiN4Yv2KNIC6JIZVt3BfmUbls/vLGnqUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507751; c=relaxed/simple;
	bh=HjJIlzLqtOvW6ZmYsyV42NR96C1mcm7HVpRyE8vb+E0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eJeirD7EN0ps98pMOq5pCH5W1p+7wVRZP+jJ6iqTTu/xg8IzrU5Lbmt6ksuwzx4O0Ur0X+byOWgJS+VRK5SD+Un33Wd5f6GlwePBuUah/YXZazOyNVgzB6EaGQ+C+QjmJs9U77QlaE66QTuTwOyCDSQ1mv8pxWfJnAisGuyR77k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JGEUvT3A; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JGEUvT3A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ni
	+khd9KioYs7Snfbc4XsGR8k1E8WKil1E+J8Z63/D8=; b=JGEUvT3ATFCPQ0Tkvb
	6d1vFg49cdvYLMiKr4w0KhG/Pr4nwhzrpMKxMOJMkmyNrW4xyc2GcxoKR5Mujf8k
	0dPVYRy5m6T10vuvIqHkj022igYivPqKBySSb8w3fcXf6YG7ujxtiyWAXcgrrwib
	beiNzDMe8bULtCtY/g2KhiZxE=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAXh6xQUqZpOLCWQw--.188S2;
	Tue, 03 Mar 2026 11:15:32 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v2 0/6] exfat: improve performance of NO_FAT_CHAIN to FAT_CHAIN conversion
Date: Tue,  3 Mar 2026 11:14:03 +0800
Message-ID: <20260303031409.129136-1-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAXh6xQUqZpOLCWQw--.188S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF1UWFyxKFyxtw47JF47Arb_yoW8Ar1rpF
	4fGwsxJr1kJw1fXwsxA3yUXw1F9rs3tFWUXr17t3WfCr4Ykr1a9rWIqryrKFyUJ34kXF1j
	qr1Yqr1j9FnrGaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UP73PUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+BWtS2mmUlWodQAA3e

From: Chi Zhiling <chizhiling@kylinos.cn>

This series improves the performance when converting files from NO_FAT_CHAIN
to FAT_CHAIN format (which happens when a file cannot allocate contiguous
clusters). It also adds proper error handling for FAT table write operations.

- Patch 1: Add block readahead for FAT blocks during conversion
- Patch 2-3: Refactor existing readahead code to use the new helper
- Patch 4: Remove redundant sec parameter from exfat_mirror_bh
- Patch 5: Cache buffer heads to reduce mark_buffer_dirty overhead
- Patch 6: Fix error handling to propagate FAT write errors to callers

Performance improvements for converting a 30GB file:

| Cluster Size | Before | After  | Speedup |
|--------------|--------|--------|---------|
| 512 bytes    | 47.667s| 1.866s | 25.5x   |
| 4KB          | 6.436s | 0.236s | 27.3x   |
| 32KB         | 0.758s | 0.034s | 22.3x   |
| 256KB        | 0.117s | 0.006s | 19.5x   |

v1: https://lore.kernel.org/all/20260204071435.602246-1-chizhiling@163.com/

Chi Zhiling (6):
  exfat: add block readahead in exfat_chain_cont_cluster
  exfat: use readahead helper in exfat_allocate_bitmap
  exfat: use readahead helper in exfat_get_dentry
  exfat: drop redundant sec parameter from exfat_mirror_bh
  exfat: optimize exfat_chain_cont_cluster with cached buffer heads
  exfat: fix error handling for FAT table operations

 fs/exfat/balloc.c   | 18 +++------
 fs/exfat/dir.c      | 52 +++++++------------------
 fs/exfat/exfat_fs.h | 13 +++++--
 fs/exfat/fatent.c   | 95 ++++++++++++++++++++++++++++++++++++---------
 fs/exfat/inode.c    |  5 ++-
 fs/exfat/misc.c     |  8 +++-
 fs/exfat/namei.c    |  3 +-
 7 files changed, 118 insertions(+), 76 deletions(-)

-- 
2.43.0

