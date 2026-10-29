Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793289047;
	b=ER3ZsvrnAbKcEJ0LCLkhcnJbImXj6La8gK3pgwbhz8iIQ876DwX4yFfZX+pvteTuCPm8
	 XGqyyXvbrGu0Qu5bUK3ZHm5hkSAbggBCcdVvYPZIOk1Jr++oeWmupr6zbBx7Sy6h34nzE
	 6sJZuYlf8I6umY8TZ6Ig1lR2EyeVDhjPMM6CVEpJ42mxa0beU9TlDeL6l58vZWvH3e0sg
	 SQJ/UnaPrEG2x/WL1HFkvq+44cE7ODh0gx+KIb8wKR6VrhAW3Etbti2su+YY31TeTzYSQ
	 Fz61rAM6JiKMFVsoWojIL04aD5OoXYdK57GDd6aXdXJCCXmmm5gbeUbDDPRE0qWDiJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793289047;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 X-B4-Tracking:X-Change-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=yaAYz8Hc0E1J++0lVxAIJTRPnroDQ9MIhn/HfIw3mGs=;
	b=ghXVxeUr6KzAku3pDbaVW6Motm7GnOQ/TpiZ2ksltNLE7EPTMNnBhgFN8G7m+oqo/EEH
	 CkQOTpDKKIPrrAjCXBlKr+CJ5Eoidf8KzAY5/2oEI9sqaZY7XttleDrDU8Eva1M9Chu6E
	 8llMgzLgsKf8brbOlfudgNSs9+xZ4XvAP3vBkfgABmClnFGSxH8ieFX9tmrThCZChraC2
	 5e/SAwSIoHXl+h+MoIBVHW2452bh1KE6C+6Ul6QPdRHlyXwtU/rQAU9GwVSr4h3PQwbXS
	 izUpK/7OL4nw5KDIv3XQE8yiR/2AIEyZJ7WdySEaFvm8m9hXVEjnwpHPtuTFJglDaOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jp2EfrI4;
	arc=none smtp.remote-ip=91.218.175.184
Received: from mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB81606A331
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 15:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EB81606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jp2EfrI4
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=n9CMCDalShVTKhOhD+z5DJppXsi7YqvLnst8+Zhlhxk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793289044; v=1; x=1793893844;
 b=jp2EfrI4BVBGN2zknGopZvCy+T/xY7ruX+Rl8f78cl08kZqIUKG058Yr5eU5pnNopGhE5qsE
 T0/y0iooL1vrTn9B54OCE8Z6i9vf6+egbewXom685DJu3Qz9gsLTifwpI7jznX/fG1UBE/D4GTm
 6lSJlF2DfLbRrRt8aW3b0P9o=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 43b22051bb286e53;
	Thu, 29 Oct 2026 15:50:44 +0000
X-Mizu-Trace-ID: 43b22051bb286e53
X-Migadu-Flow: FLOW_OUT
Date: Thu, 29 Oct 2026 15:50:40 +0000
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>, 
	Krystian Kaniewski <krystianmkaniewski@gmail.com>, "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Subject: [PATCH] mm/filemap: stop fault-around when the walk steps back
Message-ID: <20261028-jf-mm-filemap-map-pages-lower-bound-v1-1-0bf126e876d4@linux.dev>
X-B4-Tracking: v=1; b=H4sIAHuF4moC/yXNywrCMBCF4Vcps3agiVCiryIupsmkTmkuJFaF0
 nc31cVZfJv/bFC5CFe4dhsUfkmVFBvUqQP7oDgximsG3etB9drg7DEE9LJwoIzHMk1ccUlvLji
 mNTqkQZ/ZGTLKXqCVcmEvn9/L7f53XceZ7fNIw75/AQGVreeHAAAA
X-Change-ID: 20261028-jf-mm-filemap-map-pages-lower-bound-a623ed8a81c9
X-Mailer: b4 0.15.2
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

filemap_map_pages() can dereference a PTE pointer outside the page table
it locked. KASAN has reported this as a use-after-free read [1].

Its fault-around loop walks the page cache and moves vmf->pte by the
change in index. A lower index moves it back. xas_find() can step back
to a lower index when a multi-index entry is split during the walk.

[1] fixes xas_find(), but the loop still relies on the walk never
stepping back. Stop the fault-around when the walk steps back. ->fault()
maps the faulting page if the loop did not.

Link: https://lore.kernel.org/20260904121301.200049-1-krystianmkaniewski@gmail.com [1]
Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
---
 mm/filemap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index b74bc1e5015c..1df776907140 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3968,6 +3968,13 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		unsigned long end;
 		vm_fault_t map_ret;
 
+		/* A lower index could move vmf->pte out of its page table. */
+		if (unlikely(xas.xa_index < last_pgoff)) {
+			folio_unlock(folio);
+			folio_put(folio);
+			break;
+		}
+
 		addr += (xas.xa_index - last_pgoff) << PAGE_SHIFT;
 		vmf->pte += xas.xa_index - last_pgoff;
 		last_pgoff = xas.xa_index;

---
base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
change-id: 20261028-jf-mm-filemap-map-pages-lower-bound-a623ed8a81c9

Best regards,
--  
Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>

