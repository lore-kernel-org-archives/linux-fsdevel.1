Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB190411A01;
	Wed, 29 Jul 2026 16:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343784; cv=none; b=YwMw5MtjC8Bf3dQSgWs4SfzMHFwqaK6G1whC2hJZgyz7Znzmqp8tfTvbpSbS4tvPDQU6ge/PhBHQk7knxiFIA6IM0+VP38PH7m1xPlkgImw2CdNAO07EKFyQxViOyqdps/ylKEjOfRi51iYZspjXe7zhGZTAV77Uxwt1aQHe5lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343784; c=relaxed/simple;
	bh=022bLd1rMmlNyvelJecXqv+89KISK1vz6wvXeWBW9xM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XF6hvSQ1PO1ALharY/anr0jd3SutfXAuNemIF4Ef28TbJdvZouarTBvGs4vF2jIxbkUo9EGi9Dcc6KrxG5glHwT9/IspkMmbvq7qW4l0U6NcQII65SimUOzNKPVbGdW6P9AIptKFNFHfVpHAolHRGRRFV9b6bGAsRdGHjqxAdXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgCpuxR+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgCpuxR+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227EF1F00A3E;
	Wed, 29 Jul 2026 16:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785343783;
	bh=WDKDN8+NyCbFBf9xntqxHi5cksOPKTX5TLeSSDFnRdE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VgCpuxR+86B5/XgT/kIgifDvsQYtOa0PPteYon2COxBzS5V0Hd1zXaDOHNIxDjvn9
	 oVWwwqr0x4zCqJFEqrF2azA3vrRQemSnrdy+zUT8jszN3o7QceMexe3m4KkXdiIccf
	 +/Gp9SZl4Ezyn5+AX6+OnsQWkWGN5GzUjNtazG/t/9ElDRmnZHOI2DnCwVIjmV5tgU
	 5VrMSNalVPKH0IBMHRmHfctqk7hzbEVWpaq6RHDbzapMof04cfvxShlPcIa3Ynv/YD
	 wPYeM1LQwdpqaRFzC9FF9I38Roo3My1eDwWRvOGHOvv0y6kqylsY+YBHPCPKKAW8SX
	 qvgNSp/1CEGHw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 29 Jul 2026 17:48:39 +0100
Subject: [PATCH v3 04/15] mm: update print_bad_page_map() to show anonymous
 page index
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-b4-scalable-cow-virt-pgoff-v3-4-e8ecfefea812@kernel.org>
References: <20260729-b4-scalable-cow-virt-pgoff-v3-0-e8ecfefea812@kernel.org>
In-Reply-To: <20260729-b4-scalable-cow-virt-pgoff-v3-0-e8ecfefea812@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1716; i=ljs@kernel.org;
 h=from:subject:message-id; bh=022bLd1rMmlNyvelJecXqv+89KISK1vz6wvXeWBW9xM=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKy9H5Y303/Hv0nV8MhvGxxhtrk+yoCFVvfX66dm7yGX
 d5moYp9RykLgxgXg6yYIsvzL+L7g0TC5nVe8HeDmcPKBDKEgYtTACYydz8jw+r1til3nDadqiuu
 mr63QbpJzzltnYa8wVvey+duuX8Pnsjw388+4PgSwQi//su/2KWiU6dNbvi5favLx+xPk5rOsbE
 msgAA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

This is potentially useful debugging information and matches the existing
page offset provided.

Use the raw __linear_anon_page_index() function so as to always output this
value regardless of whether the mapping is file-backed or not.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/memory.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index d5e87624f692..8658f7c75d39 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -631,13 +631,14 @@ static void print_bad_page_map(struct vm_area_struct *vma,
 {
 	struct address_space *mapping;
 	char entry_str[PTVAL_STR_MAX];
-	pgoff_t index;
+	pgoff_t index, anon_index;
 
 	if (is_bad_page_map_ratelimited())
 		return;
 
 	mapping = vma->vm_file ? vma->vm_file->f_mapping : NULL;
 	index = linear_page_index(vma, addr);
+	anon_index = __linear_anon_page_index(vma, addr);
 
 	ptval_bytes_to_hex_str(entry_str, sizeof(entry_str), entry, entry_size);
 	pr_alert("BUG: Bad page map in process %s  %s:%s", current->comm,
@@ -645,8 +646,9 @@ static void print_bad_page_map(struct vm_area_struct *vma,
 	__print_bad_page_map_pgtable(vma->vm_mm, addr);
 	if (page)
 		dump_page(page, "bad page map");
-	pr_alert("addr:%px vm_flags:%08lx anon_vma:%px mapping:%px index:%lx\n",
-		 (void *)addr, vma->vm_flags, vma->anon_vma, mapping, index);
+	pr_alert("addr:%px vm_flags:%08lx anon_vma:%px mapping:%px index:%lx anon_index:%lx\n",
+		 (void *)addr, vma->vm_flags, vma->anon_vma, mapping, index,
+		 anon_index);
 	pr_alert("file:%pD fault:%ps mmap:%ps mmap_prepare: %ps read_folio:%ps\n",
 		 vma->vm_file,
 		 vma->vm_ops ? vma->vm_ops->fault : NULL,

-- 
2.55.0

