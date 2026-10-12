Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82742469821;
	Mon, 12 Oct 2026 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.54.11.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791825082; cv=none; b=ISFRC3UX+3Xbw1M96Ns2fl1ikrw6r0i4PYRtgpKnumnMswCB2XGWeKXgJdbCgzo8DxM+0UCdSPvwPWC25HSDO3PcczWeP1ZTAmaEPoKh0XdIEFyLTjePIXTypvtjIGltQIkDGZHt/ekYs6PpW89OLCnKkVd51BWxCCUOqOK3KJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791825082; c=relaxed/simple;
	bh=tsuWgfJbP8i+H/KSYcgRJdb/DSsDNVFZsS0EDbxmRWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HS4zNYNRMMs/MZGAXML0852oyTIkg/cCYqs05pAC+jH7VI9VjYyxwlBgpr8ZZzoFL7lysCmdRmbkJNpp/WXe+IoU0Zr0JAhTqZ9b4n5MgjfaHhLf/LXhLZrqEe3G3x4Bpeyg0hggDxU6umIQ5UV3NolFRi8Oi2Fnhs+1jrtJamg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br; spf=pass smtp.mailfrom=inf.ufrgs.br; dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b=vD5zQFc2; arc=none smtp.client-ip=143.54.11.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b="vD5zQFc2"
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id DC25B121120;
	Mon, 12 Oct 2026 14:11:14 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1791825075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dbHnS9Oj8ZPgP59bb06QSsJaW5K7trLBID6A4Cj59LI=;
	b=vD5zQFc2c0hhSHNIxhJC29Y4NEc/26fbiIQDSjwQjwQ709iRPKUyzNIRKeMkXDslXM1Nrk
	+Qo9pii+AWEJFRMQgut8n1gIBNrr04m+U1U3I3M/whiU/cccx1a2DKNW1FXVLgVoFPS4tz
	iOcg03/9CPyr8i/GAbWOfpfNHBRBlWUC9W9kU44vOmKWrWQ6BS8teoK7GmtCDaezIu6D3a
	MhCcKm6vAaHOo8/beAdLdIgqZqznbif3/7G3rnJXgQVHQ9tpuTamRM360p/6X8R1hXGIPP
	dNtkVAbqXgpkO/zlBs48/Jt9h/dC+E34copd/1CIpl+A63Vjc2HHZkhZj9+Q3A==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [PATCH v2 0/3] fat: allocate multiple clusters in fallocate
Date: Mon, 12 Oct 2026 14:11:03 -0300
Message-ID: <20261012171106.146243-1-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds support for allocating multiple clusters in a single
fat_add_clusters() call in fat_fallocate().

The multi-cluster TODO in inode.c is not implemented, as doing so would
require speculative preallocation or an iomap conversion.

Changes in v2:
- Keep the directory entry path unchanged.
- Add fat_alloc_chain() for callers that only need the first cluster,
  sharing the internal implementation with fat_alloc_clusters().
- Add benchmark results to the fallocate commit log.

Matheus Alves de Almeida (3):
  fat: remove cluster allocation size limit
  fat: support adding multiple clusters
  fat: allocate multiple clusters in fallocate

 fs/fat/fat.h    |  3 ++-
 fs/fat/fatent.c | 62 +++++++++++++++++++++++++++++++++++++------------
 fs/fat/file.c   | 10 ++++----
 fs/fat/inode.c  |  8 +++----
 4 files changed, 57 insertions(+), 26 deletions(-)

-- 
2.43.0

