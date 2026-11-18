Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794967336;
	b=En8PBwE/PqyQl/I9nLWQ8TzqyRysgcm2YDHV6Obcj7Jl2L57iMlYtNAmEtPS6tRyw9nq
	 X4Ql/uBI+bCkCgd2496kVz5D+dVFLJRISzn5LW6ckoWzncW8otRiW9WoIk4CY32RaX16K
	 ifM767U48eoNW7D6/pIJSAkC5W/kpEU08TA6EOGDUUFz2asoF5AifiVpuXp/E7axN7Nlq
	 DNIpmtckhev6GRggZYmrWTHeVGeENUwGu3mf4nTVtLxgzsuqaETrsGOjU/VNLjLeVyhAO
	 5Ef0DhzUNwBI85bcFLoQZtNMF+0qEtEpNBHiFhMcFNFlhDFsiWX9sydBfO4xvFOpGLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794967336;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=y0NWDAivOYRVyR/9e5o6JnVJlwWtc2cqwg7ldNwWTZQ=;
	b=1xZV/Sdnoaj8JtDIgJdDWQzqA1jVppDGJShPRLbEswSPgiM8wNPRZH4eNLlVIu380DHQ
	 RjVM9SDJjewU9kie5K4Giq9To7OH11OAIeBP7nxSuUkP7pgFU9OBIS3S6o5/8wrimILk6
	 rWrJg9EMM7fZdYAcwLAvVRzWNr7Lf19Sd6+VFYPijMl+osTDLS+EujNyuuTWHrh/2aai2
	 p4hyLe6cWyXSDO6wKSqRMDDMLdopkeSkseEX894luWoJLTmXtaa1kTJy+INvSLyC4hVi2
	 4TdLJNv6JVIeKTqxduUg3q7rGb5NIZyrhmCLDOTDihkpGmSlbyDalQwkpmXJq/KEuSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=WLeYu3+g;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFC6606A31C;
	Wed, 18 Nov 2026 02:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBFC6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=WLeYu3+g
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 47EEA1210E0;
	Tue, 17 Nov 2026 23:02:04 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1794967326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y0NWDAivOYRVyR/9e5o6JnVJlwWtc2cqwg7ldNwWTZQ=;
	b=WLeYu3+g8nn5JQDkQtnpaJej719zrOmbgjnILY22dLJF24DI2kVUDdpbnmYMvEXbqebB6p
	M87kgOsxiN7TO+bwcsBnakQdUMmblgHZFeh5HyQqJd5SQbP0gw8DxJu+SMxypYwNL7bhQ3
	xh2YwL+if9cbTBeMq1J+T3UOK1HPaK4lqm6Yt55WsbVb9cnBtBDH3TrWsxdiWTaX1zwYVf
	i33X6WVuRzHztgXm37NYOXTpUeMMw6/G9oKGuA4l3CjwnPQ0jejgGDnMKh8o7kZkzGG0nh
	9BzhfdTJy5tTtiF/+2SgEHCgyVnxnfG8vjKUlqYJm6Ts+nwEmuPnjihkjiE3Cw==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@lst.de,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/8] fat: convert to iomap
Date: Tue, 17 Nov 2026 23:01:40 -0300
Message-ID: <20261118020150.1023865-1-matheus.aalmeida@inf.ufrgs.br>
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

Hi,

This series converts fat to use iomap. It follows roughly the direction
suggested by https://docs.kernel.org/filesystems/iomap/porting.html,
with the exfat conversion series and related fixes as a reference.

Overall, the largest performance improvements were seen for extending
writes (~60%) and fallocate() (~30%).

Changes in v2:
- Rebase against latest linux-next.
- Rework DIO, using direct_write_fallback() instead of a fat-specific DIO
  fallback function.
- Check for errors/short write before truncating on buffered writes.
- Clean bdev aliases after unlocking fat.
- Rework how fat_zero_and_extend() gets and zeroes its folios.
- Rework cluster cache range lookups.
- Return IOMAP_HOLE past EOF unless writing or reporting.
- Drop i_rwsem from buffered reads.
- Use iomap_folio_mark_uptodate() when zeroing folios past EOF in
  fat_zero_and_extend().
- Don't roll back allocations on ENOSPC in fat_cont_expand() and
  fat_iomap_begin_write().

Thanks,
Matheus

Matheus Alves de Almeida (8):
  fat: support FIEMAP
  fat: use iomap for ->bmap()
  fat: add iomap direct I/O support
  fat: clean stale bdev buffers of newly allocated clusters
  fat: drop ->write_begin() and ->write_end() usage from
    fat_cont_expand()
  fat: add iomap buffered I/O support
  fat: remove ->mmu_private
  fat: add multi-cluster allocation for write

 fs/fat/Kconfig  |   2 +-
 fs/fat/Makefile |   2 +-
 fs/fat/cache.c  | 100 +++++++++++-----
 fs/fat/dir.c    |   1 -
 fs/fat/fat.h    |  20 ++--
 fs/fat/fatent.c |  67 ++++++++---
 fs/fat/file.c   | 304 ++++++++++++++++++++++++++++++++++++++----------
 fs/fat/inode.c  | 248 +++++----------------------------------
 fs/fat/iomap.c  | 175 ++++++++++++++++++++++++++++
 9 files changed, 591 insertions(+), 328 deletions(-)
 create mode 100644 fs/fat/iomap.c

-- 
2.43.0

