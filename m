Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB47934678E
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 10:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481480; cv=none; b=ANo5aDc0syRt2HSZ43KD8wBkPLQmnfa1jqH3KjzM5Usf2KhvjHORyYjaMYsCsbpg6d3OXxgVC+BE9Jho0wNf6qy8NTjIcYj3YqNhzyGGzKSgbQCud9wI3/Sp+Htmh8Cux90BzvlvWWDLgFDffCZtpLACdaT5GbAAiPPiUJpFZA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481480; c=relaxed/simple;
	bh=Z74vY6kk8WV2tQRu8koUSqTcozYlyQtJIqXoTlbHXoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xhnr/jT/WJrxhbh9amtd9Q49kCZBLgZM0PFwGE1bG9Oo9Izm64vc+YZiGl6A7WYbKUJWO2j3KrtR2XOH4pa94U3cIIo+oZqNSSB+pm0Wp3nT0t5eXZ+XFnK3s/FnrdQNzJRFHbZoORMmYBgdezLty/Pqhpm4iYbs9W891CToHAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fIZnn70M; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fIZnn70M"
Message-ID: <68ca2764-ca7c-482e-8e78-8c112ce01f99@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780481475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6CrNVQ8IBF7mJpxU4e+u8veQd433I9uH8sSfHrF0nKU=;
	b=fIZnn70MFJFtSsMFPkgs+Fv+g0kizUEPLIjo6aWTQWcbFMleyzoP3NGdSMWey53IBZJ6BL
	933IzFB1daK0zrKn/VrPYJibB0+74lHr9frtFkWnTfZbJqaEqpC41aiBvU0RwwgMbIEoS8
	8agagZWYtGlgr4/yw+KkGXIRbqGZmkY=
Date: Wed, 3 Jun 2026 11:10:45 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 2/2] mm: use mapping_max_folio_order() for
 force_thp_readahead order
To: Pedro Falcato <pfalcato@suse.de>, Jan Kara <jack@suse.cz>
Cc: willy@infradead.org, Andrew Morton <akpm@linux-foundation.org>,
 david@kernel.org, ryan.roberts@arm.com, linux-mm@kvack.org, r@hev.cc,
 Andrew Donnellan <andrew+kernel@donnellan.id.au>, apopple@nvidia.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, brauner@kernel.org,
 catalin.marinas@arm.com, dev.jain@arm.com, kees@kernel.org,
 kevin.brodsky@arm.com, lance.yang@linux.dev,
 "Liam R. Howlett" <liam@infradead.org>,
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, ljs@kernel.org, mhocko@suse.com,
 npache@redhat.com, pasha.tatashin@soleen.com, rmclure@linux.ibm.com,
 rppt@kernel.org, surenb@google.com, vbabka@kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, wilts.infradead.org@pedro-suse.lan,
 ziy@nvidia.com, hannes@cmpxchg.org, kas@kernel.org, shakeel.butt@linux.dev,
 kernel-team@meta.com
References: <20260528165635.2068012-1-usama.arif@linux.dev>
 <20260528165635.2068012-3-usama.arif@linux.dev>
 <ahlh2vdHEGo6ZSot@pedro-suse.lan>
 <cc9a1cf7-7b96-439a-b0be-ecdcf27b5da5@linux.dev>
 <ahmSolHvUChl-3vM@pedro-suse.lan>
 <185f1caf-b33d-4467-beb5-51bd8520ac78@linux.dev>
 <u52xvwk2fjjk2izdb4wvuqq2zhc5neb4q6usimcxejluuyngxw@d64sc6rvojyp>
 <ah8Qcxuugn5tTilK@pedro-suse>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <ah8Qcxuugn5tTilK@pedro-suse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 02/06/2026 18:35, Pedro Falcato wrote:
> On Sat, May 30, 2026 at 05:16:29PM +0200, Jan Kara wrote:
>> On Fri 29-05-26 15:11:54, Usama Arif wrote:
>>> On 29/05/2026 14:40, Pedro Falcato wrote:
>>>> On Fri, May 29, 2026 at 01:19:03PM +0100, Usama Arif wrote:
>>>>>
>>>>> which means mapping_max_folio_order(mapping) <= MAX_PAGECACHE_ORDER <= HPAGE_PMD_ORDER is always
>>>>> true, and you dont need the min3(..) in your diff.
>>>>>
>>>>> Now the question is if then why not just do:
>>>>>
>>>>> 	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && (vm_flags & VM_HUGEPAGE)) {
>>>>> 		if (mapping_large_folio_support(mapping)) {
>>>>> 			force_thp_readahead = true;
>>>>> 			thp_order = min_t(unsigned int,
>>>>> 					  mapping_max_folio_order(mapping),
>>>>> 					  get_order(SZ_2M));
>>>>> 		}
>>>>> 	}
>>>>>
>>>>>
>>>>> This is because this will regress the 16K ARM case where we already got 32M
>>>>> folios. Someone might upgrade the kernel and start getting 2M folios now.
>>>>
>>>> So maybe limit to 32MB? It's still arbitrary but at least you get simpler
>>>> logic. If the architecture does not support 32MiB folios, it will clamp
>>>> the maximum folio order to HPAGE_PMD_ORDER, and you get the same result.
>>>>
>>>> Does this sound correct?
>>>>
>>>
>>> Yes, so if we replace it with SZ_32M, it sounds correct. I just think
>>> the 32M size is too large. But as you pointed out, even 2M can be too large...
>>
>> So AFAIU the practical discussion is about two options:
>>
>> 1) limiting at 2MB with a slighly more complicated logic to keep mapping at
>> PMD order for 16k pagesize on ARM but use 2MB pages for 64k pagesize on ARM
>>
>> or
>>
>> 2) limit at 32MB with simple logic which results in larger (32MB) folios
>> with 16k and 64k pagesize on ARM and thus larger memory overhead.
>>
>> I'd like to maybe offer option 3): limit at 2MB with simple logic. This
>> will reduce folio size on 16k pagesize ARM compared to 1) but do we really
>> care? I.e., is there big enough practical performance impact with conpte
>> and other tricks ARM is playing?
>>
> 
> arm64 16K contpte tops out at 256KB TLB entries. It's quite a lot smaller than
> a PMD entry. Also, something that was discussed at LSFMM was its effectiveness.
> Apparently, most of the gains seem to sit on actually having a larger page size
> (perhaps Dev/Ryan can comment; sadly the slides were not posted anywhere on
> the ML, so I don't have numbers).
> 
> To me, the question is quite clear: do we trust users that say "please give me
> hugepages" enough to unconditionally give them hugepages? I would assume the
> answer lies somewhere between "yes" and "no", but 32MB I would say is not
> particularly excessive. 512MB is... much worse.
> 

I think the other question also is, if the userspace asks for hugepages, is it asking
for the biggest possible one? I think the answer is yes on 4K base page size when
largest is 2M, but maybe not the case for 16K and 64K. 

/sys/kernel/mm/transparent_hugepage/hugepages-* is supposed to be used
for anon only, but maybe in the future we could use that to determine the size
of THP to give to the user for file over here? For e.g. over here we could have
used it to determine what the biggest size is that has madvise (or always) set
and used it over here. Its probably a much bigger discussion.


