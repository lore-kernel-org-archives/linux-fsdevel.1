Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419772;
	b=Zx22wtBrWxZp90aEH9v/q6608uEP+o4nycFRwvZQmwQWF6LmXQbxE2cznR+GheSdLx6R
	 6EP4wyNWlHWVOElmlwnl2mwdzjLOzmF7JM510teECu2EXUPRQ0kA59cWgLnQ3DmLIEHra
	 hwnsyCiWVn419iDplD7h6gC5BxRQVDDj19Yksp7/lES30ukGeaEnCwnL6/iGWWARO7k9g
	 eNFDpIZzAinJoc3i/bbySDp6JyVgJo68sjNlRngx8bdwqqsyKMpIpVSiecgzCaVyJqZJp
	 SQGBADZRYGrM82J9JwbpCQ6tMyBlK/mzSWT25YYgK2WccibLnbCWLjHIGZB7+S3ZhZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419772;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=zQXiGUDfX4nhGSBE/hoqgNBZ3AZrbYE3C3VVsm2sLEk=;
	b=rMJbo6pscW7KiJZGmT5KS+UjspuhOsmmADwdRyLpd09GDzPDb6JMmpJhCTk6dJX8eSmg
	 c3l9pY7Z97qUFgnszU9fWhTKWpndbnhKHZWaCpPiB6R1yZ1ryE06dhrRJRuJoLT04NoGh
	 KJhZKa2lLfRdJGdog8zdyO9bEQMw5JvuqR6EBzI+p1b2l00hB2kaW0ul33kd6koaKHXdx
	 tOYcNpng0si9zH02cbatHikSENfDwdgHJQ6FpFoe2i5jRxWzpryWFwKtWksWTvDxqCfdj
	 PcSW2oMrfrEX+fMVJgjGQr2Vilet87JjXY2TWfGnc5VU1dPNPmyYvxyk75yFtFTwLHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b="V/ZwGOro";
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=QEyFBYDH;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76B360A6F63
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 17:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C76B360A6F63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=V/ZwGOro;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=QEyFBYDH
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABHYhjS567590
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 12:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=zQXi
	GUDfX4nhGSBE/hoqgNBZ3AZrbYE3C3VVsm2sLEk=; b=V/ZwGOroO1zo48pZ66bT
	L/ZvfSo66O62PCEkxH/hfRJgDsDlkZGZfJRgbYbCmi1+dtxRgQrXBp2H4NRmmwdp
	bupXC1WKqxHvCYocksf2dKhoqDOAGhPpDArKxAyoTLC6JyeewK89IEMXB5zRH4pf
	0Pb50jIoIV/sL7YHOXogwszUeqq0LBS9FavtCT6taGOh7vIcEvKR+lqrh4KqVkU/
	LMURGMKc6WKV0JmJNYE0thUhmAc9f9qR1S3+A8hN4defBp9qzKNuVrahAnqRl9js
	3bff7yJo2jxt9NF8vBhFxqqr6TmnnMPUnmC3slxmbWTBzgR4H2DeOemaHvgead3I
	Yg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hvew5mpwy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 12:56:10 -0500 (EST)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5337b591609so54215811cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 09:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794419770; x=1795024570; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zQXiGUDfX4nhGSBE/hoqgNBZ3AZrbYE3C3VVsm2sLEk=;
        b=QEyFBYDHdLxLP0NG8l134bbUAbyoyjgg4vRaA1BZsmntj2XrEiuz6oRHDnRTj4hF1C
         hs4Pv+R864u8bQnD+F7fCgKwIpOakZnWHC1QMbYiwp0XceujeegaQSBbThp3Lxh1g684
         BXrUI5lzir29IaDooAHyCFdAJMlOhiZ3EOjINtFcpAGz31h79ooJsaHGkiWopOZffl8a
         L1Z+SQRLrB8gdKJL8sFxVWrdunsY+pA3XbaApUqUsOJqgDeKkpMK1tn9ZTjbkMXmUPUj
         +UW59z9th/vSXIS9ObZ6wx5TVqojQTFJ8FckaMOiGuQ4cbIoPEd1Om/lYi1vzmFKJwAC
         ABVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794419770; x=1795024570;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zQXiGUDfX4nhGSBE/hoqgNBZ3AZrbYE3C3VVsm2sLEk=;
        b=PRQC+tF/o6483bWfd3/3LIPAPJFmIsKOH/BESi5YJVjXGYZM9zaYCKD1+YsBPQuB5i
         /qwlgbyr7obqoQ3GNysyNSS5ZUmDVXpUG4+MuyWr7QUdp/gLVSLBxMmiiniYtHvPfaAC
         9gCCaVH3KSLK/U8bS+PnZM9582DG8YsF+LBwNY7e0DC/Yu6n2Liv/AHKeo1ETsb7aEiu
         HxMGF9BWOnGbrg9RO1ASv5ao0HLMEjDpfDsFeCzxUu2fqMhyBBZNI45Dv2coYxxZwMYt
         p9PTAkFxGiMtYEvK2sqS+YBe+NfNprIcpmGeMGYhW3UkK1fVPtSkKXxdg5e7TdRcHgbw
         j3Kw==
X-Forwarded-Encrypted: i=1; AL+hErEf+3+gN0RvM/xptFi7as+qK1K53A5VI2/qBrtOzBnMBVlZJSqLR+dej93IjovmOz35rc+/TIbhX9cnaH9R@vger.kernel.org
X-Gm-Message-State: APuU4Z/Qw7JUlBScpIBz39w3MvwzpdzkYAjiqXUCLp5SfgTY96OpP7QA
	4p44r83iUEc7JQJDn00dxB799POjAjV1UsFQZ/QDNzAb7zA3QniqYlSvo8aSSTnDHLf6Y2+RtVr
	Me84MhdIhiAATuH0Na/TehNCMvRc1aBvf47ondnBugJKMp1Xi2jxIBFbYDQcfRi4=
X-Gm-Gg: AYBFou04+KXFpF56tebD5bhcTYVqYnCf8RM1Ou3so1+IR2/bqk9x+L6o8QdZJlSsKDU
	PVZox+TT3HNd2jZCZNmX+QUHx2yQ76xBUrofn+qwVFlezGTQuW7Slj5FefOpIhWkk9va3734xZM
	Rlf4+PVDCTRKWbYJxfYIUmJeB0FaEbcDY640xuZT0SvwmP8qhx6q7IrH4GZib1qJfdh6Z6jWQXT
	zqkEIx06EvJaB4lUo4HN412hJWjWntt8rQU6fw3QHQX7EAnaWAdcIwgGuIecR7SloZvNEv/kri1
	PBym5TGl6xZb6lfDBeFudfQc9dnCdE+Eiqav6vesv+p3+fIh4cUGM8z0By1aOVJI1X1Q+jDVtrF
	k6aiijNmE4Z9Xs1vkz8GAH99J9rkiNbG37AqHW54VqbVGcMo4Nh8Tsz7pLGKv2+OE40BbtcNXaz
	CqrE1NRSUZ8upNCAIXsQ==
X-Received: by 2002:a05:622a:514c:b0:533:3af3:43b9 with SMTP id d75a77b69052e-556c0cb83a1mr49123891cf.44.1794419769627;
        Wed, 11 Nov 2026 09:56:09 -0800 (PST)
X-Received: by 2002:a05:622a:514c:b0:533:3af3:43b9 with SMTP id d75a77b69052e-556c0cb83a1mr49123161cf.44.1794419768938;
        Wed, 11 Nov 2026 09:56:08 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550b93ee00sm54974231cf.16.2026.11.11.09.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 09:56:08 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 11 Nov 2026 12:55:19 -0500
Subject: [PATCH 11/12] mm/madvise: send UFFD_EVENT_REMOVE when installing
 guard regions
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
Message-Id: <20261111-uffd-state-fixes-v1-11-00713d368976@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794419750; l=2548;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=kEdcltU5qeZ7eK7b5dl+oNbbR7olPAATUNygSBtDqx0=;
 b=GjNOWnuSdk/55WU96LIrcc2S9e1J9GWjLD+AXNsWkcA9q1s0rpxpdn5CaqoIq5RA1eqiRV6v4
 +w/Sz2zM37YDGSHG9tKMkiXliEld8eZF962ZxuFjv4RugUrUbbLap7+
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3MSBTYWx0ZWRfXxWVKiV2tzjZM
 hgFXIjwzF9ulXOoHYTGjsy7SuS9XrgWCF5clVYXnFnUj4xwa+Ve9PFtkI5iSuf3mTOIm45nUI7d
 RwiOCTDyoSYQu+o9HMe0eKy9j+VGwUp1pv2ojrcOFWzlApkyPsc6/g/O8nGQt+rS4ZzoD4L0XKG
 QKObEbzmLUKqrAn4hL1vr6g0EAMPwj67tCpbymxj6OJ3Smxb3MhNhWyRfYBFWfEEJLsDuasbjqX
 05jI48qE6q6rafvkFolw95CJnIEhkLe9MKBlzZ+nfl92ult2Yj4ClSXHBeQgawJe9qnK7jwYUNX
 ps08uzQGNUJqUIcniRPbvMewaR2XNc1a9XmHzNjNOKrsFM5aBa9u5f1m8q96gzN1DIijHbCsg3/
 QESYWvN9GvgJNUUMDbJUIf7ayAC/6u8Sgk00J508/3Y22AIlk7fhWjYGTJlvU9XYteth+zoKBHA
 GQ93pW7SWtLWPBczZzQ==
X-Proofpoint-ORIG-GUID: DJ92XBKl03Njaou-97Z9UJYBiO6FUVBj
X-Authority-Analysis: v=2.4 cv=etVKXYpX c=1 sm=1 tr=0 ts=6af4ac3a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=H9KHOoA6oAAipju2C2wA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3MSBTYWx0ZWRfXyjaRYrDJQ1g8
 SiqQSGzK9xnN4TWyrLytFuCx+Pnx5thD8t34KpxWbKOVEq/KJsnxfXY8GFA07X7rXXExYVudLW1
 qhVd/F3zmSk5Wvi3wgw2PAnmtewJKx4rjAx9yQLRIpNIKE27W+hg
X-Proofpoint-GUID: DJ92XBKl03Njaou-97Z9UJYBiO6FUVBj
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11963
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=10 suspectscore=0 clxscore=1015 lowpriorityscore=10
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110071

MADV_GUARD_INSTALL zaps whatever is mapped in the range before
installing the guard markers. However, unlike MADV_DONTNEED and
MADV_REMOVE, madvise_guard_install() does not call userfaultfd_remove(),
so the userfaultfd manager is not told that the pages are gone.

On an anonymous VMA, the zap drops uffd-wp and RWP protection along with
the pages. Writes and accesses to the range after the guard is removed
are then not reported, and the manager cannot know that it has to
protect the range again.

To fix it, send UFFD_EVENT_REMOVE before zapping. Guard install on a VMA
registered with userfaultfd already takes the mmap lock instead of the
VMA lock, so we can drop the lock for the event and look the VMA up
again afterwards.

As with MADV_DONTNEED, the call can now return -ENOMEM if the VMA goes
away while the lock is dropped, or -EINVAL if it is replaced by a VMA
that does not support guard regions.

Fixes: 662df3e5c376 ("mm: madvise: implement lightweight guard page mechanism")
Closes: https://lore.kernel.org/linux-mm/3f4b0d1b.bbf84.1a1c55cb666.Coremail.18670333770@163.com/
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 mm/madvise.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index e8b05dc899f1..6413f0e65381 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1166,6 +1166,29 @@ static long madvise_guard_install(struct madvise_behavior *madv_behavior)
 	if (!is_valid_guard_vma(vma, /* allow_locked = */false))
 		return -EINVAL;
 
+	/*
+	 * Installing guards zaps the range, so report it to a userfaultfd
+	 * manager like MADV_DONTNEED does. The VMA can change while the mmap
+	 * lock is dropped for the event, so look it up again.
+	 */
+	if (!userfaultfd_remove(vma, range->start, range->end)) {
+		mark_mmap_lock_dropped(madv_behavior);
+		mmap_read_lock(madv_behavior->mm);
+		madv_behavior->vma = vma = vma_lookup(madv_behavior->mm,
+						      range->start);
+		if (!vma)
+			return -ENOMEM;
+		if (!is_valid_guard_vma(vma, /* allow_locked = */false))
+			return -EINVAL;
+		/*
+		 * The VMA may have been split while the lock was dropped.
+		 * Handle the part in this VMA. The remainder is handled by the
+		 * next iteration of madvise_walk_vmas().
+		 */
+		if (range->end > vma->vm_end)
+			range->end = vma->vm_end;
+	}
+
 	/*
 	 * Set atomically under read lock. All pertinent readers will need to
 	 * acquire an mmap/VMA write lock to read it. All remaining readers may

-- 
2.39.5

