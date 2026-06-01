Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364EC346AE3;
	Mon,  1 Jun 2026 05:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780293496; cv=none; b=VgK7DLR1wVou+kOxXPUqNZIjHs58p7FfxKWIOzcjGS4js+EWChTUGmioch5b8gNEBMvBP+Ce+bntgKz4cYTg6qCtqK0WWeBDFPXJd9oK3i9unRbZdUPt4RePshaAOkzYgxH3FfpXA4CeKR8ratzv4mRNd/8zBGSFOGefvQw62BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780293496; c=relaxed/simple;
	bh=gQCcrl5wOXscPu1TF4ArmdRLqUhBzNAu2ku7+1QmHp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KmiBhsZ92CxHIkDHzbGIg/XfgiKYGIkmoD3Mi46bWKrssyZ6SuTIVvKMhQTgkYCyWvAgWANfid8p9CdTIyfmE8/lfoPpVG1rXAm89tiCXVvUW0vWz6cTBVnCKIzm+VYp38YTXLcU0a7ej13xcd4jN8z5MYi45H23x/QcKO+/fDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=n1GCqtM+; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="n1GCqtM+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=0J
	yrTMDTnIbsNnfvDIxSelJbEh2fWHCPQJttmJvmeJ8=; b=n1GCqtM+SPutVhqGs9
	QSVbCdEIenwGvdNvjIfuMibNyBBheCNf1CB9kzCk8tlTfsqnVB2W8ys9avUa+lZY
	NxowsBqke8DleHKQk97LEWYdN0gI9ZqctkQjO6Spq/sqzNw0Vl61+bT4NLZSBbGM
	2A1NfmExaubXy9x9ohk6Xc+vw=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3_7Q6Hx1qsb0MAw--.47504S2;
	Mon, 01 Jun 2026 13:57:17 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v2 0/5] mm/shmem: optimize read with reduced xarray lookups and folio batching
Date: Mon,  1 Jun 2026 13:56:59 +0800
Message-ID: <20260601055704.167436-1-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_7Q6Hx1qsb0MAw--.47504S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur15AFWxWrWxWrW7JFykuFg_yoW8Kw1rpr
	yfWr1fJryfJ34fAr93Gw4xKF1fXF95JF1UWF1ftr4fXFnYkw1Dt3WfGF48GrWUCFy7Zw1U
	Jr17JwnF9w45t37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFJP_UUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+B64VmodHz5EMAAA3q

From: Chi Zhiling <chizhiling@kylinos.cn>

This series improves shmem read performance by implementing folio
batching in the read path and reducing unnecessary xarray lookups.

Performance Results:

fio --ioengine=sync --rw=read --bs=$1 --size=1G --runtime=180 --time_based --group_reporting --name=seq_read_test --filename=testfile

| THP disabled in tmpfs  | v7.1-rc5     | v7.1-rc5 + fbatch | Improvement |
| ---------------------- | ------------ | ----------------- | ----------- |
| 1M + normal file       | bw=11.5GiB/s | bw=12.7GiB/s      | +10.4%      |
| 64k + normal file      | bw=11.0GiB/s | bw=12.3GiB/s      | +11.8%      |
| 4k + normal file       | bw=3826MiB/s | bw=3849MiB/s      | +0.6%       |
| 1M + fallocated file   | bw=23.8GiB/s | bw=28.6GiB/s      | +20.2%      |
| 64k + fallocated file  | bw=22.5GiB/s | bw=27.3GiB/s      | +21.3%      |
| 4k + fallocated file   | bw=4655MiB/s | bw=4680MiB/s      | +0.5%       |
| 1M + hole              | bw=24.2GiB/s | bw=28.6GiB/s      | +18.2%      |
| 64k + hole             | bw=22.6GiB/s | bw=27.6GiB/s      | +22.1%      |
| 4k + hole              | bw=4652MiB/s | bw=4489MiB/s      | -3.5%       |


| THP enabled in tmpfs  | v7.1-rc5     | v7.1-rc5 + fbatch | Improvement |
| --------------------- | ------------ | ----------------- | ----------- |
| 1M + normal file      | bw=13.7GiB/s | bw=13.9GiB/s      | +1.4%       |
| 64k + normal file     | bw=13.5GiB/s | bw=13.5GiB/s      | +0.0%       |
| 4k + normal file      | bw=3833MiB/s | bw=3859MiB/s      | +0.7%       |
| 1M + fallocated file  | bw=24.9GiB/s | bw=34.2GiB/s      | +37.3%      |
| 64k + fallocated file | bw=23.0GiB/s | bw=31.4GiB/s      | +36.5%      |
| 4k + fallocated file  | bw=4710MiB/s | bw=4655MiB/s      | -1.2%       |
| 1M + hole             | bw=24.3GiB/s | bw=34.5GiB/s      | +42.0%      |
| 64k + hole            | bw=23.5GiB/s | bw=31.1GiB/s      | +32.3%      |
| 4k + hole             | bw=4690MiB/s | bw=4647MiB/s      | -0.9%       |


v1:
https://lore.kernel.org/linux-mm/20260520101538.58745-1-chizhiling@163.com/#t
rfc:
https://lore.kernel.org/linux-fsdevel/20260515094702.1092355-1-chizhiling@163.com/


Chi Zhiling (5):
  mm/filemap: reduce unnecessary xarray lookups when read cached pages
  mm/filemap: reduce xarray lookups in filemap_get_folios_contig()
  mm/shmem: introduce copy_zero_to_iter() for large zeroing
  mm/shmem: remove page-copy fallback in shmem read path
  mm/shmem: optimize file read with folio batching

 mm/filemap.c |  46 +++++++++++--------
 mm/shmem.c   | 126 +++++++++++++++++++++++++++++++++++----------------
 2 files changed, 113 insertions(+), 59 deletions(-)

-- 
2.43.0

