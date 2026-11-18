Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794976158;
	b=O7ekKZakHakp9vnN/+UrBHQN5f+PIgMwQH63uOOnnyPhKackoaqcdmgtbcYh+4CUDL6z
	 rcBNrb/dn4O1g2iYQex6Slc34kwyPNlOwe4F0+pDNk1PDA3fYsiEdu/SXuKwLr1lTBILf
	 CQnpE25KF+kkHfhIBSvKdIBPRJyBOwTK/Q6OevKdKLt1ipcW1YLJRC2s8skEBbHHvz4Pc
	 JapSC8hpKosrVp/M/CItFJMzGPOkUEuHe0LVu+NopsIFf0xygMCrIEj+v2Qu+E6TXoErY
	 OGwGsF9HAB5U/L8Cfow6WkSuM7bqTklVUuCca0bMOVNp/boVHyjPqRlgRuC3guMswDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794976158;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=1pZTPbPLpqcipBn+gCe+PHsN8BLdvgf8n1ZHU7b2omk=;
	b=TPE5jLrKJwpq9goGMg6T/xQCRKlvNig0UvhAPDztziB+NQVJFUbw32dIt7ssOe+1puGu
	 kQnuBlDt/6U9hI964yZxshqQqQXssBCDs8S5pDGesh/IWRl2lWJTMjml2IzlH0kuNzukq
	 Hky/TZMO9tTXvqw4P3ZAKf8NOf7BmNR/hUJrVaBCfx+WG7CFbr8zUsoEZ0tv+htEGpr/m
	 jhRjF6lwqUbnPIkwIz2CMbw39u3fLKCcSrCKaD7puQ2n9RXaRIfZ5a5giHzUMEY6eKPlC
	 3kEWy+UUBVF3IlPGkN50eJycwPO79/29bMz01Qx020FAVaFalfscd+/nsNtXmvYGBxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b="aX/azDTm";
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=20VZb8oq;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEA3606A33A
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 04:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BEA3606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=aX/azDTm;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=20VZb8oq
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI1XQKW2951557
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 23:29:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=1pZT
	PbPLpqcipBn+gCe+PHsN8BLdvgf8n1ZHU7b2omk=; b=aX/azDTmf2h7yR5Vjear
	bS0xksh+kHycMdXrf/MUt+2nFXKp0T2HZ+HWyNb74fEMpBg9UsypYlm6i4/5vsGS
	sNqllSzxTvQidwjQ89pJEkl6MA2N4MUW8BxEaa1GrF9uVWAkHsvze3mE7C46rrJl
	rhDaXEZxcLTtduVc9J1TlNMb/bQ+5GOuws3gqjwzcTPyCcPmKhQXbSiAAVTz18tm
	s7kJvLJjB1Zo4G0i7xfR+giX/dC58Y9Jvve2SxJdJY0ofVST9yrVnPQFhGKftuFz
	dZuj/YLYrjaCZ1AyPps7NOdlPQEQJe7Yc4UB/bTrLZNi6uAvGr1I87pFiorfmgv6
	mw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j0yu5sfak-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 23:29:11 -0500 (EST)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93cb7f9bb86so128620885a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 20:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794976150; x=1795580950; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1pZTPbPLpqcipBn+gCe+PHsN8BLdvgf8n1ZHU7b2omk=;
        b=20VZb8oqzo0rZ8pxmptxAvVzLz3lr054eutWVAg/b2lW9lzONpsYgI3HfLi82ElL4L
         OfgoR0IBGcxWVVHZ5tzjYXblGffNWiXd5XbZNUMeF82nT805AlTft7HceIoTNX2sZdJO
         Z4dKM6l6h6LluDmuLKLC5Hthizz36cKUrsCLuXudsYpWgufmE8Y/J9LiqkmkwOLSmevj
         uZPhiZDo16ZYnqMWHwje08DNVPDy/fzvaDfDju/o9ECw/GWiNT3ShiJf1lKfe+K21Hj9
         6GlvbotxlE5JJTtr8bwFefq0NDCxpnXH/JTgfPET0Gk6zFc0vfxcW7uaAhiC0CR7dWvP
         NBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794976150; x=1795580950;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1pZTPbPLpqcipBn+gCe+PHsN8BLdvgf8n1ZHU7b2omk=;
        b=SOTfCFmfbfe37lGm0sk3Np1oZz98hcko9X+gdaLVRXC5jkaoyyIpiOH0qDpNDBI0GC
         Lkcb8vTi3MdLLagIiP3/Yotko7NTUtwEC12fWy9UkImR38MOv3RkJ1uu/4bIX7ysiM/w
         nnT07PqThjm1W+z4w7PL01h2IMWLulxYhnXs3FDEVXpwXcuwjmnN7hWSZNiUEANtwjUP
         U9pX1vJBQcilsZhe7DPgeiaQjh483TI/jutMHByv4hld5qckc7BOCHt9hgeRTgzXh03k
         3YywshrgIv9eAAn+j24EIvIMtPUMjjBe1oovKmywkEpPcGybjQ1LGkvl6EzLFBTe+56/
         3BpQ==
X-Forwarded-Encrypted: i=1; AL+hErEackNOm7GTJ8PxPfodyOZczl+wBDv3A941FlO15Nx/zAtxjyQNNxlMnIbaVPrP8yPNeChIVnQrJTiq12DF@vger.kernel.org
X-Gm-Message-State: APuU4Z8gd8zkn4aBq+fjKdZf0OTE2X3vahZ+SQrU7V0RLn5v/yGko8td
	NUivXWvOjaUeLmCTj0nbxfjxmlk9mkU9nAXM9KbhKhBBaMemqSxIscZKj66/JC0vfIeFe60kXqJ
	zMpaQab20T42QgnMqB1oN1qT3Y+TwMxAdw7ujgyoaGBRYkHdeYs8VjyFUH7QaqlM=
X-Gm-Gg: AYBFou0OyZR1zGQrAKvzQ9w3YsHfXyhYkMvKlM7ITbrb0iMQzyBrovvo/6JY2G5dviz
	LkIAaC4z/S9hjy2yOYCAfBKA4nQrqrgbvVkeaG1xSKUyr1pNZCVHDkd+FraW79uTlAjxzZevWBV
	SRHygKeYxv4Y5FF3CSq00D6ntT2mpBDVDxYPPyhY4fIhvtVLts8S3251uzr0/Wlwx1rZ+f2kZf1
	4jAMBKybV22aoDicNvgVGax99d7lZ7sAepKgUzluKlsQBNl8TFZWMzaT7wTta6lBWrlZbWzOacw
	IbTzqD0VV7FHPxJqORy1kJSsyg8PLoMGuBssHjFpIbtE9OyyJ0/rKgKhfdTuSHTR+Ss7Jjnwe4+
	0835P+Pc01H2zN40shubdseGoTnZaFSOXZ8VjxOKc5QkaK+S6GZNFxs+iq3QmQ/Kf6108+VClIR
	FNVWEwOLiGrHtDUEsFqA==
X-Received: by 2002:a05:620a:2b46:b0:949:73f3:843 with SMTP id af79cd13be357-94999631b1dmr290181485a.74.1794976150528;
        Tue, 17 Nov 2026 20:29:10 -0800 (PST)
X-Received: by 2002:a05:620a:2b46:b0:949:73f3:843 with SMTP id af79cd13be357-94999631b1dmr290176785a.74.1794976149985;
        Tue, 17 Nov 2026 20:29:09 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b743a8bsm89678085a.17.2026.11.17.20.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 20:29:09 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 17 Nov 2026 23:28:41 -0500
Subject: [PATCH v3 1/9] userfaultfd: use anonymous memory for
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
Message-Id: <20261117-uffd-state-fixes-v3-1-b617009d1a4a@columbia.edu>
References: <20261117-uffd-state-fixes-v3-0-b617009d1a4a@columbia.edu>
In-Reply-To: <20261117-uffd-state-fixes-v3-0-b617009d1a4a@columbia.edu>
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
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794976146; l=5479;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=D1dw78bimKL+d/luxdZ7meDrQ3j5/UFW8Z8ACLLeFmI=;
 b=RfkD2DVfsR3kFo46MpyYEDOjmciIMWeEGcVQFwYVPUGxT1EM+lXv9ORRuj/jFjXbmxhIYk4TD
 rjKTtksjKS0B4mjB4HplBkLm6jtCZgqq8RPGFYZO9QYNFVL1tJIoIsB
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=Ir6L47/g c=1 sm=1 tr=0 ts=6afd2997 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=VwQbUJbxAAAA:8 a=a5NvJi0EDLanwwYVvGMA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: RsofXqdNxJiuT8e3RsccaxRL4bYL8Vx1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAxNyBTYWx0ZWRfX+kvYAYkfGi4X
 PKaC/oPLipEI4i6z0d6HCY6nONAcA2mFylXw49RJnJ4OnkuOzDtDsZn1aEhR4FIO+OVYq+nam5l
 SpoqIy6OtBxjfKbQfBkN1QZrEdhBj849WWr9vqsDZOw5M1na+rNd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAxNyBTYWx0ZWRfX4CSKZ+6rsxXV
 ndfhKrU8Is238rAze8N/zZFOscC+lN0KctVB5DJVJar/OMO/ruQTifO7KsIo+sUum1TkJ59SdkP
 xwYxbkGabT12EV0lUGk6G9H1NLx3odrD3iNiON2T+sfHghJXkLPKEDKpJvIuey4FmJqyiP+M2cd
 Qi7iElJW1Ky1JIUmARJDLPWwW9oB+OFy5rVOeu4mtgTJiU0UhDfbOsDA2yh3KckAr9s2ATW+yhv
 sM+trRhYOkEy7ZOzmqI0JGOSthojcpLzzpFC12UV9GzLiFoy4xfGhRnEtd5x8G1wLXDZDJbGyUY
 S6xvh2krzxLLVP7HZpVuMfvT/NaQYVAG2Kgb9DIea1oUwA+7hJfo5rJUFZSqsvpgrvwUp9XWNgX
 ZUaDBQCACkDkrE2cIvUAt7l6e80/lfVwc0wJbgDyqym7b+HCauWwaygZ6yEfEyeX3U4552Qkgbw
 NbQkzQq41xQ0iPnWCdg==
X-Proofpoint-GUID: RsofXqdNxJiuT8e3RsccaxRL4bYL8Vx1
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11969
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=10
 malwarescore=0 clxscore=1015 suspectscore=0 impostorscore=10 bulkscore=10
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180017

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

While at it, use vma_is_cow_mapping() to check for a private mapping.

UFFDIO_ZEROPAGE no longer modifies the file, and only fails with -EEXIST
if something is already mapped at the destination address.

Fixes: f74991b4e383 ("shmem, userfaultfd: implement shmem uffd operations using vm_uffd_ops")
Cc: stable@vger.kernel.org
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 mm/userfaultfd.c | 46 ++++++++++++++++------------------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index d65184d9a480..e787e9a3ea29 100644
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
+	if (vma_is_cow_mapping(state->vma))
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

