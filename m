Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795646246;
	b=LHE5LftFyKzPW1zfF6JfANZ9vBPX90I3pqsKK6ulUVNA0vpLK1AkUtLZ84o5DNfwsNj8
	 VqxEKlEMNCBnbh6Ki0ZkNRbg5rxtL4RenlZvgyfDWX9NhFb91BeznMei+i0wDo3OorkSO
	 MogQSr705fdylxK7sM81ZyJZvwzIOzvDDjWnRwNNWI/nfDOqHfsuinMl8b2Taa93+bNyq
	 jzvXD8XJ3uot0OnzRc2KdMUIZ1/cLhXM42BD3gdLAKZdZ05UvnSKpTqmcNdiWlQwzqQFp
	 by7tHymz93axePelDJNgUweb4FI4ENwTNpUfH+xo+yGAMdeBpx424Kdr+zBD+ylL43g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646246;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=r/88ZmpA7ofzoMgWfgW+R9YyORRfy205haZxhA2urC0=;
	b=VtgQRq3TQmlp1q9ioqapuOa8NNl9mXQZLdp8ffbx0ZC197MrQO41qRFUCNOldb7lGNUP
	 h4EcoLNN4SpWuYEoqs09LgzxpLwUqB5EuOtClaFeElImNuRQwge3HidxMVIXB7UI+0OXo
	 Lqmqidj1G5pxM5gVPSl8T0XcStpdqG8jHAVgMxK7WOXYkonaXF3ofhFezNnkbM8teb9J2
	 Wb6t91iu3znEHkwoAcosFmzrWX+ZwznXEYgpb4QCAcQpLd1SGWPuSZJwdYqXhs9bAl+GE
	 PvuU/mwRr1aJQ/rC2MjGPKoGdWClbkVz04IBWBlc5mPcWgvMW2m+feiFzVmnbnm822g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YJEKNsew;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB64606A321;
	Wed, 25 Nov 2026 22:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YJEKNsew
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4252B1F000CF;
	Wed, 25 Nov 2026 22:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795646245;
	bh=r/88ZmpA7ofzoMgWfgW+R9YyORRfy205haZxhA2urC0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YJEKNsewmLI2r18oxstIpVnByWfyrcBn6xzzvapfFHD1JVPvOLaFRvDpplT/GBlud
	 GxAcgZQbQaqlAy7PQnj201vX8pgyoYiDrp4ZxoW+0DybXurghchrZUBbrxSQgVugQ7
	 zWqmufBhrC3MMeZfcm7v4o9SbFWg58U7UmXX/b97O181tlYyXEaEdwsQ9XROgNWZD7
	 dcKa20kW+EAGZOc18ONlXxjhVZGJp/NXcEQwp461Y69pB4NLisNIB1IMqY9/63Xsj5
	 QUSZbxnNr6t2Iv1gGR0kGrw4ZV5TDJltnZNXPFbZrVZcStWRc9Ksyx1nlY4AfU5DZk
	 Y/qnIDWEZv/5w==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 25 Nov 2026 23:33:13 +0100
Subject: [PATCH 15/21] mm/hugetlb: stop accounting HugetlbPages once PMD
 tables were shared
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-hugetlb_fixes_2-v1-15-db27fd2f71a8@kernel.org>
References: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org>
In-Reply-To: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org>
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Jinmeng Zhou <jinmengzhou22@gmail.com>, Hongfu Li <lihongfu@kylinos.cn>, 
 Andrea Arcangeli <aarcange@redhat.com>, 
 Mike Kravetz <mike.kravetz@oracle.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Dave Airlie <airlied@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Mike Rapoport <rppt@kernel.org>, 
 Mel Gorman <mel@csn.ul.ie>, Dave McCracken <dave.mccracken@oracle.com>, 
 Andy Whitcroft <apw@shadowen.org>, Adam Litke <agl@us.ibm.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Rik van Riel <riel@surriel.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, 
 Lance Yang <lance.yang@linux.dev>, James Houghton <jthoughton@google.com>, 
 Yang Shi <shy828301@gmail.com>, Suren Baghdasaryan <surenb@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Matthew Brost <matthew.brost@intel.com>, Byungchul Park <byungchul@sk.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Wanpeng Li <liwanp@linux.vnet.ibm.com>, Andi Kleen <ak@linux.intel.com>, 
 Kenneth W Chen <kenneth.w.chen@intel.com>, Hugh Dickins <hugh@veritas.com>, 
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
 Joern Engel <joern@logfs.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Michal Hocko <mhocko@suse.cz>, 
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, 
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, 
 "Kirill A. Shutemov" <kirill@shutemov.name>, 
 Sasha Levin <sasha.levin@oracle.com>, 
 Guillaume Morin <guillaume@morinfr.org>, Wanpeng Li <liwp.linux@gmail.com>
Cc: linux-mm@kvack.org, Jason Gunthorpe <jgg@ziepe.ca>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Andrew Morton <akpm@osdl.org>, linux-doc@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3111; i=david@kernel.org;
 h=from:subject:message-id; bh=K65bx0/PtdyC5pc7uEgYhhGf7zKSOQWw4kDznZNplgg=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLZk1S7z76RWxGrM3GtanjsH9u8zLUHszoyMrtX16v0K
 S2WL/7aUcrCIMbBICumyBIUfN/g5ct1tdVufMwwc1iZQIYwcHEKwERMAxkZPjDptDIbrc0y8lkg
 db3DYeqRRtP/EhPXLpiqcHdfR8/MhQz/I+9YG1yY9WPudHOBvAeXo797x7Dpx+5pjVtcrjT9dUY
 IAwA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Sharing hugetlb PMD tables can leave HugetlbPages in /proc/<pid>/status
too low or too high, or make it underflow: when (un)mapping a folio in a
shared PMD table, we only adjust mm->hugetlb_usage of the MM we process,
not of the other sharers.

Accounting this precisely is not worth it for a statistic, so let's just
give up: once an MM shares a PMD table, set mm->hugetlb_usage of both
MMs to LONG_MIN / 2, and report negative values as 0. Later updates
cannot realistically make it positive again, as PMD table sharing is
64-bit only.

Document that HugetlbPages is 0 once a process shared hugetlb PMD page
tables.

This has low urgency, as it only affects a statistic. Let's not CC
stable.

Fixes: 5d317b2b6536 ("mm: hugetlb: proc: add HugetlbPages field to /proc/PID/status")
Reported-by: Chris Mason <mason@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 Documentation/filesystems/proc.rst | 3 ++-
 mm/hugetlb.c                       | 9 ++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index bcbcb41814d96..8696359b06498 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -268,7 +268,8 @@ It's slow but very precise.
  VmPTE                       size of page table entries
  VmSwap                      amount of swap used by anonymous private data
                              (shmem swap usage is not included)
- HugetlbPages                size of hugetlb memory portions
+ HugetlbPages                size of hugetlb memory portions (0 once the
+                             process shared hugetlb PMD page tables)
  CoreDumping                 process's memory is currently being dumped
                              (killing the process may lead to a corrupted core)
  THP_enabled                 process is allowed to use THP (returns 0 when
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 89d71e3dadd77..796f02a4ded63 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4744,8 +4744,9 @@ void hugetlb_show_meminfo_node(int nid)
 
 void hugetlb_report_usage(struct seq_file *m, struct mm_struct *mm)
 {
+	/* Negative once the MM shared PMD tables, see huge_pmd_share(). */
 	seq_printf(m, "HugetlbPages:\t%8lu kB\n",
-		   K(atomic_long_read(&mm->hugetlb_usage)));
+		   K(max(atomic_long_read(&mm->hugetlb_usage), 0L)));
 }
 
 /* Return the number pages of memory we physically have, in PAGE_SIZE units. */
@@ -7310,6 +7311,12 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 				(pmd_t *)((unsigned long)spte & PAGE_MASK));
 		hugetlbfs_pmd_sharing_inc(file_inode(vma->vm_file));
 		mm_inc_nr_pmds(mm);
+		/*
+		 * (Un)mapping folios with shared PMD tables would require
+		 * updating statistics of all MMs. Instead, give up accounting.
+		 */
+		atomic_long_set(&mm->hugetlb_usage, LONG_MIN / 2);
+		atomic_long_set(&svma->vm_mm->hugetlb_usage, LONG_MIN / 2);
 	} else {
 		ptdesc_pmd_pts_dec(virt_to_ptdesc(spte));
 	}

-- 
2.56.1

