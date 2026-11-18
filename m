Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794976158;
	b=P746bIxz/NjKzkKnxZ49cKW3z2ElcmyS5Hcnp1QrNc+u9Wg0tEXIlf73NWWkOfmDJ7V5
	 Kwan1IeN0MmH+7vftfWNMJbf5EXiPmvrrTqh0sd7gMlwFJ/cThl6Ik+FAdGXsNQIQdH/y
	 n8clqLA75hIqt5buOI4m22WrZs/+0LpUpunmisrR0hc9akF/Yga71uu1c44p3CvKfZfZe
	 JygoHFS0OJ+ETPuGoaryWE2f4zb89jELezBbxpdSDyC6S+ZyUjNWyXSYF4Q+s5eOE1AMI
	 BPbsR4sDQAtkhiZOinY/yh+mwPGbuxYqScvRLD0Cl8mQtp25zhh30mGnGB3df6oSA/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794976158;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=XNCJHjpXg7H4M22PhQ2BeTDOHza1Veqicyx+ercmKMo=;
	b=A0XDCZo7RoZkDiL36L89tBQsnn0yMkExr5pOh40dZ+OHM7rlgLURRnvdW2JPnt133NJI
	 iRsZfc/m8EfMW7JyodfPehrGFwE+bPti8FY9cXlOhfM/E2L3CZfqld5jk/FfaG/iWB9zZ
	 67L3NCiHL/EHW+JKEeBp5nbzPAL8C7nv8ws0fU75VmlttjSvPmUxhscfY777csajZI88B
	 8/LHqWrHFEEWp3C+6CiHjKZwc/Ict/Ds9MDP0D408VXAcXyR9VtmV0Vqglm+I4tQvr7s5
	 SLt2DkXRL+nVbP8lbxNm0wrVxwxpmeKxaBU308RtNuCjwQTAPgQbLagCUExdjWYrpVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=kJDoBRsr;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=Oa54y1wt;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB93D606A33D
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 04:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB93D606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=kJDoBRsr;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=Oa54y1wt
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI1XSVL3280079
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 23:29:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=XNCJ
	HjpXg7H4M22PhQ2BeTDOHza1Veqicyx+ercmKMo=; b=kJDoBRsrB/NsQEyhmLQQ
	PFL9HGbSbHNl5vTvWdwadua3igPUVS/Ewb8z8UJ4bDc38Xz69efN5F2+Me9D2ZDs
	+zfAJcvLAfU7xizj2s2M7KoI0avhpmTsjPLUKgpv+3HZcPaJADJrnhzHQ/PZ4Wu+
	VnI0qFH20vL0qCXDe4pqDsAVfHQQUphZXepiyexiIXaW54cUX3AHU04/x+9JKhuQ
	1FppTPTe6CKRWMK56/+SH0b3RlIJ+gbetTSCAkp7wkEv2cDxSw3J1jcGemVV0eZ9
	ghEqPF7bMwMaSc+rG12SRkOnbVS3qG7a+t+nNWXp1oglg27yy0mrNqawvVxVMo/e
	AQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j0yu6sg9a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 23:29:16 -0500 (EST)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9308eafb465so144371485a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 20:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794976156; x=1795580956; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XNCJHjpXg7H4M22PhQ2BeTDOHza1Veqicyx+ercmKMo=;
        b=Oa54y1wt5JQntImlXWdeQqrx8MFYW/MkN3a8V3HsC4nyKq1i2ESSRCSkQe2dvZ3Dry
         cPZHD/EwnT3j8V/VsH0i1NENQyfTUXxqih+fkr4e6D82GxCMjC/3DUTHogNNKlrKeM/f
         jI0+q51oxYtf1XOGv1/CJ26npcUMYKCQuQKnBenIZ7ly5xD/VqTo5yL5vtNWWG52rLEQ
         j7wQczzcjL4SVguDOZfMFMaAyv+/I4uUcisHcRFA9L1okqO/BLcKc6Guyim1UyraMAUo
         HwokZNTYhOQZTJWcmrCYPe8BWyzRI822l4Lfs6bISHWNJXlePaWvOMpgK7vg0otzjFKo
         5YPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794976156; x=1795580956;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XNCJHjpXg7H4M22PhQ2BeTDOHza1Veqicyx+ercmKMo=;
        b=i/pDHg3ppvQQgPKL6LugVG5E9XOAPxjPLyEcmXzkNgfnAjdEVhXKA1eH8jY0f+xxl0
         1mKOIdgxImwXD5XjDLuOBRaxOt87YlSGM1JLs/4Q7RwTO+295Y3Y9qOc6BVm2vwI+7lf
         stYt7r+7jKdEwcRs6Kniete035kY2Gw5NDZa7T5Qlk70G8ohXfiRq3C2ugMZG1y8jBhW
         aGnZBdbz91CkZPhRWOiJrDoYOuXgXuWpv8o5qnuDIcM/J2J05XaA3QlYv255PfiHjlWH
         au5u0fNzfXc9aUJDAcfKqrUxMrsV4NXyBUNETRwUgJbSPNT+zj2OcCB1o0Xozzirv69I
         vBpA==
X-Forwarded-Encrypted: i=1; AL+hErHHfB0eb/2EZLUg9PQp/ECorepWW0wK6ApzX2/CliNyKVTmYav2i3fcEZgnb3CplZOa6zigZZDX8Zvc5LtV@vger.kernel.org
X-Gm-Message-State: APuU4Z9aSpc4EeUuhifyG3xNEQ40tZhJnBTJJ66pcqbX7P422eIhcIkb
	JdCrHr5bIKhHC0Pfggf0E1njzNbmyWBlEExfgwjZGjYdh5xJaHwmABCPrDWawWBNSO3vkP75QlH
	Fy8MkyfnSnsdce4ndd96r8wmB6ze/eQnpET/Va161DXyG9oYBqrBHRrzzruXwqiM=
X-Gm-Gg: AYBFou0I/kRh1DAwwo9ARZ9CAqey65GcU6gVnh62DS6Q7AdjQuaXYL9CPJMdgaCt6fC
	GIcK+E1XQRwjxnWOQSJqBg9+IPdNYKp6WJ+mfmVVF4+5d8Ik1yzbuuqrgxMQT40c3TK+sPKCf9m
	4jyLd6fKhcgfQ2uazB5sLGq1UnieTPVIeWoGvlR49PmEkWncvIEdXKdlbVHffMaq8UFR6Gjstl/
	JHZ2CQAMfk2o2IHhyIgVmAqRgFamn3jbl5BGld+7XWd+KML5Uvg1v2Gif1gaGNbAMvC3vOc9khW
	zVbmdvqKSbMK1TqGMpLISN9FG45YaHoJ2pxaX8U0s1tQRlOzMfM4L9T8frW4gHCf8NbH1/Ne8ZR
	ZooUWPEA/CTR/oKOqwQbo20CgtNvtzAJsaBn0Zq/gQQ3Wh/3Bkv7W+Ncck3c3Za+hWhFv9fYxhR
	OS1oSig6SZWo+LLwtQwQ==
X-Received: by 2002:a05:620a:45a8:b0:93c:a468:2db1 with SMTP id af79cd13be357-949995ede97mr298862385a.58.1794976156035;
        Tue, 17 Nov 2026 20:29:16 -0800 (PST)
X-Received: by 2002:a05:620a:45a8:b0:93c:a468:2db1 with SMTP id af79cd13be357-949995ede97mr298858585a.58.1794976155607;
        Tue, 17 Nov 2026 20:29:15 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b743a8bsm89678085a.17.2026.11.17.20.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 20:29:15 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 17 Nov 2026 23:28:45 -0500
Subject: [PATCH v3 5/9] fs/proc/task_mmu: write-protect device-private THPs
 in PAGEMAP_SCAN
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
Message-Id: <20261117-uffd-state-fixes-v3-5-b617009d1a4a@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794976146; l=1768;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=EbKRPYoieoskQJpDqKg81gaW0G+NGTy5Bx6z8CnRsZs=;
 b=JSvYpX+oNnE9o4AKjWB2SyEOkImkawA7l35QLPhKkNybQH+XWVtVGXLK1uHIiS1KH05UxY9AL
 YTzUS6cnrjrCH+UqKgDA/2iXJ6Q8CFL1GAG8f2ZUA2gqL8yCRvg3lo6
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAxNyBTYWx0ZWRfXzzBHiqJt8kWn
 F0+H3amYBfB21FE/PDutOH7iLQ69jwFSmmWMl4xPeYAotevNTBC8if7Tez5Oype7ll3mXfAVopi
 vASOuBOR5H4kj6OeXn+amOOQiXxBO/tYnklIS57RcemSH7L50jwf83rqeoRlKvI92/CN4YumGqI
 chVMJ5pJ3DpYKoGSWlQkC68z0E9v7peBPRM5J+87yQbMnwFeDLPXzNXlAe4bIVEYuLrmqfma9U0
 S+Vr/96JRBNgnZGJ81qit5ompkaVBXhg0UJxoMkVCSEtCMA7Qe7lrYvn1otJROso06FtIvCZYiV
 VEcyDzgepaWzZAn2XSXeSA9QEbkB3aGNJqjFsa7dP9Y0CQAQf5wjWDCGbe/MtP9ZuPI9CcCE3dK
 ct2qD7gzVPAYYfRyzDdIRqVd8ZA+mKJDf7+LEIoDSYKQFmePCLrBEtJv1E8CQiQO+TPzQpl03/Y
 dmnxTV55VXcglM960bg==
X-Proofpoint-GUID: 6zdnvWDKfrLxWBKClDcgKKpqFL4IiFx4
X-Proofpoint-ORIG-GUID: 6zdnvWDKfrLxWBKClDcgKKpqFL4IiFx4
X-Authority-Analysis: v=2.4 cv=ZIJCCn7b c=1 sm=1 tr=0 ts=6afd299c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=tHa68p0SAAAA:8 a=VwQbUJbxAAAA:8 a=RyLRxA_qM0uo8G8YelwA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=ufIsyHvWW7FwcMbVRpPq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAxNyBTYWx0ZWRfX3onNHBgyD1zV
 Rt3hBrpbR2snlDseaSQVFPeIY3h//ZuGv5Ttt9qp0Zt5mBuT/vf4JMO4XtNm2y0KLNbmtZo/Z0v
 JTrXA3xFIK9Tf9fEyqbqIJitnmJ0Q3aWMmbaCd93lR0M3bLYH3XB
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11969
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=10 clxscore=1015 lowpriorityscore=10
 priorityscore=1501 malwarescore=0 impostorscore=10 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180017

PAGEMAP_SCAN with PM_SCAN_WP_MATCHING write-protects a huge PMD through
make_uffd_wp_pmd(), which handles a present THP and a migration entry
but does nothing for a device-private THP. The PMD never gets the uffd
bit.

pagemap_thp_category() reports a non-present PMD without the uffd bit as
written. A user tracking writes with async uffd-wp therefore sees every
page of a device-private THP as written on every scan, whether it was
written to or not. This requires a driver that migrates THPs to device
memory.

A device-private PMD must be write-protected like any other huge PMD. To
fix it, pass any valid PMD softleaf entry to set_uffd_wp_softleaf_pmd(),
not only a migration entry. It downgrades a writable entry and sets the
uffd bit. When the THP migrates back, set_pmd_migration_entry() carries
the uffd bit over to the migration entry, so the write protection is
kept.

Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/proc/task_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 0127bf9c3f77..15cb65c3ab94 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2510,7 +2510,7 @@ static void make_uffd_wp_pmd(struct vm_area_struct *vma,
 		old = pmdp_invalidate_ad(vma, addr, pmdp);
 		pmd = pmd_mkuffd(old);
 		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
-	} else if (pmd_is_migration_entry(pmd)) {
+	} else if (pmd_is_valid_softleaf(pmd)) {
 		pmd = set_uffd_wp_softleaf_pmd(pmd);
 		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
 	}

-- 
2.39.5

