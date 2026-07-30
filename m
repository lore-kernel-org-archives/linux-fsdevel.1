Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2053B05B1
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 06:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785392928; cv=none; b=WU18Z+2gPIuBoWdbqq7cdxYCNEmlauJvroGFyMQ8mKOlzgrxtx1OaZELAvmN644YUhhT5oxBKMem5TYGjk3lFUqABKlM82bSUMsRXj0mO2QrxKTuRsbpVJYRwpMCB108nyiKJq/UtL7DWEMelxmnTgJXz98zjeX2/vHTXuTLHqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785392928; c=relaxed/simple;
	bh=On1K3w81fo3KsHiluy85FHhsNbZ3rFpNf8XA/wTGIuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrpCn2HVwBwLLlSMRMz65bvzenFyGMuSizXKJsJhqL7zYq0PeOxY+/zaAKUQ7KsN9RwNpD1N1ozbo16gJDqttJDwPbiv++migajZt8qktv+CpfeDISEFZVPB/WW4fVyy9prU4PP7Ut4LWUmP3VNBzaFytNrlZX0KsXSBEGOjsIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Xoinvwuy; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Xoinvwuy"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e99ef0902so114341685a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 23:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785392920; x=1785997720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BYuSkRMlAL8RFmXTAhfpgmHH3OtvbWBlkpFHBuC4V6M=;
        b=XoinvwuyyCqJJMjYeE7YopI2LKZonCNERKJgEn5p0j1kOL5jpSypAzwv9MmO6uHx6+
         VE3FKIFrwlodVOQ5QkuhSzQJA82N4rVG1aEX71DT5fbmQ0TVhNxDUTqG6DP2YyvgRJzA
         Y8X3c7nCuBtToSOOkmMYJi3gtWBTdH8FsfZzNRc6flOFGmkn32LibInyTiy/FDCxevVV
         dx9ySgcg5a8jmJvLo+tl+CGNDf2hkhxPPmSdW0bDnHEOKwykZAJCMWXQA8YBxPWlsM4U
         A/wUkTk5Gh1c8Cp80l2UbEMGG8vGG5IljZyjR7piGMOBrMLgOba/fTeb0QKwn5ex2wge
         kWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785392920; x=1785997720;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BYuSkRMlAL8RFmXTAhfpgmHH3OtvbWBlkpFHBuC4V6M=;
        b=paNVF4F6Eq1AvVB/g7OzCFYTK/wYqfAepswU4corOC6SFMtXjkt2xc88K2ZBS2vtGy
         tnfIIh6KIznslnm0Rb1qcygcnxpDVfkS2cMB8i/83j0MAFpEsatoPwA3nBmNxxk2jAdA
         YYT9HSwzeQFfrZH/Lg/e3pT6otsSOTKoBnEkVCesqbIRKhUzj252+dlKyc1ueMXhLtX+
         UrsmMF5x+zqyMbiLM4Bh8IICMxfWyImm9Ur69hLx7C2PhiYWjNN3WG4tbOIq2UtvqpPx
         e0izDhpy5LmA6IoAu4LDl9BI7MwVTOeI1HPj+KLgaLh8nJ+tKTWgViOt+AkTA6I48SAO
         e1rQ==
X-Forwarded-Encrypted: i=1; AHgh+RrxFEKt8ZDdAO8FiCp6CQSI/qcxrnVipW2R62hNfB4JKFZ2qrY3nGlRB7GdxzYD5RqJ0nv/d1EHXu+hjj5q@vger.kernel.org
X-Gm-Message-State: AOJu0YyEToez7wX1XoWIbEeDLKal5WS98VJTqshj7hPt+gkVtBSa4iv5
	IFpUThSgyG8mg2Czbq87YihE9cWy3hoF1HMaVrMVHITAMtN11OUuYQeAbuJAmlBLhV4=
X-Gm-Gg: AR+sD13RgHzpCNeU8F5Giw3qFVQuFPn26YbCCdlXZ/5HD5cQp97kKb2+evbhfPtmkm1
	D3yiW/Vp7nD3hrv06keXCUMKEmqDa73R+zfrG/xMJV2G6fLndzI5VlkTV+nMN61rlnZfTiQHR8Q
	IjvlUQlmMmqzCLxGB6DScnAH3JuySvS3AhXr4z+wNhTMxagCCtAkgnB/vo754ho2hNFSQl3v+wy
	C4fnQZOkMckdTWGKitVv/XcRkDCid7XVYxddJHwuZSVwYfCVy3RtxuH4EfxNiZbcbnSmtrXJW03
	yckbgPFtxpuG8GBzP6C0iSFd/n1dlg7/TZm2Qbir81K6gbPAEtJVB6iwWzfi28pZjmIr3H7bWZg
	T7cY9NfPRFcm0k8n92zqsZhdPU8X0sTK0+anERrxc6FVuhUgQlkC+HpAeRlZSwVlpjyiDROfica
	hclyRbm0M8/bYTqYuUO3a7kHA2N7JZN+sn37bRpUmYitSivucfrjIh2tPeKmDQk6DWlWSEHOYVi
	pBuVCD+4YxuOntGeUm0rNUhDfEGyBS506C2/cn+YoLhRfqM6WKHJIU=
X-Received: by 2002:a05:620a:252:b0:92e:fe10:3f02 with SMTP id af79cd13be357-9348613d64dmr94585385a.51.1785392919868;
        Wed, 29 Jul 2026 23:28:39 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933e7318180sm346275085a.28.2026.07.29.23.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 23:28:37 -0700 (PDT)
Date: Thu, 30 Jul 2026 02:28:35 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 02/15] mm: introduce linear_anon_page_index()
Message-ID: <amru_6sVmelONPh8@gourry-fedora-PF4VCD3F>
References: <20260729-b4-scalable-cow-virt-pgoff-v3-0-e8ecfefea812@kernel.org>
 <20260729-b4-scalable-cow-virt-pgoff-v3-2-e8ecfefea812@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729-b4-scalable-cow-virt-pgoff-v3-2-e8ecfefea812@kernel.org>

On Wed, Jul 29, 2026 at 05:48:37PM +0100, Lorenzo Stoakes (ARM) wrote:
> This function provides the anonymous equivalent of linear_page_index(),
> instead offsetting based on the anonymous page offset of the VMA.
> 
> It is valid only for anonymous or MAP_PRIVATE file-backed mappings. It must
> not be called for shared file-backed mappings.
> 
> For pure anon VMAs, this will be equal to linear_page_index().
> 
> Assert that both of these invariants are true In linear_anon_page_index()
> and implement the algorithm in __linear_anon_page_index().
> 
> Note that MAP_PRIVATE-/dev/zero mappings will satisfy vma_is_anonymous()
> but not fulfill this invariant, so when asserting this we check
> vma->vm_file to account for this.
> 
> We do not update callsites yet, so no functional change intended.
> 
> Also const-ify vma_is_anonymous() to make it compatible with the
> const-ified linear_anon_page_index().
> 
> VMA userland tests are also updated accordingly.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
