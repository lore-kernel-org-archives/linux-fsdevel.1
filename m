Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8173BCD36
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576124; cv=none; b=Z7KDXlFXukeQVF9oRjbCcfwotYR4NQkpNTSS9Zarz4xtYznhP09l2cECMH4GdcQcZIzmFVqPvhDIH1Nc64rVKscKajGtHOZ0PDiMYLLT3fxcfA4PaVu7j/pkn75cBGSksKy/UTQvzuJSoCkXwa6Jd+2NgputocUpnpolB2ckix0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576124; c=relaxed/simple;
	bh=wTYQxiwnnNn1fQlaf49KQEuG8RjOnNBI3U36p9hX2rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTnxxIOqVTQ2lN2m3uOwlmgpbFQk4oun2eyLUBpNkUmTxv60eTxFcGq2quKHoaBBUF5OW06CdB2+FvXt6/E+uSlT0rlny+JLCV8f+dM0Yktc6XXjKEUAFE8mVdXMfUWqp1JcO2RgXitdXbzOw/iATQLcJVJUYzub6SHa9WjG2vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=vLMs9sBk; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="vLMs9sBk"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e6c4a867cso465776285a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 12:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784576118; x=1785180918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HgkUnnQve0Rn/Pvs0Z/0q3yFfFJ0c7Ckz6K5pdtr6eU=;
        b=vLMs9sBkiBOQ7nWM2/JvINrnxvZuXiHaXQoiMxPSr9eLnxFZ+Jzubfq8+Y765V6jXH
         Qn8sZ2I2RIRe0s69fsIAccrMwJQGCsw8WCY05tISAT99hWL7opQyW484byM6FeBWNaka
         m8yYTUY6rBYH1WE5qrmHC8lRhBH3osqitPluMLWB2m5jHl/iIAHL4mhmjmPkqlZ6M4n3
         6kxnHP7O1qeE8JGHbnySHwQdHdAcGUIsO8lJmjhLJSppROXwONURxUzeicmaHtBoahjW
         kfzSqFvXdhsznzyA2nTDknEFEDy98eJefQV3l5V0+vjf0VGjoLjx3uEklcDvL4B5rIL0
         HlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576118; x=1785180918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HgkUnnQve0Rn/Pvs0Z/0q3yFfFJ0c7Ckz6K5pdtr6eU=;
        b=lp6iSZRUm0GWjRw3ef6T6gqxUCd5cZrrAlpKcrfB6Jxwyy793lbbRF8MH/qAOhu68I
         A8ngpNbMiSPv5oHPoh2tGKu9W6Sw98BxewksVyIRZDas1RQwk/49o6TbMhuNzzyckDf1
         0X5x48GBlFOMkrIAoKcxOp9PRf0ol9qkKDwjQOqJFu1oKGzWNrHMLjO7Mwz/iApyJac/
         cJobZ4HSOEPdydkeluo5zMOWu+e1UIELNBSJOv0R5B+MRg+ZxtRELtSomM1oOB+kFLZR
         aoWVi2ROnaHTsEoaOHK0EYuUMzRk4y1vmuF1pbkqZ/Rny1RdCfmQIkl2oxVe0/Wg8l4Q
         jsTA==
X-Forwarded-Encrypted: i=1; AHgh+Rp8weuHdrepLU1tVM2h+yQOpO3lPtGlk556zv07p/Ulll8xZdX9zmHuTfnf9OnY6Um/FjlklMLOkd8Wl5W/@vger.kernel.org
X-Gm-Message-State: AOJu0YypXiY85o99KgzqLcHsqZDNDTQeUjkPFW2Hrm4z5DgLy5fF5XgN
	Sb62sVHhTm5W2Ytel0zIka86bC8bxAplTtfIL2dk566Bh3bybVGuUyGu97DHSedrn8k=
X-Gm-Gg: AfdE7cnUFeVbLfjqqmqliTX3aKRX0OGtr0GZ+wT/6vHPYnPzx+9IOnpkZU+a3/Cj3st
	f2IfZTCVYKa7naug18FLWStP4zUKmkM4aEAToE3YS9wrKuyRoaS0kFGVC6CjLyuDWzu5/OtxkbX
	5+2Hmqyd7dH0CjeF9K8RNsQhlzW99Aj90RNXvZbNjbWLAkPr1k0OexB54pA6wA+cidyKdwJWa7W
	e3uvBoP76yHAhIT6TbpJz03gavJkU8saa81IeQtYIdjcAPDrOTTE9m7BBtV5suWVegX+vu9Pwa5
	kvwcjRaa03vAD6KYTq5lNgihTy8/VinDUY1gOYg/QpyNB+tO47jVAa55bUotJncfyGi8jI7l0gf
	RvUL+5YzDCrqQ3gnd4xWvA1UzSUGL71gkTD6gUHpX8hs04chMBQKU+7tgjCxjDTfvQEpidvvvZ9
	x37Ayd+rqcydso3JNzi3AYDjPFzWe34MQPZRx7VL0YgDLn6APsw2qDuSZO7By8hLQ=
X-Received: by 2002:a05:620a:4007:b0:92e:c116:bef9 with SMTP id af79cd13be357-930b4315599mr1572701485a.86.1784576117793;
        Mon, 20 Jul 2026 12:35:17 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm957792285a.35.2026.07.20.12.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:35:17 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: Zhigang.Luo@amd.com,
	arun.george@samsung.com,
	balbirs@nvidia.com,
	brendan.jackman@linux.dev,
	yuzenghui@huawei.com,
	apopple@nvidia.com,
	alucerop@amd.com,
	matthew.brost@intel.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	osandov@osandov.com,
	jannh@google.com,
	pfalcato@suse.de,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	pbonzini@redhat.com,
	osalvador@suse.de,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	longman@redhat.com,
	ridong.chen@linux.dev,
	tj@kernel.org,
	mkoutny@suse.com,
	sj@kernel.org,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-debuggers@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kvm@vger.kernel.org,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v5 15/36] mm/ksm: skip KSM for managed-memory folios
Date: Mon, 20 Jul 2026 15:34:09 -0400
Message-ID: <20260720193431.3841992-16-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720193431.3841992-1-gourry@gourry.net>
References: <20260720193431.3841992-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since private memory is intended for explicit placement, allowing
KSM to operate on it by default would completely defeat the purpose.

Skip KSM merge and scan operations for private node folios using
the same filter location as zone_device folios.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/ksm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 47006f494fcb1..dcc5c46a29eac 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -827,7 +827,7 @@ static struct page *get_mergeable_page(struct ksm_rmap_item *rmap_item)
 
 	folio = folio_walk_start(&fw, vma, addr, 0);
 	if (folio) {
-		if (!folio_is_zone_device(folio) &&
+		if (!folio_is_private_managed(folio) &&
 		    folio_test_anon(folio)) {
 			folio_get(folio);
 			page = fw.page;
@@ -2558,7 +2558,8 @@ static int ksm_next_page_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned lon
 				goto not_found_unlock;
 			folio = page_folio(page);
 
-			if (folio_is_zone_device(folio) || !folio_test_anon(folio))
+			if (unlikely(folio_is_private_managed(folio)) ||
+			    !folio_test_anon(folio))
 				goto not_found_unlock;
 
 			page += ((addr & (PMD_SIZE - 1)) >> PAGE_SHIFT);
@@ -2582,7 +2583,8 @@ static int ksm_next_page_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned lon
 			continue;
 		folio = page_folio(page);
 
-		if (folio_is_zone_device(folio) || !folio_test_anon(folio))
+		if (unlikely(folio_is_private_managed(folio)) ||
+		    !folio_test_anon(folio))
 			continue;
 		goto found_unlock;
 	}
-- 
2.53.0-Meta

