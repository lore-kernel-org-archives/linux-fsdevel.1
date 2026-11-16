Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859474;
	b=Wfa9yjY3ts0qgvFN2OdjV5oYrCqvRvwXo9OwQ8E1SUWnlw4LRieBsl/4noGqWLaU4Zr9
	 dFM2SJPUFotKRiYVo2Cg4GUXN/aUgzEKSHJ/jPBASZ4Kc8Dj0o9S0Vw/zpqAYSh8gw3fh
	 b7Dn4/JMOQDeloH16Sa4LwJhio1sNwgWR5d42l098dlU8MPgaFd4IWO5WsGzrNMmNF/7T
	 uXUmoLTJfJkTDWk/Xo+jai/rrxHD5pYnDlrqljOS9CdW0QwH3gXbjwM3jcugQzKIo7s3f
	 8JqtqoHUXiLZ6kYQgE0lBOAc+SbyrFwl34heNEcQfkSwk5E5LEVokcGqW22iT6ZJaFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859474;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=cEJDNGjl/zFe/mV3ACxBqyEokV4hfSJvrPhzPRkWx7Y=;
	b=OnPzxeWL/+0PUrd+yXHMwoaXC80CvrJXvJA/dotIjzyNFA1ibAF7aYoZWihJtRlVPbZz
	 IQS7oai9RQVfj+0l3gdwZDUXpdsYZ/D63Km0BE4haHaSvhHE/A/PCQZ0NRRjkCXlWXHTG
	 4AsA727nehv0SzHjVde+ZV/abPs3IrgsoxFdMfLRWWp7RkFQw9O1Nt4uMg6IvrJLLSMBb
	 WNL4EzMypYEc1lMi+LgOhwayeV+W5FH9LNb4Kz2SEZwuKzBKJuQ6wv37ZtDTHhO79s0ID
	 JVtVlP/EsdvTibOmmTfMTVOS5gQCCvYpnUPvBtkZqkm/1zaQdX+2Qo+KxYTmfx/6CPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=oTB5isp6;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=h9Z2w0n6;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805D3606A884
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 20:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 805D3606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=oTB5isp6;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=h9Z2w0n6
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGJXIV43637990
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 15:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=cEJD
	NGjl/zFe/mV3ACxBqyEokV4hfSJvrPhzPRkWx7Y=; b=oTB5isp6rOQgN5HupD1s
	y4BGu3nwZm5mRAnn10ePdNKEIN3gYVx3MONUfXy6JhoiZr1vCG/+ODN5U0Uo5IFV
	5Y5ybunkPuXxdJv+Z4liVtAy9DqMHVxbF/ABrqCeJR8zngbtp7W/W1p7YwGxVZ+z
	F+CrSXjOcPsAsByfzHsmKk3tDLZnVf/+4u53PZW0EpqD5ldF9jkcl1kZ7nlir9ij
	EbSWPhOEJ2VuWMY5z97JXKHztBOEDiS6JPFvm4/fJWt4Byi36tHSjpsN/i+E2urL
	MMgLH+tQHdFdClRnByM0uoNLgYIDO21moyfeB4PhIybFvs4I8Fkq9BEQOgtU0oap
	/Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j059cj326-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 15:04:33 -0500 (EST)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5363763b556so74559461cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 12:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794859473; x=1795464273; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cEJDNGjl/zFe/mV3ACxBqyEokV4hfSJvrPhzPRkWx7Y=;
        b=h9Z2w0n6BoUpp5FcLCQ5MUqOumbizh6r5jtLh3a8bd6V+GmReTYFYpLgVuMjLoQAGv
         rT/B1atHx2F37mKs8D9LDpHoh+FmQ3+uv01Wmme2yyByWWypLLHyZIMC/uOXFmPWjtCY
         z6o2XhYd8nSs6D+rlcXkGMVqDFX5enuSfa3kCKAPuknkh2J0lg7EscVGZcgVuDveBpXQ
         epgG/kC974yvk6+4pGUcuFpm6OKFOZMdoOt/UE54qWwcwPgwEqLf2oMr2H2EElqFvUVm
         rNjBMuKHRkM45OwY5n5/JmNfqD0+GAfjjEZegWXTKYX/EBUnKM0bajNbfdCyenlz7xT2
         8l4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859473; x=1795464273;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cEJDNGjl/zFe/mV3ACxBqyEokV4hfSJvrPhzPRkWx7Y=;
        b=L2+02NiULr0YS7sABrFZ6sp6Lqdpt4A0z5K9I2OKvwjfxh0jVkfeC87OJHhzvYYNgn
         /Xrbniu7eFN9NJdKB/IY7GqyM0/8gwHdoMpEqbBnDPyFe7iTgEJdNvU4fmkIU61AeiRH
         F03aVF8vuP9LPZIGual+0S3HUkS7TfG1YtT2gj5XfoQ6V9UkfUdDzy3KI9Zba9UVoM//
         U/V33bI1ezv2bCKAmp9FHMI9UKnu5SJdPbMT3ua6mfykxnfLph6b2Z606uroEcJFladS
         jWQqwx00qJNWUGvKQktx4s3ouvhSSIvzRpwwVywd9WUcuv8wWvyeeDmO56vgwaWQAy4d
         MQag==
X-Forwarded-Encrypted: i=1; AL+hErEeKLEwxzohFtNjftp/s5zex/KpQoTxlDhNp/1K3MhFs1a1+bMMkJypNTrEAnOZNghSGZXTGHNBnXNwtw7D@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ze4hu22tJtZHNZHtHEEe3PpClyOaEmSq/pF42rXd/RGsJtZ1b
	mlUTyIEKnRZ79CfM6YICt4qbMG88NwGwm4qbqFVY3UmMcRSGsVk/HY78RK2McbuFqbIKlqAF53u
	Tdb2Rdzrp2bfUNiOB/i0wJYaaBvS93u1YAFNL1LPvhx03d+LEVGB12QfAZAFGeHU=
X-Gm-Gg: AYBFou0l6NkH87tBmHXq/Ab7FI8vwpTzUnm4uZU9Wx9+Sxxxv4baUbhoNG8CUdkSO/P
	L/Dqboey/YmQ0HYF/vCxuhn9HDI0ZP0EVOkoQgfmlyeGTGNT4NRr8PUPrAY9K6S6AXed4z33j0L
	YyBtXLJFiuG1hftL9GTdw1F/kVgBNlzdq1d/4ucQBZgcv9tPbG1Yu8TZfd5gUxolvhZBoL5qdrw
	mEtP7DY84HpwVNSu3rIUSywAsdR3Dfd5J73L4E5meNncQ/JHbryz9n13MsjZhtScdKHR2VS9Vv1
	M6riRrcVDhcLKh+07Ofxlqpq1BMG6TUprYsh7M3w5qUlMwSYt8QxeIWnPfklRtkOsEqTdzTq5OD
	LBjpC47A9c0pK39p2qVjJ80lMxOqcke85NtCHvO4yfcjBTpaUJE1i/CP0Zf5eBsoc2Ulw4YWRUb
	Qyj6sNqXIAqZ/JnmNgrLCn
X-Received: by 2002:a05:622a:4c13:b0:55d:33e9:59c with SMTP id d75a77b69052e-55d33e907efmr87730611cf.15.1794859472571;
        Mon, 16 Nov 2026 12:04:32 -0800 (PST)
X-Received: by 2002:a05:622a:4c13:b0:55d:33e9:59c with SMTP id d75a77b69052e-55d33e907efmr87730001cf.15.1794859472014;
        Mon, 16 Nov 2026 12:04:32 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23efa2edsm93065426d6.15.2026.11.16.12.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:04:31 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 16 Nov 2026 15:02:48 -0500
Subject: [PATCH v2 6/9] mm/huge_memory: build the moved huge zero PMD from
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
Message-Id: <20261116-uffd-state-fixes-v2-6-4397a0196479@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794859460; l=2165;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=Mw0PGqcdwi9MrYnN+IL/vE+jWvAOLk08il/P1XOxvA0=;
 b=ZziwTlLGLXjJcZArbTKseqAMiRMaN6WrcRvEULuLwzlevKpQUgbaDRMcTir85gnBILUj3uHSp
 YwvXpPYhyURDOGJtHeuhtt3mq6thHBtLeXk+Ex6SOWTGGj2RGQxXsJN
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4MCBTYWx0ZWRfX3vlogvNwbybX
 k/+nmQHwzifGKJ5Dz/rQ7wgSnZ120/pEmLjpYimWe3JbcuDool3NJ7njFAG6/TkRYR1bPh3g2bt
 HdKP2dX/eR4QBa8bF+l2jKaY8g1vuLgTW9ImCUJ9PEOJL1ErtWtX
X-Authority-Analysis: v=2.4 cv=MsPHeGae c=1 sm=1 tr=0 ts=6afb61d1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=VwQbUJbxAAAA:8 a=tHa68p0SAAAA:8 a=t9wnRcJLD9wLKarOqGUA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=ufIsyHvWW7FwcMbVRpPq:22
X-Proofpoint-GUID: jlLwUWYCv6lT--0tgs6QI-QXdqaw6sVi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4MCBTYWx0ZWRfXznT6W3+9aSyZ
 Ob+HYF1skGehkTEp3GtbdL9xLquRZX+tHBXRK5aCAhcvB1bmRYHNiMo3mq/crQq56/AWOBM/GP+
 iuWmqPJPRmLX2PlLVaXax4iptGLo8BpPFj/13GowCeby+BcFQTVAQ1NI9x5PuoEDbelJZCfdUMx
 YeeH0tai5fFbJTa/Nul6BXaAKtPOMQKgvszK+6c5a+Rm5AnfokRquxnl28SqnrMKLg2pR2eVOZv
 UmmOjGOUxx6LJOhJ5imMFexyjJ2wmhZIjggErsqHgP5nNry20+dO6VnXXEOseiWnb6d6DHOkMHy
 1M11W56kFa1U+y6zS8FNfBsD6rnywZYSZHULvr1rb/RFbkn6DPlinsAJMiii6eBkp/4Z43P6qYN
 GfTVGuAFTt4ZrDYj9whAYRG28a8f5Nm8zI21tyI6i2IbPN+39pUQbCDAm7KYXLBF/PygD4qPDK1
 gOhHGzspiimaAcwdy7w==
X-Proofpoint-ORIG-GUID: jlLwUWYCv6lT--0tgs6QI-QXdqaw6sVi
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=10 clxscore=1015 impostorscore=10
 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 bulkscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160080

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
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 mm/huge_memory.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5e2629602221..a2b1ac11e7dd 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3003,9 +3003,9 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
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

