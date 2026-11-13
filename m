Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794605197;
	b=ILEJdgTAyYm1f1cYXaTy78WlWiUlIKn+wnVPeUCkRWQBtIdHewYaTM6lmLWSlCVKtzKK
	 aq+Y86/IjTRc+YsgVfpmHQb34Enq8gCOmanhXHCQfKBWv9JN0TJx5hnfygDXO1A06CglT
	 ytDITBK/6yQ3SdZqTb25uExg/6PRpDev8wCYiyxMIDRQSd4eywc2APa5qiUeV6GsjNqiK
	 IqeXFv0fGCdTW09fmYmN/bD5H47c82gLVPYHIsySxJVFRuypLlTll0HwNAALnFHevDRW5
	 X1WdbLZW1oDRtGG1vMKGFCVElw8eEvXJeynAwxJO7hMTNAD6eU0zMkz7nuZe3mtR4ow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605197;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=6JtMkq3Mj1Gs8M72xLAd5Gui7Cf+Nu6B+jWxfF6iCP4=;
	b=fCDMhpgnuz2Oe6ooPB8gEELeLGp0pVgo72iZzrBHUy1jxnu0F/R5LAJjWJg8QBGPJqBq
	 MEWT8sJgQkz2nITv256ezI88dC4T87Xg9YyHfmH+SzFPEnLgCTS61ijLKMhuNCwYv04nm
	 qIGOLzDY0qMrYR9hxe4lFLTVdUkJt0eHuo9e6G98lcmCLMIi2yT74Wb7Wb+JUVqnbyl3P
	 82TcelEHjsSiTNOtig7yrOzHF40ModmdNAn4z2RaG8PQUHFasxdurlHxvqIeJEx0hjgwk
	 gec+KErlPee1b//v4Y+iKxLOW/NA/m9olXX1cBL6gVKSkCIphagpC7oJWm+MyW8QMrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WsF8M/mK";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDB5606A327;
	Fri, 13 Nov 2026 21:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WsF8M/mK
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794605197;
	b=MMHT9cwDusqzAtNsC5rIv7ltSDW/cVF4+ZgIYyKf/FOMsjpokoiwA4B7v0z3GLpMkjAD
	 b/EULA75ftWO4EFiZq2RZBIZlouywrhaIw82z+BmSNfc/yKcFmjYXWlm5Pf5zZufU+nS1
	 SMzmJHAYD3+nlNeVFTDdQZXwrV+kA0LWjv6jXYRYpoOwCbglu8iiN8BSI0VzPXCdsrOfn
	 ogNaxGnwt/1YH4Ss+KNgKzx7n3GG+oDBkzsuswsLxow7uMQUuzrEOZM9kPgTTrIgozS5u
	 sjaasnHRHouEsCAK+HR9XXilfjdI0OU1zyrCkVoznd53g89QTZXhzlIB+6MxGN1oLKA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794605197;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=6JtMkq3Mj1Gs8M72xLAd5Gui7Cf+Nu6B+jWxfF6iCP4=;
	b=SqfA2epqn9nsG1P5Th86Y3061E5gi2l6ihBA+EUoXTjoit5GcXNBdoVccXhb7KyGLm/l
	 qVLQ7XMh/XJoJE/GQLEWD53ggKvWASmeXG+bPsL7aKU7W4/W747ArdzYDHF03TSNNwZwu
	 2eT73YGtIks44N1oPUedIW0UxhL7YvhV91OFd4sEW5ogyy9/MW3BkZqt77s+PgMZwlIa1
	 7ZsyGGPbybwR2jG5AfuWVqJijY0X3PxiK3V/TFmYk3kZneDxXQREYYAU9jM1w9REWNFk1
	 fNjpskdktAna6VHedquAUG3xXM3PmFHgr+432ckg7uux9pCEHm1541aS+ZSydzdpAHw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 73EFA1F000C4;
	Fri, 13 Nov 2026 21:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794605197;
	bh=6JtMkq3Mj1Gs8M72xLAd5Gui7Cf+Nu6B+jWxfF6iCP4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=WsF8M/mKgOhp4f8H6Q/nmYw184rF2TTSkIz/7qdBEbU+poKbagbUqkr/HhLzQ0gQV
	 LNsxlQeEdpNb5B/EWyTnU+XyhFNLsgP8uzfOAkldAqLASPCPulDMQbrtiqRb/TCGQ8
	 KEKC5ja9JUCG2P8M7slWTYB+UPQXHQYqqXrdK1clHJ3o3+ay6aXzVey/yZ7r1r0ih2
	 RKPhEIjQQ8a/XX30pKFBnazX2DjMjwrs/JhfQjYefNegdVMxLKySFVz5XaOf4u8J6Z
	 PhHt7xYt3ctUC091tINZEEqjzN5rIYwGnQjORo9FWLxdUqp2eUoL5aJbv9Vth34xM3
	 kIa3FQJQVo93g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E1FDD49B11;
	Fri, 13 Nov 2026 21:26:35 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Sat, 14 Nov 2026 05:26:17 +0800
Subject: [PATCH RFC 1/8] mm: add folio_prev()
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
Message-Id: <20261114-swap-thp-split-v1-1-dfa8d4fa448d@tencent.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794605194; l=2033;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=8U+vChwHY7bImKDhKYpDCcJf0GyjeC844R7WWMIwhQE=;
 b=bwhRW6oU8F0MtgXSJAnvYmhFawAQqpNqSAeZ2CULRpOAFzH0mFOKzLo2F/+QLfhx2XXIX4rwT
 ElUU4af3Wo1CMV9aLfBV4At7whxEIEoMjum5LCSYHN1XJI4QoArc9Pf
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
Content-Transfer-Encoding: 7bit

From: Kairui Song <kasong@tencent.com>

This is similar to folio_next(). But to get the head of the previous
folio, the compound info of the current folio isn't helpful. So here just
retrieve the previous page frame's compound info instead.

This creates a nice side effect that we don't require the current folio
to be still valid as we don't need any info from it and @folio is never
dereferenced, just pointer arithmetic.

The caller has to ensure the previous folio is legal though, as there
is no reliable way to tell from @folio whether one exists.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/mm.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 77b5d450fe45..5b529bc6624f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3076,6 +3076,29 @@ static inline struct folio *folio_next(struct folio *folio)
 	return (struct folio *)folio_page(folio, folio_nr_pages(folio));
 }
 
+/**
+ * folio_prev - Move to the previous physical folio.
+ * @folio: The folio we're currently operating on.
+ *
+ * The inverse of folio_next().  Use it to move from one folio to the
+ * previous one in physically contiguous memory which may span more than
+ * one folio.  Do not use it if the memory is only virtually contiguous.
+ * This is the folio equivalent to writing ``page--``.
+ *
+ * The caller has to ensure the previous folio is legal; there is no way
+ * to tell from @folio whether one exists.  @folio itself is never
+ * dereferenced, only the page preceding it, so it may be a sentinel
+ * pointer instead of a folio.
+ *
+ * Context: We assume that the folios are refcounted and/or locked at a
+ * higher level and do not adjust the reference counts.
+ * Return: The previous struct folio.
+ */
+static inline struct folio *folio_prev(struct folio *folio)
+{
+	return page_folio(&folio->page - 1);
+}
+
 /**
  * folio_shift - The size of the memory described by this folio.
  * @folio: The folio.

-- 
2.56.1


