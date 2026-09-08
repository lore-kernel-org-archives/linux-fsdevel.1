Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E79E52BE27;
	Tue,  8 Sep 2026 11:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788866690; cv=none; b=ZX3KHCIh6hC5UjOunVH9tRdAa2VDINRhm6hTWdaGn/nB3evHFsF46yx1JHj/0jFSZeBtwszGOBuLVedb1n833SQVUk4UvuDSnquFGYLpogYHzuwcQBrLG+MLK96xtroYws6F0NmcoKZOFqmT5416zE09K97waEXoT6ElScFF7Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788866690; c=relaxed/simple;
	bh=zyHpGOvJgvpz0CkPBa/akIw5hynneWmyWjMSuuPUPHQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qpfnovsZLtTClD3HmOMNil16IJf1OaVPIi9f4hXtQlnUeCrnyLrPv1Pe5KSiULZKG1jZrGcfnYzMvFm66tTxjYmmUsjwmFvYoPI8jXPaBaXqXjV4+CSyYbF1HAeE7pqZH9BlYP91R7NeHl9WUNGIr0jMBfy5AEhc69UTTMay0vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URN9YlhJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URN9YlhJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520251F00A3A;
	Tue,  8 Sep 2026 11:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788866678;
	bh=mfTEZnUAqIu9snNugWvKz9NgMLsK8FTL3j9DOamLiBo=;
	h=From:Subject:Date:To:Cc;
	b=URN9YlhJSN5Go9+FGDnDonQuzMD3QjcnwdGAyMqEVUEuGrKKUAmNP+q5CuHjZQlhv
	 ClYVpndKK8xa9gqd6ICtUjHEKPCKLHvW9r7Q+P4WIMXlpW8IL7k1nv94wvxhY6AuEP
	 ukXMuQPId/Ph4WCO8dCGMkLGNy7UjYnvjQqW9wOhgTvG03UU8cy870Bbr/pJVU6Ugb
	 czHNQFEamstUcQLxJ45kh9iBiGnT7dqM2pYQxYxNWNSj4d7GtVeuq87TP/s083vsxW
	 wo5+jRt6XykBmUJbIfzE29PaWRRRSlCpKz2zi0p03fCCsGHsC9o89ebsiDx7YKOwjy
	 N7gXijLrRfYqA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH v2 0/6] mm: make MAP_PRIVATE-/dev/zero mappings truly
 anonymous
Date: Tue, 08 Sep 2026 12:23:37 +0100
Message-Id: <20260908-map-private-dev-zero-v2-0-acc7b5625305@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0Jm7ZhSIkVX3MOwqGWAiUqbKWlUw
 t2tXMDle8l/f4VIwhThUqwglDiynzPoQwFusvNIyH1m0ErX6qw0Pm3AIJzsQthTwg+Jx5ut6t7
 UVg+ugTwNQgO/9uy1yzxxXLy895dU/uyfYCpRoT2ZxplKOXKmvZPM9Dh6GaHbtu0LSYzZrbkAA
 AA=
X-Change-ID: 20260902-map-private-dev-zero-ba36d76a2fc8
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3588; i=ljs@kernel.org;
 h=from:subject:message-id; bh=zyHpGOvJgvpz0CkPBa/akIw5hynneWmyWjMSuuPUPHQ=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLmfygo+B1t2+j0RnhubYNyxk894yWXTk+wjLpmZJv+b
 dZ8+XmZHaUsDGJcDLJiiizPv4jvDxIJm9d5wd8NZg4rE8gQBi5OAZiIRggjw7l1t97/8Au7PT/9
 3i6li4KPmN+1PO1LVtjZpyG2rSJD+wXD/9imdwurPFYLx7Wv+dd8wuDq4X//qnfGBH2pUb5sYf/
 0KgcA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Historically anonymous memory was obtained in linux by MAP_PRIVATE-mapping
/dev/zero.

The canonical way of doing these now is mmap() specifying MAP_PRIVATE |
MAP_ANON, but we must continue to support the legacy means of obtaining these
mappings.

As-is these mappings are an unusual edge-case - they satisfy
vma_is_anonymous() but have non-NULL vma->vm_file, and their page offset is
the offset into the /dev/zero file.

Commit 93c0c8dc87f6 ("mm/rmap: use anon pgoff to track MAP_PRIVATE
file-backed anon folios") causes all other anonymous folios to be tracked
by their anon index (vma->vm_start >> PAGE_SHIFT at the point of first
fault), leaving MAP_PRIVATE-/dev/zero as the outlier.

This series remedies the situation by making MAP_PRIVATE-/dev/zero mappings
truly anonymous with !vma->vm_file and correct anonymous page offset.

It starts by bringing the memory character driver into mm/ - this file
implements /dev/zero, /dev/mem among other things and is already (as
clearly indicated by its name) within the remit of memory management.

By doing this, the file_is_dev_zero() function can be provided, internal to
mm, which allows for positive identification of these mappings.

Using this, first prevent any other mappings from mapping memory
anonymously, then make these mappings truly anonymous and eliminate all
code in the kernel that previously had to account for these strange beasts.

Finally, it adds userland VMA tests to assert the behaviour and selftests
to assert expected merge behaviour.

v2:
* Added tags (thanks everybody!)
* Reworked comment about mappings not setting themselves anon as per David.
* Fixed up test typo as per David.
* Fixed up test close() as per David.

v1:
https://lore.kernel.org/r/20260902-map-private-dev-zero-v1-0-a578c730cec7@kernel.org

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
Lorenzo Stoakes (ARM) (6):
      mm: move drivers/char/mem.c to mm/char-mem.c
      mm: implement file_is_dev_zero() to uniquely identify /dev/zero
      mm/vma: only permit MAP_PRIVATE /dev/zero to be mapped anonymous
      mm/vma: make MAP_PRIVATE-mapped /dev/zero mappings truly anonymous
      tools/testing/vma: add test to assert MAP_PRIVATE-/dev/zero is anon
      tools/testing/selftests/mm: add MAP_PRIVATE-/dev/zero merge tests

 MAINTAINERS                                        |  4 +-
 drivers/char/Makefile                              |  2 +-
 include/linux/mm.h                                 | 10 +--
 include/linux/pagemap.h                            |  3 +-
 mm/Makefile                                        |  3 +-
 drivers/char/mem.c => mm/char-mem.c                | 21 +++--
 mm/internal.h                                      | 20 +++--
 mm/shmem.c                                         |  2 +-
 mm/vma.c                                           | 39 +++++++--
 mm/vma.h                                           |  3 -
 tools/testing/selftests/mm/merge.c                 | 95 ++++++++++++++++++++++
 .../selftests/proc/proc-self-map-files-001.c       |  2 +-
 .../selftests/proc/proc-self-map-files-002.c       |  2 +-
 tools/testing/vma/include/dup.h                    | 10 ++-
 tools/testing/vma/shared.c                         |  9 ++
 tools/testing/vma/tests/mmap.c                     | 37 +++++++++
 16 files changed, 220 insertions(+), 42 deletions(-)
---
base-commit: e3b5239afe1b8f0194db7436b17c33e94c1988c4
change-id: 20260902-map-private-dev-zero-ba36d76a2fc8

Best regards,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

