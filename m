Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859473;
	b=PQHQrgl5Y1+862epi/6fe5uJ/ejMB/hSKsCXNB3saqjLX8zd87OoS5HJyHIuB3Km6x/s
	 TMq29iuvoUBnmMrvw9BHfvEi0AjPEyajOemCmmr96LNuJv+4drYLjEyLAnUj5hgwLg5Fn
	 4nmc0WvdvYQiMkQxzSKXVCVO+WBLdfRhR94CopLX4B38O1y7XJ4S+r015GTSsEmXHWZxI
	 ntsSrC8CSjOFPwM9LsQfD8URQ0Zceue3PGVNCc7TeCCdiYMHCA0jhsEN96qhTdGKbvpIg
	 2UvXmjiNDqeA7Gwqx6jcz4jdhO/I8Cu1OMSJB4dtpe+73Iviuq1Unb9Cib5uQeT6c1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859473;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=CQkHPjvXTTfeJYiMDE7iqXQPlSmcQWagnsIUKGmFjtY=;
	b=ZtgNHxYXmlOHlCgs0xfpGe/NbWFF4vgY4heN8A+tWuYZmEuwY+UIepm7VALbo94JNdd6
	 ClfXYLA1lCscYGnJ0oGOAfr59oi9DVSPSrsNhEx4DnxU14s6mkpR/P34F6NeLFDL+YVd4
	 6r1lZr5lkfqynJCKF9xd2dfE/NiL/tk3aTdP6Nm/OvEG2dUQLY8/Z1lb2JsukTghGLQGa
	 6Tp8Q8Cy9/AYlHNx2s3o1kV+W/H/wHfvm2BdI7E8FmdYp94YMD8NLa8J4FGAguYtRp2xm
	 ccwbUMq6H/E4w4YI+Iri2ReEREfUJYg+E+ibYLN8c3AdFoh0d2IiwWipnMFaeBBu1IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=KAnwt9fk;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=qFR+vGaW;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C37660A380E
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 20:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C37660A380E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=KAnwt9fk;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=qFR+vGaW
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGJXJLU3802044
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 15:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=CQkH
	PjvXTTfeJYiMDE7iqXQPlSmcQWagnsIUKGmFjtY=; b=KAnwt9fksP0cEvD3SzpN
	9AHr1JD8YwIZZF7LgL34k+/R6ExO5rgOpJUVstzTUm3dJ4FA3uvt7DqyIbplzF2f
	Qbyr4yt+DO3jQvpkf5GuJBfPa7QjJuhiXKlJmkylAWNLQlXTkXd0qXCKm/S33A4P
	R/e28+69oSVVV1TkO/OCPmTh6bKgFR9BezPq1Zg/ebPl6xQ34+Vl1eRO/xJyv8mp
	wpeZTs5qT5F3ut1t1JQz+4YL4reEX7etf8mk+c7HcTyjSyFgzg/kxGlIpRaen5ib
	4O17GeTpbLBgeQ38VvM+3Fcl0TK7hH1BjriAXPGOM7HYLZOLyvwuvStQZYnxA6YD
	PQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j0598t3ex-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 15:04:32 -0500 (EST)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-920f6bb141dso10248956d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 12:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794859471; x=1795464271; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CQkHPjvXTTfeJYiMDE7iqXQPlSmcQWagnsIUKGmFjtY=;
        b=qFR+vGaWBzqlL0ZktK6BD4Xkpn7t9hy8ooS/yXgPsSHQ1MFDkoZvtPAESR3qvvSCB5
         EbkSuhacDf3w9b0iD6Tpov1lW3lEUvnfCibIa9yOOMg/9aIFfcRt529Plc9jatzlBTz8
         aAY+tF5ADNgSvN/Xe7lpXt/gRmNC0SUYXpMN6R7CyRbkEhtYbEXkiNh76ruuXUv18Z7f
         0FLh8rA/toj50K5xtul9rvz3KcDZ8bt2NXXzrg99JqU4ASDnHDRG2EUffhGMU1OIXiaZ
         wPKfvtvt4awYcaU6ZegvA80s1OFX2YQZ2V1RxqlSNkEKUZ3Wsn3dYK/7AjI/6h7icryU
         p4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859471; x=1795464271;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CQkHPjvXTTfeJYiMDE7iqXQPlSmcQWagnsIUKGmFjtY=;
        b=S+ydKZz4L51sGPc0bg9zNuYZsa+MJk0bNmDTXqOIsDqilQHPliN7kT2T0ZukhfQAk3
         X4uni4ABXUKQjfzlicLa7dIc+m0AWFOBZle0uSGWKAMd4eqSmjMlGndpn5MWQ4fiYgL0
         t8rivyqASPvq1MrhPn9+blKsZAghpmHiEuRZdahMuXjH6053DQ/p5bBQpJ0/i5AN4BEa
         whrTmPlGWT0aqdAiI5nRkjPD4vnzOKRqhcsyj1B3m5a5b+L94iOgL7xRnsAf8PdldzR8
         kQMqHm9MJPNYdlaM9bZByykMKFGMdUvAu3XNTkVfEYmtWUWA+XNtUu78OGLkdhR7h3Nu
         mZmg==
X-Forwarded-Encrypted: i=1; AL+hErEHYUaTpMxUbLq61wZbSOV48X8DDh74WXZkOSuRHnQ3fR5cgbb+MUfIJEUuWX3ZC8ven4kijv6UkoIEveE6@vger.kernel.org
X-Gm-Message-State: APuU4Z/aWZirUpB6F4HgIMnkdYjkwSlFZLkqiLV9jbD2Ko3fZ128vvtb
	hLW3cHRewD9Dx3w2WDuIMe8EpHVCBQaGl1Dbj47c+TWrQSD5QZbLQKg4q9EhMl3FtZycZzZkTXm
	8h8N3Y5GXTQWFUQu6bZ5AvBnI6ATQdGpKb+CcvAre9YLxmsHyH/6X35eMZDr4sFM=
X-Gm-Gg: AZFdTZdnWSRdl8MiriHFqBmcRlKiAvBKKNZiyqrencaRcphHqVcK6cZkPQb6wdVmorf
	9UG8rCRCKESipEZ1549Am8e5oy+fbSxRoyw0ZeyywTxWXIn1VQhoE+Kt0T0JfvnnlPby7dGLWf9
	R8UKFsmkzCc3soHfrlYm2uhmaQ4//KNPVpd7UFNLzpvCdgUZxHHFc3tvXC9MhOBBs6eyeb/MIsz
	ii5ecYK4ljRzkx8n1THnpTco/xGQdlIjaPE+pbnXfo6BNmg9H8sHR/9Nkr0OelLB1AAVddy5aKX
	LS5Em7PkUzuuT9iaLSNX/86T6nrw3jZ3U34st0hNAm2ZTGNaaRwXn71wTy8T/FXAchyEtJzOEDJ
	3Ey4u5s9scX8IWnARW7IJwqM8tnKCFq77HReJst+rLDr6NDmXxSp0iYiYF36C3u20BX4FKetxSI
	Y9Ck2QQUtjjW4+t5bnuUw6
X-Received: by 2002:a05:6214:1c0a:b0:91c:359a:3263 with SMTP id 6a1803df08f44-91f24025642mr190254426d6.7.1794859471103;
        Mon, 16 Nov 2026 12:04:31 -0800 (PST)
X-Received: by 2002:a05:6214:1c0a:b0:91c:359a:3263 with SMTP id 6a1803df08f44-91f24025642mr190253756d6.7.1794859470498;
        Mon, 16 Nov 2026 12:04:30 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23efa2edsm93065426d6.15.2026.11.16.12.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:04:30 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 16 Nov 2026 15:02:47 -0500
Subject: [PATCH v2 5/9] fs/proc/task_mmu: write-protect device-private THPs
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
Message-Id: <20261116-uffd-state-fixes-v2-5-4397a0196479@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794859460; l=1714;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=DVXYKxTIAEZp+EXI/8oQ0I7+4ALNcq1SSndANYXncjE=;
 b=6+ELPvQGdStv4nKd8pN8sVCMbZBLqnzKv/qqOoM+QS9mkKkH9crx080ucQzM33gtlLJ8mzVNp
 0+Vap0ml9QVA7VLHR+Fr+p7Ra3EaXSyU+Vivwbom+Y1nClSCxWJsRg+
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: SWSfuKIWmKlTsPnR-fKkFfDoLAqd0JIW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4MCBTYWx0ZWRfX+wuuviLjl51Y
 D9cm5rFS770nOqTo27CwjQtTilJmTO570mKGP//NLO0ai4DBpxOiXpHx/X4jLzAY5pCV/QgAcgz
 OwV3PvT6RYdIbV6XdGr5UbJl7oiZfIH0sOHQnEQhE68awe67mfE5
X-Proofpoint-GUID: SWSfuKIWmKlTsPnR-fKkFfDoLAqd0JIW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4MCBTYWx0ZWRfX7VRs3mwj48yg
 gRZlDxsk8lLCKOMuqZqG6pKjX9xdIsiWZJUaImt4w3B3xQeaLWScfnrzwO89/XCN7mMA55vUntO
 PcTuuHysRE6OqJTDSPEWfb6Vt5+Oir6OuO0PU/2nPd3R7PsdInSSdZ4XMCls4tcjG89KTuqo/9L
 QyJe5xi/QnagMzk2IqLZl72kZd/qvCc7yDJORqNMnPjS1wHJs9VQ/9ZxlI/T5FeZ7KCE5eMZB2P
 /IqFHGHbdfo5l2U3ugU31x2o5gDuW4jUA40CyRPPbpglV3fTAEGpWw02qxmWdbJSsrLVELdropd
 9bgW+DNzwi4cLxq9gXLbNf1syt3+g77fK+4PAhuwD2AYXSSlodkLz0H7SapE61Ke7rF6ZlVRu1E
 QYHNudvfqVoRCl51lXTLHit7/XXh+qCyKAJ30nN+z+XtIYQR1eAhrvk9eYowNq4v41/8zxvYT+K
 RdOrsaGX+rP+iRjNCNA==
X-Authority-Analysis: v=2.4 cv=ZOpCCn7b c=1 sm=1 tr=0 ts=6afb61d0 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=tHa68p0SAAAA:8 a=RyLRxA_qM0uo8G8YelwA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=ufIsyHvWW7FwcMbVRpPq:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=10 bulkscore=10 impostorscore=10 spamscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160080

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
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/proc/task_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ee7f509d376e..013eeea7d1a3 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2520,7 +2520,7 @@ static void make_uffd_wp_pmd(struct vm_area_struct *vma,
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

