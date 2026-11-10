Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342806;
	b=S3Xd5tDMRUonanrFquR0A6vYoDaEweaH5RwUfFx10kcK98imi+QtgGnae/5SPqpu+imU
	 CczOL+tMHovhFFdEJo89Fg9NuhxovoTY4qO0tViOefHog3gYIjxC2FbvOmSRf3Kez+yoW
	 56lbvLQ1nVbvTqWFC7E+OEsqaqLNj0mzw8wEpat+xIkJBVsrqs9cZ91zpBx+IHSlnSlvd
	 G3racVT0BLlR0iq6cBGvudU9Jl6U0yta2Wt4ADg0nDTqBLfKpdjvQrO0BnslyS6eqq3DN
	 KRPc2jUuBsvact8vtDlE4yjTShNsuubjrhaCahu8Lyvn9+iGLID/LnTWS+0zQVi0BBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342806;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=HNkHh8576R9yenj6hZR3ukTbtfxm+sK5xBh0AHQFgqo=;
	b=nXNQDXbnUpUXsHlkpU+QvjDkxzY/jDs6OQJn6b6j++t1zNWyAFsYPeO3M+rzmEfAwdCQ
	 qsOQo9mGtCKiyIHujHAR72FgDi4iu9VxP8acHKKJI6UZGhc9SwrtzcEdDTDfrFBmHnhNU
	 DU0uuz2ydUcc3Ls2DI4ZIegbd9KxWgFn239O4/mbGAe8LN2lZ1FxnI3fYTQuH9JwOasvu
	 D/WNX/vXrkke6mmFuvUQFjccuM/dYN2hDyFmLh6ZLdllaUD3qqlslG+aetO9g+5/x0DoG
	 drI5y/VJJ2iec1x/8eeG8e8+jSC0E+iVhFZSnRSP8Rj/XSOB7Zt7P/HXRSJEFfm0eGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=faMHSEj8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFCE606A88C;
	Tue, 10 Nov 2026 20:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=faMHSEj8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D423A1F008A1;
	Tue, 10 Nov 2026 20:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794342806;
	bh=HNkHh8576R9yenj6hZR3ukTbtfxm+sK5xBh0AHQFgqo=;
	h=From:Date:Subject:To:Cc;
	b=faMHSEj8UOEq56lelMECdxXPosfoDrSmgupOG1ETLfm4s/3RSRQbWnwEO2YuWM/7o
	 dmvKVtzQ6CUh3/qK0bKxwIxZ4CxZnXNghLCj/+N5VKaXGQ+S6vb48mZc+rCQaovFzA
	 fKHHKewXX3EiL693xJoDj4nixSbxG+ILn5SFAPqTt6yCBbW2M9pj8sJvfQkDwrknjN
	 lqKgQ1wb5erbceCc9bmLoWvqgj0SOf0MZ4iPOqdaZ8BHNYWRLB0jIBXJEqO2dmIsoh
	 w7r1dGCWLtOSxfhnYv7h5R7wm+yc8RMvKwInddNOaWkifRhKkkT2xfUXMGCOBJ+svQ
	 r/GWXEbl0wTOQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 10 Nov 2026 21:33:12 +0100
Subject: [PATCH RFC] mm/filemap: fix lseek() skipping a new large folio
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
Message-Id: <20261110-lseek_hole-v1-1-c089c960b846@kernel.org>
X-B4-Tracking: v=1; b=H4sIAId/82oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0MD3Zzi1NTs+Iz8nFRdk0TL1CQTU4MUE3NjJaCGgqLUtMwKsGHRSkF
 uzkqxEMHi0qSs1OQSkDFKtbUAZorfanMAAAA=
X-Change-ID: 20261110-lseek_hole-4a9eb450d473
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
 William Kucharski <william.kucharski@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Chris Mason <mason@kernel.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4173; i=david@kernel.org;
 h=from:subject:message-id; bh=X++bvNWUrEFTrfv+bufHFUKamza572buPbl4/CTqBK0=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLI+1/cxbPvE+j1D/eEZu9grzhmFD/alMGdsl37QLiJZ/
 KjVd+6ljlIWBjEOBlkxRZag4PsGL1+uq61242OGmcPKBDaEi1MAJiJ5heF/+M5Zfhv1b05LfcKm
 d/eLrM6M5ByjxT+W6nftT4teeoCnm5HhqOm8SHsngVql4xs2W/y/IaU0Sdjs8xGZ5Obpdtsagrz
 4AQ==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

mapping_seek_hole_data() walks the page cache under RCU and only calls
xas_set() after entries larger than a page. Between base-page entries,
it continues the walk with xas_find(), which skips sibling entries
to return each multi-index entry only once. If a large folio replaces
small folio entries between iterations, the slot holding the new folio
can lie behind the cursor. Skipping its sibling entries then skips data
that has not yet been examined.

On tmpfs, SEEK_HOLE can then return an offset inside existing data.
SEEK_DATA can skip data after a fallocated page that is not uptodate.

For example, assume a 2 MiB tmpfs file backed by 4 KiB pages on x86-64,
with page index 63 fallocated but not uptodate and all other pages
uptodate. Index 63 occupies the last slot in the old xarray leaf. A
SEEK_DATA starting there can skip that page, then race with collapse of
pages 0-511 into one 2 MiB folio. The next xas_find() moves past the old
leaf and skips the new folio's sibling entries in the parent, returning
-ENXIO instead of finding data at page index 64, or 256 KiB.

The inode lock held by lseek() does not exclude collapse or swapin.

Restarting the xarray walk after every entry fixes this, but increases
SEEK_HOLE time about 24%, when scanning a fully written 1 GiB memfd backed
by base-page folios in an x86-64 microbenchmark.

Instead, use xas_next() for adjacent indices. Restart the lookup from the
root at the requested index if it returns an empty slot or an internal
entry, including a sibling entry. Also restart for nonadjacent indices,
invalid iterator state, or failed folio validation. This avoids skipping
unexamined data without restarting each lookup during base-page scans.

Fixes: 6b24ca4a1a8d ("mm: Use multi-index entries in the page cache")
Reported-by: Chris Mason <mason@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
I'll be more than happy if someone of the pagecache folks wants to take
over ;)
---
 mm/filemap.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 648f783454c3..87c583509567 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3233,6 +3233,40 @@ static inline size_t seek_folio_size(struct xa_state *xas, struct folio *folio)
 	return folio_size(folio);
 }
 
+static inline struct folio *seek_get_entry(struct xa_state *xas, pgoff_t index,
+					   pgoff_t max)
+{
+	struct folio *folio;
+
+	if (!xas_valid(xas) || xas->xa_index + 1 != index)
+		goto restart;
+
+	/*
+	 * A lookup within a multi-index entry can leave xa_offset at its
+	 * first slot. Restore the slot corresponding to xa_index before
+	 * advancing.
+	 */
+	xas_advance(xas, xas->xa_index);
+	folio = xas_next(xas);
+
+	/*
+	 * A concurrent collapse can replace the next slot with a sibling entry
+	 * referring back to the slot holding the folio.
+	 */
+	if (!folio || xa_is_internal(folio))
+		goto restart;
+	if (xa_is_value(folio))
+		return folio;
+	if (!folio_try_get(folio))
+		goto restart;
+	if (folio == xas_reload(xas))
+		return folio;
+	folio_put(folio);
+restart:
+	xas_set(xas, index);
+	return find_get_entry(xas, max, XA_PRESENT);
+}
+
 /**
  * mapping_seek_hole_data - Seek for SEEK_DATA / SEEK_HOLE in the page cache.
  * @mapping: Address space to search.
@@ -3263,7 +3297,7 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
 		return -ENXIO;
 
 	rcu_read_lock();
-	while ((folio = find_get_entry(&xas, max, XA_PRESENT))) {
+	while ((folio = seek_get_entry(&xas, start >> PAGE_SHIFT, max))) {
 		loff_t pos = (u64)xas.xa_index << PAGE_SHIFT;
 		size_t seek_size;
 		u64 next;
@@ -3286,8 +3320,6 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
 			goto unlock;
 		if (start >= end)
 			break;
-		if (seek_size > PAGE_SIZE)
-			xas_set(&xas, pos >> PAGE_SHIFT);
 		if (!xa_is_value(folio))
 			folio_put(folio);
 	}

---

base-commit: 93d7a816a2df3e907e2719bd12b0073f1285fc5c

change-id: 20261110-lseek_hole-4a9eb450d473

--

Cheers,

David

