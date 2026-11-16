Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859472;
	b=L9XpPsjPEt3T2dzL8Yycn2JtvmjcuWeeaEYg0RkIpC3UMB7SImPC8VsEK51WQDV/ecnx
	 2rbw3r6JYN2MKIJ35+H9lfHQu+Yy+P1g1pOYWomtvmpUm2MqdtmeqzU2oUBh8+VqtF50v
	 C/auFioCLWaip//QFQ9CgMm6CGTOTcZXKLiU2Q4vcS+hGiVvCgSSdsu/TZjYDo27ehHXB
	 AocrCF2684mKoPqIYqttRSbezwCHXEMNUOjekxpUs8hiQ8wf1FEGGiGA06/pwIRoMSzk/
	 GKVFrWP+svQE6yxKYS4NQL0XcVNGz8HYBB8KzFmd7CuHw4MZ9pXZKwfX5nBtDXPQJ0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859472;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=2ioUD8QeW/Bl2QsONQm9YVJC6hK9MPeWajyNk7zYtP4=;
	b=WBTmHiBDLbBsBVQ8+nk0P4sW7Z9WEOBXyhfWBPxq/HkflPecwp077vSpG6F16DNb9gXt
	 ELOFUxFC9s4PU1/xV9g0a6JRTppNf554jSTKnteK3KNIwClBJ5HSnw0LtAgHMfhVvBneO
	 +VHpAOcSkzfrhOLx+mV/dYrAnXLX1ePKggdAcJ5XrIKQsAO8Jk0F8cHs3ZdU2qUlN2LW3
	 BPoQvLe+9kqVJV8OyAtmSYG8zP46qW1s9rE0QwWKahU4F8aWL2aRVJfiKAzB2B248IYt7
	 mLn0LlnMpPr6n6WvMGXmTEjOWZ/mRNa4KvjG1M8GafqIvcgAjBftF7MT5M2maxqIr5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=rzKcPpLP;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=1tuiDLri;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1727606A8A9
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 20:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1727606A8A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=rzKcPpLP;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=1tuiDLri
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGJXRRm2058683
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 15:04:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=2ioU
	D8QeW/Bl2QsONQm9YVJC6hK9MPeWajyNk7zYtP4=; b=rzKcPpLPPjOBbfptWMeY
	KHBzukkwaGB5Pv6nbCYgFY2Oh4WwqTg9VRMTGxWKpUEyaA6PBzLi0v8FFWNZZSOz
	zh4/jwq4U3HmxAs6MHf7veIkmGvFQpNRuI7fvivypEBG4JTsSb5QUS5ocd9d2nth
	F91XJTTFa6DPCOQtFYeE7aLYtyVQZAAXD1IsmWH2zezJ7V3L46Je15bu15deNoXu
	/ne4yXvHiYnwd0MNHqVU5niignlDu3cN8QfUyKv66dUUsEgqKm727DtTCuURhIUa
	slKFrd6eHVZdFDIDPbIzNhgdGX3wx/eRm1UVIZrHoc1bkUQdj4GzaWC85jMSaI7O
	8g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j0583j3g0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 15:04:30 -0500 (EST)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91ebc622dc8so57231356d6.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 12:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794859470; x=1795464270; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2ioUD8QeW/Bl2QsONQm9YVJC6hK9MPeWajyNk7zYtP4=;
        b=1tuiDLriPnMeS3T59jlMWLiS08qkOvhN4lR43LsIdWaGfEMM7zND7Sru5qpWnkraEQ
         sukvsoAAhtpcB7BhD5pkm7CKII6/XjsNsajK17L3KAat/WcZtsCZ+xRtpm8ErNWsXWZD
         N3HAKlCgqW6vyrfNUWg1+P8Rr6d0IcGcjdCmzRVZhgyC+6hruDtt/ketiLm3CRxu1A7a
         rHEgl4QP/0z2Yrs1njXfO285OVajNuQJhPj7V1suFH1u/qX4rNAt/jZgHZ8Rx+MqUPIJ
         gl3kN09UkhgklEB8wZT0LwtAd2gNJCUfNF2ZPuSfrqnn14vNBOkLvoBOg6+/ZgvxN/PM
         vlpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859470; x=1795464270;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2ioUD8QeW/Bl2QsONQm9YVJC6hK9MPeWajyNk7zYtP4=;
        b=vy47QB1z55WRzmiFih5sS2YmJIHggDV39t2Xm00NjhnFA4P5GxZkDdhBIcz2SxgUYS
         JAE2STmmvU1rGWYjP8erummqciez6eVtV6fsAZW02aWJVrCPCIcbmU7HXyV8Bo312OL2
         0DaApn91DxYqpQzBudo7nqmD59hYFMERDT1JsvociYoOciHhiXvw2Q+yRoOzdcvFlPnQ
         CKkDFBoiWcp6j/50MVE8JnbIT/IGCm3k3L3eOmyQSEU64/9ybCv9luEwaNz3zhSZyF/u
         oUgqJWRsDVGr9GgJgWRMWo+1tCIHoNCEwyDGUA/2Y5kFx+NBBXOlU1ljYEurE/8lJZ5d
         0tZw==
X-Forwarded-Encrypted: i=1; AL+hErGdzB8uwiQiuHLoTOBJRpc8AowBFwuNe6q74rcv9SBRnK2j93PAi0G/wP1H1DPreLQmOF7h70WKt5qogkgM@vger.kernel.org
X-Gm-Message-State: APuU4Z/JTLQdVNCOLWUu8aJwPMbe5wXlSb28gxMRkE/GMaEWFWE1tVxD
	thL7WMW0hmjZ950kWUuM+S+tI42NtLf8N3giHU8FiO9xfbfMNlG3boTgu+Ml0QU8rm2Y/7Lx+qi
	9BbQF6oM5b1D/h168TY+rvXi8mFCVVuVFyEeG44MeDa6xIJznn5/gJRQ+mOCP0MQ=
X-Gm-Gg: AZFdTZe91VAcjGs3DVAiH+x7yJfx0Fsu0Sg9KjXx8juxU8nZLDewnCu4YebiS7+VC/G
	wRJeDyNVq77bSo4kTCzlgrI/qYTzxir4vix+pYD4oNj+baa8NMthilhub7V/fQXUNqM57qhVwad
	3C4qlTlumF+Y+8AHol/YPjZgRBhI9O3vLIZuTh+2VAiN7xVCTKLo/2yLfh/3fQG2CNYpGDicpsQ
	ttA4yGANYv/+96Yh20VBxQKrafZYwrX6e5+0zXD6V6qEIGCDpBkV1+sWq9lTPcYveuW9r6MJgyP
	fSxh1mRzVJrGWEzBB0mnChNWkAPm/2E/dacPVjLhqcFc+TvkK5qWalw73mExhj6seKj34/v7Vnn
	CPuN61XT0DeOGlpuU/Oq5rYQgtiKYtvY5Solae2d84zi8I21FWIwvhjbg6AUlDywCvv7RdFPapZ
	gaDdkfxm/HptjXP+//OymH
X-Received: by 2002:a05:6214:8093:b0:91f:26f7:281b with SMTP id 6a1803df08f44-91f26f72946mr159227256d6.43.1794859469860;
        Mon, 16 Nov 2026 12:04:29 -0800 (PST)
X-Received: by 2002:a05:6214:8093:b0:91f:26f7:281b with SMTP id 6a1803df08f44-91f26f72946mr159226286d6.43.1794859469056;
        Mon, 16 Nov 2026 12:04:29 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23efa2edsm93065426d6.15.2026.11.16.12.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:04:28 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 16 Nov 2026 15:02:46 -0500
Subject: [PATCH v2 4/9] mm/migrate: keep the uffd bit when restoring a
 writable migration entry
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
Message-Id: <20261116-uffd-state-fixes-v2-4-4397a0196479@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794859460; l=2071;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=Rpcxw98gNx7X8R3gnCRpd2IGCaZ7qUyuKdN6HwM4pEw=;
 b=yCtqcH1n96717qFSnug0DmtvKU2aDoSSvP8usjhBATY5U782p0hwGCGV9M5Y+cr8bHvHRBbSm
 HdPRffja1PiA8jPnHDgHJlTaf2jAJ3jlTESZwHdSAhyY+MGSmKh++wr
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: iMMfvFsrN3V83rx9X5u_Jcx8Vd-ulJK2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4MCBTYWx0ZWRfX2/7pboLFiquj
 YYCBvI10Hmwfm2fhrVrPFTM0g9HGa8qYbvm62YzTNIC5Pzg0Hp+bExDPn2WzbullCfxYU41fMMY
 9eJ1DddH8EiAsFeKPLiUEjS1N1EO4HRmJO49dpkNskd92l51mZ8u
X-Authority-Analysis: v=2.4 cv=QfjzLcbv c=1 sm=1 tr=0 ts=6afb61ce cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=VwQbUJbxAAAA:8 a=tHa68p0SAAAA:8 a=Ikd4Dj_1AAAA:8 a=b4_iZGTmu4G-YPbO22QA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=ufIsyHvWW7FwcMbVRpPq:22
X-Proofpoint-ORIG-GUID: iMMfvFsrN3V83rx9X5u_Jcx8Vd-ulJK2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4MCBTYWx0ZWRfX/9RkLJ9lHW9i
 MMJ5quzR7ay+hUvUe9dqCd4ShP/gqWQNuAJ34R0vrmbXyCQyChTGn0BowMKj2/wz4ktTd6T2DCB
 hdlNJc4nnIs+o2hKgyai5UHuI8aN5uxYXtosH283ZrSFNRQ9WDBzEPn+P+D9WZlAl9ZpO06tiBy
 Xur5xivtZPcZ/B4jvT0a7RY+HubFazxOsFM7GqQWzX+NIlTPMjqptS+AU6WThLXcsvlZbcoO2sS
 yLqOSfaMx5JHzc594Aa6tQHopSsMIdB8mKZlUNmdQYMNFpgmpMpSFeWEQ4q500BfGDDnVHxHtjJ
 /Iu1aYc0h9lnEfG02/0wj9vGPCRE4ibk2Jr/7ytpDD+bzFOhHoEZiYmXjl1SWf9cdAzvHEOWVLc
 zs4kMW868rl6zb/l18TntDIaEdeApvJrN5ozKdugZMOVJW+yfB6ZjIhjy49RZSSD/bkt3ysLfhN
 tWw8E446BWYJpiDG8eQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=10 suspectscore=0
 impostorscore=10 adultscore=0 lowpriorityscore=10 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160080

remove_migration_pte() makes the restored PTE writable for a writable
migration entry, and only looks at the uffd bit of the entry otherwise.
A writable migration entry that has the uffd bit set is therefore
restored as a writable PTE without the uffd bit, and the page is no
longer write-protected.

An entry with the uffd bit set must be restored write-protected, whether
the entry is writable or not. remove_migration_pmd() gets this right: it
makes the PMD writable and sets the uffd bit as two independent steps,
and pmd_mkuffd() write-protects the result. To fix it, do the same at
the PTE level, where pte_mkuffd() write-protects the PTE as well.

The only known path that created such entries is PAGEMAP_SCAN. With
PM_SCAN_WP_MATCHING, it write-protects the pages it scans, and it set
the uffd bit on a writable migration entry without downgrading it. Now
that PAGEMAP_SCAN downgrades them like change_protection() does, we
should no longer see them, so this change alone should not be visible to
userspace. If another path ever creates a writable migration entry with
the uffd bit set, the page now stays write-protected instead of losing
the uffd bit.

Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 28a8d7734735..d200f64b5f98 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -399,7 +399,7 @@ static bool remove_migration_pte(struct folio *folio,
 
 		if (softleaf_is_migration_write(entry))
 			pte = pte_mkwrite(pte, vma);
-		else if (pte_swp_uffd(old_pte))
+		if (pte_swp_uffd(old_pte))
 			pte = pte_mkuffd(pte);
 
 		/* See do_swap_page(): restore PAGE_NONE for RWP */

-- 
2.39.5

