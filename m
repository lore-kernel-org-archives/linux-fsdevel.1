Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DA231A549;
	Wed,  4 Feb 2026 07:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770189345; cv=none; b=XbEwIEhRIFECmKdD0YWGWF6FvImIZN6QIWf0CSMhP9HHyytET+HaHP6sSplZbbDLbiJkgSNg3RSrZdJHTUT3vC2sW9n3fIzrjmqTcOYZ1nlgYpauL61YycRKTiPEIrkYtG13kBFglyYQxo8isHAyKYsshPSa8MlP6amdpEHKdZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770189345; c=relaxed/simple;
	bh=QzOJdLW/T5ophzHb+CiOmwfaxdzEDOJaUNunep6+hjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C4f+xUBadzPoml144nme14IuNrMHlfXudDLg2i9EoE9jYaoyv2EmGXyp5EN1E9lnTs+XF9ploolN9unriHu1bUp036E16raLmT4gUHuMgWSZluHGr8WIxZ6RlONAh3dpFwJEfI2P29vhNxc/AW5kZDEYMQqkmDbwwGhIbAkwduA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YW1ARquA; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YW1ARquA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=BQ
	fxwLvi4XsX6Z+rw0IwY2FRoZdlz+wc9Z48NENb3C8=; b=YW1ARquAfyhtVsRlP9
	sqm8qt+JOOMojM0jmgaLj/mjVCDYMB2bUPBEI51bsQ9Xi7rFir7aG69YTuSY5dlh
	5IJ8GfR/BIMXEyGI+jRkMmm8tUZWJDA0IouZC+B6qPIUrerXd0A6L+tR2wqMe4Zl
	Z1fksUlEAVyGk3wVqCrdd+PQM=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgB3TegF8oJpYIHPNw--.186S2;
	Wed, 04 Feb 2026 15:15:20 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: 
Date: Wed,  4 Feb 2026 15:14:32 +0800
Message-ID: <20260204071435.602246-1-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgB3TegF8oJpYIHPNw--.186S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7try8Gw1kXr1kZF1ktFyDtrb_yoW8GF1fpF
	WfKwnxJr1kGwn7Xws3K34UXryruFs3tF4UXw47Jw1fCr15ur4S9rZFqr1rtFy7K3s2q3Wj
	qr4jvw1j9Fn09rJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7xhdUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC3Ai5V2mC8ghMoQAA3G

From: Chi Zhiling <chizhiling@kylinos.cn>

Subject: [PATCH v1 0/3] exfat: optimize exfat_chain_cont_cluster for large file conversion

When an exFAT file cannot allocate contiguous space, it converts from
NO_FAT_CHAIN to FAT_CHAIN format. For large files, this conversion can
be extremely slow due to:
1. Sequential FAT block reads without readahead
2. Mark buffer dirty and mirroring operations for each cluster

This series addresses these bottlenecks through two optimizations:

1. Block readahead: Read-ahead consecutive FAT blocks to reduce I/O wait
2. Buffer caching: Cache buffer heads and commit dirty buffer per block
   instead of per cluster

Performance improvements for converting a 30GB file:
| Cluster Size | Original | After Patches | Speedup |
|--------------|----------|---------------|---------|
| 512 bytes    | 47.667s  | 1.866s        | 25.5x   |
| 4KB          | 6.436s   | 0.236s        | 27.3x   |
| 32KB         | 0.758s   | 0.034s        | 22.3x   |
| 256KB        | 0.117s   | 0.006s        | 19.5x   |

All criticism and suggestions are welcome :)


Chi Zhiling (3):
  exfat: add block readahead in exfat_chain_cont_cluster
  exfat: drop parameter sec for exfat_mirror_bh
  exfat: optimize exfat_chain_cont_cluster with cached buffer heads

 fs/exfat/exfat_fs.h |  9 ++++-
 fs/exfat/fatent.c   | 96 ++++++++++++++++++++++++++++++++++++---------
 2 files changed, 85 insertions(+), 20 deletions(-)

-- 
2.43.0

