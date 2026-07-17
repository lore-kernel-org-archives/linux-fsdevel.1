Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4307637F015;
	Fri, 17 Jul 2026 18:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784312570; cv=none; b=f/PpPAd3mLaBwBaH1zO9TrL9nqf8X3aKdG0vfVQCAaM6IGa4IeZlss0XUlXPtAf/MAkW1dDDOlYOzFTVr2ZP2++ZNreyEm11BBp58vnmwyMARYy7RXuSDDy/nmS80AHN+OzWtRud+3vvaMq+9dgLj8ld4yaANDPzR5TzQB4WE94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784312570; c=relaxed/simple;
	bh=T5Gj/piAc/UlxcCiA9iiJMiRS1jgA5HHtjYX3YWMzOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PWqyYHEdze9XN5UVvpv8pJv+69KCUkz0YlTmal0ujzUzP/SQkq/4uJTWMCjVekFaM3OchTdtmGlWCjI8KAAGy1qOjNHqp/QWuCZzwR53GdWkDr8dI0RqKrZXM91BrHJU+mkt2CohpBfdEaFvOjN3uCkf494LV6qwPXd7N6kLWl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQb0NqBC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQb0NqBC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D8C1F000E9;
	Fri, 17 Jul 2026 18:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784312567;
	bh=ZUSSGoClEIjzcszURqrS6Zg8fTue7uAoFYyLToW70HM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cQb0NqBCHQGHC1RFzL4Kq1JuN+fgnh3yxUX3z9TzKhvfgzLhXPkosagslKQGpb6ik
	 jBM648jP4hMwYdweCkXVfjisIz2NgT6YNfxYnF4kza07w4Lf0PZ+TUeW5Sk8g8Pd0u
	 2bW2+mOyJN1QFVP22fB7jI8AGzEQ2pCS8rTpVg+2udEuBzyC5Iy6+DkEx7iKPAMCZe
	 QWv5IHzNgQN6mfE5qeCXeoBpGYK5ujKOAoTCPH8wIpGSRtgU0N3EpRd2jqdVxpFxmb
	 EP/b8mAoXtCira7rFVJ0wp0C7OSakTTEj2eGUOiOtWY/R20C+KLO8wlSfu9VRRe3Y1
	 RTHy+SMU2k59Q==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 17 Jul 2026 19:19:42 +0100
Subject: [PATCH 04/15] mm: update print_bad_page_map() to show virtual page
 index
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-b4-scalable-cow-virt-pgoff-v1-4-cf24910ef094@kernel.org>
References: <20260717-b4-scalable-cow-virt-pgoff-v1-0-cf24910ef094@kernel.org>
In-Reply-To: <20260717-b4-scalable-cow-virt-pgoff-v1-0-cf24910ef094@kernel.org>
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
 h=from:subject:message-id; bh=T5Gj/piAc/UlxcCiA9iiJMiRS1jgA5HHtjYX3YWMzOQ=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKiivZaFhx+LXA8WfhVkt0Hq1l1+dZVuTueldzvOJmpO
 i9p03mxjlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAEzEIJqR4cS79waejYfa5U85
 d6TaKbms1DtksyqP60vuPEkPlWlefgz/vc4vVDhzVSJViO1zmTKn5o3tHPV3ln7+U9xzdp9T09c
 yJgA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

This is potentially useful debugging information and matches the existing
page offset provided.

Use the raw __linear_virt_page_index() function so as to always output this
value regardless of whether the mapping is file-backed or not.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/memory.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index d5e87624f692..56b244552f13 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -631,13 +631,14 @@ static void print_bad_page_map(struct vm_area_struct *vma,
 {
 	struct address_space *mapping;
 	char entry_str[PTVAL_STR_MAX];
-	pgoff_t index;
+	pgoff_t index, virt_index;
 
 	if (is_bad_page_map_ratelimited())
 		return;
 
 	mapping = vma->vm_file ? vma->vm_file->f_mapping : NULL;
 	index = linear_page_index(vma, addr);
+	virt_index = __linear_virt_page_index(vma, addr);
 
 	ptval_bytes_to_hex_str(entry_str, sizeof(entry_str), entry, entry_size);
 	pr_alert("BUG: Bad page map in process %s  %s:%s", current->comm,
@@ -645,8 +646,9 @@ static void print_bad_page_map(struct vm_area_struct *vma,
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
2.55.0

