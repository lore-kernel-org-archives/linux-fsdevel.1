Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859476;
	b=0TO7E2m/9h0vG/ACaSbaco9bG0YFiMa5BpCwnClGJAqlkyx3kK5bE9L6LQtAHoYl/FWv
	 pFOZGqrCGhx+/iyLILdZVDRcsdH4gFWZqp5BWjtDJes8SjLOpVYXve95Tgz7s3QvIDUsu
	 arlFW+LhoUlu7a7eq15p6XmWq/DRT3G40p7GYEc8+FZn5TaloeIkXS2b05jJcUhpq5LUr
	 8W0Hgajxll6BcsfX7DSs7itx9Igz7JOZ5d0IzQLqqY1cMuHX8VckrzwIB9RVuZMj57FpJ
	 fMMyMsAVodHSr0rVau12HLbhKCrqtU22jcreQ9Jrfye3TurepjY4v2YunODf/i1Uo+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859476;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=T0fzsGxlT4q3HpaE4QZIOM3hFczkgekbU9Rdi2JFm50=;
	b=vksieNHF2pyWZe2hXtLYwbelxOiFlbPEaxV6gcmWkLOadEGVJFFWZ9VjrbnnfrMzYgcO
	 WY5TywkfaiEMllg5ryivHMG1qK8moKL9a6TJwlisuGjHk/Y0ucYRNmlG84ykXU4tms+td
	 icoZi0YOVs0C+aG3vmrhuiGOyIah2UrvHLg6DflaWwWuKFP9NTFXhjwinZnLy3A853ihu
	 KdV6Fq7Jms+mRo3NTtBsYvnHniinh5eJ+iSCgKD8wu2vP57Hw/R6T2iLZJIbpE8i3flyo
	 jVZfJF9wo+jiIlxHXnTy2pW4z9Jv5TEwqHegcMZs7YZnHIFwpJhFBr0y01stHWhaiLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b="jhx/gmZZ";
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=X2fZoklh;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA8360A5BD2
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 20:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BA8360A5BD2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=jhx/gmZZ;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=X2fZoklh
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGJXHfJ3801926
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 15:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=T0fz
	sGxlT4q3HpaE4QZIOM3hFczkgekbU9Rdi2JFm50=; b=jhx/gmZZMis2eLHme4pP
	oqNJ4vm94e7n5ru5EAk2U+UL8DsyQzJvWf+ChC8XN6mrCqqY67boqdXPXprBS7Qk
	trstAW/Z252gtEEvOL07aPupShrfGXAiOkseYxYbuuRsEcJV4NimkqrjEgjwGBAZ
	J5glBWtHlaCxVx0nUsxEpWExuqt1xX338Yhh1oydK7F0ujH2NprZdJd2Pr4Ouldp
	ZmYh8Z9jm+TsCrUVOMKcC87xdyCKAw22lwOdh036fxohi54CCT7j/HIxEBqPV1iY
	lQB8j+Le5P3ZyRX8+FaGDHPN9Xulwe2hJRa5sOEljXPywLzBOcwNfZ/Vkts5QESB
	4Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j0598t3fs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 15:04:35 -0500 (EST)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91f2b449480so67892696d6.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 12:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794859474; x=1795464274; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T0fzsGxlT4q3HpaE4QZIOM3hFczkgekbU9Rdi2JFm50=;
        b=X2fZoklh72tiA70IKt2TKCKFnyhRc8FNRAK7RnNO5BSvZwG6HyPdkyjss+MYTTAWCv
         W5XL+wcixE8oU0i9mOucgRnlrfGelPS1GIpwih2kn/u2Rwc5NiOke2q2YUCZH225Ps6A
         j3UR72OK/xTeYTbs3HcyCnWtvtvH/IztjS+6MejGTZ9IP08BYR02U+cGw8jDcNHKVbNi
         58n852+n9q1OAXKz0SS4kJyMZ8PNHrKYo0MBwPkT/A2MkyOK+GmgiVh1+gMlcIkUu8iQ
         Rd3zkPCdMHm9Ol/5xRIPungLOGb6LefxdO1LK8q4HLuMd32c5419qjgT4w5wMqvfsF0/
         khmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859474; x=1795464274;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T0fzsGxlT4q3HpaE4QZIOM3hFczkgekbU9Rdi2JFm50=;
        b=nqnydsGZR8E6BP174B8sIwQLNuudoXZwME5Ew2lWrPsmsUrXNiMkqTs2CR0OgIFrVd
         CjB4Amlh45cISXe3MNhuXSKHzyvqVU8/4lo7J7BJUzieW0+fekWnz5Enx/OZhSZPZrTe
         H+OUplrNI/i0eOUaCOlBMJ3yG6IGELDc1AU9cBUna5R1dDXV0WRj85TDAKK0655RWEh3
         I1rmroxX/AXtx56nApVv2Rlv2hqbPuFZ6iEhbWDeWZLb2ERtZpRMBT9bHrYBVuRXtnKL
         VioJW1GXMh6l2XbjgIWqBYEwBto26rOUxOuGp2o7D+3N8RTBuflzW+irptQTbWuyDO8N
         tyEQ==
X-Forwarded-Encrypted: i=1; AL+hErHqiz9SmIYnO8jKlZEHScSKbbXu3R2P8hFkTqpUdpNjJ+RhKqtVegi9wuhF0amlzIjJnOjguw7qgeiLKqUu@vger.kernel.org
X-Gm-Message-State: APuU4Z9aJzsLDUuSFpDggxnXAmfSQ7IRLwD+QHWfosDS/FIfhOh5hWA7
	nxKAv8/t8oOTm0X1QnnGDhoNBrBh5r9Aut6CmbByHZCwftivdFraq1jJVWoKcC9GkcbjA6RR3cX
	HndBhxQVuWUMeN/rt9p1IH26+uB0E6e9MI32IzYd4VJWYVv0sXdmy8mRTxCjYyK8=
X-Gm-Gg: AYBFou3SDnjOs8bxq6nTaPm+eBOjD+PHxOc6g0KrwQ3pEt8IoL+pxJTfBEliIdOIT4Z
	KkC7W0rY/qOCuSFGcUIXjN7An7AgZ55FEd5jqAYGokhNofxpr0UE0YqOqpI4ekM7MTinsdpi4N8
	y6zQGBFnCLwLAXmXoFTS6aWvSN2a2pWjViPKPjZZ9VMpqQLyGa3U/dDAZVbM0rlT7YKICqjW7vB
	OGiWfsmJX9T1HjeXKCZGWDA9J0E3QxbfxX4MM0Cdu0wf2w82GWrzQ3nxkwi4Q7SseuH9/lkIKRl
	B8fl+0LS8RVKQB414WkmYNumYbZhvAbv9srWlioxDGQR7Xtg+tVZMVrEPrbaayDC6FxWpXQDaIp
	RUTT4QExaZWRhrRyReiWmkYsO+js4nrZKXK4FT0+tERilr1dmU+SQ/lblU9FcwLfGWGHv/2P4iY
	EHnO7HEtLpo0tiF0e/eVDA
X-Received: by 2002:a05:622a:4d46:b0:533:3fc2:8b19 with SMTP id d75a77b69052e-55ac7266e55mr188486431cf.20.1794859474272;
        Mon, 16 Nov 2026 12:04:34 -0800 (PST)
X-Received: by 2002:a05:622a:4d46:b0:533:3fc2:8b19 with SMTP id d75a77b69052e-55ac7266e55mr188485541cf.20.1794859473592;
        Mon, 16 Nov 2026 12:04:33 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23efa2edsm93065426d6.15.2026.11.16.12.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:04:33 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 16 Nov 2026 15:02:49 -0500
Subject: [PATCH v2 7/9] mm/mremap: resolve uffd state when the context is
 dropped, not during the move
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
Message-Id: <20261116-uffd-state-fixes-v2-7-4397a0196479@columbia.edu>
References: <20261116-uffd-state-fixes-v2-0-4397a0196479@columbia.edu>
In-Reply-To: <20261116-uffd-state-fixes-v2-0-4397a0196479@columbia.edu>
To: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
        Peter Xu <peterx@redhat.com>, James Houghton <jthoughton@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Balbir Singh <balbirs@nvidia.com>,
        "Liam R. Howlett" <liam@infradead.org>,
        Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@suse.com>,
        =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Andrei Vagin <avagin@gmail.com>,
        Muhammad Usama Anjum <usama.anjum@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
        Kiryl Shutsemau <kas@kernel.org>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        =?utf-8?q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794859460; l=8555;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=Pw3aT4XYGUKtZXK9Y9SabvgsNMzWI/bDdIAFeBvZ9bc=;
 b=1KBkbR/5ZTJejegNiXTYgbIoFhfrtUnq5/BvJ66hqlnGtUxOw+hPSr50QgyONd5bfxVibjP02
 IQTIOjB0hFpBb3AzSDPIl0aMcz/F/Drsn7kdqmyBGNB3Wn3ql25BuCM
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: zV3w_6LkoPBaWJ04tE7837gh5zp86ThW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4MCBTYWx0ZWRfX8jYdIzLA/Kdv
 QqGA9qqxKGJeYS5f/HSoH7C5PLOtT9D9NBe/oWGjfc8L9i5khWPd0xOX1IILBJO5yuAbLWVZ5hF
 7o9+IMNWuQnEejsefO8QhKHLHn1AFM4vrD9qq9H3azA63PQqhZkr
X-Proofpoint-GUID: zV3w_6LkoPBaWJ04tE7837gh5zp86ThW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4MCBTYWx0ZWRfX5A5CdYHIH0/m
 oqm/S4T9mrjOyoJFtbK2EBrqz7jD4ywasJy9myyavKdult41xLbu1pSKjS29IvOC9Cs72YXgifN
 KZq2g8dtjWpNeLx0bMa3uGI6AFaznyCtyAnUPlewBtOPSzUFblqTiZRdISnOjOj/Qoga/7t+x/5
 O427l2pUqEQt5JkiW5WbIuQi7fL2yE7TaR77Vl1qFGyhoyLY9Cm0FEKaOkZ5b90Xmck8LOTTjgH
 0z966gi0pvXFtt2x4YnC7hZgd0p6Tu/jTzIwBxw+JMW4JMV/3eHbRW/46d7pSQA8LTviALEVjlD
 W6RvbxMNltlTr50EGeqLs8g8DGVRwCYwGzMAa3uNlzNG9lNS6EGqYKTMrFoHlE5hg+L7bHMc/Kk
 TPqTVAt+QZpIUUPc4n8v2AkSB6SbW62bkNLAxvvrT20JLeJGaN6jyO4K0sLwYMvJWabv0o5HTte
 PC+FanN0XcnDHzvwrgA==
X-Authority-Analysis: v=2.4 cv=ZOpCCn7b c=1 sm=1 tr=0 ts=6afb61d3 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=VwQbUJbxAAAA:8 a=tHa68p0SAAAA:8 a=FFitksWucw0zMzmll4cA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=ufIsyHvWW7FwcMbVRpPq:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=10 bulkscore=10 impostorscore=10 spamscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160080

Without UFFD_FEATURE_EVENT_REMAP, the new VMA of an mremap() is not
registered with userfaultfd, so the uffd state of its entries is cleared
while they are moved. If the move fails halfway, the entries are moved
back into the old VMA, which is still registered, without their uffd
state. Writes and accesses to them are then no longer reported.

To fix it, leave the entries alone during the move and clear the uffd
state of the new VMA in mremap_userfaultfd_prep(), right before dropping
the context, like unregistering does. This walks the page tables of the
new VMA a second time.

This is done with userfaultfd_clear_ptes(), which also makes the PTEs
writable again where that is safe. That removes a spurious write fault
per protected page on private anonymous memory, but adds spurious write
faults on shmem and hugetlb, as change_protection() makes writable pages
that were never protected read-only. UFFDIO_UNREGISTER and
UFFDIO_WRITEPROTECT already behave this way. This will be fixed in
change_protection() separately.

The entries no longer need per-entry handling during the move, so drop
uffd_supports_page_table_move() and clear_uffd_wp_pmd(). Whole page
tables of these VMAs can be moved again.

Fixes: 0cef0bb836e3 ("mm: clear uffd-wp PTE/PMD state on mremap()")
Fixes: 763f43865fc4 ("mm: preserve RWP marker across PTE rewrites")
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 mm/huge_memory.c | 25 -------------------------
 mm/hugetlb.c     | 27 +--------------------------
 mm/mremap.c      | 46 +---------------------------------------------
 mm/userfaultfd.c |  1 +
 4 files changed, 3 insertions(+), 96 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a2b1ac11e7dd..e994ca58cc70 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2638,18 +2638,6 @@ static pmd_t move_soft_dirty_pmd(pmd_t pmd)
 	return pmd;
 }
 
-static pmd_t clear_uffd_wp_pmd(pmd_t pmd)
-{
-	if (pmd_none(pmd))
-		return pmd;
-	if (pmd_present(pmd))
-		pmd = pmd_clear_uffd(pmd);
-	else
-		pmd = pmd_swp_clear_uffd(pmd);
-
-	return pmd;
-}
-
 bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 		  unsigned long new_addr, pmd_t *old_pmd, pmd_t *new_pmd)
 {
@@ -2685,19 +2673,6 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 			pgtable_trans_huge_deposit(mm, new_pmd, pgtable);
 		}
 		pmd = move_soft_dirty_pmd(pmd);
-		if (vma_has_uffd_without_event_remap(vma)) {
-			/*
-			 * See __copy_present_ptes(): normalise the RWP marker
-			 * so the destination starts accessible instead of
-			 * taking a numa-hinting fault on first access. Only the
-			 * marker (protnone + uffd) needs it; leave other present
-			 * PMDs in the VMA untouched.
-			 */
-			if (pmd_present(pmd) && userfaultfd_rwp(vma) &&
-			    pmd_uffd(pmd))
-				pmd = pmd_modify(pmd, vma->vm_page_prot);
-			pmd = clear_uffd_wp_pmd(pmd);
-		}
 		set_pmd_at(mm, new_addr, new_pmd, pmd);
 		if (force_flush)
 			flush_pmd_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 88c9aa700533..b491742702f3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5195,7 +5195,6 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
 			  unsigned long new_addr, pte_t *src_pte, pte_t *dst_pte,
 			  unsigned long sz)
 {
-	bool need_clear_uffd_wp = vma_has_uffd_without_event_remap(vma);
 	struct hstate *h = hstate_vma(vma);
 	struct mm_struct *mm = vma->vm_mm;
 	spinlock_t *src_ptl, *dst_ptl;
@@ -5206,31 +5205,7 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
 	double_pt_lock(dst_ptl, src_ptl);
 
 	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte, sz);
-
-	if (need_clear_uffd_wp && pte_is_uffd_wp_marker(pte)) {
-		huge_pte_clear(mm, new_addr, dst_pte, sz);
-	} else {
-		if (need_clear_uffd_wp) {
-			if (pte_present(pte)) {
-				/*
-				 * See __copy_present_ptes(): normalise the RWP
-				 * marker so the destination starts accessible
-				 * instead of taking a numa-hinting fault on
-				 * first access. Only the marker (protnone + uffd)
-				 * needs it; leave other present PTEs untouched.
-				 */
-				if (userfaultfd_rwp(vma) && huge_pte_uffd(pte)) {
-					pte = huge_pte_modify(pte, vma->vm_page_prot);
-					pte = arch_make_huge_pte(pte, huge_page_shift(h),
-								 vma->vm_flags);
-				}
-				pte = huge_pte_clear_uffd(pte);
-			} else {
-				pte = pte_swp_clear_uffd(pte);
-			}
-		}
-		set_huge_pte_at(mm, new_addr, dst_pte, pte, sz);
-	}
+	set_huge_pte_at(mm, new_addr, dst_pte, pte, sz);
 
 	double_pt_unlock(dst_ptl, src_ptl);
 }
diff --git a/mm/mremap.c b/mm/mremap.c
index fff0465f5e06..4564416a6994 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -198,7 +198,6 @@ static int move_ptes(struct pagetable_move_control *pmc,
 		unsigned long extent, pmd_t *old_pmd, pmd_t *new_pmd)
 {
 	struct vm_area_struct *vma = pmc->old;
-	bool need_clear_uffd_wp = vma_has_uffd_without_event_remap(vma);
 	struct mm_struct *mm = vma->vm_mm;
 	pte_t *old_ptep, *new_ptep;
 	pte_t old_pte, pte;
@@ -290,27 +289,7 @@ static int move_ptes(struct pagetable_move_control *pmc,
 		pte = get_and_clear_ptes(mm, old_addr, old_ptep, nr_ptes);
 		pte = move_pte(pte, old_addr, new_addr);
 		pte = move_soft_dirty_pte(pte);
-
-		if (need_clear_uffd_wp && pte_is_uffd_wp_marker(pte))
-			pte_clear(mm, new_addr, new_ptep);
-		else {
-			if (need_clear_uffd_wp) {
-				if (pte_present(pte)) {
-					/*
-					 * See __copy_present_ptes(): normalise
-					 * RWP PTEs so the destination starts
-					 * accessible instead of taking a
-					 * numa-hinting fault on first access.
-					 */
-					if (userfaultfd_rwp(vma) && pte_uffd(pte))
-						pte = pte_modify(pte, vma->vm_page_prot);
-					pte = pte_clear_uffd(pte);
-				} else {
-					pte = pte_swp_clear_uffd(pte);
-				}
-			}
-			set_ptes(mm, new_addr, new_ptep, pte, nr_ptes);
-		}
+		set_ptes(mm, new_addr, new_ptep, pte, nr_ptes);
 	}
 
 	lazy_mmu_mode_disable();
@@ -334,25 +313,6 @@ static inline bool arch_supports_page_table_move(void)
 }
 #endif
 
-static inline bool uffd_supports_page_table_move(struct pagetable_move_control *pmc)
-{
-	/*
-	 * If we are moving a VMA that has uffd-wp registered but with
-	 * remap events disabled (new VMA will not be registered with uffd), we
-	 * need to ensure that the uffd-wp state is cleared from all pgtables.
-	 * This means recursing into lower page tables in move_page_tables().
-	 *
-	 * We might get called with VMAs reversed when recovering from a
-	 * failed page table move. In that case, the
-	 * "old"-but-actually-"originally new" VMA during recovery will not have
-	 * a uffd context. Recursing into lower page tables during the original
-	 * move but not during the recovery move will cause trouble, because we
-	 * run into already-existing page tables. So check both VMAs.
-	 */
-	return !vma_has_uffd_without_event_remap(pmc->old) &&
-	       !vma_has_uffd_without_event_remap(pmc->new);
-}
-
 #ifdef CONFIG_HAVE_MOVE_PMD
 static bool move_normal_pmd(struct pagetable_move_control *pmc,
 			pmd_t *old_pmd, pmd_t *new_pmd)
@@ -365,8 +325,6 @@ static bool move_normal_pmd(struct pagetable_move_control *pmc,
 
 	if (!arch_supports_page_table_move())
 		return false;
-	if (!uffd_supports_page_table_move(pmc))
-		return false;
 	/*
 	 * The destination pmd shouldn't be established, free_pgtables()
 	 * should have released it.
@@ -434,8 +392,6 @@ static bool move_normal_pud(struct pagetable_move_control *pmc,
 
 	if (!arch_supports_page_table_move())
 		return false;
-	if (!uffd_supports_page_table_move(pmc))
-		return false;
 	/*
 	 * The destination pud shouldn't be established, free_pgtables()
 	 * should have released it.
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index ad9d243dc64b..bf42fabb5afd 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -3161,6 +3161,7 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
 		up_write(&ctx->map_changing_lock);
 	} else {
 		/* Drop uffd context if remap feature not enabled */
+		userfaultfd_clear_ptes(vma, vma->vm_start, vma->vm_end);
 		userfaultfd_reset_ctx(vma);
 	}
 }

-- 
2.39.5

