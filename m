Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419764;
	b=ZVBTnrxT25z+8/E2+cWhA1GI1ettSXsvr1WCh3gxq7cGw6Nwyi97apY62sF8SIeMfK50
	 RgvcgdbAiRKIMmzKfp3Ibd3fXPL0w3PeFcnedJHLBxViIub+3cchbvMnrp1A5wNqw6wv7
	 7ycpBpCEl1nhPrjhub+P/eG/a4R35/7nFQeOzthE1sqsWnYAWs+wcoPKxNXnPj52j7thB
	 LYd65Q2i+xENLx5/gAJsnmTYGiEnn/cfVmLWNLmF7OGC5gS1OHuMZzyw7kw9ghaDvC3ZB
	 RyZl4xLkAIgRQMDaRYmFAUX6089sdgxMxkdl3pBhUGmJ7iFwbcyc6nH/77lWXoAiFmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419764;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=R+EjyARKBaNH3SkAfWpNAWHi3Sv3+8OGpYn7wnaHoKA=;
	b=t4UM/zpA+SVFcdnjcVAg71u6s4p0TaAecQljWqqtTu+bS1plIKiQMfI13PbBdRfBQnI1
	 585FkNiwGWa4K2iIfMWKVh2s2m8okQvgoPI/l7WPMvxp6Yjq0xeC5Wlpw9erLdZE3z45N
	 PsQetr1Q6yYdzdtvd+BGNYx8qPaO8ueGHfjG1CpotbKc7P0dqz8U0Ph8cspDWvH5ESI49
	 UHV/sarPKvroEJ4PIichBkuiL/L+NIfz+jCQZaV5YMkBw9HWVDnIPf4FBmXEe+zMh2cuW
	 FlOAjR1faso9+cS0PDRNBaip3rYLnSEPXSBg6n+HdwNN7FLRU3bRIQ5FYZLMrdrNqwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=G0KSRkUW;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=D2eYHfct;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0505F606A33D
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 17:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0505F606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=G0KSRkUW;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=D2eYHfct
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABHYD011914214
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 12:56:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=R+Ej
	yARKBaNH3SkAfWpNAWHi3Sv3+8OGpYn7wnaHoKA=; b=G0KSRkUWtA/jxZnsPfSd
	sLK2jnQq2mx4i88lTY+hIFSByloYyrhH4l+bsweNL0HufkFwSPkIA5L+jh4VQ8xI
	yCr1t4YpfdhCjxoGVVwXKjHzGqm7Ra0a3vh7N4iLcAAbJTznv+VtSVNo9Bl22i/O
	Oscf1KwEhWPIYnTU2kxBMDHKGtXqVNRLGoNxc2h2hcsT0DMN8RZ+PmGIEmoBHu+6
	95dGU/3r6apsJpqt8EaKfqdzw41a7WlQT23y9A0siWQzvIDAFUyf0HwfB6jXETpy
	7ZqJKdfxS9JHmMqrOKwV4cNGswEKpJVxrwN4SXDMsbZfEcW89M5o+m7G+N2LywPN
	Xg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hvvaqgh9x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 12:56:02 -0500 (EST)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5351f1b26e6so52904021cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 09:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794419762; x=1795024562; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R+EjyARKBaNH3SkAfWpNAWHi3Sv3+8OGpYn7wnaHoKA=;
        b=D2eYHfctTkw3HFqxmPhgEl7VX10XuV+LUEVzdKGFB17MpqUd6Y39DfDHmXxAnvChJT
         LPgjQvsicQE0PdkQ7GWYukasDgj8YREI/TjYrVnIa2BtGkKeKbadLaTy2WzCKRcR5kYi
         ce8abdeG8Wft/WDnXuTDsUGQmE99EOtfaB8mjp65aKJoR8QXiM2OdD+vgWf/ffaa86Cs
         sirMtxpsefHIiXExTqnkhX0P59t3JzKcBfPiFLAP76yeEyq+axye8G2v632MEKAOZA4j
         tvmSt7dlZtXpI/kEcafOGzng0+ZiXFUQV7hOhdwETbpoB3rTmgQzlLhSuWgkrIBExy9N
         x4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794419762; x=1795024562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R+EjyARKBaNH3SkAfWpNAWHi3Sv3+8OGpYn7wnaHoKA=;
        b=oxVcw2QlXPkGQrzpbP/vlr1JPOZiScjfykgNHoDoL3fdgHekHSSr0v6MY942uQCmI/
         B42tlf1jW6SX7j2ThjCsEBSwuSHKESfbpiMFE9yd55z0nCQU3j2tlueQAxyYwF8978RZ
         XnOAYEjFVu73wxMD0ivFUxJO/9uJnUHilhkop+J1yDzSYz1naJqKy/jsvBdKULFRwgHx
         jCV+GyifESKqSNhwrGlcc/aytjBfJM39o7Qe37iktzKLsDDkmPW3+6rbf5Ohoi7lqFO+
         kNSiBFps/Oeeb4AMQVpo1HuKYQOfX48KxVhCr5uprF02XbXOkkLJ4BeRibri8QKxrKT+
         JT6g==
X-Forwarded-Encrypted: i=1; AL+hErHYsHhMJ7r/4vf0tNS1IP8h2mGspoP35wpSQSF3PlJHUi4YlhHLJmt+U5/AwuemVsd/dXkbYjMEI/QH9o2v@vger.kernel.org
X-Gm-Message-State: APuU4Z/3h2VDOErXAts+USuksQWJC+KhC4tZ4AYQbTepoM8o1pfNnY0D
	BQJEDiBJ38uRmG/l7WNhkM8Eff8AawYF+fTC9HUrHFNrOJXLCTfdnX1w4i8D843UJAptfPbzzBi
	MxL1npQkbO06nmYwnhOGi545p8H8yK4+XfoVaKj4m1EMheMv4VXJ9uVgA5g8qpJY=
X-Gm-Gg: AYBFou017ivaKD2H9A3Lu4ZQsyNAnE2Ms3vZ6dOnpCg1mGtfHAd5FsQng1xJoPvaiKi
	7Pxs1VMuLpHu0S7j0dkm1Dch+MVNMyIxKYRxXeMEqaCv8jAVyMff+v9oMXVhdCzMMG2D1+N94rF
	q0MAC7YwBVaywCxUS4UqpLJ+Dhzoit/MOmYzkCYFb6Nu9CDbvxYCYm/HwqVr3s6lBGeqKbvqV3Z
	ilTzZi8Dni7u+9kEGYt5w4bmPe6n4AOjom7LoexDZnYfRQTJD53tx/njB2pIFmz4l7472DfAgsM
	RSklK8xQzUiq52Pb6ZeZed3p9mE1Rr3ktbSYm+Lq86m8VMIKhlib7urdLPqqbKUoql1O29iDH99
	3rbYKg9/1c8rE/QvE7mhKUf8n7r2bJAxwu7rC8OedjI/+dy1LGrNA/ggzsf3JYKMP93WZcpO5NA
	EhoqRkzFYX40JJ0KeQEw==
X-Received: by 2002:a05:622a:17cb:b0:535:87c3:79e5 with SMTP id d75a77b69052e-556c02feee9mr45374801cf.39.1794419762011;
        Wed, 11 Nov 2026 09:56:02 -0800 (PST)
X-Received: by 2002:a05:622a:17cb:b0:535:87c3:79e5 with SMTP id d75a77b69052e-556c02feee9mr45374101cf.39.1794419761469;
        Wed, 11 Nov 2026 09:56:01 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550b93ee00sm54974231cf.16.2026.11.11.09.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 09:56:01 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 11 Nov 2026 12:55:14 -0500
Subject: [PATCH 06/12] mm/huge_memory: build the moved huge zero PMD from
 the destination VMA
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
Message-Id: <20261111-uffd-state-fixes-v1-6-00713d368976@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794419750; l=2003;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=c/tJkA0ywzx7Mq78hcQB+Mewlq+Kcny7U2nx85cQ+eE=;
 b=gh8f8A+1RSt0AMZELb50zZ9wb86q/oSkQ+azdyShjWWpdd+2fo767l+7G2ocPpLH2v3rnH7js
 r1p/FefMvNpAgWeMRPyewtgYy1jmipy9Rtg6Vb0m1Snm2yWGvxN1MsH
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=FraQbGrq c=1 sm=1 tr=0 ts=6af4ac32 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=dI9OOPIzGUgM9lhLtj0A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3MSBTYWx0ZWRfXzXY7UvzSjEd0
 02B3+bANsoXxSluC6cW6zP0djJG3VUqLdm42CsZnoM16bVvTZGjMLIsILN1CPvxNGpX/3R2qG3C
 9Vf9ykGw74JuVEnuNBzjSkUGeZSV7sm5gE5QUjSVPt3GyM4i2eVeTc6+6jkh9922YOSZckULZva
 U2EYe5DSktKAo8T2e5u1RqsA7gBBlbQbDaBVCG6Ja79wMTb56GjqEBAFUORs4JAwUDqegHvkYRb
 Wk4mjCzso+qw1oZXt44ya0APD2khMbW69SqUhv37qlnxHZ5L4w6Qb6jizfIiwWhO4JZmOLL+WE2
 EcI2dSP5mqrTz0H7u+v5Hx5HC/7vSykP48xJzleahxLXJHdVhgRaRhztP2VgV7algxGgXAudJKB
 4sXmYG2jTjXWWAuVFEKuKLETdX0o963SyrPZmXltZ6NkBibH1UZxvlkqAs+IT8dKFBYLNMh+3dR
 6ppixxc2RqpLz95hEGA==
X-Proofpoint-ORIG-GUID: LUWkVDfc-RjrvUwvTS6lDSSxS95YDSs4
X-Proofpoint-GUID: LUWkVDfc-RjrvUwvTS6lDSSxS95YDSs4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3MSBTYWx0ZWRfX4XolnDpEqiVQ
 ykuWG7NB7Xa/4OSw2jWIwfgcg8EUqWBvLfcD/GxPutGswhMpQihhXvueIso4r70XQVsplono9Qb
 zBKgvmQ68rySqlK/4bFxOHsu71XFZejsfTRY9mDhw7husKGr/fwU
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11963
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=10 bulkscore=10
 clxscore=1015 priorityscore=1501 impostorscore=10 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110071

move_pages_huge_pmd() builds the destination PMD for the huge zero page
by copying the source PMD and clearing its uffd bit, so the destination
keeps the protection of the source.

A source VMA registered for RWP can map the huge zero page with a
PAGE_NONE PMD, and UFFDIO_MOVE does not check how the source is
registered. The destination then gets a PAGE_NONE PMD without the uffd
bit, although nothing asked for that in the destination VMA.

The next access fixes it up through the NUMA hinting fault path. Until
then, the first access to the destination takes a spurious fault and GUP
has to take the fault path. The impact on userspace is small.

The moved entry must have the protection of the destination VMA. To fix
it, build the entry from the vm_page_prot of the destination VMA, as
move_zeropage_pte() does for the small zero page, and keep marking it
soft-dirty. A destination VMA registered for RWP still gets its PMD
re-armed afterwards.

Fixes: 763f43865fc4 ("mm: preserve RWP marker across PTE rewrites")
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 mm/huge_memory.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0d589be136d2..09176b290f76 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2981,9 +2981,9 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 		/* Follow mremap() behavior and treat the entry dirty after the move */
 		_dst_pmd = pmd_mkwrite(pmd_mkdirty(_dst_pmd), dst_vma);
 	} else {
-		src_pmdval = pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
-		_dst_pmd = move_soft_dirty_pmd(src_pmdval);
-		_dst_pmd = clear_uffd_wp_pmd(_dst_pmd);
+		pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
+		_dst_pmd = folio_mk_pmd(huge_zero_folio, dst_vma->vm_page_prot);
+		_dst_pmd = move_soft_dirty_pmd(pmd_mkspecial(_dst_pmd));
 	}
 
 	/* Re-arm RWP on the moved PMD if dst_vma is RWP-registered. */

-- 
2.39.5

