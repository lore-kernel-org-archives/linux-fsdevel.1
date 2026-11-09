Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794220479;
	b=kXfem6CVTCB9ILUOG4oChvaIc5aKtMk8OySf5Hufi+X8e+JIt5Ygly9DH5fRRMlMNZJ+
	 HjyxefuO2WzGU4xUFdT4Zko2SsGAu+6JB8EL4Cao2lc+/6ETFPA/+wYiIoPJfJCEJWWGp
	 xITTe/NMndQSwAExrNEhaO+NFJ+ejuR3TQMtKBlkLPN4IDyQnfCsm4CEAj1FeltisH9iN
	 G2KRfT9Fue+rXwV6ljqCVW4wBu9KXMJcjIlQz6o/gjPwNxqyARrYdIOdi/fRubODXj7TG
	 xuqbdkiU6e83BNmMxQMasMCA81k7ucmTKqhJBSCx3OhK2JmsjOPgmuIAeI270m+3XBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794220479;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=rtsHU++eHrXo/wih9M9uuk16BRNVVDXZX/+Z/5nwGFY=;
	b=hV9u8Jk5lAuLf5WPaWUcYPiWqNOv/CXRKLT68rn8rMNwRLJK8b1PfjYUj7bus1XHcVEF
	 KRr7e+0im8aN6FgCLsGH9eoxwjFHjTpToZQOenXAMvTGvcrUBt30PqrkOnp/E7dzMCyJI
	 3cfyokDvUKqg1N6b66gC9IA2E8dIy2XPl2kkeGuuTu9czBHLicGQAQrs1X6rfvwkOHLr1
	 14UOYtlc+HLm/RufQhSNyXGYCvsLoH/tjSHfxIUKStKEtTb6rBSjuQ4eq7e0+JM1lapJn
	 9Osm8L1z5KoUY+rDUVnbG5wnqv+dr9FsNerFBxqn5z5hoW0/z1VGEw431NCAVE8gNRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=G5UlDFmA;
	arc=none smtp.remote-ip=91.218.175.71
Received: from mta0.migadu.com (out-71.mta0.migadu.com [91.218.175.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1437D606A322
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 10:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1437D606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=G5UlDFmA
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jiy3X41lKoHJ9TTiUEkmvmqa1hNlv04MEvb3bMfslJQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794220475; v=1; x=1794825275;
 b=G5UlDFmAxfB89RIUDbFCCBS1nF+v8gvREXBs2zhxptUYUNc1JSIXCBYnlyl5Ve2epJFTWjkg
 dM19fpY5DLMMlQVRBBK4v+INbT74Y00EEqMk2JPLOO/N2vvQokDB+yIGi84zNC11LYCM/MgDDki
 c4+CssmTN1asQAWEejKKndkQ=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4358eec4bb05e3ec;
	Mon, 09 Nov 2026 10:34:35 +0000
X-Mizu-Trace-ID: 4358eec4bb05e3ec
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Mon, 09 Nov 2026 05:34:11 -0500
Subject: [PATCH v2 1/3] mm/filemap: move the mmap hit check of
 filemap_map_pages() into helpers
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
Message-Id: <20261109-bug-mm-mmap-readahead-descending-v2-1-abac52890a9c@linux.dev>
References: <20261109-bug-mm-mmap-readahead-descending-v2-0-abac52890a9c@linux.dev>
In-Reply-To: <20261109-bug-mm-mmap-readahead-descending-v2-0-abac52890a9c@linux.dev>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
 Vishal Moola <vishal.moola@gmail.com>, fujunjie <fujunjie1@qq.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <qiliang.yuan@linux.dev>
X-Mailer: b4 0.13.0

filemap_map_pages() lowers mmap_miss for a folio it maps with PTEs at
the faulting address, unless the fault is a retry, the folio was
recently evicted, or the mapping skips the matching mmap_miss increment
in do_sync_mmap_readahead().

The PMD path of filemap_map_pages() returns before that loop, and the
next patch needs the same check there.

Move the check into filemap_mmap_hit() and the decrement into
filemap_count_mmap_hit().

Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
 mm/filemap.c | 57 +++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index b04be64a5069f..c38f0e4cf6123 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3914,6 +3914,39 @@ static vm_fault_t filemap_map_order0_folio(struct vm_fault *vmf,
 	return ret;
 }
 
+/*
+ * Whether mapping @folio at the faulting address counts as an mmap hit,
+ * which lowers mmap_miss in do_sync_mmap_readahead().
+ */
+static bool filemap_mmap_hit(struct vm_fault *vmf, struct folio *folio)
+{
+	/* Skip the retry of a fault, which maps the folio its miss read */
+	if (vmf->flags & FAULT_FLAG_TRIED)
+		return false;
+	/*
+	 * If there are too many folios that are recently evicted in a file,
+	 * they will probably continue to be evicted. In such situation,
+	 * read-ahead is only a waste of IO. Don't decrease mmap_miss in this
+	 * scenario to make sure we can stop read-ahead.
+	 */
+	if (folio_test_workingset(folio))
+		return false;
+	/*
+	 * VM_SEQ_READ and VM_EXEC mappings skip the mmap_miss increment in
+	 * do_sync_mmap_readahead(), so skip the decrement as well to keep
+	 * the counter symmetric.
+	 */
+	return !(vmf->vma->vm_flags & (VM_SEQ_READ | VM_EXEC));
+}
+
+static void filemap_count_mmap_hit(struct file *file)
+{
+	unsigned short mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
+
+	if (mmap_miss)
+		WRITE_ONCE(file->f_ra.mmap_miss, mmap_miss - 1);
+}
+
 vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 			     pgoff_t start_pgoff, pgoff_t end_pgoff)
 {
@@ -3986,28 +4019,8 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		}
 		ret |= map_ret;
 
-		/*
-		 * If there are too many folios that are recently evicted
-		 * in a file, they will probably continue to be evicted.
-		 * In such situation, read-ahead is only a waste of IO.
-		 * Don't decrease mmap_miss in this scenario to make sure
-		 * we can stop read-ahead.
-		 *
-		 * VM_SEQ_READ and VM_EXEC mappings skip the mmap_miss
-		 * increment in do_sync_mmap_readahead(), so skip the
-		 * decrement here as well to keep the counter symmetric.
-		 */
-		if ((map_ret & VM_FAULT_NOPAGE) &&
-		    !(vmf->flags & FAULT_FLAG_TRIED) &&
-		    !folio_test_workingset(folio) &&
-		    !(vma->vm_flags & (VM_SEQ_READ | VM_EXEC))) {
-			unsigned short mmap_miss;
-
-			mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
-			if (mmap_miss)
-				WRITE_ONCE(file->f_ra.mmap_miss,
-					   mmap_miss - 1);
-		}
+		if ((map_ret & VM_FAULT_NOPAGE) && filemap_mmap_hit(vmf, folio))
+			filemap_count_mmap_hit(file);
 
 		folio_unlock(folio);
 	} while ((folio = next_uptodate_folio(&xas, mapping, end_pgoff)) != NULL);

-- 
2.43.0

