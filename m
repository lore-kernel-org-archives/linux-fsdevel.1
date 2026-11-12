Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508243;
	b=yfdEBqaL0ROyY+WHt8Yt/s6Tr4pDBiv3hIdFti9ZaZW2khmxLpW3Cr2+OSLoyUCU3x9c
	 GKHTKNBogZ4vTIzmyTW1pUAt0EDOxb17YGnW5OmY5cfJZOxn/ZzF69RpOgCXpvRu5agug
	 E5OKy87EAy7NA33XrhmzEAiDEzwF0Wrs+ROJUr482LQ0AfjNf1fy7u7UFc4Gxk90UiIti
	 5445PUGdD8qkddWZlrIfVjj3e1YshqlGww3whXyzqhrShKaaN0eogHPmYvg08A4lA9Ulh
	 ZTJnzeFlpXe3w22iC9unzz1k0XFqLWojh4vFi6FG84lxTmwqbk8rg7TOHrStq17rKUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=8heaxWBSFkRNUlviiZ9nDMXdRG+6YAFJsY4iZ/iCCrE=;
	b=zAH6ZlmwwBoSIsVS15wu77RsGhrkSB2WPDiY/BIMnmH+PRRAdvyCAW6LxIwYYhS8BqF3
	 Mz6QNZLeu0Vue70RQyRSataVQ2fky4CC8BkAHyIKAZm2Pwy0HAtn9vT/ZXlkHTzbef2vS
	 vv/eoru6KsXMdau60tgKrVVRhmez/mn033ma6WriN9zt5C9CMSReSGcdAKXZGUvCNIBxd
	 KYiarpcF2z9I+tbD2F4qXt5eusKEfaXrUTjDi5Uns1pexa4IGufAWHuidB7DoU3f2EI4H
	 uZ4Sh/TguRBqhkGOSR7xjnzbnYaK1YRubNVGf14KPMYpcLLYCRFKfTbLaMyj8MlE8bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=vJ74qCyX;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F29C606A333
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 18:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F29C606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=vJ74qCyX
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91c847584b8so1558046d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 10:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794508242; x=1795113042; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8heaxWBSFkRNUlviiZ9nDMXdRG+6YAFJsY4iZ/iCCrE=;
        b=vJ74qCyXcX4RPu1q1pWA1vhNWCJDeLKIA612YCnOph9UkTk4wZGmKb7itWVQVsHJwQ
         D84k4eAolynQVdR4Z0V2Vs1qPLjxPnxKs627gLUAIUQOPMJNHBwq6F99WDbH4tSyzb5V
         o1MCdB4lJoyMWcI1FYX9JotIB3vO0TD6WnOa47xCgEuNk/YxFRRN5fOSpe3DZ4hEULua
         XOB5qttzjKSnizPanqcHYLfj5Y8XHX0lWFY8AdsIzfqLtzUm9HyCowH7rfouyjQZtFmA
         u0KIiAKQh0a2TARUWPEKeNE3ggWEYvjvJey5Yo/yOyd8qaU7htJCl+b6ZnhFL9Bdw4wU
         XI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794508242; x=1795113042;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8heaxWBSFkRNUlviiZ9nDMXdRG+6YAFJsY4iZ/iCCrE=;
        b=S/N5NbaL6xiXByjvJgV4dEJ4D/cOaDOViDtVI8/SQhbH8uf0IaY6U1kU0+MoHjBl+z
         B/OPpBz/w1J/KF/iPDTQj0bKYROn1HbJBaJSDVlZsIEWsfX+KEO3D1DE7Y1gLeRfUOPC
         Sxf9pKkjX879zRBaYCaiJV45inAe4kUtwQ4oZNYMqEgxoaZbuGJqV30C8DF2EUimhVKe
         ONSKSXGgCzQDQWxCnGMsLw2cxEP+PbQ4c7ojX6aN0t4uKr03EYmNH8aheZeKKlksNfM2
         Map1L3MOhoSfBrO66xLob+c+OoK0G/Ws3mfomdoOheeX+m75ITXXkPZD6TiYG6WUByI3
         3lSQ==
X-Forwarded-Encrypted: i=1; AL+hErEWPGOyvL9YKVzUzV7hmy8hFhTMwU5Ffm8AuIO/0cMr3pe3lMzZko7qKSvkvvtOoLMzWNdg9bUHZZyaYwwV@vger.kernel.org
X-Gm-Message-State: APuU4Z+3lnNJOfutQs6JCYxdzOC9DiCibG8IjHBjdpi7duNP2nqbK/KT
	uQcIx8Yrg63P/t0JRXOfx9GFDAI9wtTlEaZl4ULxzBXvgsgEQkNLV6v99kLv1bXcQC0=
X-Gm-Gg: AYBFou1CcZcAiHvkA6cwp39NjF414fMjZEeSJXwdfUVXqHCCknu5qTix0ay8v6QTjCc
	1fdi0cZMi8lBjJjx4qiI/XzzUT9/AG/jlJ2Li3X9y6lPeo8VYKLX5E5q0LzlCBP6JluXBqdDBD+
	uYrQmh6j5OeTEEt0FB6QY4yvfOTYSimjprClTt4FIFGDcjmepLclL1YJbxp5vlg2MkSkEFWb6pF
	lTHzhdSWULXMj0g3ykAgNcgLFJx0/9FgZDFVQRndQFSkgtjwH18H68vuyyUVXdsxgDmGjB/ur5Z
	ccyUAbzbJ2wTWo6WG848HRUhmGHZiy4XDDI6a0boTDYjlfBZiD473FAhxqQKmN70Zeq/zsESCoF
	8t5qMO4F1G1K8BcVfxKNJcP2QI+gUVc/UCTudc8qLv6Bh85EbLTPiBvhlEjrJJqqjPyH/E5CoHu
	SZbhg6PlRnXQXXjdWV8oDD7VXZczzZrJNciAdPfdSOTRJz02QdwcgYHYOFc1KyzStBLwWqN0lle
	pUkz8MHbcG4kGDjpnBinNQB+5MMDDbe+jWZ5lqD6Q/sJaoi77gtM2k+0SyssuVXbjYIIaRZWxpS
	eel/u76XVB9/joBr4dyLlDQsJ8UcD1oIk2S1FRMMu/4Dlv4WKP6gFIxnxN+kELfx+qauqmTbYTI
	elHDjP0I=
X-Received: by 2002:a05:6214:4187:b0:91e:b592:ee15 with SMTP id 6a1803df08f44-91f13978bd6mr53482146d6.15.1794508242079;
        Thu, 12 Nov 2026 10:30:42 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23da1023sm1861256d6.34.2026.11.12.10.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:30:41 -0800 (PST)
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
Subject: Re: [PATCH 11/13] percpu: fix contig hints that are too low
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
 Rick Edgecombe <rick.p.edgecombe@intel.com>
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-11-3d2454362e8d@kernel.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-11-3d2454362e8d@kernel.org>
Date: Thu, 12 Nov 2026 13:30:40 -0500
Message-Id: <179450824041.482102.13630289942269263315.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-11 18:13 +0000, Lorenzo Stoakes (ARM) wrote:
> pcpu_find_block_fit() skips a chunk or block whose contig_hint is too
> small for the request, so a contig_hint must never be smaller than the
> largest free area.
> 
> If it is, atomic and reserved chunk allocations can fail spuriously, and
> others can create a chunk which is not needed.
> 
> There are three ways in which this can happen:
> 
> Firstly, when an allocation breaks a contig_hint, both
> pcpu_block_refresh_hint() and pcpu_chunk_refresh_hint() promote the
> scan_hint to contig_hint and scan only what follows it. However a free
> can set the scan_hint regardless of what precedes it:
> 
>     free areas    A = 10 bits, then C = 50 bits
>     hints         contig_hint = C
>                   scan_hint = 0, cleared by an earlier allocation
>     free B        5 bits between A and C: scan_hint = B
>     allocate C    contig_hint = B, the scan starts after B
>     result        contig_hint = 5, but A has 10 bits
> 
> Secondly, when a free stays within one block,
> pcpu_block_update_hint_free() passes the end of the free area to the
> chunk hints as a block offset rather than a chunk offset, so in any block
> but the first the chunk hints are not updated at all.
> 
> Thirdly, that free area stops at the block boundary, even if the free
> bits continue into a neighbouring block.
> 
> Fix these by always rescanning when a contig_hint is broken, passing the
> correct offset, and refreshing the chunk hints whenever a free area
> reaches a block boundary.
> 
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: da3afdd5bb54 ("percpu: use block scan_hint to only scan forward")
> Fixes: 92c14cab4326 ("percpu: convert chunk hints to be based on pcpu_block_md")
> Fixes: d33d9f3dd96b ("percpu: use chunk scan_hint to skip some scanning")
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

I was able to reproduce all three conditions and show the pcp allocator
will over-consume memory and in some cases fail allocations.

The change otherwise looks reasonable to me, falls into the class of
"Avoid doing clever things" camp, which i like.

Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

