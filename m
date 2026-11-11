Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419773;
	b=A/Av1uQfNeybB0XJa+J2UwbN1127OppjePPGkHjM4wQSmfv9+vzNhiR3vDwj5I8LUo6f
	 0qAvFhK6qMt5xBbUHkXfRUUHuaLNB4t8axAXNjXJ1lc622JFpHoQZzdlJm0m3NSoqAVHO
	 JAUKIt8PmlmCFrIQr3+pNBdvcgrleloZQMTU18k/RUTXeAXe+a/b3S5v9Iz5khSCcAWph
	 O7wBMpneby/NR1jDrXBgVT9vZcC4CB8h3Q6thtGiuuw7wztVpGFHmSCzImu/ZYKHONJUm
	 HqaoJKy93Bax2kVgHg/lRMvy3q3RvYIPww0wNE1BCG+C7+b75pOYggPGNWCQ4LJKx2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419773;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=WBv+J2+tviBYV2q/dbnc2XjYzZXGIYwmkmp3zIEQAQE=;
	b=xTIPkgm0bLYXEk31YKmvGeVH2jmY5YsJ/dgLc01DwR51FoAzfYbdk8uT0kD3lyCeXpIW
	 tr8R2NheY1CHYiHQBX5HCcsiBO1e8w9y30EmAe9l6jr+OpZsJz3nLLWJ2/k1KivSk8cqG
	 ydMaWjq6PFs3WMpxVNmMcttlCw2jXaZeEM74HXvkD0RKcuDksRRTRDof3JGBGuilh1+A/
	 mBNCl+brbeJTmk4OgSh3y1YYM9WpPctlBNtSj0SLa/lr/7Ti+DVSlYBGEDqO+qA4oydhP
	 lVDtOR/oUWMTF0Ms3PDTup6P0Emrp4SjQP4JlUT/lIoW4TTNszidYzsdw0o4Xc1x+QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b="skMHD/yh";
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=LrM6xseG;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED8460A6F76
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 17:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0ED8460A6F76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=skMHD/yh;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=LrM6xseG
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABHYJ7l1158262
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 12:56:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=WBv+
	J2+tviBYV2q/dbnc2XjYzZXGIYwmkmp3zIEQAQE=; b=skMHD/yhL0b+juEJ8bBK
	90FcKnwvgP8LdEjYM2BRa1GRJTrlcBRieIWB4kzjmnCpkBVxTbhCNDYIYB4klSJJ
	YedlfPhnksj9gcQti+pbHdP8cgojvWXOB3E2cR96cKFyGgLqI3EhqgMKRbzF92yX
	T3S4vpxqYLDUmEngcjdZ5+3ZhE15dd9QBwqsrJP3y5ipFjacGhFz+Vm0c3jZ8hLq
	8tpgl6/Ne85jUccPfzKgKPRfhCCiqsNNRrFzxRiYxIsOHzTg2qvM8J8aNwiKDdJX
	XJoT0wH6bXFE8EpnwMEbMmqag6mh6aF7ICAjuWFR+zTuuCDkv7Z4djkZ+a6yVdig
	qw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hvhnsc4cm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 12:56:11 -0500 (EST)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5358515b4easo60206431cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 09:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794419771; x=1795024571; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WBv+J2+tviBYV2q/dbnc2XjYzZXGIYwmkmp3zIEQAQE=;
        b=LrM6xseGEZtWNc5EwZTL3iEfmTStxKpFtKIgWzJdAkCX6OguBWlvNGh4WCzXP9K869
         iE/Fo6+XxnBjXzrh9HZFN3/Zkr8t4IYJ70RY5OLBKO6JS5ATvIqVM0kHDE/j1mQn9qcI
         mpxEq2E8aFvYBBrLhT61rKmS303NAd8yrozc+CsY+ikOjT/cvi2Ug8XnZKtcQvtKTFWC
         BWyAhWvVYXWx4PPd6PK57eeyoMPjeO7/hsOT/y9hOhNEXlyTBp2wS+EmdbXvbORkWW9u
         Zv2GuJStcbPniFn4AG8U9qODR5YhxA/OL4xaBC0wqaf8+Kfx/Oz7qWfG5ykbz8WXU6eB
         fnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794419771; x=1795024571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WBv+J2+tviBYV2q/dbnc2XjYzZXGIYwmkmp3zIEQAQE=;
        b=G/m6QvNlcW4Z3oynKY7LneB5Sb0RfXNVebdzLfweaupuRle2tFm6B5/inVNx35yAu1
         kW5Olhf8kyV0p0W3uHT/vZTJdl4c85pgdnLEc4kvBkrAGioNPHo5/kk8cWqVsdGuE0l8
         CI3plMOdhLwzGGCy6cuWBMhwT+unosvqiGFmXz6vPHB86VwsA1FWfJjxs6osW5KWhaKI
         Q0DV3D9V7/Voawf1o3if6oJ24qojAoJAXsdmBWCHcmFnZ0oE+WYahQ7Liz+5Cy/ku9Lp
         UcbBh0V7PJy8xBdhOaF05ExbXbBPPAi+hAFz5EY64z/rAcOO4bS7rKHv1aEe+lG/E6bl
         nfTw==
X-Forwarded-Encrypted: i=1; AL+hErFdbqBvFwW9DOkcyWPfCx8KDAUGLI6Qy07Vr4fWN37MMORs0GLnr1OB7i20xtuzzWdCtEEH8lsycSCp8RCZ@vger.kernel.org
X-Gm-Message-State: APuU4Z8GIPswiUOfNOjMSIwD72OT8IJ7btb1GUOGeoGu1waECJoH/IcD
	8c3A46fzddFwpbtVr07wkk0YGlSfNoq7li8/rNytboF7WmvQ96XikJMlcpgKczzy/np1lRUEeBX
	0n0unauiSuhbluoBIrMdAER78U8LUUxU1IvdkQPObwVrb2sPU8+gdWHoLWprNtVM=
X-Gm-Gg: AYBFou1eLjlmzhaEy6u/dUnFwQhSDEUE3QHdmQ72eMFtdviiv9b2sH3LhAP5W5Pebsy
	B3PsQFhPnjC3IaDR7V8Q5kArK4JhOAkJ2Dpck/MEbH8+PMIidXzM452vpJoob/l6K+suE2z1Uf3
	zVgvLCm2WiHP533a/55Umf+z4FzSPkKkC1V804xEfppYMr/dXfbrggZd2OBG3WSyjr7cYz1ogKA
	WwudW9IEnfUAmOGZVuA6k0HBV4RDYZjPwbBNyKlNyAkHdIprTZ9fCsRv6t2eSZ5rl/Kg7i5TEcW
	8pW5Ir8xuZ6nGNNPE7lH1EU0LhirWjxhAdnFDl7VPwXiHgW8s/z0yYoJKEcyRuawQYFYuOIiOxX
	GB7dSvs7sinnHFlCpgRrYgd/qE/bEtwMenbvEOz9mhuacI45MgITutY114JVVRNkeULNIn8mqnb
	r4X67Mi/VfMYoIcH+8aw==
X-Received: by 2002:a05:622a:1e12:b0:535:e5f1:393b with SMTP id d75a77b69052e-556bd706e96mr49217191cf.4.1794419771180;
        Wed, 11 Nov 2026 09:56:11 -0800 (PST)
X-Received: by 2002:a05:622a:1e12:b0:535:e5f1:393b with SMTP id d75a77b69052e-556bd706e96mr49216611cf.4.1794419770601;
        Wed, 11 Nov 2026 09:56:10 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550b93ee00sm54974231cf.16.2026.11.11.09.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 09:56:10 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 11 Nov 2026 12:55:20 -0500
Subject: [PATCH 12/12] mm/userfaultfd: check hugetlb end alignment in
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
Message-Id: <20261111-uffd-state-fixes-v1-12-00713d368976@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794419750; l=1887;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=QGRuzGiLMk3zkcIfTBxvpb0tKHGNzURyYH72Y9LpGSs=;
 b=zVrcDEAYCH1s+r2j/3K7D7hrzgJ9Hgjn07fWepfXvMyGJykQMyQ0cut1ptQLRa/2G6lrMYLxp
 U4bYjKscjxOBW72PsQrrASnKTsMaN+w3XHxLnxfIErs+DEg3ZfUkktl
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=S9lMU4sP c=1 sm=1 tr=0 ts=6af4ac3b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=w5LpOudGytjZGezDRloA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: lCn0lPS840YUPCu6sh6MRSxvo5cymnIL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3MSBTYWx0ZWRfX4wMAYQ4kK3fm
 a9jQbD9Uzvras9JMgKWSgb2JKBqaM8MHIzGhR4sgLCqETIlnXdPRZ1pAGQcGfOmhG7q0m4xsfX9
 nU2uFuxFjiVpk6VPoEKMWhh7LMCwJRU/1noDfec3fyB1EZifmDnQbyldOE5QxPmM6ppaUjXoaHc
 jgM8Y/+1BNTnY+J1vNRvhByfBW/BmE7YECBNLPbXwQeZrx6nmXrlj/ccTJesYNlKADT9iz3F7Cm
 Fpfsy4xGIAYgkGPC82j+75LtQ5TLVYyTqMhuDWrhgTMZhw6pFA3Fy8y7bmvarrYr9D+1oYnkZ/R
 5kQMFYeGwgDm5dmBON67b1DhSbSatyc5Wt5kp/3i2wXps8gp6YEDBZu3S2DNdWicRIy2o76m08I
 FyaLTkw2Ak6wotujDFU/6hi7eVWkT5OULfSHMJpUJJCvqTTN3r9sUfg/65Lpx8jDFryLkgw9LFQ
 7wQw/fn5EsJoAgXnnlw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3MSBTYWx0ZWRfX+msTQIhH8aH5
 je+5f3TNbdoSC0hffy/gCT1AEGdc4fCMDfIserlJeBmiRXfzEA53nBcaKATD9n4bajyLSUvvG2q
 XJcuBT6CHRW0/roFIbsyu4xfhII9B1c2VMH06HyTfN6FM9YtHbDw
X-Proofpoint-ORIG-GUID: lCn0lPS840YUPCu6sh6MRSxvo5cymnIL
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11963
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=10 adultscore=0
 bulkscore=10 phishscore=0 malwarescore=0 impostorscore=10 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110071

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
 mm/userfaultfd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index bf42fabb5afd..c0076c8b4e9d 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -3983,6 +3983,18 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 		if (!vma_can_userfault(cur, cur->vm_flags, wp_async))
 			goto out_unlock;
 
+		/*
+		 * A range ending inside a registered hugetlb vma must end
+		 * huge page aligned, as in userfaultfd_register().
+		 */
+		if (cur->vm_userfaultfd_ctx.ctx && vma_is_hugetlb(cur) &&
+		    end <= cur->vm_end && end > cur->vm_start) {
+			unsigned long vma_hpagesize = vma_kernel_pagesize(cur);
+
+			if (end & (vma_hpagesize - 1))
+				goto out_unlock;
+		}
+
 		found = true;
 	} for_each_vma_range(vmi, cur, end);
 	VM_WARN_ON_ONCE(!found);

-- 
2.39.5

