Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793465040;
	b=bQXRXOVYbX5TZJsUkThjk+mylZAZBURDp5RRd9egAysApE0Sqc+Xyxm2CkXfaDRlkjxo
	 wEJFjbR4maaGsR3crTAcSxYgo4wmH+9R6xqDU1aS6p+rRA7cQV/P3UNcC1hTpPBSq9LaO
	 SQI55T3LDxMD5x1F+E3fCd0P1FzrHqoNmbLwJwsbBFtzOZP+kErn4FtuywArutF20YjjJ
	 APeicVG9iIPiXJTK/PY8wq8gCsZ1A+IXMA91UkjtrjO+bBUd1Bhqd8R+wkXboIaILJPGM
	 OQl5yIOL0SwOl+MHsRhdiiIj8K47mRgGcjesnWC9zVtehphyy8CMTYkSnQYmvzBlo4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793465040;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=htO4y8Jcii89sIWN9YYC+xewu8E5vXH8dUHgiKAmlcc=;
	b=jYrBHjypbz6KKjrUYZ696u+aIBu74weuH2u8llfHqOsxXR9dzU7cNiDXmyEeOuFweIo7
	 TJBLF8BV/TqVVKPOFfYGyL3ORhfapfTEhwdTfc6A3tDrqfiZOdztcWYq210I0siQem3UF
	 Nh2ELQ1+Ge9dBMEFcRKuuazE97qJg7Yx1Ypk/iR3JSSEWkU8s/tMPxz5ZPjhyl8NAwSB4
	 Wy8v6j273JCrytx4XqyT3s1dDsirU7fVICzkOILDGCiN3dqmLtWda0u3eMUkGFmIOlNFR
	 ysCOrb5AovknEhreiL1kbovc+HDybq7+OOJ6kMKPBLP3o+cNn5S4+pnDZGMhBT7axkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b="TMQfAw/h";
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FAF606A31E;
	Sat, 31 Oct 2026 16:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65FAF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=TMQfAw/h
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 5C5FF120351;
	Sat, 31 Oct 2026 13:43:46 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1793465028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=htO4y8Jcii89sIWN9YYC+xewu8E5vXH8dUHgiKAmlcc=;
	b=TMQfAw/hUdDodiYjNk5tmyy2yw8XgvRwD1Ns/6CEtWTDyFaCSWuAkS3Mb3PEkObjCQX3mV
	AvjNpIMy2SkCxY6RMwzxna0g0lHA8QDH1Fv4mUSOvzHjc0icmhKtADMWl5/fLH0DUvcce0
	7J5kRSAadyYpNnoRq4VFbalSxjDd8NjPNIZ+KMQQjajoH6YZAbEbGKznC9n46W9GH+zcIT
	NbdlRPrFoxvfYRstl+0CR5epGXke9FI4+HOIiJIY6xYugjolezbWaRhqyNoQJqoR3QI7mE
	nfevHw/K34feFq1Gn/15BjhIRwbsAkWXijw0Aj/RKfTlMJiSWVBN311ZOivZOw==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@lst.de,
	linux-kernel@vger.kernel.org,
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [RFC PATCH 0/8] fat: convert to iomap
Date: Sat, 31 Oct 2026 13:43:18 -0300
Message-ID: <20261031164326.278125-1-matheus.aalmeida@inf.ufrgs.br>
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
writes (~30%) and fallocate() (~18%).

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
 fs/fat/cache.c  |  95 ++++++++++-----
 fs/fat/dir.c    |   1 -
 fs/fat/fat.h    |  20 +--
 fs/fat/fatent.c |  67 ++++++++--
 fs/fat/file.c   | 316 ++++++++++++++++++++++++++++++++++++++----------
 fs/fat/inode.c  | 248 +++++--------------------------------
 fs/fat/iomap.c  | 180 +++++++++++++++++++++++++++
 9 files changed, 599 insertions(+), 332 deletions(-)
 create mode 100644 fs/fat/iomap.c

-- 
2.43.0

