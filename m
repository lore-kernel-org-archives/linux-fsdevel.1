Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C5948382F
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 18:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869578; cv=none; b=E+UVGjCWy0yrici+Ie9VNZm4lNSke0aoabl5sGlygkmaF+9mIdOVO43PzxeWz+IZWcZHD/m0IH9ip9/CSXjRNj7OXAdC48H7cqyDsFUX31ROFFCEmwjjGuGpWgmsOYEcGaTahqLZrcBrZZ2EPhEt3eLcTWL/B3WiPknC3C8igQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869578; c=relaxed/simple;
	bh=Fy0wHmd3j0nRih2sYwsjYIDOGoKEx9pprPd7Ycd1PEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o5JsM+X0tY36ILwG9ec/qAUIG1sU4dAXdToyoHtgFORhzFXhmj2IUXGTqoZIEJoPXfIFnYFlp8O8iB0pGYhHEEoWT7FS8nCXz/E0rQhlGTjGSrhcFrutlp4Hp0UgTO/pPzNrOTiYKAiySt/DTOcWbH0dWHxrEAB7OfYA09Njh/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=P7C0CHDi; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="P7C0CHDi"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674IYRKp1999058
	for <linux-fsdevel@vger.kernel.org>; Tue, 4 Aug 2026 14:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=IXGG
	w2at+L2vnEOc5GYny4bpp2wSKxYA9ebiI09IaVE=; b=P7C0CHDiaLIMwRlERVCQ
	2JS5t1syYGUmkwtfAi4bkz3mbz0/zBvmII5X/9F7bQopsz6mbaEwVC/gm4Cxmx8i
	N1jgbz26Hs6k1PkFKqKmzWfR2gFjWsHwNImqgzJmhoIteaEpMFp1wDv40+vHf6x2
	+m1YVI8YOAHYv94djGb2Tg9dQN/K6CnSKWo17X51RkWmZevfH35nQ9TrYeztgRI9
	hmB+IJ2rcRgYg7iXpx0WLaXmWo43pAzj2TGNgWgKjglYg2D6Kx8xzhlN4yiL9gZ8
	/yhLAlgaZE4a1r156ZckLlvpA+VC0x580HwCaQ5OnIXpW7TdO27iVYuMBJfHaa5V
	jQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fuhqba8fa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 14:52:54 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51bf321d786so1131681cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 11:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785869573; x=1786474373;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IXGGw2at+L2vnEOc5GYny4bpp2wSKxYA9ebiI09IaVE=;
        b=VST7CNINoXtzbhVIAieRDWnglr9TOC7EQtmwyZmbuo+x+PypdpJvt0wba+A3W7bQN2
         0WUEuheBpfr2zgpnHhuHxElWWp8zT71qbumG/GbL5+zhbJGJss4vJVMMCM7QuoKBT5C8
         q8VP4grajT58CCgSHmlNuKi73vRcd7hEpaYQZGzBAKhLEPy3exSJZt/GcuyXyhjTZwVW
         b60vk1C8RNVFKyU5bvKDybAdgcf7pSx2zTe/j0+flLHdiTNuel2umgSuRUyMnVENx84u
         v1W2lGOtolMNq7S1jxlwAphxh+M7kcPRDx4EBWXXgyFnJnlNGq+aR5KkG2GVXH1U/Q3f
         AfqQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpbo/d0ie8C40WTmJUBYfb7HZnMUZvQLUstIYt28r57vJ/ooXCPMUmAnnuz17meOyCHFxukJfopTcWGfYmZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3yPQSzlVCOcHG3YjmTY7SgTeJWoyGMwicp2nsdXxGA7hpG9K8
	fFnmoIFYo6v9l8DBi4B4mf6un0wIitpAAL6Ik31P3KiPiuDS4HqYPIKSlx4cI0ufZPAC+52dERW
	dujP6Y69IiuE5dIAQ7zppUN769K/4yK8wYSuXP1BahHzjdV4LQTqBu9hu2MeWPDo=
X-Gm-Gg: AR+sD11WRpxmFU741rgt/dSNMoHOUXsjM/rgNJVdgj53SsZ0aBbE25dSziJEIAnRHNe
	tKbXNY03SRFbxFx7mNVdDkDlpTWPTyIFzUQezGFV4quYh8mHdseAPDGSTWkGYgtSl0DP9b+AuZw
	YYV98SbG5ZwsT4X2lHKi5r453ss3HzW6PYY9ouZhnaBYDNosN92bxIPRxeWQjdFapB8LsXBs5Bz
	RMMFZ6vzuOuqg/31XuvxYtcrRZrFsfomtrcmmZKRBfJ3FPpjt9THkxIj124ai1lvWNytO6gfDjh
	oyaABjSzpe3gmo3+nZCKE0JV8OfqJdwIIp5NxwU6wwl1YQ3COihECbmoqq6FqnomtArdW9irb1R
	uJ7C1+R0U
X-Received: by 2002:ac8:5a12:0:b0:51c:1f97:e860 with SMTP id d75a77b69052e-52ce5f2752cmr13886861cf.3.1785869573290;
        Tue, 04 Aug 2026 11:52:53 -0700 (PDT)
X-Received: by 2002:ac8:5a12:0:b0:51c:1f97:e860 with SMTP id d75a77b69052e-52ce5f2752cmr13886441cf.3.1785869572780;
        Tue, 04 Aug 2026 11:52:52 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec232d7fsm2313275f8f.20.2026.08.04.11.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:52:51 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 04 Aug 2026 14:52:18 -0400
Subject: [PATCH v2 10/10] ceph: rename ceph_check_page_before_write() to
 ceph_check_folio_before_write()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-remove-wait-on-page-writeback-v2-10-81f0ab065284@columbia.edu>
References: <20260804-remove-wait-on-page-writeback-v2-0-81f0ab065284@columbia.edu>
In-Reply-To: <20260804-remove-wait-on-page-writeback-v2-0-81f0ab065284@columbia.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785869541; l=1302;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=Fy0wHmd3j0nRih2sYwsjYIDOGoKEx9pprPd7Ycd1PEY=;
 b=0IePVxuLC7vw8rtzQUNlq/BT2+vfHxRsOOG3aH3xK67+jgzeo9E2ec8vR2z6rFQq+G4a62iq2
 yew0TORASoFBpyZLd/LrUzrNW1mBhpUUwLMTTyU+1n577jdtw9woP3n
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfX4Y0WqAmsOdi0
 T/tVMtRmp6/62aSgKuhvnVf0DbHi28PPi21+yUF+L9hAtrllmPUN+oCXbsMARFMGelF6NnbybRR
 YC0FtMc3qJpiGWJQayKsY+W4mHkVmOu12ZoeGwqi7Z1Jzm2EZrNo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfX1vC0cELSTpSW
 YDCUWvJm0YETcqSREywmLyUZHMFlfmYnOuESoZqgOr3zCptyCF2JYjQo34LDptvS/f8ysMWK2ak
 IpUCdTgG2+nYB3TBk1PA3M2TndUoGz7ohDRhCNei/whRH9OXZWXxRvY5gXcogyB9EUPQA+TSygV
 p1uRaFRPD0f/HvZ1AzD2BIv/eQKspEYAJb5HQH1G3TwZ3whnHut9uv6EMCSiwKz+F2uxt6Mlz9T
 2kt+4CgfGORYuy0yKjo3OCDZLVCwBwZOtRP26GKImtJxABNXzNAKAHMvbeRiOIfyPraJQbfOcrA
 0OnKertHn5VaDXWNKMd5QEegrQkpCI+bhBE2+qKMLw6V6HmYyNxB18JB06WE6DofcanvYjfOBLo
 S7iEq/6fuN6eHN/65rm+Q5xNykZMBpy/VNyh7AxAHnShkYwE+6XOZ+3ljVAOoEKud+/wW71FCYw
 G7IKKuwcIsdfpW9OsYQ==
X-Authority-Analysis: v=2.4 cv=dsnrzVg4 c=1 sm=1 tr=0 ts=6a723506 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=j1J1DEHOHTVaJYOjuVnKiw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=pveTg1YcNyQK2WBy6c8A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: NhRUqutgo1-WpGLYpCqjaSQxHNHfxiTY
X-Proofpoint-GUID: NhRUqutgo1-WpGLYpCqjaSQxHNHfxiTY
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11865
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=10 clxscore=1015 spamscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 bulkscore=10 impostorscore=10 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040152

This function only operates on folios, so rename it accordingly.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index eaf5b3f6d13f..08d854ed663b 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1153,10 +1153,10 @@ bool can_next_page_be_processed(struct ceph_writeback_ctl *ceph_wbc,
 }
 
 static
-int ceph_check_page_before_write(struct address_space *mapping,
-				 struct writeback_control *wbc,
-				 struct ceph_writeback_ctl *ceph_wbc,
-				 struct folio *folio)
+int ceph_check_folio_before_write(struct address_space *mapping,
+				  struct writeback_control *wbc,
+				  struct ceph_writeback_ctl *ceph_wbc,
+				  struct folio *folio)
 {
 	struct inode *inode = mapping->host;
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
@@ -1340,8 +1340,8 @@ void ceph_process_folio_batch(struct address_space *mapping,
 		else if (!folio_trylock(folio))
 			break;
 
-		rc = ceph_check_page_before_write(mapping, wbc,
-						  ceph_wbc, folio);
+		rc = ceph_check_folio_before_write(mapping, wbc,
+						   ceph_wbc, folio);
 		if (rc == -ENODATA) {
 			folio_unlock(folio);
 			folio_put(folio);

-- 
2.39.5

