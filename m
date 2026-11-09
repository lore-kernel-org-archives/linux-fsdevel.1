Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794225858;
	b=DF+VbdjXXJeJl6EXF/q+IB+rL2NWb02aqW0vE2bW0ufg0hoR19pQX0u8/egcZ+u1vdFj
	 XL7Gk6nVNmJpOfxb1ZNIiXmmsWLqhRv3kO12H535+DKp/uQoz07uwJ5YeKyEdGuhWh1Jb
	 98Ohpmy1oK3W1FXXc8C2Q2+3NnMI8VzT/737o5m6URs051bjhp7sNcF6hvWr1exvbxWpy
	 Z8VnFKdKSGCUyzpuqorkY2bchYlSnobb0Xb3Ff8tjh03NFEwb86bJzKpR+DAlnK2SRs/t
	 IhjYLucm7NU+2uYBENlO6sDJf9qfClyJXubCzl8/6Lt8iX2nh/7MoI8EH5zcQULIjdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225858;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6MFiKRgYbDh7TYHy8nV42WRITeRtyQvjTK97N2J3pK4=;
	b=DzEZ5wCFqG73QXypIZ7cxngOw2b14QFuolZgc1fPC7RlQP73BRUznRR/V8uDQ1ek2wse
	 o8JL9QNBvco2F0VN65gMuE716lSAaxhrWR+QsmyxzV6xhGN3jbvqYwiVNougjCwL20a9x
	 AtFDEkhdNkd1kqfz9paABqqGKOTxK6GWWBoHVhHppnEQzTQd9N1lCnVePAqqhYiCRWNbq
	 01lYmTEHvp5vTNaOAEXq1uYbWBklqvpksVgxXY2Ub9NoxsBUGvH2lxmLVVgZ7/XVnrJeH
	 ncIyp1c4SRZGBiuZUslANas9nMWB0rBUPdRJK2eSi8QhbVS0OzlW5b5C0DbGjImfwBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Mt/n0Jtc";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086F9606A322
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 12:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mt/n0Jtc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871651F008BC;
	Mon,  9 Nov 2026 12:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794225857;
	bh=6MFiKRgYbDh7TYHy8nV42WRITeRtyQvjTK97N2J3pK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mt/n0JtcC9od8cYxe7uDVecnAvAxzv/cU1Vo0IFHPMpU5MiUkxwu8omUODYV5Zcqy
	 LPX8//ZdfaIcEutLlmY5Kl1GtVoLj3HA82/9bm1IEnetSW/2or2GYtn3PaLE+MB4f4
	 WXPnKxkV6rWmcOHXoc5U/1ljClKcmA5xOi2nfngeSgAljF166tDnnUUvHZk+bnGujy
	 PHOHKmSOOXgU9+C2CM2VhhYkE+B6tXrXGnVSRUZyPBUHBq7kwO2FZK0lXEq1rwwaiG
	 /P4Q1Zi7GWkjU9CePeXr/asytuVD8lPk2+vkK/lq8NDBGh4XsNjgcYpSSBvnjhcIq0
	 Eu4SJ9xHJUwVw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id C3CC2198003A;
	Mon,  9 Nov 2026 07:04:13 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 09 Nov 2026 07:04:15 -0500
X-ME-Sender: <xms:vbbxas7vTZ344FZodtk9B_zvzXKOzJFB18lU71dHyERZnO88I0_QbA>
    <xme:vbbxanR68IbNzBLNyT9N8TkeafL1bK9hE0ojWsPXQ3r30Tq_UeOfgS2OaqQYbqSdI
    sqIVB5TBcuz-wdu75KcqvnG6SxRiWwHSx5oPHe3kP8qQB0xHl_IRVsi>
X-ME-Received: <xmr:vbbxaj-ZV81kczXXLZ5HYmfOgEUxfILItKX_4OH16YTcSpFP95k9IgoBAvQ>
X-ME-Proxy-Cause: dmFkZTFNHiUwdQBBta8BQiRQNiL+3aFxYBCGleH13rK/AikNGSSC3QUGqUhmGxAnWboa44
    Oxa+oNSrcFePVCLQ4GNJqtcYf4GxsV9GMptj5ZrpOImzhEVV24EobsIoaE3cyqt1HUzWKb
    uvK/vFY8P9JVFvAY4sv/elH4sBbKNz8TiTp9kbnxQZ5ar8JtE1kD6OyBHc5nmptdrKWCE1
    SHUchB4wZ75gxD0AKiAsvr9dPbzNysAsG0icmsqmjFSwMuBk9eg/M1NxwUGV5B50W5JtPi
    mSSRdlKYNHyBf92yjckRvTvKXC7OSPkjnpnydQqAEDttujjY9r4EKzHT66M2V7UmWGi5er
    ikZqmnu1uDnQHyaxkbjc46ZO43YOdBKQ1RH9KKccapbaOK3TTnl40pdbE/fr9DYpMhsTps
    j7HDy0qRpYPcOYLrtTF/1DiZ5inJTQLs8BJtHHXRT5o3uOQnNATpLAzreKbBQmMaTgZw6n
    JJM8vVVipFfCsj7/JhuP/uX+ZPPZzqzXlmahs13aSfSACRHNO+KiV0rP04PsMuhmhNVCxa
    6VEdZqnX1y4cB2i0dapKU/4yUbSBi+QVM7HrT7Yveslwg0KGF7iTSXxum+Teq0KUQ1NQOK
    eGPOIoU54wqRC/DFCItRABfTGoQHAkcITex6FYgamEzVAu1nbJ3frcEw+1Mw
X-ME-Proxy: <xmx:vbbxagpYR0bJyBxZ5WUcSDYmTyQPfKgTDoWexdv4F7Y28rMEwFXGWA>
    <xmx:vbbxahV-Xrm1KZbHFu6yVMLQmpdBhLtQmBHvAIfygaNVaGh5tX-3mQ>
    <xmx:vbbxat5WYPH6be4un4C-Z1rnHjk0rPA4jLt3YvBnoI_yMDhZyO3vxA>
    <xmx:vbbxavASrqab1Rwq6GkTNevdpBpjcqA-hV7oQdjlEneqU4vwiVKAVw>
    <xmx:vbbxahdvpjtgJfsfZzOe8dn5eYMOllmn8MhjVXQxWUJ5zoVw1NEar4-G>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 07:04:12 -0500 (EST)
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
	kernel-team@meta.com
Subject: [PATCH v2 2/2] mm/memory: refuse to map page cache folios that are not uptodate
Date: Mon,  9 Nov 2026 12:04:02 +0000
Message-ID: <20261109120403.82361-3-kas@kernel.org>
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

A page cache folio that is not uptodate holds data that was never read
in or cleared. shmem fallocate(2), for one, adds such folios and clears
them only on first use. Mapping one hands userspace whatever the memory
held before.

Each path that maps page cache checks for this itself: fault-around in
next_uptodate_folio(), a fault in filemap_fault() or shmem_get_folio().
Nothing in the mapping code does, so a caller that misses the check
leaks stale memory silently. MADV_COLLAPSE did exactly that with
fallocated shmem THPs until recently.

Warn and refuse the mapping in __do_fault() and do_set_pmd().

__do_fault() checks the folio ->fault() returned while it is still
locked. do_shared_fault() unlocks it for ->page_mkwrite(), and a
writeback error can clear PG_uptodate after that; that case retries the
fault instead. For CoW, __do_fault() sees the page cache folio that
do_cow_fault() copies from. do_set_pmd() covers MADV_COLLAPSE, which
maps without a fault.

The fault gets SIGBUS, as for a folio that fails to read in.
MADV_COLLAPSE fails and leaves the range to be faulted in.

Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/memory.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index cc1d0b7d15c7..2324c04d632f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5684,6 +5684,13 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
 	else
 		VM_BUG_ON_PAGE(!folio_test_locked(folio), vmf->page);
 
+	if (WARN_ON_ONCE(file_folio_not_uptodate(folio))) {
+		folio_unlock(folio);
+		folio_put(folio);
+		vmf->page = NULL;
+		return VM_FAULT_SIGBUS;
+	}
+
 	return ret;
 }
 
@@ -5727,6 +5734,9 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
 		return ret;
 	page = &folio->page;
 
+	if (WARN_ON_ONCE(file_folio_not_uptodate(folio)))
+		return VM_FAULT_SIGBUS;
+
 	/*
 	 * Just backoff if any subpage of a THP is corrupted otherwise
 	 * the corrupted page may mapped by PMD silently to escape the
-- 
2.54.0

