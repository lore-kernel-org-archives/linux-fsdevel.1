Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794976157;
	b=ohv6cKGtHDhG6shNdE+rnBVwkL8+9VLOCCdJobPmwGEX/sqsPQL0My9X4JNL1EFjXAy0
	 gihzfOf59uakxNoHQPhmnrykPSU0eYm0ULj3r4BHkii0BR7rzyZDWdODwIxRabfcGUHYd
	 cCpguK6KZ/rP4+iN/+P/5C78rKmEla7kDCqtl6kgcTiCrugbJclxweZDi1mtpQsAzL1Ms
	 6uCG2ngEEzF1AD5Dt9ab4bP0qjD6wDrN0u1E+NbMQ5Wr7B5+ingvj5J3/Jl4+ToIfYnC7
	 2aonS9miu6/MGDputAURHfyk91nN3eiN7cdE6dKWNitxJ0qiqps0nLOx8dNmY1rx2dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794976157;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=zDdKei2vMEAeXLILC50Im1ZDZfx8CAWqdgs4l23ZWvU=;
	b=wTOI9FfOIO3fyBzicDndK6DLzzXtSwaV2ops8v/swSeNmwE8Ngct3Roth2xtFLftVO/A
	 KGQ9rg1/4kLeV3qY8KxsFyeCBDAYgztCHz7f+XLPAcXMqqvdXEPSu4sOSAPI/3Gjy5RLV
	 TqOYzMTeKQsN9ujO+38jR9CmFNE3NlRvXxEbfszq/Ql+nHuk4Sr04iPh/HOb/a15rEyPP
	 dRtFRvBPnXFrV3Rx5u14ztKx0d5wozbMtOxJkiUh5iEzDgssOYYKyux6P4VSG7XiAghOq
	 hWUcFK70v582TYD2RGtvGmp4AKoHQJL4J65DGhngYOn4ikVq/4YPmsUmsg7ediX7HEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=IhyowP8W;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=SNfQ7OVM;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A3E606A336
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 04:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08A3E606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=IhyowP8W;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=SNfQ7OVM
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI1XbUQ3627332
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 23:29:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=zDdK
	ei2vMEAeXLILC50Im1ZDZfx8CAWqdgs4l23ZWvU=; b=IhyowP8WjhewUHW8kP1w
	6j0tcSqtPM8vC2Cj5KBA7d77bsmlffEPsKJQC6zFhGIrApcn9DJS8tyJANelTpow
	hj91jIPmLHO2iAhHswNyqVqzb51t+CyA6VEq3XSyZuNgNspymfxqup/lMdMkkNxU
	NH0MOXW2OWhalTUqMcK8UWIwPzknWnbIZujsabmgAfmMetEZGodmQ6ed08hcg2//
	MFrYcaGBD9iuSwEePvRhxNIUdk+lTJ+iTsSN1Qd6ZYJHjG0E+qbFs6P3+ztx/wym
	VUXWnM7xNr7Wzy+7CziaYbd8HcMv6s4avpd2/cynD2Ube4udXBQp1bja69/uHKzq
	rA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j0yu79gdf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 23:29:15 -0500 (EST)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f20addba1so108876285a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 20:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794976155; x=1795580955; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zDdKei2vMEAeXLILC50Im1ZDZfx8CAWqdgs4l23ZWvU=;
        b=SNfQ7OVMyiqfl7+I5WDDd9lECJWgGPQERg6qQAmvhwd//GEKtsNShUbCjbpchSuuEj
         JMUZfWoLXtyoqTyM84kxJKNlLqJE+g7hcZ75HDbPmp76uB6ECkZn2E3HJUupg4viTI+M
         F3gEu25SZ/cLoeQu2769m5r8d0BmxZUrDgSF+yEMgNzzcJ8/VZvhBUi/bxEga/LYTtIZ
         NMdDa1wIGavhMpUQupDqOK+Q118S0zO2VTxj4j/NCyiGLtcLR2R4vIzlml7mXuaf356j
         Wy5CBDZzB4FtXIvcsqqupy5x8ncQ9ba7LGC2nA1GOZEmHvC87s9EIIHk4wpvZIYF/iKX
         04Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794976155; x=1795580955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zDdKei2vMEAeXLILC50Im1ZDZfx8CAWqdgs4l23ZWvU=;
        b=A+NbQHmVmGxgcn+FUR3YebgjE2AjIrQsMQ0IP/ZZg272CQqyIvyhtR2vYugJKtpJU2
         +KwkZnKVM+I5xnWKI/UWsOvEWL8VQKRyLbA3qDviVc9RAMK1XY5YfOkglmMDVTIVV7IQ
         L8aP6jT87EPYuRnAguIJ/ur4ORed5p2nbuHBBOm2xTC8O44Wis2z0HG6Ttw80VEGAFj2
         2KVeOw8g7GR+/3ZFL8YVCZtrB9GZ4ORA2SB9jJkIpX+ebnR4IlD2IfQBJAI+JJaYxb4L
         1PoEI8jFlRUwN6j4kR7j8E3RYVx/L527rEpuzTQJt6zu2uEwhv127V0EHdhg6R6DNnf2
         xlSA==
X-Forwarded-Encrypted: i=1; AL+hErF7MeXifLoP3LMwodcGE+d7IMYrmeq6b/0HbGLRzG239SiGhZGYan3LL6kSsiPVBnjHAa7YmiAjJyiMasuO@vger.kernel.org
X-Gm-Message-State: APuU4Z/Vj6Frnsnl3neKzLoSFkMe5RllrB/pfp7a3xNQuhQabj47mlj6
	b++XPUO10ucX5PSrZwyeHcSnn94h/YRVX7g+k9d21n++00ytvLwCbzOke3UnNkQCt7+3EL8R9aC
	CdpLp+ZalKy7OO4G+yOdVFhMNLrNXu0aM0zbCyY31FIpbU/olvx3TT5Vz+0gCfIM=
X-Gm-Gg: AYBFou2/uoi4ddHAWqcxk+7/yuFNVdWp9FveTnroRC6qzVIUIb5rv84/4DWeW/K+KV7
	MRi33RD13OGqfPA5nYHh9t5XTsm88R/kFzs7n8CZwCqUfdAt9ygdjujgtOFv2XF2scuAzzsQTc7
	Pbb5/K4UEmPvxUeOBQ7bkGaFHzRQNmM0so8wl76KdGTCMo3mVpL1V31TB+EKT7fuV/xYVDgL6kS
	60OIUk6gF9VQO6sMgcYUqVxELTVyslMqm1iC0UyNMDqWK+R9YW6mHROEbqExwJnp2aSqyjog8y4
	/NQCb16xqXY7Ubm1H43FFYf3LPt3F4UCvXEveFK1CysXjG4uba1C1uxpXl3/XBPDNnvoaTVDCGL
	ezmIzcvNGvdEmPUH8g4XmInOhhahJfGpD6pe+lxKUAuBp06j9kOTT+V6FH06alCgtPhtOczbfam
	ToDrMuLMFtIwPXbYkPWQ==
X-Received: by 2002:a05:620a:6cc5:b0:939:6dea:4f1b with SMTP id af79cd13be357-949997683b6mr310406585a.49.1794976154740;
        Tue, 17 Nov 2026 20:29:14 -0800 (PST)
X-Received: by 2002:a05:620a:6cc5:b0:939:6dea:4f1b with SMTP id af79cd13be357-949997683b6mr310403485a.49.1794976154331;
        Tue, 17 Nov 2026 20:29:14 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b743a8bsm89678085a.17.2026.11.17.20.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 20:29:13 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 17 Nov 2026 23:28:44 -0500
Subject: [PATCH v3 4/9] mm/migrate: warn on a writable migration entry with
 the uffd bit set
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
Message-Id: <20261117-uffd-state-fixes-v3-4-b617009d1a4a@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794976146; l=2256;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=iVphMSJ7Urh2fIXcYVatrMOzIkJtjyML23OJSADW9gA=;
 b=ufH6wJASUrwLe+a2SyLTMf7lQHuEBbZ7mTnTLAFziy7DuvjbLfMCP59gSJiwfXv3bKRlnt5EK
 RqrfDVkmiExBSNfYuxADHn5NDFZ2h9wOlHN/h1lWWBjjh5ZZDmfFBMS
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=LvgHWXdc c=1 sm=1 tr=0 ts=6afd299b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=Le39LiMa9jTJABa3:21 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10
 a=A0y_DWxS2BwA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22
 a=azVShVRs0zEubeQ0wG0L:22 a=LFElCxfDvO3_aldaUb0A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: TKwXOCm24P3RYGKjiXvvucsZ2kq1hNhh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAxNyBTYWx0ZWRfX39puFIeHRjLh
 o336jwFacX9eWrNaU+tomr/PpjErjy533+6a4VtYbCKapAfveVChbKKMmvGwud4Pz2BLnODYkw3
 cqgIiBvrW3r2yy/6AaSYXbZbu5//spyikJG/VRnwGQ7+yC9AZZWR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAxNyBTYWx0ZWRfX0rDKPoiato6n
 66vbZP6NMuxPCrA+JqZCsIU+wSsHBg68pIC7n0r0tvpsD59KBWXJfVVARCuaGEoOsRyYpufbn6v
 NfE0jlWxQf+vbTibSAp4K/JC4ly5CHXWPxutnDgWezDomC4xgjLj7b2pTG4sF1gjymiEBEGBY1G
 nSu5oddyDBr6VjcApbycIvo6y7DwN7pfZWGQXGWG+hQ/txw6mAk3KrFCCU7FfNblZAnhlDk4+VX
 SHHBwYm6mqiwMUAUHaN/OzbAqdHYCmRkeBahuoq2ZnYbrKG6PMpAOzAcM4iwqYvbLKcgAs3Phiu
 +H84WmEMsMlDu/i03sAXnii0BbKLUnckcKhC1IJT6RISpCo23sAFps7Xk5G/jdb4Ui4M07D9+k3
 PP5sapEFrA/UPvNA1G+A8mfVoq1U2l7qSFpwUvfhQZapo9FC1LSZCN6qBnqPK8Fj/XUUU+8MzPZ
 ZqDPU8cMohNaTiuIqTA==
X-Proofpoint-GUID: TKwXOCm24P3RYGKjiXvvucsZ2kq1hNhh
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11969
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 malwarescore=0 phishscore=0 lowpriorityscore=10
 priorityscore=1501 adultscore=0 bulkscore=10 suspectscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180017

A writable migration entry must not have the uffd bit set. Every path
that sets the bit on a migration entry makes the entry read-only first.
PAGEMAP_SCAN was the one path that did not, and it now does as well.

remove_migration_pte() restores such an entry writable and drops the
uffd bit, while remove_migration_pmd() sets the bit and write-protects
the PMD.

Warn in both paths on a writable entry with the uffd bit set. Also make
the PMD path only set the uffd bit for a read-only entry, like the PTE
path, so that the two behave the same, as this should never happen.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 mm/huge_memory.c | 7 +++++--
 mm/migrate.c     | 7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0d589be136d2..4a4e187ae3b1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -5225,10 +5225,13 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct folio *folio
 
 	if (pmd_swp_soft_dirty(*pvmw->pmd))
 		pmde = pmd_mksoft_dirty(pmde);
-	if (softleaf_is_migration_write(entry))
+	if (softleaf_is_migration_write(entry)) {
+		/* Setting the uffd bit must make the entry read-only. */
+		VM_WARN_ON_ONCE(pmd_swp_uffd(*pvmw->pmd));
 		pmde = pmd_mkwrite(pmde, vma);
-	if (pmd_swp_uffd(*pvmw->pmd))
+	} else if (pmd_swp_uffd(*pvmw->pmd)) {
 		pmde = pmd_mkuffd(pmde);
+	}
 
 	/* See do_swap_page(): restore PAGE_NONE for RWP */
 	if (pmd_swp_uffd(*pvmw->pmd) && userfaultfd_rwp(vma))
diff --git a/mm/migrate.c b/mm/migrate.c
index 28a8d7734735..c5b0f57343ab 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -397,10 +397,13 @@ static bool remove_migration_pte(struct folio *folio,
 		else
 			pte = pte_clear_soft_dirty(pte);
 
-		if (softleaf_is_migration_write(entry))
+		if (softleaf_is_migration_write(entry)) {
+			/* Setting the uffd bit must make the entry read-only. */
+			VM_WARN_ON_ONCE(pte_swp_uffd(old_pte));
 			pte = pte_mkwrite(pte, vma);
-		else if (pte_swp_uffd(old_pte))
+		} else if (pte_swp_uffd(old_pte)) {
 			pte = pte_mkuffd(pte);
+		}
 
 		/* See do_swap_page(): restore PAGE_NONE for RWP */
 		if (pte_swp_uffd(old_pte) && userfaultfd_rwp(vma))

-- 
2.39.5

