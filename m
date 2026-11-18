Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794976164;
	b=bp+UCnwH7Ogu12wgVWdbd9ilnHEZv10xlRR5SDan6ZTjc9FHGD0L2Nb5QSATzCeM8qBx
	 3lk+JRaxBCrJczb4Iu7cGwtt7e3QgOvauQaql5hXGVwFquEVcrQxwhRf3n+uRCaLyUI9c
	 0in9Mhw8V0htnVG2sZcP32Z6FZOJDiSoRYMJ5Sc50ctwC3SVh/Ux7JgoQn5bPixcY+IHN
	 OwO3u87m8JO0JMofVukEnYgzCzAwvUy3SDJeEC5HCIVoP5X/EWJk8Sae/OENnIQkvG829
	 ZOWRZSgy6rDTKSo8ndRDTmXLPlBR8VsfXKEqg0eT64eJ+YeCd5ByVsZllxFW7FAVPaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794976164;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=i5zpFBIp+1LdT2GGZLD5EjnwLjNrouTOus3Kut6TC8c=;
	b=tEQliqGPBqLquWD6awbhf4H7VES1NWNs0H+Ug/aUGNrAVNZbjcTsaBuSE4B8mdwbNa+r
	 bqSpwN7qX/twjO3qNfnKFSbXIO9MgLeBdFdK8eMTQx8eU/WyoLPuZq7x8T2CEhOn9wcSN
	 hvkmg/eMVCjCJKkYt18ISLMyTLRFW/YqOcdY4GJV5Lvu20mAd+GfGQTktpuQyMsRQeImP
	 jqpEFNytRc/iMQdqvFN1WXXrDzZUAUtlVKS3eRjE1qz25/aEAWhXq6qbvwb0wTqGrZTMg
	 761C23hwKFiDKvAXz8KX+pp0BwnG7bb8ZbF3oBqQL0lhXct8OS+ZXf6j/3mIDamyrIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=ifCaGtTp;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=yUZUNM85;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F9660A381D
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 04:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3F9660A381D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=ifCaGtTp;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=yUZUNM85
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI1XSEr3279997
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 23:29:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=i5zp
	FBIp+1LdT2GGZLD5EjnwLjNrouTOus3Kut6TC8c=; b=ifCaGtTp+RHPKmxjiwYp
	EhQqRIfb8+M4e/v9xIOPeSPRLvrH6ccqH/QNbR5MXC0mG2x2/ZQml4DTHdtqMm6G
	EnyUsKTHmA+jYG+kmv2zphD/5Qnaz5S7sd1SPPkFKG6J6Urpsyd1kI/FBRP/KjS+
	ZTdBbzic85Gnqwst3K67EvTlgRIAkXAieYWf+WRTQ7f85JXSFZ3GGJT4AoZbf4w4
	QQc+ElIVfaNenz2v8OIodjgk76SpCThp6OCF4C3kHZI11dzm8sLwTYXlO4QvNuve
	z99CdSGJlN7fVewyRMoNqh2J92GGgpSCEG6PCSuHq4nacnXY2iZ1fBiG638z5Sjt
	EQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j0yu6sgah-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 23:29:22 -0500 (EST)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93e92aad34aso116465885a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 20:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794976162; x=1795580962; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i5zpFBIp+1LdT2GGZLD5EjnwLjNrouTOus3Kut6TC8c=;
        b=yUZUNM85r2tCDggczEfG4xe66I1cC3EPCoUfUTMZ9R7+FgejdMLhd1epB/y7sF23vQ
         o7dej7Mi7yIPEQc/VWEUTDsBMSGyQzJ2ButuQV7RZ+Wq1fSrSZ84+N0mZpRyB0/yh0g6
         gB8gdU0PsseXNTd9iMxumGPzL+S27qitd1Gy/y1VJTF9/Hpxx2Shd1+o9WDiRN2I9fWn
         PXFC3JnngpyLbn2+2PWeEYsknbOpB3RlWe4vGQ4J/pCnJU+OK3VH6Hs3y9TdVXWRYliy
         yLfNE9vKpU53A0VA2PITEqnzWd9m9MXm90+uMkwYtLUz/SkK7o5SEc0mnk62npMtxg1D
         bEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794976162; x=1795580962;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i5zpFBIp+1LdT2GGZLD5EjnwLjNrouTOus3Kut6TC8c=;
        b=EWQlwQTv4nA12UDIXoe+0f4dho19D0m+hYBRX285G+uTlckxWkBAtYFgH1ukJTzrJD
         UGzk56AuN1+4+3ueuPjgrS7cJo818VD9rQOxyjTcVIgKhCbAUPHDkw579DcVa/lMZLFB
         /iscFRGGzSQhWEBpFDszwJ5uHy9P+zcvAld7NbhBPV2FmWzSX3hPnG6cuiSb4yZl6/Pl
         VjpZCjihhhOK288s950HabxuITQCGtlEahJK3rvz9bxEILq3qJQf/+ooG2pM/5kQ4kqE
         kGhECGwcZQE7kBrWG/DSuNEmr63PJUGWP7pyw8jeWlfuRmKlzrhhhbdbCDCibmRaX4Vw
         OgFA==
X-Forwarded-Encrypted: i=1; AL+hErFKGJNX8sO3rNdp67puh0X9EfO/wwtJlT9E/LmKGB6n+fxYyWYRB+yiUKrjNvHJmbAtcXK+HrsMN4BvkxhL@vger.kernel.org
X-Gm-Message-State: APuU4Z/9SgUUx7EZZ/n5rhdR3RAUIHivNMTCve1GYLPMnvWI/1QRkIIT
	c4QLYc5mOSSV3eXX9c/S24yckEYRENMpam/u92tn2DW6i3nbLucbUC6qPCOftDC5GDfwyrOVe2G
	ZxwOkk4Jw2F9vSD8nx+0hZ99TeVEabWIq9qZUmqnneGgj07zyugWmM3idkmSE5Xc=
X-Gm-Gg: AYBFou00uw4+ePKac86OErY3u+K7J0opbvV+gdfLSLspsWIoxHr3UAhRtEteZazzBvx
	uxveuTnUdTtKJZkD5qZ8gF4y3nR5rfuAO7kCDet53ccCSe/A/N05mZ7WbCvLBCFFo5F1zzI57VW
	9KqhqsSJCF9x04QA+UKnBUmps/w9l+uvmUKgOMH3EzpCBJWRtdFvVhxTNwIHyM8C/1R30qH/Eg+
	sfr8f0rn3HHNsd6dtsNTmcqoJbqZML3V1yt+Mdpn7knuAGq99AV5Lc4VnmaexMPFNp5fuYJShSh
	7ls8E2CkPlPT5OMapJIdRBV2F1d+kMp8WRGyxfC2APHJ5nAujRlJNnrcwwKVij1VGR2/kkY2cYk
	PFMboSVAC+QYbvbUIVqzagn/TWXEmiDh01U6wPJUafj3tcOs2ndT9fmjuxnHF4BjHwtCj48YI3X
	olgL98RrIrV79aOSZA7Q==
X-Received: by 2002:a05:620a:2906:b0:945:fcd7:7823 with SMTP id af79cd13be357-949995ee5bdmr310931385a.63.1794976161882;
        Tue, 17 Nov 2026 20:29:21 -0800 (PST)
X-Received: by 2002:a05:620a:2906:b0:945:fcd7:7823 with SMTP id af79cd13be357-949995ee5bdmr310928285a.63.1794976161125;
        Tue, 17 Nov 2026 20:29:21 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b743a8bsm89678085a.17.2026.11.17.20.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 20:29:20 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 17 Nov 2026 23:28:49 -0500
Subject: [PATCH v3 9/9] mm/userfaultfd: check the hugetlb alignment of
 every VMA in the pre-scan
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
Message-Id: <20261117-uffd-state-fixes-v3-9-b617009d1a4a@columbia.edu>
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
        linux-fsdevel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794976146; l=4876;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=EAxjBdGKjmNBZwoH8jlh/pcqgFCSerjkNK/wjow3uGE=;
 b=KUR+7ad8tDe+EylRan8+qSxOeisLzBXY9hPHmeOwVFnG4dxe7Ag2XQ64KOhMu4e5hqw3d5kCe
 +LFkOdORmnhCXD+Pe/H5JBozZJ60NMLg61evwFPO4+4kCv/tJJ5n0m1
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAxNyBTYWx0ZWRfX0Amx69in1LkU
 r7gVQn2CCvGFi2gQIzWu1rucNkVwBQL4ag11miUyhCg0WcovIQ5bXX5jo203dNOp0T0BU4JGkAH
 tNW9tnewLoNcPZLkMX0ot3NqipOYIZk+enRkopodDQ9Esgp0TaogqjPP7uC5wPjNBu1kfKCPocf
 e7xidY4AOQJSNzTajVK6OL+uAM4MPQVHQU99odpRi7AVJHAKB51YeY4e7SJjkDwi1fb3nu2+EVf
 eL4PDd/vCQdHYQeZjdqib0AEydfFjUatTVwgXys6sMwOrfHFrsDMCg42Pl4ooobJXZn1wWGYpve
 6DXoVfx7ykt8iEjQkWp8cxb7B06zr4JBbTOluCF+fWBoB/+0HSruRe3LUFl6Lrn4SUGu8rpDLYy
 Bc55NgbkBii/Gz8Mks3WR1faq6vEdZuGNrAdCu+QGRVO9fcENLU3yISAOqy2MlUpSROWT4nmC41
 S2Qx2bH4i1G8cFmkN5w==
X-Proofpoint-GUID: POoqmt1SWTggvJ7CBspnNtQnB6YX2qty
X-Proofpoint-ORIG-GUID: POoqmt1SWTggvJ7CBspnNtQnB6YX2qty
X-Authority-Analysis: v=2.4 cv=ZIJCCn7b c=1 sm=1 tr=0 ts=6afd29a2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=sktC-jyAyf29sAdH:21 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10
 a=A0y_DWxS2BwA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22
 a=HpS3TJQ9O3Ob1ozEcmik:22 a=VwQbUJbxAAAA:8 a=9qlVvB6YTzTb8WvwRWkA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAxNyBTYWx0ZWRfXz38qk0NPA0mC
 kssl5qCPzToxe3wvsxWCEuVtj+dzUPvQs2PeZuAkp8OWpBAf+qsIaG2nA5GPKP9adDwfaBwMIpd
 pM3iL2NUvufV+XcORAZ99ph7kCI4/75uILZHGfn7nAoM4tVuIOPg
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11969
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=10 clxscore=1015 lowpriorityscore=10
 priorityscore=1501 malwarescore=0 impostorscore=10 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180017

UFFDIO_REGISTER and UFFDIO_UNREGISTER both scan the VMAs of the range
before changing anything. For a hugetlb VMA, userfaultfd_register()
rejects a range whose start or end is not huge page aligned there.
However, userfaultfd_unregister() only checks the start.

An unaligned end only fails later, when vma_modify_flags_uffd() cannot
split the VMA there. At that point, userfaultfd_clear_vma() already
cleared the WP or RWP protection. The ioctl returns -EINVAL and the VMA
stays registered, but accesses to its pages are no longer reported. This
requires a caller passing a misaligned range.

To fix it, move the alignment checks into vma_uffd_range_aligned() and
call it for every VMA in the pre-scan of both ioctls. UFFDIO_UNREGISTER
still returns -EINVAL for such a range, but no longer unregisters the
VMAs before the misaligned one first.

Checking every VMA the same way also changes the following:

- UFFDIO_UNREGISTER now returns -EINVAL if the end is not huge page
  aligned in a hugetlb VMA that is not registered. It used to skip that
  VMA and succeed.

- Both ioctls now accept a start that is not huge page aligned if it is
  not inside any VMA and the first VMA of the range is a hugetlb one.
  They used to return -EINVAL, although such a range covers that VMA
  from its start, which is always huge page aligned.

- UFFDIO_REGISTER now returns -EINVAL rather than -EPERM if the end is
  not huge page aligned in a hugetlb VMA without VM_MAYWRITE.

Fixes: cab350afcbc9 ("userfaultfd: hugetlbfs: allow registration of ranges containing huge pages")
Fixes: f369b07c8614 ("mm/uffd: reset write protection when unregister with wp-mode")
Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 mm/userfaultfd.c | 54 ++++++++++++++++++------------------------------------
 1 file changed, 18 insertions(+), 36 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index ada841a9cb2a..b80bcc1e03d0 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -3692,6 +3692,20 @@ static __always_inline int validate_range(struct mm_struct *mm,
 	return validate_unaligned_range(mm, start, len);
 }
 
+static bool vma_uffd_range_aligned(struct vm_area_struct *vma,
+				   unsigned long start, unsigned long end)
+{
+	unsigned long size;
+
+	if (!vma_is_hugetlb(vma))
+		return true;
+
+	/* A hugetlb VMA can only be split at a huge page boundary. */
+	size = huge_page_size(hstate_vma(vma));
+	return IS_ALIGNED(max(start, vma->vm_start), size) &&
+	       IS_ALIGNED(min(end, vma->vm_end), size);
+}
+
 static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 				unsigned long arg)
 {
@@ -3770,17 +3784,6 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	if (!vma)
 		goto out_unlock;
 
-	/*
-	 * If the first vma contains huge pages, make sure start address
-	 * is aligned to huge page size.
-	 */
-	if (vma_is_hugetlb(vma)) {
-		unsigned long vma_hpagesize = vma_kernel_pagesize(vma);
-
-		if (start & (vma_hpagesize - 1))
-			goto out_unlock;
-	}
-
 	/*
 	 * Search for not compatible vmas.
 	 */
@@ -3797,6 +3800,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		ret = -EINVAL;
 		if (!vma_can_userfault(cur, vm_flags, wp_async))
 			goto out_unlock;
+		if (!vma_uffd_range_aligned(cur, start, end))
+			goto out_unlock;
 
 		/*
 		 * RWP uses protnone as an access-tracking marker. PROT_NONE
@@ -3820,20 +3825,6 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		ret = -EPERM;
 		if (unlikely(!(cur->vm_flags & VM_MAYWRITE)))
 			goto out_unlock;
-
-		/*
-		 * If this vma contains ending address, and huge pages
-		 * check alignment.
-		 */
-		if (vma_is_hugetlb(cur) && end <= cur->vm_end &&
-		    end > cur->vm_start) {
-			unsigned long vma_hpagesize = vma_kernel_pagesize(cur);
-
-			ret = -EINVAL;
-
-			if (end & (vma_hpagesize - 1))
-				goto out_unlock;
-		}
 		if ((vm_flags & VM_UFFD_WP) && !(cur->vm_flags & VM_MAYWRITE))
 			goto out_unlock;
 
@@ -3943,17 +3934,6 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	if (!vma)
 		goto out_unlock;
 
-	/*
-	 * If the first vma contains huge pages, make sure start address
-	 * is aligned to huge page size.
-	 */
-	if (vma_is_hugetlb(vma)) {
-		unsigned long vma_hpagesize = vma_kernel_pagesize(vma);
-
-		if (start & (vma_hpagesize - 1))
-			goto out_unlock;
-	}
-
 	/*
 	 * Search for not compatible vmas.
 	 */
@@ -3982,6 +3962,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 		 */
 		if (!vma_can_userfault(cur, cur->vm_flags, wp_async))
 			goto out_unlock;
+		if (!vma_uffd_range_aligned(cur, start, end))
+			goto out_unlock;
 
 		found = true;
 	} for_each_vma_range(vmi, cur, end);

-- 
2.39.5

