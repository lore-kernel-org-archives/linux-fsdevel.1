Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419770;
	b=Vn8hgBrFE8WvOCOeHydmiHMbhR4I/VrItN65TXzN1ERgWRXXht/TYkIyL6pqVyNHE21k
	 5q4mdkD8icmSF6Ko0E3Q9SWMqMqmxIvqqrfVujq3Nj97Fl0kyzsrM3TYJUbWo0fyp2Lb6
	 OJoDQz73usDUniCrXbwA2QBU3leq31edQoXUIK1C/4K7+KNHf8d+9ibHtLAj3rWYP0Ek8
	 S/lFpM/A1rZxB6tuEhG8x6fgeHuhcgkUeS32VHBlAYvHX/SVYe5oxUjNxUTmQGWoz8cgU
	 zvUq5CRXQffq+jpmncPoItgx7Q/szIrRL2onietGLEz3bhNXwgwdltwjgWUOIehTpBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419770;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=BBlMDdhjzTQo0mVweCvphKP4StdkmuGlmZUd2y9c2JY=;
	b=gH5VLX4QrCezFgVT1Vnjci0mh89DR+5EFXTICvKxWNeEgb+uxTSTPJhInEB69n2N1aIG
	 ociMvFuEI2nGotZnRGxhzVO7Btyf+K+bGbeGW+CRV5KLmnnOPIv53sfwrcru9KoGnWEf5
	 +WZSqC1E67BjbEHul9aXU+4i6z3Bjl9AcPrBfT/P2yZTMY/BP9h/TDvhZrNJPt2hgqlxP
	 /nitYKiFpMVz53v3CNcxXTEZV3h0dHYO5GmluPBOLZcmSP1WB7jY3/YgoASKzllj+S7oh
	 pbKWul/Ut5VsxoCvrlkU23TM3pAVHZy6e7dhDi3obd3Guy5GJyecXNpl89XEUFm7OtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=Hh7sd9pL;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b="Xqdzm/mk";
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300E160A5BE6
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 17:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 300E160A5BE6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=Hh7sd9pL;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=Xqdzm/mk
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABHYBNx737093
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 12:56:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=BBlM
	DdhjzTQo0mVweCvphKP4StdkmuGlmZUd2y9c2JY=; b=Hh7sd9pLX35u6rtxYlZD
	dOxs6AXrfDKYFU3/qNuaqZzFICWetMLouHi567NphQxkL0icIcLmzP+l8kVtqnLK
	EJ4h3S3xmxzrH1Ed/xY0Kg/wU3P1QXtWAT8zKvcfGt9iqsO+k5ygY8cqTipWQB70
	EbuBHeXykU2+jWv9NhaFE50/yEg6CvkI9A5kq4jZvS9UIT9G7SpHZao4BLi48sK2
	WoLN+xd78SbCFK5hFQ5sjUhorjsqLHHO3XV0ljVCpJLlr9nivITzDw9Ar6WUVaES
	U4+lkxX9MBi+E46Y+xpNva3RXBJLwbkkQGH46akYRZe5D4KMgpE610DCQedVFH1m
	Gw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hvdjkd4mr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 12:56:08 -0500 (EST)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-542fc619afaso44785951cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 09:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794419768; x=1795024568; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BBlMDdhjzTQo0mVweCvphKP4StdkmuGlmZUd2y9c2JY=;
        b=Xqdzm/mkbvJuyD2peNgtHEnY3yBXQRevuL8CgdBbAquA3dj83PGt7f2DVO+QTnDbH2
         PGZZ89/juRCMvhN1KBHF8Y/Nc9rO3tj+Pl+rSptymX9o5cljftsVZ0/OXD8wxyh/j1MF
         xh5YtevoYeqfBcmb/NXDIZxcej55g6pqYSUOwYWf++sB4S9MbMwOEs+ZSIwLLU7oBEej
         tYBZEaii+R/1sw8NF7fOSM4XSIdQFHraXdPhwoxDgNxl3qrne1pFvQinZLC2VxvKXgA/
         Q0SWKnZTdjcPF0wHfsAXKNiQBj4h2GxovmuCGr50QjArldhGSdsNqV+KWZa5iCKLTzmP
         s7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794419768; x=1795024568;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BBlMDdhjzTQo0mVweCvphKP4StdkmuGlmZUd2y9c2JY=;
        b=haqaZ6rfePY7JT6KQmKJvoPG5mw6dfScmAaDLYUKVp8OgBWLtbq4PXMO0s1dijN3eT
         iyRyYEXIWI//gr+I4YLxVQnmRfmwINUs6YOYTlVZdSIluZFcbSGbVaOvWUjAObSozbK7
         hnsk4Xhu94ujZu30kW6Y5fHZHFc+IPbb4jaELI4gPN6YMF7OUbT2BsnSomu0P82MoH/N
         4FAsYv5HW8t4sh9w8qZUsKhVM9DjWJKuXwrEIz45gGX+AfbhJhLl1No9jSfjdAxd4O9r
         hu1T3sfbaBcOW12/RVdrjAerU7Xrn/LXQyzNWQw1JX/bsD3/KbkiCzTj/gxbhJEMCPZI
         nf+Q==
X-Forwarded-Encrypted: i=1; AL+hErEPh7HwKdzIbZxSKeyoAJ9yt9uAgTJkvblsJ8Q4ga/ZocypJD9RnA5+Rp0a+ujPKe7Ce/XO6qYV1Lgl5Xvg@vger.kernel.org
X-Gm-Message-State: APuU4Z+WK/xruPMhtLrdA7b8dVpkdR9AcrlvxVxWce2tJGoxHsnHJOf4
	OU86NLnB4uTnYSGj4shbpUC5DNw1h1TwYPWr0wzn5dvSY7lJHouSLn1oANx8jnTSavFZsnsZNbb
	awFWd9Iv9IdYQaM81EhUqRXoc2PU+ss3AVr/7pDc92tNPMXbilWfN0CPjXx7Zih0=
X-Gm-Gg: AYBFou3CeVjn9vL1PjgxAUCwnPqwnkXUZmyFyvvm8uctiVvKnN4PUVPqdPoRXbC3O5t
	BZeQAg+vHDta1HqtAC19UXqzEY6fhwT9x9wmRIyBgJhUkHiH2GZqoRJv1s+hRNAaXVPUv2ouzzt
	kFHoubPsylLUBbb+lcflXVsmp97pTyMXJuwGCDYzUsLNIwY77gIIbnqx4s7ATXje4JWbqsJVgPO
	XaOvGb0tvqI6+x3g34OsvKMW0SNZGW5JY8bNRDfgCAWSR3DVZSMXVdke822kLm/84U9svYqFUbA
	oQJq7eCQrgyCu9Qyur8O3jVhAafeAoIPGm8t+QerNg49jFMjEa1nU5yOSBPQJM8ztB3qp+9e2mK
	WeCZflQvCD9OtYsAq7F4OJAl1VNRoB+v7tmqgsJTUYVWYN8I2xOGGM/Lrh2tXnvWOPJZh/Dq2oI
	lLkkT7MMeO4iSghVG3Gw==
X-Received: by 2002:ac8:5a0e:0:b0:536:79aa:de1f with SMTP id d75a77b69052e-556c1197894mr48425351cf.59.1794419768098;
        Wed, 11 Nov 2026 09:56:08 -0800 (PST)
X-Received: by 2002:ac8:5a0e:0:b0:536:79aa:de1f with SMTP id d75a77b69052e-556c1197894mr48424651cf.59.1794419767488;
        Wed, 11 Nov 2026 09:56:07 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550b93ee00sm54974231cf.16.2026.11.11.09.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 09:56:07 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 11 Nov 2026 12:55:18 -0500
Subject: [PATCH 10/12] mm: set the uffd-wp bit on a guard marker when
 write-protecting
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
Message-Id: <20261111-uffd-state-fixes-v1-10-00713d368976@columbia.edu>
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
        linux-fsdevel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794419750; l=4747;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=ul44rnbOIwU4lu3lsdNUVT1/DDeRuHSjTUnRw0a9WDU=;
 b=fQsTj/i4UDq/yryVbSh4wKtMJl71uW3GYCH+sFLo7nbH9QwIF3IoGj2UFmj9P90rfaHOlmBJe
 gd1PEh3ydhsDVrHDCabHuLuuuSUCXXz5rWvEfQeIz3wqKs2J9YDY4iH
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: fF37z19mh49u9W6A96F2kuJ_4BIcyiDx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3MSBTYWx0ZWRfXxHRqHKf3qKvB
 Uny6B8NPW958dYPbmDovfZsb0/6wsxlc8MOguNvbqek+mwek8IL9DUCO0YFMb1btSKilgcDnY0l
 E502P02C1ApbAmTUvCCfYd1FHNDwr8EJaRi3M/ij3PIVZGbkfBX5zo/1X35K/ntQR1LrbsMKT21
 dMNv5b+koz80r+JmbzjjNa7QbH9lALEIfdoMyo71ADftTvFL96Q8mG362TL/YB768OEmB01O2ed
 q8czXENZyQPPXqqNmTO4jWn89WpmMQvNPXzyXoXY22ndv3pbjJPsv5xw0odYmkL73vABsqryZIA
 WaG/NIaqAdtw8imcpocvUBboUGSsD1apjqPXF3WOyTTDxPsBcGMwof5XyJHKIRL63JP2L0jppaI
 0dSRuSM2OZyK+bU53NTBDwzbktH80RJ9pLI045dp0beU2rorPmyWNqWY6lhXebjpBWupjSgyA0u
 dGSULMlntXgIfdLUq2g==
X-Authority-Analysis: v=2.4 cv=V/boQuni c=1 sm=1 tr=0 ts=6af4ac38 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=A3l_acRxY7KWR7xJ1gsA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3MSBTYWx0ZWRfX38f17v6DnczO
 b2LaLE6iickaEcXXU2OeZ9FfTC07+zx+6iKsQqAADGLbnheFRF03wGVc45qf1TuQc7GZka0u9Hf
 11HHomdq2wstQvA1+c+26luA0czXeTDmQ5G7Qs22gRytXFjPP8oF
X-Proofpoint-ORIG-GUID: fF37z19mh49u9W6A96F2kuJ_4BIcyiDx
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11963
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 adultscore=0 impostorscore=10
 suspectscore=0 spamscore=0 lowpriorityscore=10 bulkscore=10
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110071

UFFDIO_WRITEPROTECT and PAGEMAP_SCAN with PM_SCAN_WP_MATCHING do not
write-protect an entry that holds a guard marker. change_softleaf_pte()
ignores guard markers, and make_uffd_wp_pte() only sets the swap uffd
bit on the marker PTE, which guard removal clears along with the marker.

On a file-backed VMA, the page is still in the page cache once the guard
is removed. It faults back in writable, and writes to it are not
reported.

To fix it, set the uffd-wp bit on a guard marker of a file-backed VMA in
both paths. A guard marker can carry that bit, and guard removal then
keeps the write protection by leaving a uffd-wp marker in its place.

Move is_guard_pte_marker() to leafops.h as pte_is_guard_marker(), next
to pte_is_uffd_wp_marker(), so that make_uffd_wp_pte() can use it.

A page that is write-protected while a guard is in place is now still
write-protected after the guard is removed.

Anonymous memory is left as it is. With UFFD_FEATURE_WP_UNPOPULATED, an
entry that is write-protected while a guard is in place is still
unprotected after the guard is removed.

Fixes: f807123d578d ("mm: allow guard regions in file-backed and read-only mappings")
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/proc/task_mmu.c      |  7 +++++++
 include/linux/leafops.h | 14 ++++++++++++++
 mm/madvise.c            | 11 ++---------
 mm/mprotect.c           |  5 ++++-
 4 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 752f1b13d47a..7b1c843a4fd0 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2439,6 +2439,13 @@ static void make_uffd_wp_pte(struct vm_area_struct *vma,
 	} else if (pte_none(ptent)) {
 		set_pte_at(vma->vm_mm, addr, pte,
 			   make_pte_marker(PTE_MARKER_UFFD_WP));
+	} else if (!vma_is_anonymous(vma) && pte_is_guard_marker(ptent)) {
+		/* Keep the protection in the marker, as mprotect does. */
+		const softleaf_t entry = softleaf_from_pte(ptent);
+
+		set_pte_at(vma->vm_mm, addr, pte,
+			   make_pte_marker(softleaf_to_marker(entry) |
+					   PTE_MARKER_UFFD_WP));
 	} else {
 		ptent = set_uffd_wp_swp_pte(ptent);
 		set_pte_at(vma->vm_mm, addr, pte, ptent);
diff --git a/include/linux/leafops.h b/include/linux/leafops.h
index add4968ded44..831b85a184c4 100644
--- a/include/linux/leafops.h
+++ b/include/linux/leafops.h
@@ -547,6 +547,20 @@ static inline bool pte_is_marker(pte_t pte)
 	return softleaf_is_marker(softleaf_from_pte(pte));
 }
 
+/**
+ * pte_is_guard_marker() - Does this PTE entry encode a guard region marker
+ * leaf entry?
+ * @pte: PTE entry.
+ *
+ * Returns: true if this PTE is a guard marker leaf entry, otherwise false.
+ */
+static inline bool pte_is_guard_marker(pte_t pte)
+{
+	const softleaf_t entry = softleaf_from_pte(pte);
+
+	return softleaf_is_guard_marker(entry);
+}
+
 /**
  * pte_is_uffd_wp_marker() - Does this PTE entry encode a userfaultfd write
  * protect marker leaf entry?
diff --git a/mm/madvise.c b/mm/madvise.c
index e2c6b0f26672..e8b05dc899f1 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1085,13 +1085,6 @@ static bool is_valid_guard_vma(const struct vm_area_struct *vma,
 	return true;
 }
 
-static bool is_guard_pte_marker(pte_t ptent)
-{
-	const softleaf_t entry = softleaf_from_pte(ptent);
-
-	return softleaf_is_guard_marker(entry);
-}
-
 static int guard_install_pud_entry(pud_t *pud, unsigned long addr,
 				   unsigned long next, struct mm_walk *walk)
 {
@@ -1117,7 +1110,7 @@ static int guard_install_pte_entry(pte_t *pte, unsigned long addr,
 	unsigned long *nr_pages = (unsigned long *)walk->private;
 
 	/* If there is already a guard page marker, we have nothing to do. */
-	if (is_guard_pte_marker(pteval)) {
+	if (pte_is_guard_marker(pteval)) {
 		(*nr_pages)++;
 
 		return 0;
@@ -1275,7 +1268,7 @@ static int guard_remove_pte_entry(pte_t *pte, unsigned long addr,
 {
 	pte_t ptent = ptep_get(pte);
 
-	if (is_guard_pte_marker(ptent)) {
+	if (pte_is_guard_marker(ptent)) {
 		const softleaf_t entry = softleaf_from_pte(ptent);
 		const pte_marker marker = softleaf_to_marker(entry) &
 					  ~PTE_MARKER_GUARD;
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 6cc5b99b4185..3f2d6e3aca93 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -261,7 +261,10 @@ static long change_softleaf_pte(struct vm_area_struct *vma,
 			const pte_marker old = softleaf_to_marker(entry);
 			pte_marker marker = old;
 
-			if (uffd_prot_resolve)
+			if ((cp_flags & MM_CP_UFFD_WP) &&
+			    !vma_is_anonymous(vma))
+				marker |= PTE_MARKER_UFFD_WP;
+			else if (uffd_prot_resolve)
 				marker &= ~PTE_MARKER_UFFD_WP;
 
 			if (marker == old)

-- 
2.39.5

