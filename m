Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F067E37C0E5;
	Mon, 29 Jun 2026 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782745442; cv=none; b=qBqYycqjXQaPuIqy0TGRTXj6xcRZkmUzwx7OZ4Pr8rU1Ky7NPwzlEWOKwqr6X/MsB/oB2UUpPEdZkJegpKDdE1wKxL7CbBeTn0PTp85X059PPOqlesnYZM6b64E3pK9rnppcXz+vDv3fx1v/VOg6U7qelg4gvJCwarRgqG92U3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782745442; c=relaxed/simple;
	bh=T1CVxi7lIdyWyn2veTi/PzCLocIdWLPx/0kPjizu+NU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kM8Yl7X7aqKbtaXovIyQBX4EgAQsWviL9R+qpif8ckh1BgdofPD06zw8l4vfV5mbCQepVc0c7ADL83406U53nNnaWid7DjiaipSLPdl0ktfzgbaUh/FegvEscfjeru+AYRaOV9p59+pS55LtTXfSZ1HCGkEZfdkS8PdSG0Cjhbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESN8Gj1O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESN8Gj1O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB5F1F000E9;
	Mon, 29 Jun 2026 15:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782745440;
	bh=Xh/MSGNSnNRTjM6MyqfalLvjoIfiLrZQnoiXR5GG7w0=;
	h=From:To:Cc:Subject:Date;
	b=ESN8Gj1OzVoyWQgxniIR+ph1G1ks5F2YjNdY8EmOaSKlPB5hO1UpgG4F9jCCeDAJe
	 ilTxD8yxiPcBgUwB+OLB6DLCFS5tktLhQt4hC21j8+1bQ0lGYgTcCJPatPW46b0/Dx
	 7zR8As366NZxCaD+ZOuPavMTcEERsO7GTOu4c/D7bNZeVwHOGHMs9HvDZmXOkrQ4CL
	 rV/ucsgUu3V2zPY0xHQO86s7YH5ASdPrJaBygEWMCVkGroIps74ZF7ZmRqIH+McDu8
	 9YJfwIss37OJSIFfAJfyskXK0F9hUam0Qn0G0irsYlWb35L89OvlTKwRJI85l0H2kM
	 QuRJuPhaYNGRA==
From: Lorenzo Stoakes <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>,
	Jann Horn <jannh@google.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Kees Cook <kees@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 00/10] mm/rmap: index MAP_PRIVATE file-backed folios by virt pgoff
Date: Mon, 29 Jun 2026 16:03:40 +0100
Message-ID: <cover.1782745153.git.ljs@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In memory management we've managed to manufacture a great deal of confusion
around the concept of anonymous memory. We have:

1. 'Pure anon' memory - anonymous VMAs whose folios are anonymous and
   swap-backed (thus for reclaim purposes, treated as anonymous). These are
   simple enough.

2. shmem - file-backed VMAs, file-backed folios (from rmap perspective) so
   present in the page cache and mapped by an address_space object, but
   whose folios are also swap-backed (thus treated as anonymous for reclaim
   purposes).

3. MAP_PRIVATE-mapped /dev/zero - a strange beast whose VMAs have
   vma->vm_file set, but whose mmap_prepare callback clears vma->vm_ops to
   satisfy vma_is_anonymous(), which results in VMAs that were mmap()'d
   referencing a file and whose VMAs reference a file, but are in every other
   sense anonymous, including the folios.

4. Other MAP_PRIVATE-file backed mappings - These possess file-backed VMAs
   and have file-backed folios until CoW'd, at which point those CoW'd
   folios are anonymous.

This series focuses upon issue 4.

In order for us to traverse VMAs using the reverse mapping, we require two
fields - folio->mapping and folio->index. The first tells the rmap code
where to look for VMAs, and the second tells it at which offset the folio
starts within the referenced object.

For anonymous folios, folio->mapping points at an anon_vma object. For
file-backed folios, it points at an address_space. And:

* For file-backed folios folio->index is simply the page offset of the start
  of the folio within the file.

* For anonymous folios belonging to pure anon mappings, folio->index is
  equal to the virtual page offset of the folio.

* For anonymous folios belonging to file-backed mappings (i.e. CoW'd folios
  of a MAP_PRIVATE file-backed mapping), folio->index is equal to the file
  page offset.

This series establishes a new virtual page offset property of VMAs to
allow us to map anonymous folios at their virtual page offset, consistent
with pure anon.

The purpose of doing so is to lay the foundations for the scalable CoW
work. This is necessary because firstly the approach first looks in the
maple tree for the VMA located at folio->index << PAGE_SHIFT, before
falling back to looking up tracked remaps if necessary.

The MAP_PRIVATE file-backed case means that folio indices will very often
conflict with one another and this remap tracking becomes substantially
more contended, and of course the fast path can never be used.

This also makes it possible, in future, to unshare anonymously mapped
folios with deep fork hierarchies on remap, eliminating the need for remap
tracking in the vast majority of cases.

Simlar to page offset of pure anonymous VMAs, we update the virtual page
offset of unfaulted file-backed VMAs on remap, but do not once CoW'd
(i.e. vma->anon_vma is non-NULL).

Overall, there is little impact on mergeability - for shared file-backed
mappings, we treat the anonymous page offset as equal to the file-backed
one (via vma_start_anon_pgoff()), so merge behaviour remains the same
there.

The only impact is on MAP_PRIVATE-mapped file-backed mappings, which must
now match on virtual page offset as well as file page offset to be merged.

To fail to merge like this would require CoW'ing the mapping then remapping
in such a way as to eliminate compatibility, but this is very much an edge
case that should very little impact (and which scalable CoW may very well
address in any case).


REVIEWER/MERGER NOTE: This is dependent on [0], which must be merged before
this.

[0]:https://lore.kernel.org/linux-mm/cover.1782735110.git.ljs@kernel.org/

Lorenzo Stoakes (10):
  mm/vma: introduce VMA virtual page offset field and add helpers
  mm: introduce linear_virt_page_index()
  mm: abstract vma_address() and introduce vma_anon_address()
  mm: update print_bad_page_map() to show virtual page index
  mm: introduce and use vma_filebacked_address()
  mm: propagate VMA virtual page offset on map, remap, split + merge
  mm/rmap: track whether the page VMA mapped walk is anonymous
  mm: introduce and use linear_folio_page_index()
  mm/rmap: use virt pgoff for MAP_PRIVATE file-backed anon folios
  tools/testing/vma: expand VMA merge tests to assert virt pgoff

 include/linux/mm.h               |  61 ++++++++++++-
 include/linux/mm_types.h         |   4 +
 include/linux/pagemap.h          |  66 +++++++++++++++
 include/linux/rmap.h             |   2 +
 mm/huge_memory.c                 |   3 +-
 mm/internal.h                    |  69 +++++++++++----
 mm/interval_tree.c               |   4 +-
 mm/ksm.c                         |   2 +-
 mm/memory-failure.c              |   4 +-
 mm/memory.c                      |   8 +-
 mm/migrate.c                     |   6 +-
 mm/mremap.c                      |   6 +-
 mm/page_vma_mapped.c             |   6 +-
 mm/rmap.c                        |  23 +++--
 mm/userfaultfd.c                 |   6 +-
 mm/vma.c                         |  70 +++++++++++----
 mm/vma.h                         | 141 ++++++++++++++++++++++++-------
 mm/vma_exec.c                    |   2 +-
 mm/vma_init.c                    |   1 +
 tools/testing/vma/include/dup.h  |  48 +++++++++++
 tools/testing/vma/shared.c       |   3 +-
 tools/testing/vma/tests/merge.c  |  22 ++++-
 tools/testing/vma/tests/vma.c    |   4 +-
 tools/testing/vma/vma_internal.h |   1 +
 24 files changed, 468 insertions(+), 94 deletions(-)

--
2.54.0
