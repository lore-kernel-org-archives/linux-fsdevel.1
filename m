Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859470;
	b=lOpvL1+nk5Kg534HUDNoWNtEBUBDxn6cb+FzSr18Ub7r3DZoEXr1rYifgwL7RoRZ33rX
	 wr2FsaqjS1K8aXBj2tv+cKLT82mYytdgnFhpGj3cJHowc4KDhPjIOuSktrhNQpyKJHeFv
	 GgvuKW6D3xUsRsL48tzJ/UXPmnoq0BrzHCeS/SyriHXEow1clXuwrqkAViNsj7L62Hpra
	 kxtq8o7LJFhw9uAk0GUv3tJZZMK4Wngw7TiKdJckVpyjbviUn2Er0Q6Y2XbF33NFAe2Ii
	 ZVd2YBUrjSha2IYI7KznXu4aZTzOSUlAi6epIbDXTwJUOxx1Gi23oEolskaVJHe/bIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859470;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=RP1wf1hEuo72YiQL0ApBaCY3IcmJDKYfBXmWsofzDvU=;
	b=05K90jwKX41/XTsKeDM4uAQO3QsISY0TtIbg/sMBf+V7gkgyEKo9RJfj2xNQpzLJLmRw
	 WjvX7Kzzv+y/VDa4RNhnpYbBjER3PNNrqB3sponI4tPRj38WtxblVtPWDhQDPcxo395AH
	 1Dpk2KdbEL3nPDeJHSgLNeo1iUP/QoQkicaekCg7eYdEx3LgdDJSa+HeMPUJxoAyl+9RD
	 a7afI9wfl5Z4rE7e3qQwe8ysjxLmnRWVGrgdTvco8XcG5AHzqjTbJ8oCDZTqaedASy3Xm
	 jd7saYlCJl7pRCL0TwIKK7XajmStR29mw6dwcqnUOOhUmwPBlcJzshrZ5exxpCKicgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=NeXkZ2oS;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=1RiGQrJV;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EE060A262E
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 20:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27EE060A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=NeXkZ2oS;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=1RiGQrJV
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGJXPxx2058207
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 15:04:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=RP1w
	f1hEuo72YiQL0ApBaCY3IcmJDKYfBXmWsofzDvU=; b=NeXkZ2oSCUmIAaaLYlgD
	uI0urTFRReiqOS0PvsckuTfbI6O7HzwGF99O13+Ri3hvgUi04VyxO/eE/d+9Q0rv
	VBcdlKKP9zpqDVJIsDK6v0hi4ZGLRkpfxN0r2Z26rQfS7wWQY3Q6m8jDuLNA+tgt
	jar/IbiMngx/UXHys2m9quPZl1HFs9ujU6TIAXHJAPANcOmNwjzw+JzZL14wGO49
	jBf/4XOtLGZUY88++QHpxYrcktVlaBRwCsVOJj3d3jj+GFBd/Jtei0DpLMEmlDae
	IDzJhFjzLEkuKdedu13llpY3cU6zUGvCHSXMgTXWNe8d9T/IreVwKLXITU+rBxgg
	cw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j0583j3fg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 15:04:29 -0500 (EST)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7d2c7a903a1so2596537137.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 12:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794859468; x=1795464268; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RP1wf1hEuo72YiQL0ApBaCY3IcmJDKYfBXmWsofzDvU=;
        b=1RiGQrJV2n06j/R/EZz/5BjVtYw2+kNMUvNm24O1OhsW+L1kbfPaVsuK7m38cxBDsl
         QxHU5OEYiNUFvsKdYy6ddZ625+aRs3mHCLMZFOrTxfMzGMsRgcLcjBySjPEimdQlcqix
         Snj4LFuoU2fRORu8n0rrxlT9j7ktx5z0b/UIs24jPsuCJs06fyzfgWrgoe7r2hSHtgTb
         P7RhDQQJT2ACIoSBmAPqbob73/S04Qy9MAUJoG0hS4S9SOAgT9jSxzQvrkbnNlnknNj4
         beoB5hKyafHbdjShDf6eiQ8CMqzwJDXFYFYmrju/O/BAn+tXb/SJ6NS0zY2EEW7QtMDG
         gieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859468; x=1795464268;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RP1wf1hEuo72YiQL0ApBaCY3IcmJDKYfBXmWsofzDvU=;
        b=tK4XMu9qvTqhocKmUm7fB4WlH6ryt3X1b9QVaExHiddiDSSyscT7eRl89lFSexKAWc
         OIZ/5MlLp31kEZShyzXTO5mLCgC+xAGxmWeXP1KAifb8yH/tkCwGQbe5V7gLFA4tNFSx
         EAifpdxNQ6aj01W/ziaULEcD0k110A0DJ3wt1rU/bMT8gVHmzbWGYxihI3h24veRDw/X
         x4DzQHYsJypW/xLt8gJzu4tPYQcW8kfzmlP+NzDiiFxtmYiwhd48ltWTQQvu6hr8xtbO
         +UjmkIep66wmM4SeEsWFLd9WjfnELdW5qzyerdHUn4iUvbZS9orxT6HaXCEyh26sNyQJ
         haYA==
X-Forwarded-Encrypted: i=1; AL+hErG+HMUL8fBgL9Na3UfiO2UPwXMK2REedPOm0XAlRRwksYJdJ5jKrEeoigDDQQzO9I50QOkKYdhQ3cXqU0Yq@vger.kernel.org
X-Gm-Message-State: APuU4Z9tE47B3WEN0NUpq0+HCGfiHZ/JAcgAd0iJUDMLK8OgjE1Ek98g
	P4MG8s2bDSJ/iYyCyOuc+31tV1P/+5mR4mfHlknf8bMi19jI9E9UH3zWBQ942GOFTmDxM8Wqnne
	GqqTWI9vCS3ImyKuRkvkbtAgK36Y528R8i6Ikc1uPSdbniicqXRPbNboD1hhLvNw=
X-Gm-Gg: AYBFou3hoh5N+hNb2FTkpb5At1z7WS0EChAL/Lw1lsVPr0wSiEst3ksakpskXTRhAmV
	PMHxl03kxOuIWHDg9JXzZLkyJ5am1gmXbgR+TJilzbrq5c9Hqhe6VgyMj/MVLSjJ2z4B5CiYTry
	VdYavim8UIjIyIm1rzjKE4w6Zt9bxamDGz+epW3n3xbRQrcqewzA2kjYIj9lSdBCqYUUSZMHpk8
	16dNhSasST+b4ktoGh5MAyjmuw3I+Etpd3y/ZNYz1iN0N+/dAZlgFtIh5EjglyCyaPy5WQT3b2c
	KyONSRuOf2os2/O1nTjrVvbCxIUaHbcnuu2h8AwFcqruKbXY7Wkw9J+riJYLD7HHyVI62TvvZNU
	Mco3lLH/41xOQku4OIRhNmA/etfJrvMkLRk1k1kmhKiKoOOp7GqWzrBWS2/ZxQhVF3DcwxaemGC
	1Iw2JChjgBqgmSXc1pEl0l
X-Received: by 2002:a05:6102:6051:b0:7bf:74c1:b607 with SMTP id ada2fe7eead31-7d64daf59f9mr3933609137.34.1794859468259;
        Mon, 16 Nov 2026 12:04:28 -0800 (PST)
X-Received: by 2002:a05:6102:6051:b0:7bf:74c1:b607 with SMTP id ada2fe7eead31-7d64daf59f9mr3933565137.34.1794859467689;
        Mon, 16 Nov 2026 12:04:27 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23efa2edsm93065426d6.15.2026.11.16.12.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:04:27 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 16 Nov 2026 15:02:45 -0500
Subject: [PATCH v2 3/9] fs/proc/task_mmu: downgrade writable migration
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
Message-Id: <20261116-uffd-state-fixes-v2-3-4397a0196479@columbia.edu>
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
        linux-fsdevel@vger.kernel.org, Breno Leitao <leitao@debian.org>,
        stable@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794859460; l=6344;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=hGDNR/WqM/YeXKLh1H2S+/S9/vDNdjLF5ztTsvussOE=;
 b=QTpWpJnwJIh+mIuTvkIO3+HUHJtrN24GfR7wSh+FX2cPRK20cyW4QzZaaZbm1LdVowblm2J1W
 y50qXyD7ao0CafbW2U7VPMkfpKDGgMVpA5rsNKJ42d4IZB+tSvUSyUX
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: FZWHI7heMnLSP1vrJywVrICgAeigzjdR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4MCBTYWx0ZWRfX5HCrKJxZ6+2+
 Yi1IITz/Je1ddBnSdHtLPG699gO3ilfHptihco73JR3JoNMIrcyRm2pDQAWibMxdeXNEIr/crG9
 5DCEGzsN3lMH85t/xTwX065ulDUo1qI2MXokjO18aOl0zYCf4wD7
X-Authority-Analysis: v=2.4 cv=QfjzLcbv c=1 sm=1 tr=0 ts=6afb61cd cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=xNf9USuDAAAA:8 a=tHa68p0SAAAA:8
 a=lA3VTUfxpHkutY0wpvIA:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
 a=ufIsyHvWW7FwcMbVRpPq:22
X-Proofpoint-ORIG-GUID: FZWHI7heMnLSP1vrJywVrICgAeigzjdR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4MCBTYWx0ZWRfX5qs7fztZ30fQ
 9sqn0HgOGqJU86bS/+0fbidC5YhyiasB5alfI+CyB0HnFvBS4MKE4I+Mas/phukj8J+3qafpg6S
 G/vmSFbypNXqRW956mc2PYI7crhztYttggBwCDVp+SA55sKk1+jNY+VRxg9YfMmH7FLclaB0Mx/
 aUwKH0VtvAQyNaXZvQ679JlazE6RjnZDbhA0XnENR1IvxMyScC4BVZNMmwQQkXyaDeww6/M3is7
 zX8Z+vUgp/gnlbCxnHhcuX9yBjAjB8tnrzPcNjiYUi+NdorwppN4+lMzpNLlUib8DixsWTxI5n6
 aZGMwFJyB8TxqveLq8GOXBosReIP2TW30JlxlyuQUx3SNm5HAytVGHVOTzk7pw5cMH0q7G4L1wF
 L3bUbjYCGBOL4KJkiif9vxCMj+bImOaCv8VpRQx0JS2CnsWWNtUdr+Kr5DyvQB88KTGltmPWq36
 FKalSdnIz2iDg4XodfQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=10 suspectscore=0
 impostorscore=10 adultscore=0 lowpriorityscore=10 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160080

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
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/proc/task_mmu.c      | 40 +++++++++++++++++++++++++++++++++++---
 include/linux/leafops.h | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 164b4efc5e09..ee7f509d376e 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2405,6 +2405,25 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
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
@@ -2418,7 +2437,7 @@ static void make_uffd_wp_pte(struct vm_area_struct *vma,
 		set_pte_at(vma->vm_mm, addr, pte,
 			   make_pte_marker(PTE_MARKER_UFFD_WP));
 	} else {
-		ptent = pte_swp_mkuffd(ptent);
+		ptent = set_uffd_wp_softleaf_pte(ptent);
 		set_pte_at(vma->vm_mm, addr, pte, ptent);
 	}
 }
@@ -2477,6 +2496,21 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
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
@@ -2487,7 +2521,7 @@ static void make_uffd_wp_pmd(struct vm_area_struct *vma,
 		pmd = pmd_mkuffd(old);
 		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
 	} else if (pmd_is_migration_entry(pmd)) {
-		pmd = pmd_swp_mkuffd(pmd);
+		pmd = set_uffd_wp_softleaf_pmd(pmd);
 		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
 	}
 }
@@ -2557,7 +2591,7 @@ static void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
 
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

