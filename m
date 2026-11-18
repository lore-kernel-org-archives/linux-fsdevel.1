Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794976161;
	b=0UKdnixWJ5z2V1KNY06ZpzqQGAjDUmT5hTHBg010/oiC0lG10G2w3RbetfH4GSz3TjnT
	 XDVjdF3wrLoyJPgkD2F8YO7bSaIRX+ApivS74NQGk7r/nviAVIszv6kDWEXbLAi1yCADB
	 HTDKxWcYoX3ohYZyMbcj2riLP+3xKPdZAD2DTy0Kd+3fAXkx5SvY5djH4gAywHR+n2zjS
	 08J2ygSpYUH+ypZfxEvE5GmPf2O87IBXPdpWBhNtUo1CPf/8EqqT61tfd6vBzHuD5xX/A
	 7cJ91YSsxt3ZOt8Igrt3KH+3RQTvHEBQJb1HK/2L9SpS1pgNSycQm69q7fjqbXHyuhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794976161;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7289YXaM//7fO3vmjy0krlSMq7JNI/I55b1Tqrw8TVE=;
	b=XXOJ52joAOoFzWBnWuyP9WLv5+xl9w6ky+FrmhhiKSSar2LqgGl/nEa97JFqG+Ocxkvx
	 8kDVK+ljluZCBQPhAmHIgZgIf3WqFNvHQl4hAAo04tx18W2yRL3ynPJaUZ3KU4zN7M+0O
	 NMvmEbtXOv1sdV5vfTJkm8ibhBXLYqC5BUGdQfe7QlFS58B8DAgyzF0WqC7QGtcuiy3pR
	 6ckp2igxKC9H5jGVGdCgGKz2NqaCKPEzRwF04SovT4K+DgmtOtqbFrMzbcOWs9P7C4GMs
	 xeaBDjfwMbbuTbAaoTc6j+79WnNpSAE1X0Gly8f2L7DXY6ZWRXeB06vQFqr17MYiQRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=D+tgjc3n;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=SYZlEQmO;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912AB606A881
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 04:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 912AB606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=D+tgjc3n;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=SYZlEQmO
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI1XshF3918537
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 23:29:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=7289
	YXaM//7fO3vmjy0krlSMq7JNI/I55b1Tqrw8TVE=; b=D+tgjc3n5T9eWM1dnAI8
	vg/1W/rALeZZWof3IhNmi7Qs0A9z81k3nfwgwKFoomptRfUvp3966Milx5QG5Fkn
	0RIYkB68ie15ZAXwrzvEk9ZoyNTU1w2rYiIUqscHDmOVemogrQM4IoSUkjfrftTi
	q0+ZUlMpXiUgZ6Y503fUScF4XkAR7inxnzHIragKKjuNUXpuhfk2lW3QO8plWbk/
	UGKIXAFV0UP3PN31BPX0u/Pq6KMoFrCoTxSs6067IUDImCgai0XA5ZMVELxYPzT1
	lMdOYG99AiCwLbzfKziBzXg+bMDS9ej5ILKWoRYMtEzMV9rt5wTF8wjIaiyheI5X
	kg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j0yu99f16-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 23:29:13 -0500 (EST)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f2c0e6653so105728985a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 20:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794976153; x=1795580953; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7289YXaM//7fO3vmjy0krlSMq7JNI/I55b1Tqrw8TVE=;
        b=SYZlEQmOh73L0F9rwoBDMxVf9/DNvCZMzrQGK/aJt/Sqjznm6G9wCBCmrL93SWhL9L
         fkELmNpHuE5a3RaaTma9CbpHNmAAkXJK1t7HQ0ANBHwlIDIA8jCl8kN/fFm7NCrB5lWK
         us+p+idA67FFVOZ2Amq1DU/yea+K/rkjsSIH2PymePVvJEClntvA695C5mWCqTmuuLrT
         Udxm44ET+rCvREaw6rkYiTPUB2H1RJ0d8zpLgHUaFGvrlsA1wXcqzoV5I5VfoXw7PiBl
         ++zVSKBSEQcZFZLMpRRXaKjGgcpUMX5qPa0bebj7w74xA7I/Wp3WlgRMFBLH4aw3SbPH
         Bwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794976153; x=1795580953;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7289YXaM//7fO3vmjy0krlSMq7JNI/I55b1Tqrw8TVE=;
        b=rpWW81NUU1MxlWrXySfuppc71G46W1Snl+EzEe3Kb0RzBK5+zSyVzIuoeH/3zjhtHT
         U6QBI8wzfG+R12/st1jlXGwTZdSG8YJBN/kcuua0TR96F73Cs8XNJZcbu8MMs5uSkXwN
         y7lAlGS1V5wjbLh502xjzY5UkoVmtPfb+GClGVSF70ezcRJcalrGSy0dE4Z5UAK+eQFx
         XF0UaO6As7A8NJzhNKVVr2BRSzpIDpQjGH10S+XBSa3BcvXZAyNxaxKLMnp/QRNPu8Ap
         UzeITK+0asPiUSbV9IMFMq0aGEefVKGLe7qEhDnb6j6rkJDusKqLZxytnyL2WL6WupQM
         3Lxg==
X-Forwarded-Encrypted: i=1; AL+hErHIjRkUYQ60ykJVdn2y4uyBA2qINvSYOh1dvx8J+5byUcexl8FT5zIsDyJKqydWB5sJKw4KYZomZ7VD5qPC@vger.kernel.org
X-Gm-Message-State: APuU4Z/WxWPj13ijM1KmRyaKZrlo4+1xs40sKUCgX4Ml524m3jKLJQg+
	T9/GekGFRyjlMYfXIoMX7FRg7RukWiBYyB9xnY0K13Gr2syM2Sui8cDMU56Y/w3lHWQeXSVg/SL
	myT2jVTbnaMsMp4pnJmKzto668lm2axn77AvwOCWfY46rTUyXVXt8iychJWOMBiE=
X-Gm-Gg: AYBFou1vvk1VPZd090qwkP48TVjfRLpMCKa/QjV3Na1nZYowgZwTdL+Gq/8S7sw6lSY
	UabtT1dW1IEEG1W6L9WP2I5O8SGTtd8yHsGnyVlCNHwoEUX/BcnObT/7xA+YtYvcKX4CKiEt8ZN
	q4uXxbCeNCkMz6gd0EwOOeZnU21vsVSlzJvc8BsiTKBwxpqt5Iat3dy3muxszaphJ+/h1Ispotx
	3Vhr6rwAAOj1tlv4q39581liffSwO8yG5mvIChEJZN7OSpQqRxRHSe0yeVGrirmEeqp6b38GKTe
	n3dSn0ley2bxZVNAWYYMYIX9fcOWPH7ffFACubbxYvKVacMQnCokcEtBkc2otLhV9o18jACEo8Y
	2ePFXnBuVrcVcrGjQnLIofdOhddgSDSf1ZFuDvO+Mi3pFZ569mcavDzrmw4PUKofEeWKTK6tDp9
	sLDFYOoceroNnL3oiBJQ==
X-Received: by 2002:a05:620a:648c:b0:949:7118:47e3 with SMTP id af79cd13be357-949997ae5aamr287928785a.58.1794976153370;
        Tue, 17 Nov 2026 20:29:13 -0800 (PST)
X-Received: by 2002:a05:620a:648c:b0:949:7118:47e3 with SMTP id af79cd13be357-949997ae5aamr287923485a.58.1794976152909;
        Tue, 17 Nov 2026 20:29:12 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b743a8bsm89678085a.17.2026.11.17.20.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 20:29:12 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 17 Nov 2026 23:28:43 -0500
Subject: [PATCH v3 3/9] fs/proc/task_mmu: downgrade writable migration
 entries in PAGEMAP_SCAN write-protect
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
Message-Id: <20261117-uffd-state-fixes-v3-3-b617009d1a4a@columbia.edu>
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
        linux-fsdevel@vger.kernel.org, Breno Leitao <leitao@debian.org>,
        stable@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794976146; l=6398;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=Z0rU5WQNPjJ3mHksKsJWDJfedbCcJMJetTMLG2vLB2w=;
 b=XRNKM1Ps7CsF2NIY2cPR/5N7gPAIoUgLViuopj/ZmKmBllYfk7tlQClC7AC3NNR5wpkG8MLS8
 LI2kMb+hAcEBcaRAuWV9rfWeSrlnYobKmxBRbHlHaNma8CQAC3tZJq7
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=S6FMU4sP c=1 sm=1 tr=0 ts=6afd299a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=xNf9USuDAAAA:8 a=tHa68p0SAAAA:8
 a=lA3VTUfxpHkutY0wpvIA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=ufIsyHvWW7FwcMbVRpPq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAxNyBTYWx0ZWRfX08Z43Vgk2kr0
 rbhklIH1PmUDnyiTKs6ReYORGXnkrzolsEvMhZqTq3y6PcTKM9im+Bwpjh81thmT+xwa1w9g53G
 NjyG8devb1zRTct1vd6L4ashIf43q4gQ0Lqw32kTUNkgli/DXkCzvOx6X9O8ZrNzhpDlRwTSrNy
 7qpYprQ3MMRhfZJIldk0Jx5dm+Iqd1DpV+fL7iTkQUGzdKvwRYySEOU1vqR3KWpow2mcelwY6oj
 JXzANGe+TD74NPVkHbCgmMZlCRIwavFZzl/cjCrRe8EvM7GaeChTLidP2UxauLll1jKEn5le7nB
 YCpeyvjt9FNV73Cq1dn4zkLvpgFwBODauzCJwH3Ax8G3LmgBev+b5DCxH3RwBIL28rOtCXvMstG
 xs5/uMu2whtuxn6NdOxZzs0has/4hhN+OGD8lrKzB6BlOj/lvhGAUh7U3CtHIZlD9p3x289+czX
 7pvdiHvu2868tVmjLcg==
X-Proofpoint-ORIG-GUID: FNgPHcath5QoY9LliJZNl13n52oyJEU_
X-Proofpoint-GUID: FNgPHcath5QoY9LliJZNl13n52oyJEU_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAxNyBTYWx0ZWRfXzmWhmhwJekW5
 e51LD1IKtIETkoLOova6UWJJlbmA7w5nztPROGLOQ9+meeRrqbmrNV/P5F6Ki9V0ZHcoeNJA3lL
 21pjJtQAOVzCyVypf8JHa45N5N3FkA+sYPQaa1Gjktn6OYAPsESh
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11969
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=10
 spamscore=0 lowpriorityscore=10 priorityscore=1501 adultscore=0 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180017

PAGEMAP_SCAN with PM_SCAN_WP_MATCHING write-protects pages in a VMA
registered for async uffd-wp, and sets the uffd bit on non-present
entries as they are. An entry with the uffd bit set must not be
writable, so that the page is write-protected once it is mapped again.
change_protection() therefore downgrades writable migration and
device-private entries to readable ones first, but PAGEMAP_SCAN does
not.

For a writable migration entry at the PTE level,
remove_migration_pte() restores a writable PTE without the uffd bit. So
if a page is under migration while PAGEMAP_SCAN write-protects it, the
write protection is lost. A user tracking writes with async uffd-wp
sees the page reported as written on the next scan although nothing
wrote to it.

With CONFIG_PAGE_TABLE_CHECK, setting the uffd bit on a writable
non-present PTE or PMD also triggers a warning.

To fix it, downgrade writable migration and device-private entries
before setting the uffd bit, as change_protection() does, at the PTE,
PMD, and hugetlb levels.

Add softleaf_is_writable() and softleaf_mkreadable() to leafops.h for
the downgrade. The open-coded copies in change_protection() can be
converted to them separately.

Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
Reported-by: Breno Leitao <leitao@debian.org>
Closes: https://lore.kernel.org/all/avNEgmvYdoukt6MS@gmail.com/
Cc: stable@vger.kernel.org
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/proc/task_mmu.c      | 40 +++++++++++++++++++++++++++++++++++---
 include/linux/leafops.h | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 22361607020d..0127bf9c3f77 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2395,6 +2395,25 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
 	return categories;
 }
 
+/*
+ * An armed entry must not come back writable, so downgrade a writable
+ * migration or device-private entry before giving it the bit, as
+ * change_softleaf_pte() does.
+ */
+static pte_t set_uffd_wp_softleaf_pte(pte_t pte)
+{
+	softleaf_t entry = softleaf_from_pte(pte);
+	pte_t newpte;
+
+	if (!softleaf_is_writable(entry))
+		return pte_swp_mkuffd(pte);
+
+	newpte = softleaf_to_pte(softleaf_mkreadable(entry));
+	if (pte_swp_soft_dirty(pte))
+		newpte = pte_swp_mksoft_dirty(newpte);
+	return pte_swp_mkuffd(newpte);
+}
+
 static void make_uffd_wp_pte(struct vm_area_struct *vma,
 			     unsigned long addr, pte_t *pte, pte_t ptent)
 {
@@ -2408,7 +2427,7 @@ static void make_uffd_wp_pte(struct vm_area_struct *vma,
 		set_pte_at(vma->vm_mm, addr, pte,
 			   make_pte_marker(PTE_MARKER_UFFD_WP));
 	} else {
-		ptent = pte_swp_mkuffd(ptent);
+		ptent = set_uffd_wp_softleaf_pte(ptent);
 		set_pte_at(vma->vm_mm, addr, pte, ptent);
 	}
 }
@@ -2467,6 +2486,21 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
 	return categories;
 }
 
+/* Same as set_uffd_wp_softleaf_pte(), for a PMD. */
+static pmd_t set_uffd_wp_softleaf_pmd(pmd_t pmd)
+{
+	softleaf_t entry = softleaf_from_pmd(pmd);
+	pmd_t newpmd;
+
+	if (!softleaf_is_writable(entry))
+		return pmd_swp_mkuffd(pmd);
+
+	newpmd = softleaf_to_pmd(softleaf_mkreadable(entry));
+	if (pmd_swp_soft_dirty(pmd))
+		newpmd = pmd_swp_mksoft_dirty(newpmd);
+	return pmd_swp_mkuffd(newpmd);
+}
+
 static void make_uffd_wp_pmd(struct vm_area_struct *vma,
 			     unsigned long addr, pmd_t *pmdp)
 {
@@ -2477,7 +2511,7 @@ static void make_uffd_wp_pmd(struct vm_area_struct *vma,
 		pmd = pmd_mkuffd(old);
 		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
 	} else if (pmd_is_migration_entry(pmd)) {
-		pmd = pmd_swp_mkuffd(pmd);
+		pmd = set_uffd_wp_softleaf_pmd(pmd);
 		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
 	}
 }
@@ -2547,7 +2581,7 @@ static void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
 
 	if (softleaf_is_migration(entry)) {
 		set_huge_pte_at(vma->vm_mm, addr, ptep,
-				pte_swp_mkuffd(ptent), psize);
+				set_uffd_wp_softleaf_pte(ptent), psize);
 	} else {
 		pte_t old_pte, new_pte;
 
diff --git a/include/linux/leafops.h b/include/linux/leafops.h
index 4c1476ae3234..4c016fc28690 100644
--- a/include/linux/leafops.h
+++ b/include/linux/leafops.h
@@ -434,6 +434,57 @@ static inline struct folio *softleaf_to_folio(softleaf_t entry)
 	return folio;
 }
 
+/**
+ * softleaf_is_writable() - Is this leaf entry writable?
+ * @entry: Leaf entry.
+ *
+ * Returns: true for a writable migration or device private entry.
+ */
+static inline bool softleaf_is_writable(softleaf_t entry)
+{
+	return softleaf_is_migration_write(entry) ||
+	       softleaf_is_device_private_write(entry);
+}
+
+/**
+ * softleaf_migration_mkreadable() - Downgrade a writable migration entry to a
+ * readable one.
+ * @entry: Leaf entry, softleaf_is_migration_write(@entry) must return true.
+ *
+ * Returns: A readable migration entry for the same PFN, which is exclusive if
+ * the folio is anonymous.
+ */
+static inline softleaf_t softleaf_migration_mkreadable(softleaf_t entry)
+{
+	const pgoff_t offset = swp_offset(entry);
+
+	VM_WARN_ON_ONCE(!softleaf_is_migration_write(entry));
+
+	/* A writable anon migration entry implies AnonExclusive. */
+	if (folio_test_anon(softleaf_to_folio(entry)))
+		return make_readable_exclusive_migration_entry(offset);
+	return make_readable_migration_entry(offset);
+}
+
+/**
+ * softleaf_mkreadable() - Downgrade a writable leaf entry to a readable one.
+ * @entry: Leaf entry.
+ *
+ * Returns: A readable entry if @entry is a writable migration or device
+ * private entry, otherwise @entry unchanged.
+ */
+static inline softleaf_t softleaf_mkreadable(softleaf_t entry)
+{
+	switch (softleaf_type(entry)) {
+	case SOFTLEAF_DEVICE_PRIVATE_WRITE:
+		return make_readable_device_private_entry(swp_offset(entry));
+	case SOFTLEAF_MIGRATION_WRITE:
+		return softleaf_migration_mkreadable(entry);
+	default:
+		return entry;
+	}
+}
+
 /**
  * softleaf_is_poison_marker() - Is this leaf entry a poison marker?
  * @entry: Leaf entry.

-- 
2.39.5

