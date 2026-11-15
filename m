Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794734700;
	b=gV5gBOdsmQYVS2CtVDfU+z8GP/VKFpBaz5SLLfufOjxK/WOxPspJ1rxvqoKeYjRlHdtp
	 u7wLv2WJnK7VEivV0fqWYTcTn+q35nL8C52OHYHMJ9iqlLeqFNNEsJuMuM8jGYLLvbVJi
	 aGEcPK/ivoihNmoYoMaBD/K/Fj9ZcckYi0qSyN7Ne/7Sjk9OlXiBuPCtem7H+lPF9aEkx
	 cQkAi56Upx2H6cQWQcfgWCRU3UFH7umJT2SWz0OLK/km8p1r6mZJ2HtdtOMBrYbZp0pYg
	 /G7gvRc8nTfQfJb6rMccN4T+ibyIuq/D+8toHtgArG4DaNfy2ihfKfA4t1g4Wx2IM8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794734700;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=9c8p7xnMkOo8VygGtCf+xkzjwVTSeX+xnVktgNDwVkU=;
	b=j0aovjdFozM0bdXOx5o7hPJLI07JeNkZ6hSpm9tiF8TfLpySqmt4ni+i0MlvY1suPabY
	 VydqB5U3raOjWBAby+NH6xQMP5uRO1Y+LHt9Lp3UYIpfVFy8buVOVnDmznkZJchLfUwqH
	 hRFW0eIFpUFIGibsmlnVM0/wx2UPlqNoD8Vsp/YeM9tPQ7MUpvC3r3hnvZ4LcKohStqR+
	 zlr87A+cpSPVGE87JXW4LhB2AMDjHkJ6AA1sh/Sf1UjZWahhRn4S4cWmb9wA1KWwA0Gvr
	 qt3OhpYOVt/Q8o+14xlftjFCpmKey/jNw6Tnqjw8LP1Ng+0xIG+NrCMbsyWjievLalg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bynmu3xb;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=OM22gf9d;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A72E606A327
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 09:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A72E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bynmu3xb;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=OM22gf9d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794734698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9c8p7xnMkOo8VygGtCf+xkzjwVTSeX+xnVktgNDwVkU=;
	b=bynmu3xbjk1GpbFUvUfRxAk3I66xSKCAz1br1I7i+RFko0Jot4WsLyI6Zd66BqF9iAzle1
	zw53xSHivjAabTVskoHLi8Td/ZIpK9vR73zD5jHpQkgHC8OWt7C+5I4PACJkjurYLYvA3m
	EAVHEtU25zLjvYwnDRkEAQOx+5lAbo8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-ts82BPEOOOeOLsGlorn3XQ-1; Sun, 15 Nov 2026 04:24:57 -0500
X-MC-Unique: ts82BPEOOOeOLsGlorn3XQ-1
X-Mimecast-MFC-AGG-ID: ts82BPEOOOeOLsGlorn3XQ_1794734696
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3ad907ca4b3so11033321fa.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 01:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794734695; x=1795339495; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9c8p7xnMkOo8VygGtCf+xkzjwVTSeX+xnVktgNDwVkU=;
        b=OM22gf9dVdnx9TbTO8vNQ9Y8YBWJM2fhKGDxOLV0X6pmaQMXGtuVoJNGXoEpDuyuEF
         HsenWSJaBPqwm4A06rMK0yCOt8cq4fURVt6VduV5MKUGH8lO0CRRXvRCRCl6bk88ang1
         WyL+IbAycwZEZl9BSkmQmIhm3/rpvKHfeaY8piIe0u7RwhQuagKogxLvzgLY+6IChws5
         gKuppmnrjIYqrSkqKRcOC84+toW18d39+PbMxIzRHoVKWD3tpxVGW4Ts5UNw57NB08iX
         jOAEuUt5EaPpVGxlGzuCFNN2J3UROosEEggceQJHEjQZzygFHJhsRVJatiGk7IahmJw+
         Zltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794734695; x=1795339495;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9c8p7xnMkOo8VygGtCf+xkzjwVTSeX+xnVktgNDwVkU=;
        b=LKzn5YFTHu8iaj9XbdrsQvbK0EOPWAw3r2AfsxAdNMhq4EDr7zZhQ3HZvx1DCiVjWi
         kQo2xIxHn0XnezOyBKjEJxlTV3/1+4ERZRDWnHniS9wRylm4jdd7FAshlJchDTDrQfNG
         4aj4cBcXhJccw2nP3hfGrZI9ODKgEfdMHClCqbnHHTBBVX/oTgJkWU+P0dltlQYc1EuV
         v6jkwEc5Rdgi7o+t21plOgnDNUhOnGFVAnWj5PY/5bvlDPy9TRJsm45SSD+JAvEMCk/t
         2WBiWKijPc1sjiJNn/1VdwRow6hlG7chHVINQCvjTIQ7lWLw24PzNDpBmkNlcVfi85Ma
         zlzw==
X-Forwarded-Encrypted: i=1; AL+hErGE2kAyFQST/B/Aj73xAueo6+U8jmERyRtn74DWROZcJPDOKuP+7u+LTqbJRe/+EiGlH3Z14/eq3QsL+sgy@vger.kernel.org
X-Gm-Message-State: APuU4Z/kdiuTRO+tVFAop84GUiKJuWFpNBgRXrtR7qkZsgFj+9THEckf
	8U2nSzZ9u0LNSNgcxqz3ueYeGpdwrd1tmrRlHY7yDsDKSDSqjHznB5sMD0XjzyXNY5mE+S4omQ5
	z8cLSLgSHU/yKZW9iitGqeiRY9NeM2E+Pi/nWYKsvI1JWoNC9vs2z9pVo5vRiG6VSHQ==
X-Gm-Gg: AYBFou14j34AtYyJQT6u9MeTrRuFEb3Pg09nwVCydXdxXMbt8QBDgOE0cLtLQu17ugk
	N1HooaVWwVIZpDIZxIQhPFOmH8ALjsyU8z3DPib5yCC/9DqXSjzD8OTFI2sxbgMvw1xt3M+7d1Q
	ma91ydfB97nS2MdJf9+VzSehXk8B6ixT5HGAYP5F2FjvrgpT4K0rC3xcw1ucJa2vUG2uy8f9802
	jf9bVXlzv/ohABM3EovC49osjGI4L7fmt8c8H7KbjaTP6XWtchVjloIK/3tNE0aEg4XiU8dXRVA
	i2jayQNhX5w546QQm+kdd8QYWox1FmmepuU14NRCrLxNiGvM+6Rw5bmI85ySMMyzFeBVvIzTEOz
	pHFb5Da0FwbpAU3MvhrrXdDfmXj8dbgUL0J/Jp87mK6Af+5dRI+1cpCm7PuVHyCMUaL3wgODyN7
	s5Smnd
X-Received: by 2002:a05:651c:211b:b0:3ab:1639:9a75 with SMTP id 38308e7fff4ca-3ae2b4efaebmr20845071fa.11.1794734695443;
        Sun, 15 Nov 2026 01:24:55 -0800 (PST)
X-Received: by 2002:a05:651c:211b:b0:3ab:1639:9a75 with SMTP id 38308e7fff4ca-3ae2b4efaebmr20844811fa.11.1794734694918;
        Sun, 15 Nov 2026 01:24:54 -0800 (PST)
Received: from [192.168.1.86] (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae2b780517sm24261081fa.15.2026.11.15.01.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 01:24:53 -0800 (PST)
Message-ID: <607bc1e3-7f12-429d-8b0b-a24f77b3762f@redhat.com>
Date: Sun, 15 Nov 2026 11:24:52 +0200
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/13] mm/migrate_device: don't collect a range twice
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Balbir Singh <balbirs@nvidia.com>, David Hildenbrand <david@kernel.org>,
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
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Usama Arif <usama.arif@linux.dev>, Kairui Song <kasong@tencent.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
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
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
 <20261113-mason-migrate-et-al-fixes-v2-5-50a2ed382b61@kernel.org>
 <avfrWjzLQdDcmXO6@parvat> <8c79ce88-7730-44c4-92a0-d760d6f8e9e1@redhat.com>
 <avinH6zgTzpjMCrf@gremlin>
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <avinH6zgTzpjMCrf@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 11/14/26 20:34, Lorenzo Stoakes (ARM) wrote:
> On Sat, Nov 14, 2026 at 08:45:55AM +0200, Mika Penttilä wrote:
>> On 11/14/26 07:09, Balbir Singh wrote:
>>>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>>>> index 9e5dab8e1b77..28ed706109da 100644
>>>> --- a/mm/migrate_device.c
>>>> +++ b/mm/migrate_device.c
>>>> @@ -257,13 +257,17 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>>>  	pte_t *ptep;
>>>>
>>>>  again:
>>>> +	/* [start, addr) is collected if we get here after splitting a folio */
>>>>  	if (pmd_trans_huge(*pmdp) || !pmd_present(*pmdp)) {
>>>> -		int ret = migrate_vma_collect_huge_pmd(pmdp, start, end, walk, fault_folio);
>>>> +		int ret = migrate_vma_collect_huge_pmd(pmdp, addr, end, walk, fault_folio);
>>>>
>>>>  		if (ret == -EAGAIN)
>>>>  			goto again;
>>>> -		if (ret == 0)
>>>> +		if (ret == 0) {
>>>> +			if (unmapped)
>>>> +				flush_tlb_range(walk->vma, start, end);
>>>>  			return 0;
>>>> +		}
>>>>  	}
>>>>
>>>>  	ptep = pte_offset_map_lock(mm, pmdp, start, &ptl);
>>>>
>>> Is the intended race a concurrent MADV_DONTNEED reclaiming the PTE table while
>>> PTL is dropped for the split? That would leave pmd_none() true on retry, entering
>>> migrate_vma_collect_huge_pmd() through !pmd_present() and taking its hole path.
> Balbir - yeah exactly the PTE page table removal, and it zaps the migration
> entries installed for [start, adr) too, so those don't keep the table alive.
>
> And yeah, we would then see pmd_none() on retry and
> migrate_vma_collect_hole(start, end, ...) would appends entries on top of those
> already collected.
>
>> I think this is "ok" for the fix, the hole is collected from [addr, end).
> Thanks. Yeah addr > start, so it's not PMD-aligned so always ends up in the
> per-page path.
>
> And if the split happened at the first entry then nothing is collected yet
> anwyay.
>
>> But couple of things follow. It can't be possibly collected as
>> MIGRATE_PFN_COMPOUND entry, only small pages. And the collected entries
>> in [start, addr) are wrong ones.  Finalize will recover, but the
>> migration will fail for those.
> But that's true for any zap that races after collection started, so there's
> nothing for this fix to do here.
Yeah agree this fix is fine and good for stable. To collect the whole
PMD hole a rollback mechanism is needed.
>> These all are handled in the HMM walk based migration series.
> Ack great glad to hear :)
>
> --
> Cheers, Lorenzo

--Mika


