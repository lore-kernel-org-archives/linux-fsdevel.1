Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BC637CD59;
	Fri, 17 Jul 2026 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784312534; cv=none; b=oIlRtwz/6iAkmSHWX1uv9v0tWAbBtqs2LG8mXrdhgh/ecM94RkC3/60/gwA0oyslgS5WQH9YjSwPzJHi3nuaLgapIWBLHTEdM6HGpq+eCRJaYTvsuTHMP0T+q6Yt8uCIDlcKLSjcDC2TGey0z6qY8qnJvisXFymHqBgJA+qpPrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784312534; c=relaxed/simple;
	bh=d2McZ8qqupq73DW6vLZJ4SJt35wa8LS/2RNB+wGC1SY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lwns2Wbh72HimQrR3LCn729SV+308nBdWWNCeyh5W1imAlV5VWJpJm3Vt0whdglRlglBeVrqI1GV1xCc2U4Aiueq2+pg+vlrdlt8cTpDj+tncsMcVZ6xo8vET1Rv4ZafzxSnIoX9lQp+g3ra2G7aEWjDgzpq55nhLbkIpkyZhhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Domzoas1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Domzoas1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC331F000E9;
	Fri, 17 Jul 2026 18:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784312530;
	bh=Cpq4AIRba6og6vu0k3GilMWxNVdoNwEkt2Y5ktgRSJg=;
	h=From:Subject:Date:To:Cc;
	b=Domzoas1anATfXMmlFE3I4FOGUlnT/lelCUuwI2mT7InXj0iWg/lRLHwVDk7BlBe9
	 mV6hrFIyOx6hrU7Jk9K2LnLcB6jVPytZqi+xXNHqePKTK3oIGdFib2yhCyQ88XyL+c
	 seXT63zMRX1Lg1ljPPsvhLUHeF1zEUAofSCEYY2hI7Nc5qN5d5pLzSJUNngtqeoeTt
	 hhIUE9LjmfKET9TkP3zDkeHLnVP3Tqyb/1w4j5FapRljPLMhIJ9Xe2kqW16gfgDWUP
	 1W8je9uOo//SEENV3hNYt8+CtJzNdfoZYycFNphwPK+uBVx9MenrKdH7AMZ9WFyphB
	 +CIBSQiLT5tZg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH 00/15] mm/rmap: index MAP_PRIVATE file-backed folios by
 virt pgoff
Date: Fri, 17 Jul 2026 19:19:38 +0100
Message-Id: <20260717-b4-scalable-cow-virt-pgoff-v1-0-cf24910ef094@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADpyWmoC/yWNSw7CIBQAr9KwFgK1H+PKe5guAF/pq6Q0D0RN0
 7vb1uUkk5mFRSCEyK7FwggyRgzTBupUMDvoyQHHx8aslGUjW6W4qXi02mvjgdvw5hkp8dmFvud
 aWivBqMrYhm2BmaDHzxG/d3+OLzOCTXtxNwaMKdD3uGe1e8yGDCRUeynbqlb1WThMwo/x9gSaw
 ItAjnXruv4AWFMSBroAAAA=
X-Change-ID: 20260711-b4-scalable-cow-virt-pgoff-a0cc0eb14bc6
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, 
 Harry Yoo <harry@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9320; i=ljs@kernel.org;
 h=from:subject:message-id; bh=d2McZ8qqupq73DW6vLZJ4SJt35wa8LS/2RNB+wGC1SY=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKiivauK5+spXLCd83m6f5Bepe8Xad8q9/o/bzK7x/DF
 84wz1udHaUsDGJcDLJiiizPv4jvDxIJm9d5wd8NZg4rE8gQBi5OAZjIznKGv2JB3T9KPkXutXUz
 WFOvw/snQ/7axPLYY1+WXtznFC3tocrwP1zs1XnbCZ1XOf5McRG8KV2vF6+9el3zPbGpus9rvio
 d5gMA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

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

Similar to page offset of pure anonymous VMAs, we update the virtual page
offset of unfaulted file-backed VMAs on remap, but do not once
CoW'd:(i.e. vma->anon_vma is non-NULL).

Overall, there is little impact on mergeability - for shared file-backed
mappings, we treat the anonymous page offset as equal to the file-backed
one (via vma_start_anon_pgoff()), so merge behaviour remains the same
there.

The only impact is on MAP_PRIVATE-mapped file-backed mappings, which must
now match on virtual page offset as well as file page offset to be merged.

To fail to merge like this would require CoW'ing the mapping, then finding
another VMA with identical file and compatible page offset to remap next
to. This is therefore very much an edge case that should have very little
impact (and which scalable CoW may very well address in any case).

We also address the outlier case of MAP_PRIVATE-/dev/zero mappings which
have file page offset but satisfy vma_is_anonymous() by making them truly
anonymous.

This is low-risk as for anything meaningful these mappings behave
anonymously, but it is very beneficial to do so as we eliminate an odd
corner case, and those are notorious for attracting subtle bugs.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
v1:
- Rebased onto mm-new.
- Dependent series heavily reviewed and looks highly likely to land, so
  un-RFC.
- Added explicit check for /dev/zero and removed ability for arbitrary
  mmap/mmap_prepare hooks to make themselves anonymous.
- Made MAP_PRIVATE-/dev/zero mappings truly anonymous.
- Added MAP_PRIVATE file-backed mapping merge test to selftests.
- Added a MAP_PRIVATE-/dev/zero VMA userland test to assert that the VMA
  really is made anonymous.
- Added MAP_PRIVATE-/dev/zero merge tests to selftests.
- Fixed missed virtual page index site in try_to_merge_with_ksm_page().
- Updated folio_within_range() to use virtual page offset for anon
  folio. This had no impact as it is only called for large folios at the
  moment (and MAP_PRIVATE-file backed mappings can't currently be backed by
  a large folio) but making the change now protects us for the future.
- Fixed typos etc.

RFC:
https://patch.msgid.link/cover.1782745153.git.ljs@kernel.org

To: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>
To: Vlastimil Babka <vbabka@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
To: Michal Hocko <mhocko@suse.com>
To: Jann Horn <jannh@google.com>
To: Pedro Falcato <pfalcato@suse.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
To: Miaohe Lin <linmiaohe@huawei.com>
To: Naoya Horiguchi <nao.horiguchi@gmail.com>
To: Rik van Riel <riel@surriel.com>
To: Harry Yoo <harry@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
To: Kees Cook <kees@kernel.org>
To: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
To: Nico Pache <npache@redhat.com>
To: Ryan Roberts <ryan.roberts@arm.com>
To: Dev Jain <dev.jain@arm.com>
To: Barry Song <baohua@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
To: Matthew Brost <matthew.brost@intel.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Rakie Kim <rakie.kim@sk.com>
To: Byungchul Park <byungchul@sk.com>
To: Gregory Price <gourry@gourry.net>
To: Ying Huang <ying.huang@linux.alibaba.com>
To: Alistair Popple <apopple@nvidia.com>
To: Peter Xu <peterx@redhat.com>
To: Xu Xin <xu.xin16@zte.com.cn>
To: Chengming Zhou <chengming.zhou@linux.dev>
To: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: ljs@kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org

---
Lorenzo Stoakes (ARM) (15):
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
      tools/testing/selftests/mm: test virtual page offset merge behaviour
      mm/vma: only permit MAP_PRIVATE /dev/zero to be mapped anonymous
      mm/vma: make MAP_PRIVATE-mapped /dev/zero mappings truly anonymous
      tools/testing/vma: add test to assert MAP_PRIVATE-/dev/zero is anon
      tools/testing/selftests/mm: add MAP_PRIVATE-/dev/zero merge tests

 drivers/char/mem.c                 |   8 +-
 include/linux/mm.h                 |  74 ++++++++++++++---
 include/linux/mm_types.h           |   4 +
 include/linux/pagemap.h            |  66 +++++++++++++++
 include/linux/rmap.h               |   2 +
 mm/huge_memory.c                   |   3 +-
 mm/internal.h                      |  76 ++++++++++++-----
 mm/interval_tree.c                 |   4 +-
 mm/ksm.c                           |   7 +-
 mm/memory-failure.c                |   4 +-
 mm/memory.c                        |   8 +-
 mm/migrate.c                       |   6 +-
 mm/mremap.c                        |   6 +-
 mm/page_vma_mapped.c               |   6 +-
 mm/rmap.c                          |  23 +++---
 mm/userfaultfd.c                   |   6 +-
 mm/vma.c                           | 116 ++++++++++++++++++++------
 mm/vma.h                           | 144 +++++++++++++++++++++++++--------
 mm/vma_exec.c                      |   2 +-
 mm/vma_init.c                      |   1 +
 mm/vma_internal.h                  |   1 +
 tools/testing/selftests/mm/merge.c | 161 +++++++++++++++++++++++++++++++++++++
 tools/testing/vma/include/dup.h    |  77 ++++++++++++++++++
 tools/testing/vma/shared.c         |   3 +-
 tools/testing/vma/tests/merge.c    |  22 ++++-
 tools/testing/vma/tests/mmap.c     |  49 +++++++++++
 tools/testing/vma/tests/vma.c      |   4 +-
 tools/testing/vma/vma_internal.h   |   1 +
 28 files changed, 764 insertions(+), 120 deletions(-)
---
base-commit: 5093dba1014c1d7f7e247fd118f0fa8f22136046
change-id: 20260711-b4-scalable-cow-virt-pgoff-a0cc0eb14bc6

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

