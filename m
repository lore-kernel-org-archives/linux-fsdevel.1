Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794225855;
	b=IopMHY35q8FC3VPFhWIKcFkL4bx0/nTiVo0e5NLlNpNXpGd4CF1UwgvoPLQdC0cx14Wf
	 6Ssk6G8/yVRw4V/oe7uxZCuTX6bjjzejeNHoUqjNvehcAGxPopnbT1jGaL+t7hjy7AXvb
	 XQV1aTQN7zYQX9PV1cLc6glOGemMucAk8i7YJlZc+34HSHZeXRr6M9hcKfhe3KuQhbNFr
	 z/pQqVFlFGKjkrPNX865lqYxfXRHMEa9c2BYWaXraej++zkwcicIW+5HE/O58chvmZD2L
	 NXO4LorHJz3pJ0d5Q+qk2eh5hjrNiXmvYHwsH22cvCbE1MJnL8cohHwhs2Y7isbSH+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225855;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6KtNQnmIxI0QenYCQzZ2p4IsyzDnjmwEuXaOE3U5xFI=;
	b=pY4lKnEKIZCcbi5WTIUN43cMzNRmgZOUF3jgb8Y5PILLyUrKxsDHT/y6wReNCkuhR42W
	 vFyk2xMXGz9hOuqQ699JFEKATi5MSJn5I+KmC0BwXDWWIQP2Ki9FtiVCiM6RpHCoxyBrY
	 1N5NiLOlRRmHsJ90EOAE6XJayhXh9GseDwatKlHZnBLp18XnpGmndSDIFvhoYn7Vr67rg
	 vwNGpam2aLssjMzH+rCUJbSHXjtn/XukG+Q6U9YKO9WyAG7oDtCsKONtFAZdb539VW9r1
	 DTaBnuAkmu4J6ILJpqt4tHoZTy0TRc66Kul/k+p7L/YLJZDI+1XnUvZcg2TfL0k/H5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=maqChVHY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5794606A325
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 12:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=maqChVHY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140081F008A5;
	Mon,  9 Nov 2026 12:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794225854;
	bh=6KtNQnmIxI0QenYCQzZ2p4IsyzDnjmwEuXaOE3U5xFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=maqChVHYt7UHd0PkqZXlPhMF5EF/+k7GB1eNh7F8HqF9xvpV8sXRBNefl0fmFp1u4
	 PKUad7AQdbEH5nmXexaX6va6BgpSOUGNMTn9Erlv2zwWhgE7QSWf+ldKMjnSZ241gg
	 gn4YGN9cIXIkeXxROiliDbE69JhFp9EsbEQkZOI4b8j3PXRz/jqspQclGkuwObYwLc
	 yZzTUlqzJEKHIDRMlBS4liICJervpwke9NhZEkgMaVVwegBiB04frU31JTPfzI/jOx
	 /ZiUXACm3w/5n45d5s+tWYFAGYc/wA5sa4dpArLN+z/kZ5/f1zE+LhHpp1WNAlAxvW
	 IC8fgzx0LH+Zg==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id 35F691980047;
	Mon,  9 Nov 2026 07:04:10 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 09 Nov 2026 07:04:11 -0500
X-ME-Sender: <xms:ubbxanVJ0NJhtycXziopWk4XCNAwqCArL31FN9dqV08EEkTHblzXyw>
    <xme:ubbxargjz1sUGoaL3GxTZMKMocATt7Qtpm0BosjuFGBY9ZpRAouHXr4p2VNuZSWTE
    PjbV3k9fmm4-eeplBdPBZAyZ-JfNPcL2awVPvA9sMLTc7HLmUjTG8I>
X-ME-Received: <xmr:ubbxapghy3Gs0Cw0tDsJcZ_JKHiBzAlrKjRABh8CIa5SwUrTTtZ7jWuX3qU>
X-ME-Proxy-Cause: dmFkZTFgcJX3QqaptuagcgdnHFOsQz9wWiwGd7fgbWtGQNXmmbQfltLWg6boYc6d5AKRlG
    aOxWDcvYi2kECOnriHvC/JUlDnzbmMpNexALRZD+bYBHTIomNBZGGdCvXnp7cpCw3lorG4
    mGkrJknDCty1x7KsL8HGILfh1AM4KqxL7tur3y4mpHTRwUy6di6Bu27Pr9NACBQYUpbMuF
    HWK/8Qq13pFWGE6fal96QlsPbVBll7/chUmg6CwRPtzvPHt+donq3X9nQyFhwbSOM0N+Io
    m6CjDIVHaS9HXPRZ818OnENAcELGySEuqqm38mAS7EtGpMa7cAB0pgdfGnkGeISrlEhMJK
    KuMC6q5DLaHRgyX/hBgjUKsMUPqtZvjgceEDkznhIAplP8bkScP9qG8/uxFiNocDvLdG9i
    N8Hy78HdgidFLTVI7NDYd2CVeoCAPHnrZoGw2UIa29B2Yp6pRijzZz0nCJPRSvjAqI3iZ9
    bzRWmV0UzyvP4GPE6jgzctKeHjJE3QxKwRHZzzwXWm86MSzEKA8+sYXUiwyJQ9b5dWatt3
    h/DZ1MoPGzMIHR9gCGVnGZsBTU2h6rGOFDUdhPxkjvGRdErnEhyPoSNtUpHkceGOd49bZu
    U9tWGzr3emLA7R+XNz5O+UrnfvFHgUmsFRCq1vM3BUqxqdafNXiPI4K1JSEQ
X-ME-Proxy: <xmx:ubbxaou2cd4MDPPsZWTc0JUPCRLO5YfSIzY5iQDBzGcmjgZBP3qjcw>
    <xmx:ubbxavtNT78aBYuwNIwH5W5RO915k0-15pwynMptd-wRw-5MbIoEnA>
    <xmx:ubbxapNRYN8vQpJ-7V7a2LWGKESPlXh6GgERsIED29lEhclHDsC-7Q>
    <xmx:ubbxahftb521JzFlFMK76h3zynBQ9Ex86ysKAL5t0YKYHWdr3bladA>
    <xmx:ubbxagk0-Xy-yC6jtYOso1yE66nO4KzIVS5amyJd0dIZs6pZbuk9BLWz>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 07:04:09 -0500 (EST)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Chris Mason <mason@kernel.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2 1/2] mm/memory: recheck PG_uptodate after ->page_mkwrite()
Date: Mon,  9 Nov 2026 12:04:01 +0000
Message-ID: <20261109120403.82361-2-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109120403.82361-1-kas@kernel.org>
References: <20261109120403.82361-1-kas@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

do_shared_fault() unlocks the folio around ->page_mkwrite(). Writeback
can lock it in that window, fail, and clear PG_uptodate with the folio
left in the page cache. ecryptfs_writepages() does this when encryption
fails. filemap_page_mkwrite() relocks the folio and checks only
->mapping, so the fault maps a folio that is not uptodate:

    CPU0                            CPU1
    do_shared_fault()
      folio_unlock()
                                    ecryptfs_writepages()
                                      folio_clear_uptodate()
      filemap_page_mkwrite()
        folio_lock()
      finish_fault()

The next read(2) or fault on the folio reads it in again from the file,
over anything stored through the mapping in the meantime. Those stores
are lost.

Recheck PG_uptodate once ->page_mkwrite() returns with the folio locked,
and retry the fault if it is clear, the same way filemap_fault() retries
on a cached folio that lost PG_uptodate. Skip folios outside the page
cache: driver pages from ->fault() never get PG_uptodate and would
retry forever.

The check stays out of do_page_mkwrite(): wp_page_shared() calls it on
a folio that is still mapped, and a retry there would fault on the same
PTE forever.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/sashiko-outbox-202966@kernel.org/
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/memory.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index fe72e66c9c2e..cc1d0b7d15c7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5613,6 +5613,18 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	return VM_FAULT_OOM;
 }
 
+/*
+ * A page cache folio that is not uptodate holds data that was never read in
+ * or cleared, and mapping it leaks stale memory to userspace.
+ */
+static bool file_folio_not_uptodate(struct folio *folio)
+{
+	if (likely(folio_test_uptodate(folio)))
+		return false;
+	/* Driver pages from ->fault() never get PG_uptodate */
+	return !folio_test_anon(folio) && folio->mapping;
+}
+
 /*
  * Either the VMA lock or the mmap_lock must have been held on entry
  * (see FAULT_FLAG_VMA_LOCK) and may have been released depending on
@@ -6163,6 +6175,16 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
 			folio_put(folio);
 			return tmp;
 		}
+
+		/*
+		 * The folio was unlocked for ->page_mkwrite(). If it lost
+		 * PG_uptodate meanwhile, retry the fault to read it in again.
+		 */
+		if (unlikely(file_folio_not_uptodate(folio))) {
+			folio_unlock(folio);
+			folio_put(folio);
+			return VM_FAULT_NOPAGE;
+		}
 	}
 
 	ret |= finish_fault(vmf);
-- 
2.54.0

