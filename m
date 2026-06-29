Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2604279EE;
	Mon, 29 Jun 2026 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782745453; cv=none; b=XkZDt3D/LHfL55GcdmdB9nvkGu/Ama/5B6rG9Ag+SbwkkF+wN/1znM4uM55FZQamSXzAThY27Diafvq/QyWUK/r2iWNeCydOwmqvNDdIvdVhkR8gdcE3xA0SdLpcUOANeDN83ut7Cl62lviozeClE8mJhW+4xGkUzpOUjbldZck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782745453; c=relaxed/simple;
	bh=xYdGs2hYm6cZgTn2nq/whsO7qcoa+Eo9Pq9YQgOxIco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFcYWywbRKg0ivMitpwFUVDcKV9iicKxQBoZ2ftAz7a37JjI1jM33DiM/NGCc34cuJX1CKwBtu58D1I6ElxzPnYKU7UVjox9mVBbJ8GeyZ3UrjCkapsEy7XkqtBOv11ElkG8Dh6MpaNso4jhE1eeLxLEeCLYTDCxyPY1owixHzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcDHXqhE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcDHXqhE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C4F1F000E9;
	Mon, 29 Jun 2026 15:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782745452;
	bh=tWUJODwdTE7pH27pI40oaqFE2CYlQJqY1Z9hmUi6ed8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PcDHXqhE/bIrZtFQ9F+4e4CNVz6V1zxlfjiFoRWxC1FDjE2JODm8vZb2iN6Eigzno
	 Ph79Y9UrJqcVN+LGSlnPItEj4sZYiQkqg6bD+McwtzEJm66HSVr/MBs1XcEN6nv27W
	 N6DCX7mWnMYR9EK7bLKbqxK+26Ff1GBjJqTcTEqCLkf/44WEU9mJaGc9wPRxLCBL5f
	 ukj9O2dq8s1hFfITtdeXoOnwmL+lVdivY3/X1KUAuhE/5zGqtiK29pSEr3fHuXrtc8
	 bFud6jCxY+2pSJ2CEAJT3QQAG/uhAY1BuJQS0h1qZUw/Fu1/9VZd5+KoPGUtYMAjXP
	 3J8FGt4KLhgfg==
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
Subject: [RFC PATCH 04/10] mm: update print_bad_page_map() to show virtual page index
Date: Mon, 29 Jun 2026 16:03:44 +0100
Message-ID: <f10dd43c4ca57484948dcdd9be9fe398f79dc9d3.1782745153.git.ljs@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782745153.git.ljs@kernel.org>
References: <cover.1782745153.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is potentially useful debugging information and matches the existing
page offset provided.

We only do so if the VMA is not a shared mapping, as shared mappings ignore
the virtual page offset.

We use __linear_virt_page_offset() as the VMA may be shared.

Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
---
 mm/memory.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index f5eb06544ba4..7890e5200ecb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -588,21 +588,23 @@ static void print_bad_page_map(struct vm_area_struct *vma,
 		enum pgtable_level level)
 {
 	struct address_space *mapping;
-	pgoff_t index;
+	pgoff_t index, virt_index;
 
 	if (is_bad_page_map_ratelimited())
 		return;
 
 	mapping = vma->vm_file ? vma->vm_file->f_mapping : NULL;
 	index = linear_page_index(vma, addr);
+	virt_index = __linear_virt_page_index(vma, addr);
 
 	pr_alert("BUG: Bad page map in process %s  %s:%08llx", current->comm,
 		 pgtable_level_to_str(level), entry);
 	__print_bad_page_map_pgtable(vma->vm_mm, addr);
 	if (page)
 		dump_page(page, "bad page map");
-	pr_alert("addr:%px vm_flags:%08lx anon_vma:%px mapping:%px index:%lx\n",
-		 (void *)addr, vma->vm_flags, vma->anon_vma, mapping, index);
+	pr_alert("addr:%px vm_flags:%08lx anon_vma:%px mapping:%px index:%lx virt_index:%lx\n",
+		 (void *)addr, vma->vm_flags, vma->anon_vma, mapping, index,
+		 virt_index);
 	pr_alert("file:%pD fault:%ps mmap:%ps mmap_prepare: %ps read_folio:%ps\n",
 		 vma->vm_file,
 		 vma->vm_ops ? vma->vm_ops->fault : NULL,
-- 
2.54.0

