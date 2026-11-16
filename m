Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859481;
	b=wuaKUPaQ1kGcW1XIDMpx2sMP1kino/RVapq3x3SdeBO9I3vSOJt3EVcs/bfabfsLno/e
	 CGuUOsCp6x4A++7hSqqwDmMB+LVPPszKJku68ztoAjImP7x49VcbhYuB8G5+ul2nsT5HO
	 253m4MrSOswoHZMZexo6lqfPOTu9sg9A3GT7hSSyDgUNnqcQWHzuTsG0lqRjBvw4vV95p
	 bNWtF3aIP3cTs+W/B1g+9xBbQLthC9Qzl8CgdvgmZX7+2oRM84AufFJgIayrdRl+/MjRJ
	 D9i/vUtAw0PYFeys5jK/5fhEISVDQ88lDtaQvAXUV5uAucCdCE8LX6Q2/KgDisVX7SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859481;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=aJcdx4vcENOgHdl2eEbezDZ2+sbt03i8E18pwL1oDcg=;
	b=WdVCfktXB4A20kn1LjSORrQRy+ft+Qqn4wAJOzkK8vbC609w49LI3XEolnk94wp22kCk
	 kL+4zcKfJB2DjLNpLS+goGG2tTzOdqdSu8e3NHCqx9EEukeA91ycQtzQV/QKbWf2PZ7bs
	 ssoSmiRiwgIpKs5jES4RBrEI9NGZUIlQYgNV2lgYoQ1LSgng/9wuwzzfzswU5hSAKYzdP
	 HCZIYfPd1z2pL7kEBo/PaIvzqGu1Bb9uWmn1ukeCHIiMi79zEdCHyuIiZzQ/T6Z//wfEe
	 Tq517inOLfazuY1B4yS/oj/QdGfBDtf1DEI+CBhllJV6tiG1rdH+3VzAX7nnIzUGskw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=O53Otncr;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=uh+hB+HI;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E32A60A5BEB
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 20:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E32A60A5BEB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=O53Otncr;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=uh+hB+HI
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGJXUNi2979351
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 15:04:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=aJcd
	x4vcENOgHdl2eEbezDZ2+sbt03i8E18pwL1oDcg=; b=O53OtncrkYvH3dSx5Qwi
	Fl6G3Ntqld1xFgvYXyPjTgAl+xLeLCmaF6zdCn5hz13GszwJVItrKpw7Lz5eUS8S
	eMRvbV0y5yS22AyYY1SnxqisJI+0yWhw334hIoFAO5YyY2BM04PsJVm8Gm+qfTOj
	T6FmYNtj1uEoV4PU2BgQCsrQ45FIHjyyo2LeE84H6S+AlRJN/SMwQZgm30nW5JvD
	lBsozOtZjWJNBsin0lxTYg1KeRuLsI+V8wxBX38DU8wS2QE1avDgVWx+AoBPQTiA
	fWTfz0erwiJE61WCtAA5phLnOQQuQBPpt9f2Le3MUZSt7UpO+YZUsGX1qEA2zWQE
	aQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j059sa2n4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 15:04:39 -0500 (EST)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91f12cc95a0so80329196d6.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 12:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794859479; x=1795464279; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aJcdx4vcENOgHdl2eEbezDZ2+sbt03i8E18pwL1oDcg=;
        b=uh+hB+HI/MEDXlBES5QRyRdUbPFG2QWcOSTvu9OZedehwlRI7SQlNH6Kq/IjARvbeH
         XC6IBaFxv6q47pRTZwjWNrBK+GuBZpbax3cuZ7mti3Kl3imDJnzO1faydXVsKiO7qaKX
         ms7gpHCnaiJmTeNN6lAqnjl3FVDBx7VMS6hcfxr1VHlKNAb2awp3zDREng1hew89be3J
         /SoHeQ4GuB20kruBGwnY5JJAZJms+Y/2XscsM68S8Lqn6lAmG1W6IdRi/t69EE8DPURy
         Z8GLTNEM/wHaEd6g2AFk/iviTKiaT5fGWMwxdUUe6jzVJLV5MYvijelcCIdqULBJztP4
         V4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859479; x=1795464279;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aJcdx4vcENOgHdl2eEbezDZ2+sbt03i8E18pwL1oDcg=;
        b=Me9B/cAVcCNXhSImQPMZdjfCorsu09i6Tf2+A0ZqPHxlQFuWh8kQ2itA62jwRa6XPu
         dTdvX1qH1Gs/Kz2DFiu0cNTk+43pFvDUsU2jkxCwy5NnUpdliQ32vmvFeiplnjOAm2te
         9d/r2WY/yyYp7nm4FVwFDzGNeJeP7SXfszevmDVs3QdA8saKH+YKlPY439V3Yt5X5nNr
         RCbJWjp9BvWwe0qr5rXIFIhK64PfcAOEQHfTPTfYl3I5FZEy7rnStRUmp1rabKuP8oyp
         MmL0Agne1Wz4rhtYni2q9ldeaCI2w+hUtes6BXQFIOIXjyXvcS32Yj/J5vwmBnZ/FoiG
         7OYQ==
X-Forwarded-Encrypted: i=1; AL+hErE3khqU/rzooW5f9n/Q5PgHZ59mapSZdxvyuOtrXaWaijSBuGoD0ckWqmBf5JRwKh4BHGKF7U0FNJi7Zorb@vger.kernel.org
X-Gm-Message-State: APuU4Z/jQCW6zvrs0V2Qrcelx488bMzGi5X0kIwXNDNOJTnp4nN9d5eE
	CvFx8/7VoC1lbYfwYo85HugTZyQaf6Xlq/wtA+cTZrxT8XC2iy0uOMXD70Js487RpY9nruGasDa
	Wt5MPxsRKt4GlIaOCOzh2owRO5Zox6zVc7fN9cXo61jwd0bzd8qLYPFzcdDgBh+I=
X-Gm-Gg: AZFdTZdG7iZ/NeUtJ/5WzRrQrKFW+kCUcvm4nvw52yZgDIKzsZ7loeXvNFUjccKahpj
	t/pj+ouZTGg/O4SvcK0WKysUCHc50OL6ABmkomdh4Z0Ut7A69LnTNEYUEflXTn5iVYHFrDs/wKk
	lhMVtFo3WA2ncz4I8ZM7e127MDwtIdO+4dkL3jazkoma9XTD5xF0KshYc1HUK5c1lfH12IVvgt8
	RHpfQlHNu/McCprFD0OXGCP7kNRYGplqVkNdeIUsD7qoNiAkQHi1YS3ypFCHpIgV1vTR+WhbQag
	EMresH3MCeISb03hPVbrNv3xTG1GaVvBbCRojKqlqiOtKEMH5sEGUDZpRweJVedMSjsv88khl+c
	AN2GkB9AhkaTRY/UswfNLx6dC7tcopEA2Dh49Vm8tfyGglzXJt0i0zADLXssRnuJiG93LuKhF3x
	e6xKJpogVKYaW9Oyd3NToK
X-Received: by 2002:a05:6214:623:b0:91e:b874:1290 with SMTP id 6a1803df08f44-91f2420900bmr177490986d6.41.1794859478726;
        Mon, 16 Nov 2026 12:04:38 -0800 (PST)
X-Received: by 2002:a05:6214:623:b0:91e:b874:1290 with SMTP id 6a1803df08f44-91f2420900bmr177490156d6.41.1794859478219;
        Mon, 16 Nov 2026 12:04:38 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23efa2edsm93065426d6.15.2026.11.16.12.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:04:37 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 16 Nov 2026 15:02:51 -0500
Subject: [PATCH v2 9/9] mm/userfaultfd: check hugetlb end alignment in
 UFFDIO_UNREGISTER pre-scan
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
Message-Id: <20261116-uffd-state-fixes-v2-9-4397a0196479@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794859460; l=2072;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=Piqnlv4F255M+HE2n3Ql4fdpsjy2Q0rhRNGi9JUEiaQ=;
 b=PR9LR3++3QTBASZudMyOGXHVHu58spzcaDhpG/3Zgg4i0SNzsQRrpoFgELBiH53vOEocXA9+v
 /FkJ/lGjlSZDojjsaQdfAfd+8YWMdP2uWlpedn5houvj/pq2Mgd7aIs
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4MCBTYWx0ZWRfXwcCss+VpHpLi
 0yMNt3h54phnQsZYb2RXF/tvr/5aPmsL/dC4oOUQzbuIs+rQdMfhr76VdEBHGlNDwmuY+3s2Jhf
 HQR/mLvmx+iaGRxjS5rFkoJ5bhhFlZFCFLtlABUej63g8SXvLFesn6mbJcaszmFxyjD9hutCcaU
 QmU4L1s+BwIZd1W5uC244RjPkQXIea7K+YD5NVXVfq72ScO8yFRELdIDWT1dXqJcpsK0lKwo8SN
 ggWLkhG4pD3H0B1Z2bCxusp70OOndAs8d93TZgmIYebgQEIu/j065j+J9FtisqaQ/eToSEl88fd
 9iFnDBB4iyEXbX43BiYjkk3L2nHVEG0vyTe4dH1kXCLSkcTQkezxuynwjov/mELcAavAzkOCywd
 9ejs93yILWmMBM1veWu5uXzP1Xv5WPMBvksM4VFDrHxH3LniidaYS6KhWH55lHY0vC/f0Bq1pg2
 mXhfBqkdJ2MM4uR/EmQ==
X-Proofpoint-ORIG-GUID: rtBNsmnFBMu961IaV43Y2bicvCf0IzEN
X-Proofpoint-GUID: rtBNsmnFBMu961IaV43Y2bicvCf0IzEN
X-Authority-Analysis: v=2.4 cv=D63SufRj c=1 sm=1 tr=0 ts=6afb61d7 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=SFyPIUEspjz1PKPiGGUA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4MCBTYWx0ZWRfX++CpVMiBEVyU
 DduIN+ihq6Ojcvdbf8A6puYvWpg257SyVgb4oFQV4GM7I56puDEi1s9SZYvELZvTRtGw3XQGoRG
 JsoGOUgVKwxjLGIHfUBCc+e3/T6y1fayo+Tei0ZWtO1Tz4PPPGHs
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 priorityscore=1501 clxscore=1015 lowpriorityscore=10
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160080

UFFDIO_REGISTER and UFFDIO_UNREGISTER both scan the VMAs of the range
before changing anything. For a hugetlb VMA, userfaultfd_register()
rejects a range whose start or end is not huge page aligned there.
However, userfaultfd_unregister() only checks the start.

An unaligned end only fails later, when vma_modify_flags_uffd() cannot
split the VMA there. At that point, userfaultfd_clear_vma() already
cleared the WP or RWP protection. The ioctl returns -EINVAL and the VMA
stays registered, but accesses to its pages are no longer reported. This
requires a caller passing a misaligned range.

To fix it, check the end of a registered VMA in the pre-scan as well.
The ioctl still returns -EINVAL, but no longer unregisters the VMAs
before the misaligned one first.

Fixes: cab350afcbc9 ("userfaultfd: hugetlbfs: allow registration of ranges containing huge pages")
Fixes: f369b07c8614 ("mm/uffd: reset write protection when unregister with wp-mode")
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 mm/userfaultfd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index bf42fabb5afd..d8abc24353e1 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -3960,6 +3960,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	found = false;
 	cur = vma;
 	do {
+		const struct userfaultfd_ctx *vma_ctx = cur->vm_userfaultfd_ctx.ctx;
+
 		cond_resched();
 
 		VM_WARN_ON_ONCE(!!cur->vm_userfaultfd_ctx.ctx ^
@@ -3983,6 +3985,15 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 		if (!vma_can_userfault(cur, cur->vm_flags, wp_async))
 			goto out_unlock;
 
+		/* See the check in userfaultfd_register(). */
+		if (vma_ctx && vma_is_hugetlb(cur) &&
+		    end <= cur->vm_end && end > cur->vm_start) {
+			const unsigned long vma_hpagesize = vma_kernel_pagesize(cur);
+
+			if (!IS_ALIGNED(end, vma_hpagesize))
+				goto out_unlock;
+		}
+
 		found = true;
 	} for_each_vma_range(vmi, cur, end);
 	VM_WARN_ON_ONCE(!found);

-- 
2.39.5

