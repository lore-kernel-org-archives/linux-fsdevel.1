Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CAE3EC6B0;
	Sat, 26 Sep 2026 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790419285; cv=none; b=f3DvGtLxaSumEM7q8GQZ8rGVlxCEdc3BS2swVauh+q9l9FF6sA6yHVaqtV+WpweZyA1Mzcc9WIdQ5CxAo7H1zkUJ78bjHDkkfWKUKUBbSEWwbWnNc2RNWufYZejCl3iYVo756B9gsCw/6LWR4yaY+i/LHob3C0gsQckP4CQNkFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790419285; c=relaxed/simple;
	bh=fTo54dQ27lNlohXIePrTiYH+6/z9AkWMENqu+dTZcY4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rVMlzrc41hn2/c+8fEiuroi3jLLi7LBW98VhpcDZCXkIMdKg5TIzd0PbtNIMs1pi0TiJNqDb6u83be927HnE0e1BeZEMWg8RtQWxd9D/pkddiUvKwvpt9H5hXqUbPNM5Yp84s68pu8mTnA+wnAXufI0vGFbn3w2ILSBk95UKTII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ir0K3VQu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ir0K3VQu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F2D1F000FF;
	Sat, 26 Sep 2026 10:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790419281;
	bh=TZRBqF2yMAgyYQEkKpNQPhn7mCO9yemFSVQUeDjssXc=;
	h=From:Subject:Date:To:Cc;
	b=Ir0K3VQu+rpNG9WmGygjpObvd2itOXxLZnKt/4/ihMoDOen7cunLzb3YqU3wiAe7a
	 NjsUIHV2kY+lTNuqhxRJJ9TPCoVSFJed1k2aZBn3ibN6EBmXvg/e/E9CrXMcR/JPIt
	 /DfsXmhxFujrwBxSNQYcMBfeCZFW5wl3Bc9SyxST7wNcKhsj0DO3+wIH6tRos3U6xA
	 zm+faOQMvGv508ToWVBvQORwaOcNrA8XHO7SFRu9LzMb3OKm9cALiuAMQ0H6Rvo2Cr
	 ST8hIML7rskENwCmSHvLCXsbxtwB/pR9VPggLxRTUEAm3++F3il61l1+u1Pw+tfL+c
	 PamhigTv4GNMw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH v3 0/6] mm: make MAP_PRIVATE-/dev/zero mappings truly
 anonymous
Date: Sat, 26 Sep 2026 11:41:05 +0100
Message-Id: <20260926-map-private-dev-zero-v3-0-d4781e84ccfc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNQQ6CMBCF4auQrh1T2rRFV97DuChlgEalZEoal
 XB3CytdGJf/S+abmUUkj5Edi5kRJh99GHLIXcFcb4cOwTe5meBC8wMXcLcjjOSTnRAaTPBCClB
 bqRujrWhdxfLpSNj6x8aeL7l7H6dAz+1LKtf1D5hK4GCVqZyR3KEzpyvSgLd9oI6tYhKfSvVDE
 avinKmVFkpy9aUsy/IGAqNskv8AAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3834; i=ljs@kernel.org;
 h=from:subject:message-id; bh=fTo54dQ27lNlohXIePrTiYH+6/z9AkWMENqu+dTZcY4=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK2L/TUUN8nN/lnrX7ewTmPLvIYP9Cb4il+Y8aKqX+/8
 u2fGr/vQEcpC4MYF4OsmCLL8y/i+4NEwuZ1XvB3g5nDygQyhIGLUwAmotnH8M+U+b1c+1O3038/
 ilhoqYvNrdrbplbOKWPya9qtprlx5U8YGbrtdCJa50505TrzzVjlQe7v4PjpMv7C2nMPc2i0W+i
 vZgcA
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

v3:
* Added tags (thanks David! :)
* Moved the reworked mmap_prepare vm_ops comment to 3/6 where it is introduced
  and fixed a typo in it, as per David.

v2:
* Added tags (thanks everybody!)
* Reworked comment about mappings not setting themselves anon as per David.
* Fixed up test typo as per David.
* Fixed up test close() as per David.
https://lore.kernel.org/r/20260908-map-private-dev-zero-v2-0-acc7b5625305@kernel.org

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

