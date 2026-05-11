Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708C72F8EAD;
	Mon, 11 May 2026 06:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482018; cv=none; b=Gksb03NzU4wbi6RNalAoWSHC1iws0Neo9bcAaeob5+/RyuGWlEc3646ENe0isI0q+2VttPauaD9WUNd/rCkRyVcvUIBGKfor5pevfkioGGOuxLrrv2C572oIWDZVlgIYnoVcTpNmgjJJrGLFZ99WjhmXPolE8rJqxJatLT5R86A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482018; c=relaxed/simple;
	bh=g0QT7cCTsXmTjW4SvIvFQn0tUkYEBj6EUCd9E0j3wuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LahZyX+bSpLeP6DFprd9fWntvHdhalxrqq72NxMlMoL4qt2fcI6e2+xGsu9G7/EajsyNQCdutfUQw8okjW1giXBAdgIZPXSbLx7X8k6Ej5aQPtsd25KUBLskmberjxIlnQNKebkDoQaRngNsOKT/FsrIgGCJAHp7rK+zmOxfWiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=WfQsprSE; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="WfQsprSE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1778482011; bh=KvcBiJ61ExhUr8Ag0SmSBeGGSQWpBNyi4VxNqzF8cb8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WfQsprSEWvLn8OC480A8B9x15Vb5Xm7g6hUqFu3AV15j3bwKr5cqw432ATbwcl5u2
	 P5h5kio9UiiIfTv0+wYQzFmbkvVD6J3g71daRBke+BL2pUkMXN6frp5/HmUNdlWUQA
	 NRZa3o0Gkv6YtXXMbKA6X7UDNlf1cVi8GCxIM1Uc=
Received: from [IPV6:240e:604:311:bdd:c445:e8ec:eca9:fced] ([240e:604:311:bdd:c445:e8ec:eca9:fced])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id BB0BF0BC; Mon, 11 May 2026 14:46:48 +0800
X-QQ-mid: xmsmtpt1778482008tbnsg6sdz
Message-ID: <tencent_38E69D3DB046106F5E2D0AB9769E27149509@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeieeOvOqEro+wX77w6fbh/2onfyY6207ZU0kC23izLwOt3CLQFU5j
	 NRyOylqvK1has+Fn1jt0JgQPVtqFzeUjmqe+7AuxMJIA3od4DZHplZexHRsyN/CBC3KrXLoHP7pw
	 XMXkKqNtv6CtyN6POJ4/+5/W6Vi9/b1gWonKex7zdJOsnGkyzMivCY/NJNd0LyxC7g1ipGC/AiEg
	 uKAEH4NPJWw7TtFYkOKlDUa28AQ6AkUh1aZltLBYiAfV1Nh2+biOaKsKl4MaN6Yv1TQwiozKbUbH
	 oihXRWguy8VxL69zb9OKg5YHI4hfm3TSCHeHicPE5vgjlBHoMOnbaOTYtFt5uV1567UFk98zgra/
	 y3rJxJ1Pm+wTqTsDLc+czk4qSNmUReLmWXPUJ3slKy+ZzDKKRb+cUUoT89vQDvGjUjtkSWVyARg3
	 RE1mecvEbW8eiCHZSgmT/DNlCs60Th/k21bKD36zufk0XQp2RIVyivi3SCpgXRL1EzU1/5c+trHX
	 n/nN4wP8WkHdzGlqtkoO/Pp8pOIk0CkomxpoPki9KbUxplwqc/yYz7tH9ZncHOZSftlAC5TFeF3G
	 SPi7hTBpbfQ8rctpFeZZmxS/vda5oxwjeWoMbWzIUkilyXjkZhLHFelmcjE2G+iT4hbrEPyM6OGS
	 yMhZ3jsqFgJhaiVf1qpOW8ZuWp5ONiNwT6Jy9zBPA2JbHxkGmrM3YnbmorzF2BuPUwr4S/8cPrzv
	 futcMPsytsf/O8Hen4sr6G/5hHz+t8VBras/ojpO0NenVvkhKj7Bzy+4+VPJ/B7mjHIzsugjHKgl
	 uYpUUxFvyS/J44jFxhq76J618Uvfr4QmyLoCYR9MrOuky/2Kj5IT80caqFKt/M77orBdJjogIidO
	 PI9/GFc7U99JoqZxvSSOm1hqu5kXU2Tn9r2mCrqWsyveuqEToahIML+ICIj5/ZWvCfiVu+XK8jnJ
	 u22p31IVKaWOEDN5/gCwV0PQE0hMwfRHsh+/6DBGUioj5nx5iFa1pFAm2LbQG8SZ9esCXnwizu+q
	 nCbic2aRbZogyoseYzSrL4BkEi2H//xk+I9rreaLZfLEbwXAzbexIcYb2Nhde0Y8GJUjcCtYN0gR
	 FjcVVi7eOsesZC6uU=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-OQ-MSGID: <de715a64-b3c6-4530-9003-d5e4d66da029@qq.com>
Date: Mon, 11 May 2026 14:46:47 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/fadvise: avoid remote LRU drain for mapped folio
 failures
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
 Lorenzo Stoakes <ljs@kernel.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <tencent_DEDC345B4071ED3C9B293ACD437B9C8DBC0A@qq.com>
 <f7669744-f71c-49ee-9241-c015ed90f165@kernel.org>
From: Fujunjie <fujunjie1@qq.com>
In-Reply-To: <f7669744-f71c-49ee-9241-c015ed90f165@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/11/2026 1:47 PM, David Hildenbrand (Arm) wrote:
>> -long mapping_evict_folio(struct address_space *mapping, struct folio *folio)
>> +static long __mapping_evict_folio(struct address_space *mapping,
>> +				  struct folio *folio, bool *lru_refs)
>>  {
>> +	if (lru_refs)
>> +		*lru_refs = false;
>>  	/* The page may have been truncated before it was locked */
>>  	if (!mapping)
>>  		return 0;
>> @@ -331,14 +323,38 @@ long mapping_evict_folio(struct address_space *mapping, struct folio *folio)
>>  		return 0;
>>  	/* The refcount will be elevated if any page in the folio is mapped */
>>  	if (folio_ref_count(folio) >
>> -			folio_nr_pages(folio) + folio_has_private(folio) + 1)
>> +			folio_nr_pages(folio) + folio_has_private(folio) + 1) {
>> +		/*
>> +		 * A remote LRU drain can only help with extra references on
>> +		 * otherwise evictable folios.  Mapped folios also have an
>> +		 * elevated refcount, but draining LRU caches cannot unmap them.
>> +		 */
>> +		if (lru_refs && !folio_mapped(folio))
>> +			*lru_refs = true;
> 
> How can you conclude that it's a LRU refs? Could also just be something trivial
> like a remaining GUP reference, or am I wrong?
> 

You're right. The elevated refcount does not prove that the extra
reference is from a remote LRU batch; it could be GUP or another transient
reference.

The intent was to use this as an approximate filter: avoid the remote
drain for failures where it clearly cannot help, such as mapped folios,
rather than to prove the exact source of the extra reference.

"lru_refs" is too strong or misleading as a name. For v2 I will take
Matthew's suggestion into account as well: avoid adding
__mapping_evict_folio(), do the folio_mapped() test in
mapping_try_invalidate(), and think more carefully about where the
fallback boundary should be. I will also use naming that describes the
decision more accurately rather than implying that the extra reference
has been proven to be an LRU-batch reference.


