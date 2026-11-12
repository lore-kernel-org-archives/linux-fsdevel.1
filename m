Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508418;
	b=ejvmmWV/AYMykHZiWwOerZoG7jm6UKA2byKkvHhYbW2Ol2Oe4XdQixna8WV0OigRcl4e
	 fsbQDsw1iuTDvZ02Nx3tYFvjDWsUV5SXSFK35CPfxfpu+CDoGCMmuyzasooqhQuIFdlfp
	 xXGhZLowoz6gPi2jhepJq82LI6UWKRVBpQ4jitBNx+znAQsdyq7suiIwlUC7wAePpzQzz
	 PSRPmDHL3mTG/Sl4e/LdDjJqyNS9q8UpwxWWWEgkpSID0OblnSeRfH7HNTWdUtbUY1JZ2
	 XDxMjhs64YtOiLMFlQDucuAeXcllqE+S9fDOdKNEThrP1IgfIieORlV74T47vtH8v2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508418;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=E0X/oBNSd837oq8qemdGMRW3gOZl3XdynAbQm9FPXsA=;
	b=KlCIjrfAcQ5uZwLwfuABdZrPEA/8oERlSUuCVF8vHKw1zSOV+roJnB5BGA5iC/Vrn1h8
	 95klAcAQiAruQ0DdiPzBsv7lw58cLmqB7iUaR7bMu3uu1BuBQYXc1YbaBG3zR0DCCQ8QI
	 CVHcYBEzBu0ZExrm5a9T0AbHtTZ8jzmdXE8BEFzhd6h64QBXOVPsRjVD7Q0wUeTPZhkk0
	 oVyddjBo1sdJ7bPLuZHnWedIzvLh7fo1yU4HY97uohh/3RbG9SOeaYb4YSQnzPQ+WTIQQ
	 GjinXhtIn9e94QZoDcT78NU2/eMZFQIamnprSoalQxFoZDS8LOMJva20IVQnRuV33yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=vOr2VvyR;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3995606A884
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 18:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3995606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=vOr2VvyR
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93f079a63b8so3176885a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 10:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794508417; x=1795113217; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E0X/oBNSd837oq8qemdGMRW3gOZl3XdynAbQm9FPXsA=;
        b=vOr2VvyRtP+KBt6PNgpsroLYuZ2WDXRyTOc5i95zgwooIsYRcxqQzqiTLUmi/IXsxY
         hHwNRJhCrscdVv/HsHUP4QAcTt1cJdndeVKPMDxbJ861WXUxNdUDlH6/AnX5mNWc7Ok7
         gz1LKAJ7k9EX0GE3xjhFTEeo+pTWtrYXtUOm92dteko0p+d/6NHk9jVtPuT8NDgnPWvg
         XtxTBeTZ4wwWnSR7wfGblG7vb8M3uTKovXED6EyA5tN4BZTkv+jChVYvxAiFXwAYGK8k
         e0QYgsMMPmx9nO2Garn9QvjiEbljM9VzEiJMpYxfNqtFGezq9HjbZijLAU2AbIeA4Mjf
         wCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794508417; x=1795113217;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E0X/oBNSd837oq8qemdGMRW3gOZl3XdynAbQm9FPXsA=;
        b=PHlf292RHKJsRw9FdS1sqs7gihSG2cKikQ9JDIqNCNWJo5AS9jFxLoNBlMlmriuu8x
         OCLFWQY8VBysVGpJn/eNH1wyXsFLACCxP2T+fCT2cmdXU+2X8U6DvPYlojUHOCGYS7rB
         HKksQmh10xcuAIgFEMeUpC5GSwCPRBItxF0aDJfXO+aksZfG+h77jccA9C2iFnI6k94P
         4JbTQNMcta35NODCTCkmJyl3NA4XwpExOxdxreWekcVewje7w+rQgwL12Qr3OMBlOOBz
         s0wMeA6m09m4zBB9+9dORVZ0uO12KLduvU82v46ACukemyKmLxBk+WAtvqrE482HVnbf
         rqug==
X-Forwarded-Encrypted: i=1; AL+hErGMnJMlcQAotqZ1I0JP6VmQqSFe3fl5ELRX+9tP3o/x5X3tFs+swyneqCPE7FSRv5IFI+pvWwJD1fkch0H1@vger.kernel.org
X-Gm-Message-State: APuU4Z9+am4O+dpic/icYv0zw8vofxSNzIp2Lqvu7nqkv4oPV4rlADjq
	4E5mXm3ct2KA8cVfa4ddj7dGozaj84Pvg6EoeywkEaer/vBw0tSiCK6X0ISipe4seWo=
X-Gm-Gg: AYBFou30qmWkkKFwAD2/1Fqsp4wxZB6Y/syByozHncTeLnCYBTulS9Xsl/k8dnqcVdU
	IJfJhsQm7gVHIwZEsO1k/rX/H+88S87XZrbWMgE427wuPuZfCLrQi09DFbl1rvljgwYVh8zsUe5
	NhdFoFw6TKnEjmVJKyh21OFqizKPQRiZhd9jX/aBuOD+doKOJDeWCY33eoS2DOLyUHt8NM3MnD7
	6wxvMMp7SaNQRaFPWQV5/wYSotZ0hztllLPpzPHtH0bhotQcEPE6gwaxClZt4gILK353VdMZW6K
	BLjZkhXiHrI/ieVl1nBI042f/9y9L4aJsPA/F30dgZNo7kUQ/wXgvDdvd+PpdQzMpRDsEhBfi9s
	g4UQO9CCOgBjRPG9ndqEhEHCBvxBVcwAo1jDOMtA+uIxcfMehyeLznge1jZyen58Pz9FCsACbGd
	3oOlt1JDJBdlpr0FuwlvD3E2jGtVCzavUDjmlQN7h4LY8Pf93GMGugwTtHqRuYCgOXotXBKHncI
	8e12rIlSRhRDUgigUBuWjOkujTLh50x6Al3ymFxFfYiU2BDrdbFXC2+8qsy2JzzBPwl1ycz9Ccw
	dd+1qgv5lAhXRoLAPBhFbXbh2sw5vpPWxgt8Lxwcjo3iPpF2petffIlnCPAIxSqus0JIAds8xOp
	7s+Bx068=
X-Received: by 2002:a05:620a:27d0:b0:945:ad43:1d59 with SMTP id af79cd13be357-9494bbef3b9mr40481685a.75.1794508416926;
        Thu, 12 Nov 2026 10:33:36 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d456b2sm2035036d6.12.2026.11.12.10.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:33:36 -0800 (PST)
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
Subject: Re: [PATCH 12/13] percpu: search the whole reserved chunk
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
 Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-12-3d2454362e8d@kernel.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-12-3d2454362e8d@kernel.org>
Date: Thu, 12 Nov 2026 13:33:35 -0500
Message-Id: <179450841509.482102.2272758511939089806.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-11 18:13 +0000, Lorenzo Stoakes (ARM) wrote:
> Loading a module with static percpu data can fail with -ENOMEM even
> though the reserved chunk has a free area that fits the data.
> 
> pcpu_find_block_fit() does not scan the allocation bitmap, rather it
> tests the request against hints, starting with the contig_hint of the
> chunk, which describes its largest free area. If that area is too small
> once aligned, the search gives up even if a smaller free area fits.
> 
> Consider:
> 
>     request:      256 bytes, aligned to 256 bytes
>     contig_hint:  260 bytes, starts 4 bytes after a 256-byte boundary,
>                   so 8 bytes remain after alignment
>     also free:    256 bytes, starts on a 256-byte boundary
> 
> Ordinarily this is fine as the allocator moves on to the next chunk or
> creates a new one, but the static percpu data of modules can only come
> from the reserved chunk.
> 
> Fix this by searching the allocation bitmap of the reserved chunk
> directly rather than using hints.
> 
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 13f966373f92 ("percpu: skip chunks if the alloc does not fit in the contig hint")
> Fixes: b4c2116cfae6 ("percpu: update pcpu_find_block_fit to use an iterator")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reproduced the exact issue.

Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

