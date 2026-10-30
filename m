Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793332378;
	b=zMUaOrXKFPhd6OVOm4Ksa3dmb/qRnQOBYKDutB8920IU5BOF80cPOIOD/75Krmb9naAb
	 x143KcBO6Ib5AuwDsogWiwAN3nClFcTHJwmrTCHxIcw0ivYiljq1TdL68RJRv6FAwCpLI
	 4TPR38NltDvcZtFcaE816KAOaq8uLhfMHMb1B/NzQWxrB13hBp/arKh7o3bgzXAOAaFnu
	 R0mJIniBDwnuQ2MjYo1lePLizq2y99X1zV/L8tHYlbPPe6aOhIueFT4XNlugVz1kB6M/g
	 vXtDIm+/XWnBf4eP62VKVYY9uxRIu8a61wmeSGPyHk5MflkEDiQn+IYi6DaOMJd9aGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793332378;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5bagKzpGDehBxLfa97XQN1B8UzHzLG4c9sAiEfjTT94=;
	b=aFvO2Kv7osFThmmERPnN6ygOPNlUTexk/92bECDz54u1JSX57Z67ukA/vXAuHkJ33z1Z
	 PCgKsiffgL8UE/JX22A16l714fqzg2P0R8thOax0BSSSFlwx4gKGn/qV3qljNTGIi9pXe
	 IPRMVRfkpRDNqSaXkFUH733BDSUqv39QxFMr7h1pcte7Owo20eUJdng/sebbk1HxnLecT
	 AVriVLh4de8NUcAeVdM4UexjTrHpeTExdhXzs55yI/YccCpXUhfS5rSl+hktEw82f/R6Q
	 VkiILTvhJpqvYXT/9JlEfFTcqgH697dlMohYYZqRxax9utm8NL0u5mrsYEe+VZtJlMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DZY6Ki4Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA638606A31A;
	Fri, 30 Oct 2026 03:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DZY6Ki4Z
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793332377;
	b=gOiNJwv7Og6rmhGD0HKrOYrgUOFmX6QSaopL04+Rp4IGn66j2m79ZdP11puVGIETj4uD
	 LWX6P1Q57mkTqQ4ZwxU63SVqCeEhJGCvxn2BL64JbuEgK1KQEHfaL2UhOqwt4tCXEsdIG
	 ta8Uk6ZQGNGoGBTHYbCbwhXHV0lkzeyC5mUiSlMO65K1bNEIk+VJG+A6idt4T7Jsv5qoy
	 BqPR68ozH1vCvVae209NSmeUrgIVpwb2tiUsqt0JOqV6DlFe/juw3yrg711W5JHjpPfK3
	 +V2fu3zuxOHdRgmpwo6gMPU8ZXwUng2wpJzwNjxWa6UH7b83oQXBAtAI0eQIsFk9aug==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793332377;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=5bagKzpGDehBxLfa97XQN1B8UzHzLG4c9sAiEfjTT94=;
	b=ybGrV8qddiBMBv2dc1+uNBCNffHvT1kUk9IUh1CEVU81OVGRRMsG/qjTsgF1hRnQkYIn
	 uxsVjuEk7UgGsMHoQWf2XZuv2XWXilaq6dGor1RAwD+0vw+CCmRQrAzUEfdv4WAfvLGx8
	 OBHPQupB+uOC268CDPxbEuUa8kia1ItCP9x1uiTX+IUGtCxniIGcHwe6B3fytGCXXuR2Y
	 Q2Oy07tOg7NYth0s2thvd2QwuI0t6M8nRlUYrGzSzhK0EiWeToetzlBqDIQrfXWMADvPI
	 132JLkEmbMmongl0wob0T0AdeuqGAUIkElVtScQYHulCbh7i9m1YBejB/mznL4J+aAw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 28E7C1F000C1;
	Fri, 30 Oct 2026 03:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793332377;
	bh=5bagKzpGDehBxLfa97XQN1B8UzHzLG4c9sAiEfjTT94=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=DZY6Ki4ZoiC/7TJ4jKqVzEvih70W2MICtGk9hryVMvWSxOv/CspVZUQ4MzMOH57DJ
	 9lS+pXxC3mO8DDqmJVcqDYqTpcGLH5whhb6PAq73rw357IPCfc8nxcI+8EF1KEgFAz
	 yrdpueX2cSwTbICwyAdYUz0no6nCo/OtNcZzGte+Bl4BdprTB501yATT42LethgYIQ
	 MkIvqdUBq8qJGIus70ghpNHcA0ZovKBws3gIpp0ST1RNeHBX74rk2RS6S0Kt7IjTGA
	 dS1Qr5RdA9KztnsQzA9LrJtEpCSU1HL2SBivl25H+svtCzWrMeStRzhKrgT/d0QrcR
	 x6WWKKYm8w5zA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AACF7435F8;
	Fri, 30 Oct 2026 03:52:56 +0000 (UTC)
From: Daejun Park via B4 Relay <devnull+daejun7.park.samsung.com@kernel.org>
Date: Fri, 30 Oct 2026 12:52:57 +0900
Subject: [PATCH] mm/readahead: keep at least half of the async window when
 aligning it
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
Message-Id: <20261030-mm-readahead-async-align-v1-1-109dea6851fc@samsung.com>
X-B4-Tracking: v=1; b=H4sIAJgU5GoC/x2MQQqAIBAAvxJ7biEthPpKdNh0q4WyUIhC/HvSZ
 WAOMwkiB+EIQ5Ug8C1RTl9E1RXYjfzKKK446EYb1egejwMDk6OtACm+3iLtsnrkrldz66wyZKD
 kV+BFnn89Tjl/F5UzkmoAAAA=
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>
Cc: Ryan Roberts <ryan.roberts@arm.com>, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Daejun Park <daejun7.park@samsung.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793332376; l=2790;
 i=daejun7.park@samsung.com; s=20261006; h=from:subject:message-id;
 bh=KlGeHCvXeiq1+GF1wuBXkFRE3vYfwUDNHyzWlyHiR68=;
 b=6sgU0Xgwqz6XOoOauwEV72LBz9kw9m5WlIYb+cqZUpHR8kgYzsAyqdlAug65ocGla5qbp/Hrj
 bPKuxR/UQasC8l7t1DapqPOFgn9m5GwmI0sdNdV2RMIBMd8du/pBJp+
X-Developer-Key: i=daejun7.park@samsung.com; a=ed25519;
 pk=4yUfDqGRZTIj0Ik43z1GoMZRWCNm/rgX6uJuM9dtNIg=
X-Endpoint-Received: by B4 Relay for daejun7.park@samsung.com/20261006 with
 auth_id=1122
X-Original-From: Daejun Park <daejun7.park@samsung.com>
Reply-To: daejun7.park@samsung.com
Content-Transfer-Encoding: 7bit

From: Daejun Park <daejun7.park@samsung.com>

page_cache_async_ra() trims the end of each new window to a multiple of
1 << ra->order pages. A window that starts just below such a boundary
keeps only a few pages. With read_ahead_kb=128 and max_sectors_kb=512,
1 MiB reads after a 4 KiB read at offset 0 hit this on about one window
in three. They issue three times as many device reads.

Halve the alignment until the trim keeps at least half of the window.

Fixes: 18ebe55a9236 ("mm/readahead: terminate async readahead on natural boundary")
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
Tested on mm-new in a QEMU guest with XFS on an emulated NVMe,
read_ahead_kb 128 and a cold cache.

- max_sectors_kb 512, median of 5 runs: reading a 512 MiB file this
  way takes 0.247 s before and 0.180 s after. The device sees 3329 and
  1032 reads.

- Other reads with max_sectors_kb 512: without the 4 KiB read, and with
  64 KiB reads, the times do not change. Random 4 KiB and 64 KiB reads,
  two interleaved streams on one file, and 2 MiB reads at random
  offsets also take the same time. They read the same amount from the
  device, within 0.3%.

With the device's transfer limit at 2 MiB:

- max_sectors_kb 256: 512 KiB reads after the 4 KiB read take 0.626 s
  before and 0.322 s after. The device sees 6147 and 2056 reads.

- max_sectors_kb 1024 or 2048: 1 MiB reads are not trimmed.

- max_sectors_kb 2048, 3 MiB reads: the device sees 343 instead of 271
  reads. The time is 0.120 s instead of 0.118 s, the median of 40 runs.
  The interquartile range is about 0.10 to 0.13 s for both. The window
  stays at 3/4 of the maximum, off the 2 MiB boundary. mm-new reaches
  that boundary by trimming deeply.
---
 mm/readahead.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/readahead.c b/mm/readahead.c
index 6e55632902..f4da9b4606 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -713,6 +713,17 @@ void page_cache_async_ra(struct readahead_control *ractl,
 	align = 1UL << min(ra->order, ffs(max_pages) - 1);
 	end = ra->start + ra->size;
 	aligned_end = round_down(end, align);
+	/*
+	 * Keep at least half of the window when aligning its end. A
+	 * window that starts just below a large boundary would otherwise
+	 * shrink to a few pages and cap the folio order. Use a smaller
+	 * alignment instead.
+	 */
+	while (aligned_end > ra->start &&
+	       2 * (aligned_end - ra->start) < ra->size) {
+		align >>= 1;
+		aligned_end = round_down(end, align);
+	}
 	if (aligned_end > ra->start)
 		ra->size -= end - aligned_end;
 	ra->async_size = ra->size;

---
base-commit: 9c449f885765cf8d80b2c60b1971e774bba51a3f
change-id: 20261029-mm-readahead-async-align-e491b3dc16a6

Best regards,
-- 
Daejun Park <daejun7.park@samsung.com>


