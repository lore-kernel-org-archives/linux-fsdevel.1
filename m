Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794605198;
	b=is8pQdyy0AJG4ZdNVtGJ0F+K2igZ8tlASj7kTdf93kDW5L5WwEvOD7PGaEdp1d5LApw7
	 bxLM/PwDTs2LbrpLTW0/aDqAxGYE2vAQk7BPB1lyXvl4oaRvV2qigRqHTQvbFfdZeXTTt
	 1TrvOO8F0xOsfVrqGRZ4x6zIs+WmIPTV5Ycp9wEa/MoQ0YVqVrLrqPd1wOTyPxhtopvrl
	 GAPxe+lAUhP1p6Vom0zOdZH7QGMgi9gV04LpgQ/vziuR/ocRO3KI4xkZNRzzQ+ccGYF7g
	 SfZFYMIOHKBygZAXgx4p4UAASzbstmy/jxrfS2afC0Mhz4W0ibOkAMLEVYUSbYgUynQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605198;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RibFmcy43zDpCGtfntgboZ6WXlEHO0X8D9N0FndJ018=;
	b=xJVI8rGm50ouD0idG7DkM5+1MT97xSGF2/jnfHrppaUjfQyAw7BgaA9AVR7RxwgCmt1L
	 Prv7GWx45TT1bYps46reHlaxtx92W3C3CnIXPyy3F6JqqD/ZUJmZZKKM/soIH2le3rMfF
	 QN7nCwqVIBPe4puYyNAMcnkR9i9gaN9vMmqjp9MRGcin/Q6Lv0Bwa0XhYfDYSLgz9/8vZ
	 zp2cx5ghkopKx9xJHlGg7op6STU69QPDjot/2WqmyUyfZOu/Kvc2O/DCqeEvfpZ/f178S
	 7dxoUv2TCsOXMQO4qfXhmtDp473tuwDW3ifwVSnWGuduWh2i6SCK+W093Mivp+FohDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W4P1v5TT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4B0606A88A;
	Fri, 13 Nov 2026 21:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W4P1v5TT
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794605198;
	b=o8769zQxwdSCPFlJaeMXLxun2PYeLLc7SxPYKuZSC88BR4CelzQbK8le/fiAQQeQlUX8
	 pHb9LDu4Y1IW3YTKKavvGxBZK/a0ugsV9eDRK8be7qVIgMVDv5myu3bNrp0YD5ho3jIfA
	 v+Gx4Naq0IqSaYlg56MG1cTiwkJgnFJFngnzaeTyPMj+MLBwvW71mxVFJ/eSffKAkHS6A
	 lU9JERntwlzZ/r6uLSXI7hxX/coi3njmDqK6qh0E43CyY5yL4C2L/rsjNFWh6nbme/QUH
	 nvAK/8nu1hQm0n/6vXcwoT9hK3AtY59+dP4PQoOuRkLG55Nj9zWZe/pATftobJm9UoQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794605198;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RibFmcy43zDpCGtfntgboZ6WXlEHO0X8D9N0FndJ018=;
	b=dxVuMo6NVwjJr4rw6nukIQv1VzZO89R6Ovt7GVM2L/6xcPJgJNlHVjON8SBU859Ee1J6
	 UQCO8Y/O7mFBINDj1Z8bCY9A44Yqe+F9BMj41dkVaUDNGwcvgfamaVaiJyExDDHS5/guv
	 kMTAHQqzZQtfpwVzvtmFC1RtycUUQE8uS34gtILdlRz5jN3o0Ey+SnGIm2Rhv11VPAXvd
	 CzmOhDM5/qiV11K2mxxcF77D3we0fpPrJ5NCq5O5uGVtabtgxLCKS9tPBev/KBavqIzGt
	 AeuMzs/VGJn42N4D7HarIgsloV7+HB7C0uihwXuDtuLHxfnKy0VGXZ6qBBEdDGapNdw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8F4771F000C7;
	Fri, 13 Nov 2026 21:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794605198;
	bh=RibFmcy43zDpCGtfntgboZ6WXlEHO0X8D9N0FndJ018=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=W4P1v5TT3rxVYDEHZbq1V629SuhWgkBhc5wEaVdESThR+AiZKQOke/7HJF7dTPEo2
	 MSYLc3T+TaATjoPR16y01jEtIJwpY0qrHp+1/Xiq992/sUEZWktFVd2TGXLbAEag1Q
	 TwFuX1GzgzDJ/nMqFS0rGZa0OufHO1aBhxLvmOvF0Y/8M9y8T53fdmUque5l+1DpQ/
	 QzVKbGGZRrAayt8jj7VOlBB+H73LTzv/w4p+gNXC+TWTIwiFjr8e/LsNJDaxrvK/gy
	 90Bh45/EVkzwwD742ZXFCb84ayTUwJuPLiwKvpgbqKd4YAuM+mE0ujQ6xCMHqLi3gu
	 qut0SJ+HD6XJQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1AED949B1A;
	Fri, 13 Nov 2026 21:26:36 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Sat, 14 Nov 2026 05:26:19 +0800
Subject: [PATCH RFC 3/8] mm/huge_memory: avoid an unnecessary folio size
 reading
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
Message-Id: <20261114-swap-thp-split-v1-3-dfa8d4fa448d@tencent.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794605194; l=764;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=LmZMW4ryeSabpn9A1T3iIoGeWriFohkqBblDlYZuq1I=;
 b=4fw0LMeSbz2l92yW9mvBPwE3Bk04f4enplJroZxhcwS0OJz+aB1OBrVwS0CwbCV0PFM4kLkng
 8P7TF3DT9z1AcN67GtLPSjSXQGar6Bv6odbdrAeZEpSgq81WlJQyTNb
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
Content-Transfer-Encoding: 7bit

From: Kairui Song <kasong@tencent.com>

We already have that in the local variable, a trivial cleanup.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/huge_memory.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0d589be136d2..b60fd73fe35c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4287,9 +4287,7 @@ static int __folio_freeze_split_file(struct folio *folio,
 		/* compute next before the folio can be freed below */
 		next = folio_next(new_folio);
 
-		folio_ref_unfreeze(new_folio,
-				   folio_nr_pages(new_folio) + 1);
-
+		folio_ref_unfreeze(new_folio, nr_pages + 1);
 		lru_add_split_folio(folio, new_folio, lruvec, list);
 
 		/* Add the new folio to the page cache. */

-- 
2.56.1


