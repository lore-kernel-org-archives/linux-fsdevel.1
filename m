Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ED22FA0DF;
	Mon, 11 May 2026 06:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482357; cv=none; b=SyBEbu6IXJKnvCeuttD7nparaQ+Ia5ez7Zeckw8dnWl3EGc1TQ5/JmAbDHbvKc82B7dUaBn4P+iZHfL6BrC9G4ybFnwYIpDfSX1IOAD/oMCqwRFVOxTjHKBuymFyRkpTEVrcb3Enecn9Vd0T7i+olksJDJ21cWgJDZ2+5E5J9m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482357; c=relaxed/simple;
	bh=uchdXmEV8JAPkW6q1BtDekmd2FYFvq7YhBk2HK+vOKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPWuN6Eh+oECwunlU1kzhlH7X3vtqwwX9qth8LmfR7H4N+frpj835z157U4mrMhRBfROaiU5lqW2yM9BVvptTC0FrfGQXA0H8cKNo5CPclxtkKIu2saG/gXMgJksFa9JU39PoYXqiEl1D5vxiyoPKt20fw5wR/fjbOMTx+P4pGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=s4UcPdhp; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="s4UcPdhp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1778482347; bh=sJMLXjcI26im9xhxw5BNpjzNLmJVL3i6Qc/ACsf+MrI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=s4UcPdhpU4ak5ukd2I/WMPJ7kJoOwf/ktiWr8AL9E7XlXPhHTK9EQGOP8gLLmlytr
	 cxBonI7MKYzETwP065w0tdJ2hU2rC+ngvlm00r8rpB5VHMMZIcJy90bPyM9A+7xx0m
	 ilxm71JplqL+Org4gq/GXdRmuea73KfhMYVtmPFo=
Received: from [IPV6:240e:604:311:bdd:c445:e8ec:eca9:fced] ([240e:604:311:bdd:c445:e8ec:eca9:fced])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id D181BA5C; Mon, 11 May 2026 14:52:24 +0800
X-QQ-mid: xmsmtpt1778482344tk43alsnr
Message-ID: <tencent_C372613CCF2B0ECFAB78EC8C30DFA05A6C0A@qq.com>
X-QQ-XMAILINFO: NHTNowOA4hJdL9MNiUn503bk+gIIoshFg41SfYK7ZghKAjSwMb/h46Np7NdrWy
	 BOCKNIcDS1mY0Lu0VOYm4/QH0ue8n/Z263k3FVaMSFLRonuvkhlvbv/Botg+NJR8Cv5Ro9ADJKmC
	 hYPV6vRZU7C2RNrRZo/yEedM6jjnb3hmF7dlhR6Yx84+nVSGeQTnNZgJdHsA+5f3bJPDIQLLQF9h
	 ArAUfz346GiaUsqgg1l41Meh3msZhgV0PyuQcMZgumiutQB+803tF/KxW+kkYTaTSbzzc1Pu46Ov
	 cT+clgy4em7iAjS0/sZCsryBCgLw3rMzXFCmn69TJEUflBKP/Yrs6sK+CndYb3CgbM0LbAHqlhYA
	 IWV5EmKKKBvGcNwPxFKz9w9qyOMMMpnWBs1yukZZu06GZuNTKx5YW631+tzLxD3OTViRcjVC0EWD
	 GaRrfisaMhWg+zVU8NOhDIWL4jBznAxasDbMnuVOK7ewS2sefYgB0MdF/j9WpmpErX6aYHicWTfc
	 zLtTg9A0xCZuKaeKkHwh9d8fpL1FRKjMU+We48aSNW8oUaEaJ0L2pmg4qcodoSRimzQA0WZG4S+J
	 PwIjwGs9oD5pppkZdf8xEZJQzdGbB1lOuxX3kOmADzlcUowCdAMoifLqJ5K4gbYYwvWW2qHUBq1D
	 UHHKmkQyh99Ipej1/pq4CUtKdeYVEGmr1y7+i1ap93g5f6UQi7zMS3xS9CptsnkWgIAEUs/MUZe6
	 /uiABfDy+L+MtzTM/JUGhAzgFD+9CAAVDY3L7cN1LyKOudczmx8Bc1fX1N1Tte6ipgrFXh0oeMR/
	 e4NaFUySzFXJLSOiwPX/myXzByAyRlATTCmxuMG7Cq+PZAiDGgew+BHsmiwlBLdCJ7NOe0odf+LD
	 yPuofSMpgKiCDnQHwWVSjlmvmUuTYvG31LN8aHmXEeuCf+3RhRuF5W0b2JybKjpQHkfNpyVcu7S9
	 MHnIn0f9xzsv6cWoJb6HcMUtq5lS9TuLgTNZCRu+uuz15mbflwm9iXCgHnCn4i092lhf83G6avcn
	 6dkqrse5z5g5qFct92oht/QVV7PdcBwcEF9kSAqHtzZxcmTY+XYD9NaUozjNsRvpH3iGM6ITgPrp
	 kcE6+Drrr63E99Pd3upTyW3U1CCotov407AWgcbZdifkuJz6w=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-OQ-MSGID: <a19c1140-5c5c-4dec-9746-f81f78f11bbb@qq.com>
Date: Mon, 11 May 2026 14:52:23 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/fadvise: avoid remote LRU drain for mapped folio
 failures
To: Matthew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@kernel.org>, Jan Kara <jack@suse.cz>,
 Michal Hocko <mhocko@suse.com>, Lorenzo Stoakes <ljs@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
References: <tencent_DEDC345B4071ED3C9B293ACD437B9C8DBC0A@qq.com>
 <20260508163549.40a7f3c8c4286a553855b02e@linux-foundation.org>
 <agDK6PkESVR5OOYn@casper.infradead.org>
From: Fujunjie <fujunjie1@qq.com>
In-Reply-To: <agDK6PkESVR5OOYn@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/11/2026 2:14 AM, Matthew Wilcox wrote:
> On Fri, May 08, 2026 at 04:35:49PM -0700, Andrew Morton wrote:
>> On Wed,  6 May 2026 11:23:59 +0000 fujunjie <fujunjie1@qq.com> wrote:
>>
>>> generic_fadvise(POSIX_FADV_DONTNEED) drains the local LRU batch and
>>> then tries to invalidate the requested page-cache range. If any folio
>>> could not be evicted, it assumes that a remote per-cpu LRU batch might
>>> be pinning the folio, calls lru_add_drain_all(), and walks the mapping
>>> again.
>>>
>>> ...
>>>
>>> Teach the folio eviction path to report whether a failure hit the
>>> existing refcount check on a clean, unmapped folio. Only request the
>>> global drain for that case. This preserves the existing fallback for
>>> failures that a remote LRU drain can plausibly fix, while avoiding it
>>> for failure reasons that a remote drain is not expected to resolve.
>>>
>>
>> Thanks.  AI reviw asked one question:
>> 	https://sashiko.dev/#/patchset/tencent_DEDC345B4071ED3C9B293ACD437B9C8DBC0A@qq.com
> 
> That's a pretty poor quality review.
> 
> My question is why we do this bizarre thing of switching between an
> unsigned long and a bool pointer.
> 
> I would also avoid creating __mapping_evict_folio() and do the test for
> folio_mapped() in mapping_try_invalidate().  It all feels a bit weird
> (both this patch and the original code), and probably needs a lot more
> thought, which I'm not in a position to do right now.

Thanks,agreed.

The count is not really used as a count by the fadvise path; it only gates
whether to do one remote drain and retry. Also, adding
__mapping_evict_folio() just to pass back this bit makes the interface more
awkward than it needs to be.

I will rework this for v2 to keep mapping_evict_folio() unchanged and do
the folio_mapped() check in mapping_try_invalidate(), as you suggested.
I will also think more carefully about the fallback boundary and use less
misleading naming, since an elevated refcount does not by itself prove a
remote LRU-batch reference.


