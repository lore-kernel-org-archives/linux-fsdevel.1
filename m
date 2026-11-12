Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503243;
	b=KFG17AmjJr2x/Mgrq1gylZMhlQd+bTTCBYBQN5j8BpzZU8VogVjG/1XKQfQy8/r710yP
	 5WFmEoPkGrbJmOwrj+M/VbAIRB5ZK7kQJjKlYlrTFKwksoRDcJ2yFneRwyrIsp0+vWnbP
	 tWA8OmmTOw9QxK/hgvOgyhBGGzvFqV/B+pfNF+37OyfMBBmnQ9WJ+XDSpygU4hPDc38Io
	 h0wRoaPxBcD/DgeGdG3hbbvxUnRLJTWG0o7Q/V8xsYBAKQpdmsHmpWicUWb6P+ju7NW7W
	 yOCihnj8pAxmwBXdmlbrWFwRunStoFz+HW29oy/rgmyGEWYhL9Lv3GV1eumSOr88rwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=KhfyBc//VTsBjqGcAjilygXZyjWzwwcnsTJakX/xnqg=;
	b=fV2EPrsz89CCMQpD/BtmN+dBEmXqS5t6KCORCVAyBWtmGqVY/XMRyRPfKtYRSKqRc1eP
	 HVZHRRZr6InNo0jeKbW9m6M7o+i3CNFKLAwl3tJUaSeVWkTJksTYsMHd+zTnoWbT6VZCy
	 VkMOsXwrtKFWto/9lJ1WwC4c8baLqlnEyVoFEy8RTbsJpeApUqmauc1LKLNutRg/z0D1H
	 s7jLrb3dEYJV+SY2UccEmoEr4ptktiDje3aHX6yYZoYY1I4okifumUj0pnqHNIg2Usi8v
	 1lj4B//mpIxnii4Mc1isCzDuC8qP5Kn31HiGpXS3RzPn2FNVQho+zuUrjPNhil6irmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=XxxT1kWh;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47557606A333
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 17:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47557606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=XxxT1kWh
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5363c8de563so46343981cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 09:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794503242; x=1795108042; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KhfyBc//VTsBjqGcAjilygXZyjWzwwcnsTJakX/xnqg=;
        b=XxxT1kWhf77k5HWqZd5kSrqa9TenqWzfTradsETOEJAdqwv5kPkm0YFAc3mX+F37IW
         1+OIKlYSvTjKdGZQIoIFNycQRdshGBKzSLwaeC3xje+Rkrey59b/rRuJgxLtsESLtKO4
         fVWG/05n08TabWyxSrBJEGHgNJOaxevdOavw6rdXW33g2qgVFOyhrVMQNIPDgYxyBNOj
         2Sq8DODDDCLwWpRKQfxahhMapheQX0LjT+is2oM2+S/96qVC+UBHAXoB/dIaiPzzbGzD
         yM8k8ffsmtFewc5wlZ76cXuEnxlW5NNd8lrp6aiYPxKuJhlQsaEgK9Cy3UNScEKqkmnv
         IQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794503242; x=1795108042;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KhfyBc//VTsBjqGcAjilygXZyjWzwwcnsTJakX/xnqg=;
        b=wjBRza+2ul6P4z0avDFPGS0vi0iilcalu4zx0IBha2bUKGxdTTuV/9qBpVNbgaxfcC
         2w2pkxxw+QSnKq52ERiy/vpa1sNwrSIaIK+TWTEsEROIxiDTmPZt+s6y+O52AoeI6pq/
         OWHSMSi8OKbpRWIbK0b6dIy+Bhs3U8O/q1ou6+2GOUEBhZq0YMbnXXFxNR0wiKzA6F9+
         421N+hKE6oXakQ5vtD/JjchGbNalhc2JORZt8XMdH95cGoQuk/4NC+FHmxaFyzrpAQ3o
         7Jnvwu8P4NMsAFHpDvtAhUy3ocbeLohQW868IlPQp6w1gUooyU+ohr7/9VvTJkcGat8q
         wgsA==
X-Forwarded-Encrypted: i=1; AL+hErGA24zk2CGPBvl4Mdt+FVlM25pBDqawD2AvVZ6TRioNwocNFcBNN3y70FzA01FRKYLV7PXcD8cxNy4/QzPI@vger.kernel.org
X-Gm-Message-State: APuU4Z8PzXyW723XtCUcNN7SBL+l4x3ubguh+Bg4OVKuLH2ocWDoLDed
	GbtM7ad2sG6WChPwmeByVahQwxNloE6x0TJb0Q2xG/KqifDtff6Q3FEC/5+tH6ndCfEMHjN6QQo
	LiFqk
X-Gm-Gg: AYBFou3JvC7bK+xdeivq1HmR51b1FV3K3+NQ9aPczp5nXKk9sJgzoZWiJH314/o7CFk
	usb41Vcb67jtfx5m+k8Pbv2HEtvZC2kKG1pmYM1FyTD+x27ZZUAaCIH3nYsaGyyJz4iknl/69mj
	7hOFD3A11eMv71nO7EkudEJT/zIUaN2ntT+doYEVUBhfvsJUb95nSWrMkaSe+JM3TdEhwSd+KTo
	lD5wK+874nCf/0Ef8LnXZIkl8x0fltY4BEx+ulKcMsc79D3QjDNqBfLf9Q3MEetv4FBAtfDcQ96
	+x5SBModBWsbiqfhgocg3Zo11fS5kZqEtnp5WA80Cg53BiB2uUAFYsMfjeb1xFFLIWRXm55L/0K
	4GdwVYRzQwh1CsA5DAUrkFkJ2x9Mjxrt/TnmKnvlIkqBDCPEDNqxEfoojZACEqYfQNecBDWpi7c
	iEuRI21iiLtq2XlZ3UDIJ6Rd2tiWraqYiZcp0UFgEhTmK5wu13YcZRt48X2dUHfcKN476AIxdpo
	7Q+xKUgQ0SQ8AoGUyvtJIPEt85ITFJGgZ/n2WRjLLQ3AmjydcArzHyfeUK8aHnuab8KEPRsKm1+
	ygAVbuevjpAmlSDLU5efYghXKPv2/dXpNHztFZCWrF1yNUUKJKppcWBXJT3U6zqsExxTXufufXG
	qsZpFUeU=
X-Received: by 2002:a05:622a:684a:10b0:535:70b4:3f7b with SMTP id d75a77b69052e-55aaaefd128mr5760821cf.65.1794503242102;
        Thu, 12 Nov 2026 09:07:22 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550bd33340sm78278751cf.21.2026.11.12.09.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:07:21 -0800 (PST)
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
Subject: Re: [PATCH 04/13] mm/migrate_device: allocate THP deferred split
 heads
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
 Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Glisse?= <jglisse@redhat.com>, 
 Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
 Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
 Chris Mason <mason@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 "Borislav Petkov (AMD)" <bp@alien8.de>, Mark Brown <broonie@kernel.org>, 
 "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-4-3d2454362e8d@kernel.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-4-3d2454362e8d@kernel.org>
Date: Thu, 12 Nov 2026 12:07:19 -0500
Message-Id: <179450323943.482102.10332650234844298705.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-11 18:13 +0000, Lorenzo Stoakes (ARM) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> A THP that device migration maps into an empty PMD can end up on the wrong
> deferred split list when it is later queued for a deferred split.
> 
> This occurs if the memcg has no heads yet (resulting in a warning if
> CONFIG_DEBUG_VM is set), where deferred_split_folio() will then queue the
> folio on the parent's list.
> 
> Once a later THP fault in the same memcg allocates the heads,
> __folio_unqueue_deferred_split() and the split path resolve folio_memcg()
> to the memcg's own, now existing, list and take its lock.  They then
> list_del_init() a folio that is linked on the parent's list, racing with
> anything holding the parent's lock, and both lists' nr_items counts go
> wrong.
> 
> Resolve the issue by calling folio_memcg_alloc_deferred() after the charge
> in migrate_vma_insert_huge_pmd_page() and falling back like a failed charge
> if that fails, as __do_huge_pmd_anonymous_page() does.
> 
> This was originally discovered by code inspection.
> 
> Fixes: fafaeceb89a5 ("mm: switch deferred split shrinker to list_lru")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ ljs: tweak commit message, remove unnecessary comment ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Was able to reproduce the warn this spits under CONFIG_DEBUG_VM
and see it relieved with the patch.

Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

