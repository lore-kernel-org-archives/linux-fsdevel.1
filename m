Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4953436CE1C;
	Wed, 20 May 2026 10:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779272386; cv=none; b=NK66Y5xD+bA0U4b+8gSPkKhVoQ/Wvcp4SVQtOLgkNPqZiCxwMC/Kznr9m4g33vuKCJrKgpoJHGhYWjKUDiurFPvYQ1yUR4KqM7L4U/O0u6tUtdWQ7lLo34WrxzUNCcry9tPDhyHPht4eHwCPdENR8l+J9B+JBlWJQ+SEO9L9h+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779272386; c=relaxed/simple;
	bh=hJDkNgEzc3qALFl7zRoMYGHp66xfCIICzufpSN4uDgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IGRO8leCKeo8Yrzi0/wIyIlpjycBeJSzCRXHrvqkKMHNMXQvq+oQdZcxYivpdkShmqZjpeR5wVNgJCLdk9YITrYfnb6Y4l8iy/dZbZC9fl7AWIEG9UDTLkeG/uxxQcpNqC7VLpy8gAv5UV8ZU8TLj1xybTXw2RbvyUE9dAvQUvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TqmLjHTT; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TqmLjHTT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=cI
	UPCew6mQzUD6Ph4xpmn+i5FaQUMTux+sdvb39UKTw=; b=TqmLjHTTAk1/HjRCvH
	33x3kviaHSPjmPKeON4XnoRA8HscZG65ZRpq0YtNHIJi49X3C0tMVvz/dxBWel/f
	KjsloJO1oBCL7KaomlKTe2I/N5uuPPCN6F4aLwy9QtKcS8nYTR5yAG1h4y8wh/f2
	pEFmQdHbYEvTImKBRt82QKVvI=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDXbbprig1qQK31EQ--.641S2;
	Wed, 20 May 2026 18:18:22 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v1 0/5] mm/shmem: optimize read with reduced xarray lookups and folio batching
Date: Wed, 20 May 2026 18:15:33 +0800
Message-ID: <20260520101538.58745-1-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDXbbprig1qQK31EQ--.641S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur1UtFWrCFW7CrWxJrWfAFb_yoW8Kr13pr
	nxGF93CrykJ3yfJr93Gw4jqFyrXr18JF1xJr1xKFy8Xr1Fyr4jyF1xXryrXrWUCr9rZr1U
	JrW7JwnFkw1UGrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j-nYrUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC3BCcOmoNinBzpQAA3h

From: Chi Zhiling <chizhiling@kylinos.cn>

This series improves shmem read performance by implementing folio
batching in the read path and reducing unnecessary xarray lookups.


Changes since RFC
=================

The RFC version used xas_for_each() in shmem_get_read_batch(), which
introduced about a 1% regression for 4K read workloads.

This v1 addresses the regression in patch 2 by switching to
filemap_get_folios_contig() and optimizing it to avoid the extra
xarray traversal overhead.


Performance Results
===================

Testing was performed with fio sequential read workloads:

  fio --ioengine=sync --rw=read --size=1G --runtime=180


### THP Disabled - Normal Files ###

| Block Size | Baseline  | v1        | Improvement |
| ---------- | --------- | --------- | ----------- |
| 1M         | 11.4GiB/s | 12.7GiB/s | +11.4%      |
| 64k        | 11.2GiB/s | 12.2GiB/s | +8.9%       |
| 4k         | 3809MiB/s | 3838MiB/s | +0.8%       |

### THP Disabled - Fallocated Files ###

| Block Size | Baseline  | v1        | Improvement |
| ---------- | --------- | --------- | ----------- |
| 1M         | 23.7GiB/s | 28.7GiB/s | +21.1%      |
| 64k        | 22.6GiB/s | 27.0GiB/s | +19.5%      |
| 4k         | 4668MiB/s | 4678MiB/s | +0.2%       |

### THP Enabled - Normal Files ###

| Block Size | Baseline  | v1        | Improvement |
| ---------- | --------- | --------- | ----------- |
| 1M         | 13.9GiB/s | 13.9GiB/s | 0%          |
| 64k        | 13.4GiB/s | 13.4GiB/s | 0%          |
| 4k         | 3818MiB/s | 3836MiB/s | +0.5%       |

### THP Enabled - Fallocated Files ###

| Block Size | Baseline  | v1        | Improvement |
| ---------- | --------- | --------- | ----------- |
| 1M         | 24.1GiB/s | 34.9GiB/s | +44.8%      |
| 64k        | 22.9GiB/s | 31.3GiB/s | +36.7%      |
| 4k         | 4721MiB/s | 4708MiB/s | -0.3%       |


rfc:
https://lore.kernel.org/linux-fsdevel/20260515094702.1092355-1-chizhiling@163.com/


Chi Zhiling (5):
  mm/filemap: reduce unnecessary xarray lookups when read cached pages
  mm/filemap: reduce xarray lookups in filemap_get_folios_contig()
  mm/shmem: make SGP_NOALLOC succeed on hole like SGP_READ
  mm/shmem: introduce copy_zero_to_iter() for large zeroing
  mm/shmem: optimize file read with folio batching

 include/linux/shmem_fs.h |  2 +-
 mm/filemap.c             | 34 ++++++++++++------
 mm/khugepaged.c          |  2 +-
 mm/shmem.c               | 75 +++++++++++++++++++++++++++++-----------
 4 files changed, 79 insertions(+), 34 deletions(-)

-- 
2.43.0

