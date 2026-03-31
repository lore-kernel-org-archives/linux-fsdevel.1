Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846703EB7E8;
	Tue, 31 Mar 2026 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774948346; cv=none; b=A97fwpPR5NrMfIdhQtQDcKwryC1ucWnSywCALMmMMlCXwT5fvEGKsBhxDcQraOWpjkxV4o4lwzWzxZlv2bHyLwMp0FbtkMWWPbbUebP3hys3TTU826Q3aSMSFKbrcCVWqqP0e2ckyMaC9FOPwtEBZUdGSEr0zl9yf4iGjeiVpeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774948346; c=relaxed/simple;
	bh=3+vENjtwds0D76OuGCh6GojX8zdfo7hJS+Y75HJ+C3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P6EstYoB0TTZE51p5mPyxw6y4Q0vvAhaa3C3p7ANsLWhTWYEcK2dCU/J8SUaF90/eGypNPO8GMld/xxvla/eNk49IujJpo+uAAmRcY5JvWCUW7/MRgff+ssNLNnoWR9/rGtFWAkJZgLZi+eslMpSJL3EXN8fyBJvWg5MCaIYUSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pwYzw8MQ; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pwYzw8MQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=78
	8cNyJuycLYtqyCSVoMeq/nZDiFhN72EqBEqWavn1M=; b=pwYzw8MQiu+Z5dZKxc
	m782tF28m4CutsDB7WsHY74fQYRwlN8xsXg9oeIdcDwf/Jt8fRRDPU8xBpScLIjE
	8qf8UPwnNP8EmZiZQyxSUiM4CgzIEYT1KAXv85vF3DvLnaigDjzlUOWAEs7MqYT7
	4lvturYLt5PCReGYiEz8PdvrM=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXetTUj8tpdt0MCg--.18595S2;
	Tue, 31 Mar 2026 17:11:50 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v1 0/6] exfat: unify FAT chain walking helpers
Date: Tue, 31 Mar 2026 17:11:07 +0800
Message-ID: <20260331091113.20882-1-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXetTUj8tpdt0MCg--.18595S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7trykKr4xArWxWw13GrW5Awb_yoW8GF45pF
	WfGw43JrW8Ja4fZwn3Aw42y3WY9r4rAFW5XF1xJw1rZrnIyF12vr4rtFyfGFZ7A340qw4j
	qrW5Kr1UuFnrCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UP73PUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9xZmBGnLj9bJ8AAA3B

From: Chi Zhiling <chizhiling@kylinos.cn>

This series introduces and uses two new helpers to simplify FAT chain
walking logic across the exfat driver:

1. exfat_fat_walk - walks FAT chain by a given step, handling both
   ALLOC_NO_FAT_CHAIN and ALLOC_FAT_CHAIN modes

2. exfat_chain_advance - walks an exfat_chain structure by a given step,
   updating both ->dir and ->size fields atomically with proper boundary
   checking

These helpers replace open-coded cluster walking logic in dir.c, namei.c
and inode.c, improving code readability and ensuring consistent error
handling for corrupted FAT chains.

Also includes a fix for incorrect directory checksum when renaming a
file to a shorter name.

The base commit is exfat/dev without iomap changes


Chi Zhiling (6):
  exfat: fix incorrect directory checksum after rename to shorter name
  exfat: introduce exfat_fat_walk helper
  exfat: use exfat_fat_walk helper to simplify fat entry walking
  exfat: remove NULL cache pointer case in exfat_ent_get
  exfat: introduce exfat_chain_advance helper
  exfat: use exfat_chain_advance helper

 fs/exfat/dir.c      | 111 +++++++++-----------------------------------
 fs/exfat/exfat_fs.h |  49 ++++++++++++++++++-
 fs/exfat/fatent.c   |  23 ++++-----
 fs/exfat/inode.c    |  11 +----
 fs/exfat/namei.c    |  29 +++---------
 5 files changed, 88 insertions(+), 135 deletions(-)

-- 
2.43.0

