Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419766;
	b=cJgg26FGtPbsbDEC3gDKtVO18iOhX0oz5qxJTBQKFQ++xSQTOzK6wNH4TdAOKR044tIg
	 Axu1l41mCjxhcW47WwIUWdYZH6QJ77f1NVHdt59ndmAuOQhZ0lLXrKMPzYJrsS8mV7avf
	 n8vhLwfjXbwTe2T1curpTMDzQjI/UvaMP7FaSS9/HXTp3fsb2QCU4X2NrD9qWC20uzTWP
	 fP4PgT0A7KPsTg6VSU21V5bGTPbi4+Yrp7xxzXEcSkhKoAiz32HDAPsHKhPasOz5jHFhC
	 ZeXLEI9r2iorUDtksdV+c/LdvXvuI/rwWa2pVqeMy/Oi4lid+JdFL36IL0bs/ZCQfXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419766;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=6AzRWOawdY/XLsSE0SxncPICTiSBCQ9PaSP9Cbrxo7I=;
	b=nq4YN9HPH0jzQD4M8E8jDvbnMDiyEFYfo+p26fmXAR83o1njR6V+fzBGvxDBWpHA3Xvw
	 ZQyCSOLQAo64kRRZsJPXplWXAQ+pdqiEGR030NOZQY4Awv2FcLZYLzL2VKnH2IzLb/Ajp
	 2VNqoILjvw4izxh/6FMKpXexvEY9X6S7oxQECoHf+n5EeqT1aWrunAj1jxOlp3mMHhSM4
	 +sHmm3C/5rKTDLGrK7sg2tK/+jRwahwh0oqzQZKcHR5gy4MViUytCucCiuChk9JrsRJGr
	 8qEu4yk7e6KWmNNIYOejFNFjG2osHTS5BmR1O4oBM7sIIhsAiVPv+4Yc2T3P/zso+xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=mZ9TpS6g;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=SNe60Si7;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9677660A3807
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 17:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9677660A3807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=mZ9TpS6g;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=SNe60Si7
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABHYCxQ1158017
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 12:56:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=6AzR
	WOawdY/XLsSE0SxncPICTiSBCQ9PaSP9Cbrxo7I=; b=mZ9TpS6gUjDIbQYCHJ6x
	wJP8tC5iyLAn99DRvrMSIGLa9e2Abh3dQfauq3CMKbiCjS/TuGgkzl8BNmrkaIZh
	RhpnHwtoODq8GKkVL2Yd5lsoAJa3NPfYsxNt6BpLW2i5ckWuIUK4jnLafvUR12/V
	M2znURM75XoxtxR+ZTLwEs1RnUmwNTatoKzRzze4FZSnuLISvZJCOh0eCYtIPJkW
	iJHv9Gb2/iEOGuu4excsj3SNPXa36ewwPD2EYRMXmXcFfnFk/GInj9+js2drqfjx
	UXY97LrLWcRNQ6Qx5mT9zekVGFtH/Dk1D27C/RuK8CDdunZJwrPsvRxPYgyZdAT4
	bQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hvhnsc4b5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 12:56:04 -0500 (EST)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5337f26ee19so93243441cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 09:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794419764; x=1795024564; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6AzRWOawdY/XLsSE0SxncPICTiSBCQ9PaSP9Cbrxo7I=;
        b=SNe60Si7//WuziteiEr0owOG5Qz+q1YbAVjwXcfgxZbiA/Oys3sxiDPHu76utyGNCT
         PN1kGHAq//iwm+sHwCHPA191bWHQSvIG39p61/llyhcgCl5pQoscBZbHQs7t9xcitgDN
         ELprdfhyBPCynOE3oJ5/bKHe+xfR++MlpSqBLSi4G1AYh5ZJ7UMWu5kuTOatAU8ePlBf
         fd5It1vb4mpuTreZE06hdeqp0OdLOBDfAQvT+uptZAreGyBVB0SmpvHZ8WqENdolkrRw
         9N79tBw1CkBxjNYFmtePChwaImaLjPLvJJG0m5cTJPHr6Bt3F0dCo4ldSkDQOJt/Nmoy
         /fcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794419764; x=1795024564;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6AzRWOawdY/XLsSE0SxncPICTiSBCQ9PaSP9Cbrxo7I=;
        b=Q4Hl99/ro6M/y3BUPpNf1ZhNsipvYsBH7BAfLCmOhiwRGdzqmuU2a6490y+hSXvCCk
         q2pH8OFoaj0yF2hSDtSBkMR7fgeAUyM8zLfIJOMQ11oIALlETDVOcc0t/IfXQoDaj2ZT
         RCrgj3AhFVSlYGbqLbvoqz6+IuWh0E1dsLCddFXIgsdI74j1H5b+XrbH9goM2kkwT7oY
         FHmzy5TOMWxzpGzO48ONZlg08DUDWhtas4tFSg6Wk8STwddA3e9pYoYkqJiZy2Gs0gdG
         w8i3fNy75h26rTQqz0alo3LFBZlRKhJv+Pk44BqrrVO45vA9gwCNMFpkwFeJ7ShwdNIE
         arqg==
X-Forwarded-Encrypted: i=1; AL+hErGSwcsOj4+O4pYuPyN58Cxk8wb0VvlXl9D31b/EGi5TkkZEbHPxiPKs0mcUpnNuFjjk8PhbztFBO2ksDT7p@vger.kernel.org
X-Gm-Message-State: APuU4Z/psJYqXLz9FBwyWSMaUE73nLxkEHOnkU79fs2xMRD8K+nkuTZ1
	aUrD333G1Lt/tVAgdVnJWygqEorEOCL3mHraCRrBONRFw71C0JdPtOp0x/KrQNZ8VNVoLGyzgSn
	tyd99TFuPUGA4+AQlQFNjEGHhkwHZc19vNaYtjKaBerAPUvJPj5LJ4qmCnHX7ATk=
X-Gm-Gg: AYBFou1BlxkmrUZNKgVWTZg0Cn3ZxUQO3sp9HfmP344YAMAxSThsNir/dietZoIZKfE
	yPhRo2TXu/lgZXPfBljoxjyegOxhdR9fDFTl5iSQth2nRj0uQmu9/VtrX3eLygretGdQQn6mnwi
	5bVw0WlFajMzENKk0tqbTRBnwVsv9WpqRNPeZr9yRSrZGYtvDPEXA4t/nMCQ8muGvSzVP2ADLWN
	uwGwT5p3L/vrtk4cDzYZf1KF1bq+Fp3v1zL2BWGkMeXxmX2QwWvTOlGNEUabZfiT14psWtFctP6
	qEooJ1pdmEzipqOyqhQ8S4R/8DEh5WNfrsxQ+GLu1Z6+3ZUL3ioN2bGBbTd0yCiBuIEAYOJPh+a
	x4DBVVVsVCRLWeTuulgu2tuQ/mRLLLUHpV6tKPt/G5RcICM3flxxGMZBavu/sG7tkQW0b5YmzUz
	Jguh0hm7ONriz47Ksrbg==
X-Received: by 2002:a05:622a:4c0b:b0:535:28bf:556a with SMTP id d75a77b69052e-556c0cbc608mr46373031cf.37.1794419763591;
        Wed, 11 Nov 2026 09:56:03 -0800 (PST)
X-Received: by 2002:a05:622a:4c0b:b0:535:28bf:556a with SMTP id d75a77b69052e-556c0cbc608mr46372341cf.37.1794419762971;
        Wed, 11 Nov 2026 09:56:02 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550b93ee00sm54974231cf.16.2026.11.11.09.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 09:56:02 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 11 Nov 2026 12:55:15 -0500
Subject: [PATCH 07/12] mm/mremap: resolve uffd state when the context is
 dropped, not during the move
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
Message-Id: <20261111-uffd-state-fixes-v1-7-00713d368976@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794419750; l=9517;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=Z3HcYciE/Tpm+iRergRe0sb0AcvrNns+MIo/9+inaMs=;
 b=cOb/U2nEhAPxpm+v1OHS9aAxpELHnPNk3VbTh68lRUDhTNV1JAziyMSKOd0O7bdJx5n7IvbZb
 ngljTmRptHrDjYwAfHcm4/DsgA9qTM18A/se1FF5D8AsJoUCtCbFO9O
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=S9lMU4sP c=1 sm=1 tr=0 ts=6af4ac34 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=geY7Is6-Ug028d5rLKYA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: KYazMixc_yOXiIPvPxn-23BpY18UGyM2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3MSBTYWx0ZWRfX2dv9ENJsS/Z1
 6SCzCzhnvi4KDhZ5EJuWINEsElWcBusda7RkU5Yobs4miHUwqeTlLY++VkCzAoxd1q1OdIcnkqy
 V8KrhGZr1sCbcKsKTy1WV1oYUtkdrKFAVgRYtKw5WfpvSwiXztjFsJDIjrdJcxjD7fK4YICJCYi
 dWk+e093ENsZKOHlrQL9ilVykdFSgG1/yd4lBGdeyB0QrwKSkPFxFXoHc95/5T/MRXX/hjb8SzE
 oUIigzp3NPGIpGBFJO+CfsFT45gpXeUBtVAFC6+9QbDReTp6tXkPulVWVUA2p3DShdaexDIfvqT
 j/tB2QjcI48TPPvTsFrU0tVd4Nvr/LRkNI1nW2ciCmv5H3yc28FtQpIo9Fb9w0gnuUu1S+PfAv8
 Dsrv2xnXpdeKb7WLNiIKj696/CHzHW22BWAemf2XhL/pd3dv8wfkAkt/Mgl7lR6WOjJF9GZJqI4
 1XTvUR2BSkzUYhlRK+g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3MSBTYWx0ZWRfX4gxmF1g2ccGf
 kktIRcjYNCQ8SRH+SYD4Rrh1gulkG5Ev0BV2mahEkG5uCAzT85gALNmvKCR9WfRNAM7+LfdJMLE
 Xv6auLHvvVl+PvEYdy86/02HTOsyhEOUn5tJbpcqQfIp+toTtL31
X-Proofpoint-ORIG-GUID: KYazMixc_yOXiIPvPxn-23BpY18UGyM2
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11963
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=10 adultscore=0
 bulkscore=10 phishscore=0 malwarescore=0 impostorscore=10 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110071

Without UFFD_FEATURE_EVENT_REMAP, the new VMA of an mremap() is not
registered with userfaultfd: mremap_userfaultfd_prep() drops the context
from it once the move succeeded. The uffd-wp bits, uffd-wp markers, and
RWP PAGE_NONE entries in the new VMA must be cleared as well.

However, move_ptes(), move_huge_pmd(), and move_huge_pte() clear them
from each entry while moving it, before we know whether the move will
succeed. If a page table allocation fails halfway through, mremap()
moves the entries back into the old VMA, which is still registered,
without their uffd state.

Writes to a WP range are then no longer reported, and an RWP range
becomes accessible without a fault. Nothing restores the protection
afterwards. This requires a page table allocation to fail in the middle
of mremap(), so it is rare.

The uffd state must only be cleared once the move can no longer fail. To
fix it, leave the entries alone during the move and clear the uffd state
of the new VMA in mremap_userfaultfd_prep(), right before dropping the
context, using userfaultfd_clear_ptes() like unregistering does. A
failed move then puts the entries back as they were.

This adds a second walk over the page tables of the new VMA, for VMAs
registered for WP or RWP without UFFD_FEATURE_EVENT_REMAP.

Like unregistering, userfaultfd_clear_ptes() also asks for the PTEs to
be made writable again where that is safe (MM_CP_TRY_CHANGE_WRITABLE).
The old code only cleared the uffd bit and left the PTE read-only. For
private anonymous memory this saves the minor fault on the first write
to each page that was protected.

However, this adds spurious minor faults on shmem and hugetlb. When
resolving, change_protection() rewrites every present entry in the range
with vma->vm_page_prot, so a page that was writable and not protected is
made read-only, and its first write after mremap() faults.
UFFDIO_UNREGISTER and UFFDIO_WRITEPROTECT already behave this way and
lead to the same spurious faults. This needs to be fixed in
change_protection() and will be done in a separate change.

The entries no longer need per-entry handling during the move, so drop
uffd_supports_page_table_move(). Where the old and new addresses are
suitably aligned, move_normal_pmd() and move_normal_pud() can move whole
page tables of these VMAs again.

clear_uffd_wp_pmd() has no users left, so remove it.

Fixes: 0cef0bb836e3 ("mm: clear uffd-wp PTE/PMD state on mremap()")
Fixes: 763f43865fc4 ("mm: preserve RWP marker across PTE rewrites")
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 mm/huge_memory.c | 25 -------------------------
 mm/hugetlb.c     | 27 +--------------------------
 mm/mremap.c      | 46 +---------------------------------------------
 mm/userfaultfd.c |  1 +
 4 files changed, 3 insertions(+), 96 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 09176b290f76..468a49041b95 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2616,18 +2616,6 @@ static pmd_t move_soft_dirty_pmd(pmd_t pmd)
 	return pmd;
 }
 
-static pmd_t clear_uffd_wp_pmd(pmd_t pmd)
-{
-	if (pmd_none(pmd))
-		return pmd;
-	if (pmd_present(pmd))
-		pmd = pmd_clear_uffd(pmd);
-	else
-		pmd = pmd_swp_clear_uffd(pmd);
-
-	return pmd;
-}
-
 bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 		  unsigned long new_addr, pmd_t *old_pmd, pmd_t *new_pmd)
 {
@@ -2663,19 +2651,6 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 			pgtable_trans_huge_deposit(mm, new_pmd, pgtable);
 		}
 		pmd = move_soft_dirty_pmd(pmd);
-		if (vma_has_uffd_without_event_remap(vma)) {
-			/*
-			 * See __copy_present_ptes(): normalise the RWP marker
-			 * so the destination starts accessible instead of
-			 * taking a numa-hinting fault on first access. Only the
-			 * marker (protnone + uffd) needs it; leave other present
-			 * PMDs in the VMA untouched.
-			 */
-			if (pmd_present(pmd) && userfaultfd_rwp(vma) &&
-			    pmd_uffd(pmd))
-				pmd = pmd_modify(pmd, vma->vm_page_prot);
-			pmd = clear_uffd_wp_pmd(pmd);
-		}
 		set_pmd_at(mm, new_addr, new_pmd, pmd);
 		if (force_flush)
 			flush_pmd_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index cb2de24affdc..97bd29925476 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5168,7 +5168,6 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
 			  unsigned long new_addr, pte_t *src_pte, pte_t *dst_pte,
 			  unsigned long sz)
 {
-	bool need_clear_uffd_wp = vma_has_uffd_without_event_remap(vma);
 	struct hstate *h = hstate_vma(vma);
 	struct mm_struct *mm = vma->vm_mm;
 	spinlock_t *src_ptl, *dst_ptl;
@@ -5179,31 +5178,7 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
 	double_pt_lock(dst_ptl, src_ptl);
 
 	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte, sz);
-
-	if (need_clear_uffd_wp && pte_is_uffd_wp_marker(pte)) {
-		huge_pte_clear(mm, new_addr, dst_pte, sz);
-	} else {
-		if (need_clear_uffd_wp) {
-			if (pte_present(pte)) {
-				/*
-				 * See __copy_present_ptes(): normalise the RWP
-				 * marker so the destination starts accessible
-				 * instead of taking a numa-hinting fault on
-				 * first access. Only the marker (protnone + uffd)
-				 * needs it; leave other present PTEs untouched.
-				 */
-				if (userfaultfd_rwp(vma) && huge_pte_uffd(pte)) {
-					pte = huge_pte_modify(pte, vma->vm_page_prot);
-					pte = arch_make_huge_pte(pte, huge_page_shift(h),
-								 vma->vm_flags);
-				}
-				pte = huge_pte_clear_uffd(pte);
-			} else {
-				pte = pte_swp_clear_uffd(pte);
-			}
-		}
-		set_huge_pte_at(mm, new_addr, dst_pte, pte, sz);
-	}
+	set_huge_pte_at(mm, new_addr, dst_pte, pte, sz);
 
 	double_pt_unlock(dst_ptl, src_ptl);
 }
diff --git a/mm/mremap.c b/mm/mremap.c
index fff0465f5e06..4564416a6994 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -198,7 +198,6 @@ static int move_ptes(struct pagetable_move_control *pmc,
 		unsigned long extent, pmd_t *old_pmd, pmd_t *new_pmd)
 {
 	struct vm_area_struct *vma = pmc->old;
-	bool need_clear_uffd_wp = vma_has_uffd_without_event_remap(vma);
 	struct mm_struct *mm = vma->vm_mm;
 	pte_t *old_ptep, *new_ptep;
 	pte_t old_pte, pte;
@@ -290,27 +289,7 @@ static int move_ptes(struct pagetable_move_control *pmc,
 		pte = get_and_clear_ptes(mm, old_addr, old_ptep, nr_ptes);
 		pte = move_pte(pte, old_addr, new_addr);
 		pte = move_soft_dirty_pte(pte);
-
-		if (need_clear_uffd_wp && pte_is_uffd_wp_marker(pte))
-			pte_clear(mm, new_addr, new_ptep);
-		else {
-			if (need_clear_uffd_wp) {
-				if (pte_present(pte)) {
-					/*
-					 * See __copy_present_ptes(): normalise
-					 * RWP PTEs so the destination starts
-					 * accessible instead of taking a
-					 * numa-hinting fault on first access.
-					 */
-					if (userfaultfd_rwp(vma) && pte_uffd(pte))
-						pte = pte_modify(pte, vma->vm_page_prot);
-					pte = pte_clear_uffd(pte);
-				} else {
-					pte = pte_swp_clear_uffd(pte);
-				}
-			}
-			set_ptes(mm, new_addr, new_ptep, pte, nr_ptes);
-		}
+		set_ptes(mm, new_addr, new_ptep, pte, nr_ptes);
 	}
 
 	lazy_mmu_mode_disable();
@@ -334,25 +313,6 @@ static inline bool arch_supports_page_table_move(void)
 }
 #endif
 
-static inline bool uffd_supports_page_table_move(struct pagetable_move_control *pmc)
-{
-	/*
-	 * If we are moving a VMA that has uffd-wp registered but with
-	 * remap events disabled (new VMA will not be registered with uffd), we
-	 * need to ensure that the uffd-wp state is cleared from all pgtables.
-	 * This means recursing into lower page tables in move_page_tables().
-	 *
-	 * We might get called with VMAs reversed when recovering from a
-	 * failed page table move. In that case, the
-	 * "old"-but-actually-"originally new" VMA during recovery will not have
-	 * a uffd context. Recursing into lower page tables during the original
-	 * move but not during the recovery move will cause trouble, because we
-	 * run into already-existing page tables. So check both VMAs.
-	 */
-	return !vma_has_uffd_without_event_remap(pmc->old) &&
-	       !vma_has_uffd_without_event_remap(pmc->new);
-}
-
 #ifdef CONFIG_HAVE_MOVE_PMD
 static bool move_normal_pmd(struct pagetable_move_control *pmc,
 			pmd_t *old_pmd, pmd_t *new_pmd)
@@ -365,8 +325,6 @@ static bool move_normal_pmd(struct pagetable_move_control *pmc,
 
 	if (!arch_supports_page_table_move())
 		return false;
-	if (!uffd_supports_page_table_move(pmc))
-		return false;
 	/*
 	 * The destination pmd shouldn't be established, free_pgtables()
 	 * should have released it.
@@ -434,8 +392,6 @@ static bool move_normal_pud(struct pagetable_move_control *pmc,
 
 	if (!arch_supports_page_table_move())
 		return false;
-	if (!uffd_supports_page_table_move(pmc))
-		return false;
 	/*
 	 * The destination pud shouldn't be established, free_pgtables()
 	 * should have released it.
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index ad9d243dc64b..bf42fabb5afd 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -3161,6 +3161,7 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
 		up_write(&ctx->map_changing_lock);
 	} else {
 		/* Drop uffd context if remap feature not enabled */
+		userfaultfd_clear_ptes(vma, vma->vm_start, vma->vm_end);
 		userfaultfd_reset_ctx(vma);
 	}
 }

-- 
2.39.5

