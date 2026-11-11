Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419757;
	b=5dIhEMjZJuNGvSF5vPJKdW4yqxkNB8eUFzYAwAfGJaYyuNNV9syYwEGGyBjB64jpBCU8
	 HzFSnwJdTIFg0mPLmrz6FvQCmXolCimH1NzfnlTLGfIDHeXc2EtrEepFMixBICYxTx6RS
	 wz6nsFty5ckAzH4eeF2SXjghewhJxXBCujUUK79ljPGbXeGOJ4lu0632MrGTL/UT4AcWt
	 vixvlgw+RCNtffKygAATXtLOoUskt0KpaNARJ/L4RMz0MLBxmSY+DniU8K8eKDxp0RuNM
	 Z/NJvo3jL6t8ksp4FP1qqmt0A/iheRFZkOXUypNYPCKsqAz/zjPa2rB7VThQ4/mqW9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419757;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=deCzxOFeDCQXgKxHB3hOal3UgkmEGxjDuW74KEugHoU=;
	b=fcmz4MrMm5u9ZbvrRqqQ+uJnALcNApVxKp6siOv3VS6QHwRmDTaoVoiSNn9mvBHzUGyt
	 Vl47twYhLn17/xbRQlz3fmNdAObRpL8qgbqoVtpNu+QpuA3zx2OXznY6JjEPL+Eec5Ybo
	 eMR4mnm7brz9cdlyluy1+2KO8ow92SdP0prJDIXSUS1BfV8zgEbbd2HZJ8cB6SeLA+kPa
	 UZzP4q/6hPgdu+YmHludG8CxN5yq099dawWsXnW6810qjVB6eKXKKozge1IhErngHSGIj
	 rvdIEGqGOVZvOPC4qu7JsXBKTgOxZk6lfsXGmecQrSKURr0Mn/D73Mw2XBCbYGvLagg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=nL1QA79v;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=VwnW3Qzq;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1743606A331
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 17:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1743606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=nL1QA79v;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=VwnW3Qzq
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABHYHmh3845101
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 12:55:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=deCz
	xOFeDCQXgKxHB3hOal3UgkmEGxjDuW74KEugHoU=; b=nL1QA79vIxrk1LgRXl1R
	ipAVXpxa26rNAPdRIHB2IMbb1SbgNxZNxC6+K43RVctvACGgXZ9c/sMH0lHNFgoA
	NUbS4vXonzDqYheWBIi2VsAKB02Siim+bORzdo4O0M5R8/5InB4F8/SSfIFg87+7
	eLLBRyWqs+PiYQPhiovxSeEg4g5MM5YSJ76W2DC9A9b8I5E0i3L3raNk4nu7TUSW
	QGje/p67Ob49L6nWEu5f88d+wHJyf+pEQqyK2S9TpDoyMMjUaPl06rVA/reQ5GOw
	1kLoNnQWh+PPE13TgFJt1BPQB9NvkEXaiUU6KSu/MmojvRAlqAZV/8IZXws0+NEk
	pA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hvg4qmexr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 12:55:55 -0500 (EST)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-53664602c7fso75585181cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 09:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794419755; x=1795024555; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=deCzxOFeDCQXgKxHB3hOal3UgkmEGxjDuW74KEugHoU=;
        b=VwnW3QzqqtwSwH0CmH2pD4ibQ3qfPS9UQ7bvFg7FVUVbvSiMwtxRqwY7/vl8R+qiY9
         cqYXVKoQ8MHaPt1BuQ8JRq2nkpXRRmsKkWwJiZvQX21j7n5oT2A5cL4mjv90T/f/0+PI
         9kUWb6BWAQfDnUksWPG+a5I5p5AMOi1pPCfOYSc1XnCN8iQo3WI0Ow9wQw2irZsutnJb
         DSwK9OaGQf+unrwumnmW3O5qT7Lanxf0rrr/8xYSPMGpqMot/4kd64LYE/3Z3w6fEnOY
         eFqU1UrrYLzCDaoAeG4SIQW9+M79Qv1bQnYGLL9p1T31oc5X4DwjbEM8ACtVakdyfSKB
         T3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794419755; x=1795024555;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=deCzxOFeDCQXgKxHB3hOal3UgkmEGxjDuW74KEugHoU=;
        b=FPj5RcAhyplAuzXs1OBkZnMH7QQEM2v/FrfAodQIl7OWJkKNbF3wU1Iz9RPBAXdHFi
         OVFCUsO2oMaoUZEovQRyY2wjgEuKFRLWujPgKjj0w+2g0mSosFs4fBd78nNtLGbxkJav
         m+2GaBF3RnS++ULSv7Jhgduu2DK9NKe3oH3PbG7kuDhmQs7pkFdjlMSudyYg6dUZ/5Ot
         LxjTCa7/DFSqnLgQsHfpxYs/G7L3kw//X/ViM0VrEI0dl9wgEBhyamS0uEgCbyqCkldw
         9u+hCbZDV8L2ym5SHd9wt8g8pD3Bl4nfyoq4I3/0r6b7fmweLvjdOGKAaJWWITik8VWA
         YWuQ==
X-Forwarded-Encrypted: i=1; AL+hErEH3iNPNAf6NeYAGPi0qC0hBGjZPKwaVAxKLmey3eo8FiSXf3jQAbFg/ejqZS9p2/s6YgqX9fqlEkV/RR4A@vger.kernel.org
X-Gm-Message-State: APuU4Z8yAWJDuzVt7l+QQQIVjmvnFt5MX7LDAzrkHcB3R/McjDdFWFey
	6NS6xrdEVsvdzRIM+eybwWg+BtHGc3ekyo2GcHe160m0eiotL8ZMKxnNkQrKpoQw4sOT/frrN2C
	L9W9PEC6FAayc85Apd4ObMzzbYhkPCDhcnDe8M9TWK2i9HhaFXeAlwCfx0Z+ikY8=
X-Gm-Gg: AYBFou3zk9lS0g6YZHiarmkfWM9mqpxqf/HNPkbb7l5hagRhkxwZjUUWYr8b+kQs5RM
	JEZBX9m9U3F7FB+Vb/1rAyGVt0VYcx+x2J1haD4UhOItaU9T6goSKpppX0eyH0/hdvcvBN/btrG
	jTT9Yrh7vGIRCIrlCa/g1wZ2XURP7AKuqjxGtVek+0F9hfwLMltcdiK7AdJB1vxIjGKHU/vt1qE
	ABXiWMuZff26XivgbAjsX77azw/QMWX/IhAcZBBhGs3fjWlv0qz0k94I4kLfRKisF+4PdyDirhV
	sDp9ejSlAuOEOayl8f9A5q603bXk+zAQrvYUq/gxJCfXbHdsl7IByXoyuh+uykrwa97AJBrGKGh
	MVcT80jBf7EpeKwKIxmj54nAwZy7a17y7BGRSiNE45RQuoWkB4HEFQHjii68qcJTmlnpzfRZQGv
	4Hk8gHJ+5hOJJzmllEcA==
X-Received: by 2002:a05:622a:4c6:b0:551:ad99:3df0 with SMTP id d75a77b69052e-556c1a5e3f7mr48808301cf.71.1794419754934;
        Wed, 11 Nov 2026 09:55:54 -0800 (PST)
X-Received: by 2002:a05:622a:4c6:b0:551:ad99:3df0 with SMTP id d75a77b69052e-556c1a5e3f7mr48807671cf.71.1794419754264;
        Wed, 11 Nov 2026 09:55:54 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550b93ee00sm54974231cf.16.2026.11.11.09.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 09:55:53 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 11 Nov 2026 12:55:09 -0500
Subject: [PATCH 01/12] userfaultfd: use anonymous memory for
 UFFDIO_ZEROPAGE on private file mappings
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
Message-Id: <20261111-uffd-state-fixes-v1-1-00713d368976@columbia.edu>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
In-Reply-To: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
To: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
        Peter Xu <peterx@redhat.com>, James Houghton <jthoughton@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Balbir Singh <balbirs@nvidia.com>,
        "Liam R. Howlett" <liam@infradead.org>,
        Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Andrei Vagin <avagin@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
        Muhammad Usama Anjum <usama.anjum@arm.com>,
        David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
        Kiryl Shutsemau <kas@kernel.org>, Chris Down <chris@chrisdown.name>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        =?utf-8?q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
        Michal Hocko <mhocko@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794419750; l=5307;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=ZGzqhLx0gH//2ZFXY5DcwHUNOIJoLDbuuIlcIz+dT4o=;
 b=eBI5XdW7u+jazsrmWEO2BTjYrlgooAZbQFoFI5BxfJc84/TDMCva259mt44pi4Q3MmInVwbC8
 Gp0p0OSeiIXAPfpI5jclFrZpIzdZfkcquSiZQb7hr/WMWAWNQXKUChK
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3MSBTYWx0ZWRfXyzD+DfKeko0j
 QsJAE7+W83L/N0zFJQQrB97DhHya1BcHRxB/jZdw0b37DyDy9rE4qpRl9yHuGa2+RAVZRgIeSE8
 qytXFPjfG55+jiKvbHQb+T/u+fa2OyolIddu7USCPK7PPJ2RYmCsvKFzx7kmpJDETKuCwqLG+kw
 34OiMbuN//KjOMKfv0d/KdaReBV2QVVBLbMGt5HpEaij2ULS5VurPZnM8CXemNT9RIk2coVHpEA
 k3j6II8iy0EUxu7rICRqlw55A0CGXOZ+4PHNfvjng4Nav/tboGXexQ4jOdzIrLv+nxpEd5Tc90p
 nfrcEMqBP7cLowE2IX42YAQJ9c3fbVJ+UZx/oHwrgphpqrQSlvGGddg2inRUZHCHqwD/EQ1wsBB
 ZCITrhvR5S4nhNctGMmKCVn/aQvl3yVlcpFaDIgfodg/CPiTuj/UY6thxmZlySJNb0xWxTxZLZE
 G2D3+kPVUuvqWJGL1sA==
X-Authority-Analysis: v=2.4 cv=fodJ914f c=1 sm=1 tr=0 ts=6af4ac2c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=VwQbUJbxAAAA:8 a=a5NvJi0EDLanwwYVvGMA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3MSBTYWx0ZWRfXyAXaJR5hh9HM
 +KEOtzPQTX3C7uXTb25nEGRZlMdUJTS6NzeWlUJXlymp14wf58JDB64tHelUr+Kq9YAeirgs5HL
 ZVJsb1SLzO+nxjA2+lBCDqva0sfplppMvN7C6JE4C9fQFQHYHsmM
X-Proofpoint-GUID: d8_K2h-4Itot_ViCEYeBVeWljP6XGenI
X-Proofpoint-ORIG-GUID: d8_K2h-4Itot_ViCEYeBVeWljP6XGenI
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11963
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=10 clxscore=1015 priorityscore=1501
 lowpriorityscore=10 malwarescore=0 spamscore=0 bulkscore=10 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110071

If the mm cannot map the shared zero page, UFFDIO_ZEROPAGE falls back to
mfill_atomic_pte_zeroed_folio(), which allocates a zeroed folio and
installs it through vma_uffd_ops(), no matter what kind of mapping it
is. An s390 KVM guest with storage keys or protected virtualization is
such an mm.

For a MAP_PRIVATE shmem mapping, that adds the zeroed folio to the page
cache of the file. That is wrong: a private mapping must never modify
the file it maps, and the file might even be mapped from a read-only fd.

The ioctl can also fail where it should succeed. A missing fault is only
delivered for a hole in the file, but UFFDIO_ZEROPAGE can be called on
an address that did not fault, or can race with a write to the file. If
the file has a page at that offset by then, inserting the zeroed folio
fails and the ioctl returns -EEXIST although nothing is mapped at the
destination address.

What we want is what UFFDIO_ZEROPAGE does on a private mapping when the
shared zero page can be used, and what UFFDIO_COPY does: only check that
nothing is mapped at the destination address, map zeroed memory there,
and leave the page cache alone. The zeroed folio path did that before it
was moved to vm_uffd_ops.

To fix it, pick the ops in the common folio path, as
mfill_atomic_pte_copy() did for UFFDIO_COPY: anon_uffd_ops for a private
mapping, the ops of the VMA otherwise. That makes
mfill_atomic_pte_copy() and mfill_atomic_pte_zeroed_folio() redundant,
so remove them and rename __mfill_atomic_pte() to
mfill_atomic_pte_folio().

UFFDIO_ZEROPAGE no longer modifies the file, and only fails with -EEXIST
if something is already mapped at the destination address.

Fixes: f74991b4e383 ("shmem, userfaultfd: implement shmem uffd operations using vm_uffd_ops")
Cc: stable@vger.kernel.org
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 mm/userfaultfd.c | 46 ++++++++++++++++------------------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index d65184d9a480..61a712e1f9f5 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -531,15 +531,27 @@ static int mfill_copy_folio_retry(struct mfill_state *mfill_state,
 	return 0;
 }
 
-static int __mfill_atomic_pte(struct mfill_state *state,
-			      const struct vm_uffd_ops *ops)
+static int mfill_atomic_pte_folio(struct mfill_state *state)
 {
+	const struct vm_uffd_ops *ops = vma_uffd_ops(state->vma);
 	unsigned long dst_addr = state->dst_addr;
 	unsigned long src_addr = state->src_addr;
 	uffd_flags_t flags = state->flags;
 	struct folio *folio;
 	int ret;
 
+	/*
+	 * The normal page fault path for a MAP_PRIVATE mapping in a
+	 * file-backed VMA will invoke the fault, fill the hole in the file and
+	 * COW it right away. The result generates plain anonymous memory.
+	 * So when we are asked to fill a hole in a MAP_PRIVATE mapping, we'll
+	 * generate anonymous memory directly without actually filling the
+	 * hole. For the MAP_PRIVATE case the robustness check only happens in
+	 * the pagetable (to verify it's still none) and not in the page cache.
+	 */
+	if (!(state->vma->vm_flags & VM_SHARED))
+		ops = &anon_uffd_ops;
+
 	if (!ops) {
 		VM_WARN_ONCE(1, "UFFDIO_COPY for unsupported VMA");
 		return -EOPNOTSUPP;
@@ -597,32 +609,6 @@ static int __mfill_atomic_pte(struct mfill_state *state,
 	return ret;
 }
 
-static int mfill_atomic_pte_copy(struct mfill_state *state)
-{
-	const struct vm_uffd_ops *ops = vma_uffd_ops(state->vma);
-
-	/*
-	 * The normal page fault path for a MAP_PRIVATE mapping in a
-	 * file-backed VMA will invoke the fault, fill the hole in the file and
-	 * COW it right away. The result generates plain anonymous memory.
-	 * So when we are asked to fill a hole in a MAP_PRIVATE mapping, we'll
-	 * generate anonymous memory directly without actually filling the
-	 * hole. For the MAP_PRIVATE case the robustness check only happens in
-	 * the pagetable (to verify it's still none) and not in the page cache.
-	 */
-	if (!(state->vma->vm_flags & VM_SHARED))
-		ops = &anon_uffd_ops;
-
-	return __mfill_atomic_pte(state, ops);
-}
-
-static int mfill_atomic_pte_zeroed_folio(struct mfill_state *state)
-{
-	const struct vm_uffd_ops *ops = vma_uffd_ops(state->vma);
-
-	return __mfill_atomic_pte(state, ops);
-}
-
 static int mfill_atomic_pte_zeropage(struct mfill_state *state)
 {
 	struct vm_area_struct *dst_vma = state->vma;
@@ -634,7 +620,7 @@ static int mfill_atomic_pte_zeropage(struct mfill_state *state)
 
 	if (mm_forbids_zeropage(dst_vma->vm_mm) ||
 	    (dst_vma->vm_flags & VM_SHARED))
-		return mfill_atomic_pte_zeroed_folio(state);
+		return mfill_atomic_pte_folio(state);
 
 	_dst_pte = pte_mkspecial(pfn_pte(zero_pfn(dst_addr),
 					 dst_vma->vm_page_prot));
@@ -927,7 +913,7 @@ static __always_inline ssize_t mfill_atomic_pte(struct mfill_state *state)
 	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_POISON))
 		return mfill_atomic_pte_poison(state);
 	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_COPY))
-		return mfill_atomic_pte_copy(state);
+		return mfill_atomic_pte_folio(state);
 	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE))
 		return mfill_atomic_pte_zeropage(state);
 

-- 
2.39.5

