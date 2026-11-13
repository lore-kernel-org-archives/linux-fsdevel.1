Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794605198;
	b=saS/JAZfw5mKMSa/NNT23tecu4YAAYcxmEMYzBSPvVdEzufkK+5Hi5/KFlBg/zy//xq1
	 mX8O1LqgSLtQjIF6NUPjQIL9wnJuJ9iriQbSKVCuA1wmflVm2zklKeb1aCHYj9drLCr4v
	 Bb6aXqIuVjH3rf5SmFmM4B0S5tjoISkrGgF87j3++L/9lhbuL6cBYjJp+K3nRlVBIHAZa
	 JtlVJq838k/rqik/EFqpK7uARBupFcWYktYiyaXhTKfOLaR8N9DbA5ExvWlVgDhyTtSzB
	 6R7qBkIu7jUQGDk5pSqEGJ8rT8R7NiV96hx4aC0/egtHXqlTbJG7U+StwdFQrTFzeHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605198;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=e3++s3veCOvuSG66GMLIoHWuPEpo+kSr6b68ALtiz4s=;
	b=etKyujUAz+q0XqVLfcs7/RNcQ/Yjwh1h4sAylpEQKk6nR8Upiffb7c6HHloP9vJd8U1w
	 jBlI50nCOre7nLEzGzxX57TFcwj/F8kjYsP4gZsx2rNSsUSvVP9U1e08sStel71IUAHBE
	 7ztnBO0IAO8FluILcxG4H40RfTenAs3p+q7T/GvPSgud9CyzIj2a5ofON7iApLo3mm/R/
	 wpgK9kJxiQrc1Zpp30ecn47PnN48NH1uO0HC4xhVg+h7xCzZEHhOk3XFO8sFEjlmw+Pxr
	 tNJf1uuBtQ5FT5mn2o2wN3HbqKBvYCofRMaI/KtH4donT3VuJX6kS900iGNNjENpgKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZSatrfhB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D38606A88F;
	Fri, 13 Nov 2026 21:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZSatrfhB
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794605198;
	b=wPujZV01OzoxTQF+Mb7rklM8iSgCLNJ5ngwNtK477usfzlJNTJxepNIQRFxzJ65fFVEK
	 B8mwjXmtIIBKqID6g292/UDZL+NvN0EtHK64FFmBtBler8cQwOEEvRLuMI6k7sDcjQlp+
	 9+wYHz7Um+nx1mVgjmDHKqusZrL9ruBeJUEjG2tS2eXQMrsSOZNaR/6hNy4SpZC7c9LKl
	 1Y1yEpFO11dKg0kZZb+pTi0iRV9bu4myt0pgZBYVGm/p6eNf76EkIQj5U90G9tkJjZxvA
	 FAcmeNGMGz64gbED7mOOqK57QS04fg99gJvPX6OHqlV6HTzQ8KEQanzK8QCuOLaW93g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794605198;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=e3++s3veCOvuSG66GMLIoHWuPEpo+kSr6b68ALtiz4s=;
	b=m1XPXh/Fxj83kPv/+v+tZPogJxpBKNRXzqGxJv833dFIKnyw0b5vyqxWkILSXXTas9+4
	 PEpdShw8W7agSaCZpAtwSlLckEkqmDXe/Bn9DcROVeCE0eUpqMMK0O14wljoJs4HMRSfp
	 YeOlH+wV3v2UCbne1xUcAQALbWVkoaiElwkyv8/lXFi6SKgUU6kxlewQg5XVLSzMXyl+1
	 wN0V5k7lR8XmIPONZww0D7RbMb1JNn3BCH5Fj4rQ+4idaE3xbxNXbEPlO6wIzqFn6C/g4
	 MippUpkbDULIigBITnUji0gQm4D7srbytabHjf4bmMmsLueSTim232pssdarLuugH2Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A38641F000CA;
	Fri, 13 Nov 2026 21:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794605198;
	bh=e3++s3veCOvuSG66GMLIoHWuPEpo+kSr6b68ALtiz4s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ZSatrfhB5vChYsYtYb6zRdq80aXdh+L0GdDQC8st85gRm7/ah2tEOEWl88JPBoQvp
	 11JAmIshEH88oLRRM0c7ymKWlpUOS2NaPnypfvhsvigjfpGwRw83raOGSZucv3zTnM
	 Q4qbZ5tipwLVHnoX+ydEi7457tDWjmUC+a3+IhXUGDPtfjNLI4BURol9htkfW1/iLc
	 /7j4mX2IHrndph6fh/kRZtUH3qC8tfMqVLOB1nYTxSNdgMBE7512evLf74guB0PjOP
	 ydfQq3BmIMCzTklypdLl6OqS/bvr9ImYVbnIT0Nf2gn6e6THcbJHxM0l1bBsist9pW
	 aWAgVVPUs+rvA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5DF2049B26;
	Fri, 13 Nov 2026 21:26:36 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Sat, 14 Nov 2026 05:26:22 +0800
Subject: [PATCH RFC 6/8] mm/huge_memory: rearrange split routine handling
 for better optimization
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
Message-Id: <20261114-swap-thp-split-v1-6-dfa8d4fa448d@tencent.com>
References: <20261114-swap-thp-split-v1-0-dfa8d4fa448d@tencent.com>
In-Reply-To: <20261114-swap-thp-split-v1-0-dfa8d4fa448d@tencent.com>
To: linux-mm@kvack.org
Cc: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Kairui Song <kasong@tencent.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794605194; l=2082;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=Ywh5u6CH0UvNagiKhU1WNU9qFNY87IWayR40Afi6yCI=;
 b=5BjTzAVdQpgSdWyC+wp+tXTzTaCfmBLbicy3sBWh0+gsjfSSveiCBn0OAOViPC/pMoDHBKNFM
 dILf8SHbE2BB1NmVgVtErkw8dzv+fl3VR5SvpYPPSoY5MiKaULg5b9m
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
Content-Transfer-Encoding: 7bit

From: Kairui Song <kasong@tencent.com>

Anonymous folios never use a mapping or an xarray, so combine the is_anon
and xas conditions into a single if/else-if chain.  The compiler cannot do
this on its own because the xarray split calls sit between the two
conditions and the anon mTHP stat update comes after the split helpers.

./scripts/bloat-o-meter on mm/huge_memory.o (x86-64 KVM test config) shows
__split_frozen_folio() shrinking from 1077 to 996 bytes.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/huge_memory.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 7270baa20d80..e16b93318613 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3929,13 +3929,17 @@ static int __split_frozen_folio(struct folio *folio, int new_order,
 	for (split_order = start_order;
 	     split_order >= new_order;
 	     split_order--) {
-		int nr_new_folios = 1UL << (old_order - split_order);
+		if (is_anon) {
+			int nr_new_folios = 1UL << (old_order - split_order);
 
-		/* order-1 anonymous folio is not supported */
-		if (is_anon && split_order == 1)
-			continue;
+			/* order-1 anonymous folio is not supported */
+			if (split_order == 1)
+				continue;
 
-		if (xas) {
+			/* Split can't fail at this point, update counters now */
+			mod_mthp_stat(old_order, MTHP_STAT_NR_ANON, -1);
+			mod_mthp_stat(split_order, MTHP_STAT_NR_ANON, nr_new_folios);
+		} else if (xas) {
 			/*
 			 * uniform split has xas_split_alloc() called before
 			 * irq is disabled to allocate enough memory, whereas
@@ -3960,10 +3964,6 @@ static int __split_frozen_folio(struct folio *folio, int new_order,
 		pgalloc_tag_split(folio, old_order, split_order);
 		__split_folio_to_order(folio, old_order, split_order);
 
-		if (is_anon) {
-			mod_mthp_stat(old_order, MTHP_STAT_NR_ANON, -1);
-			mod_mthp_stat(split_order, MTHP_STAT_NR_ANON, nr_new_folios);
-		}
 		/*
 		 * If uniform split, the process is complete.
 		 * If non-uniform, continue splitting the folio at @split_at

-- 
2.56.1


