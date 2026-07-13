Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC8E3043BE
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783935126; cv=none; b=Rg26p36Ys8rRi3WJhW9tWrOSXvhxjUUyEymEFcCTFuDH1zkOb9NRmSe+Ex4MhIaqM6K6PrEV9vpbjR59i7Mf9A0fXEZuOxcya1M/kDNXCcB5wSL2eB7JjNoFm8v3CvdqeOm/oeLOMPBkH95vE/3Er6mU4oGA96DgMulrzW+WjCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783935126; c=relaxed/simple;
	bh=nFFwYdItz3gV6J+FQDBAp7K/ohAMq0IGLglECyu5YnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pbcu6dcPNHgl8eNiQrGFNslK9dwizGr/CjNk5RWFg6XOGxSIVY/hkYk1zRgxa3y1me3Tj1RjQXMuHWignohR2PgXEXTBwnTYByORE2qUGvKBDN+6E5OyAy9esV28oxLY+f/3agjOBfQ+eA6PqSyX6POu8NCJqnPgWy6tj3MKFA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4pW/fYB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4pW/fYB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E911F000E9;
	Mon, 13 Jul 2026 09:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783935125;
	bh=8lhwsqOR9OYufkP9Jb1Vo4afPwabERH4nWOwiGvWRp8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=d4pW/fYBkfgMCUljrGQAVHeKqZQBN0BBW6VRizcv2ahprCpKY8bmwK9c1ws/meNO0
	 yf3fDImFbMOL8rKkO4VQ7nccY/p8J+EWvEBRlkAaouQ/j4zuuiiWrEdiDwy23eofRK
	 98oU5N71VFEjrW6wbLZfxZFfh18hZqUFkwB22RY20j2K8uVZUsArXyCFtxqJaN6NMY
	 KHaIuSkdQbVoV+8BVS1ccc5MKPknsIVm46iZGEf9IkuZK1TsE4O95aH0J5foydJcDx
	 CIapPev3EIdba+E8RKdrnD1mDLFf3xpGZIfAhXpPyJ+L+FoFh4DhiJG4eB4ZluCdVv
	 9ugNcRnYc4XDw==
Message-ID: <e0dafac1-739b-495e-880d-879bdd984fcb@kernel.org>
Date: Mon, 13 Jul 2026 11:31:47 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fs: stable_page_flags(): use folio_test_*() helpers
To: Jinjiang Tu <tujinjiang@huawei.com>, akpm@linux-foundation.org,
 ziy@nvidia.com, luizcap@redhat.com, willy@infradead.org,
 linmiaohe@huawei.com, svetly.todorov@memverge.com, xu.xin16@zte.com.cn,
 chengming.zhou@linux.dev, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc: wangkefeng.wang@huawei.com, sunnanyong@huawei.com
References: <20260702110614.2176986-1-tujinjiang@huawei.com>
 <20260702110614.2176986-3-tujinjiang@huawei.com>
 <905c7dc9-a0d5-4b28-a899-53798fc4628e@kernel.org>
 <8b51832b-391d-4497-8135-8a3cdd4e4f57@huawei.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <8b51832b-391d-4497-8135-8a3cdd4e4f57@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/13/26 08:58, Jinjiang Tu wrote:
> 
> 在 2026/7/10 19:29, David Hildenbrand (Arm) 写道:
>> On 7/2/26 13:06, Jinjiang Tu wrote:
>>> stable_page_flags() currently accesses folio->flags.f directly. Since
>>> commit 476d87d6a061 ("fs: stable_page_flags(): use snapshot_page()"), we
>>> can replace these raw flag accesses with the existing folio_test_*()
>>> helpers, thereby cleaning up the open‑coded flag handling.
>>>
>>> For KPF_IDLE, set_ps_flags() already handles both 64‑bit and 32‑bit
>>> cases, so the duplicate code in stable_page_flags() that deals with
>>> CONFIG_PAGE_IDLE_FLAG for the 64‑bit case is removed.
>>>
>>> The flag bits that has no folio_test_*() helpers are left unchanged,
>>> including PG_owner_priv_1, PG_arch_*.
>>>
>>> No functional change is intended.
>>>
>>> Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
>>> ---
>>>   fs/proc/page.c | 94 ++++++++++++++++++++++++++------------------------
>>>   1 file changed, 49 insertions(+), 45 deletions(-)
>>>
>>> diff --git a/fs/proc/page.c b/fs/proc/page.c
>>> index 2717dbb0431b..0dbd46fa84ea 100644
>>> --- a/fs/proc/page.c
>>> +++ b/fs/proc/page.c
>>> @@ -148,8 +148,6 @@ u64 stable_page_flags(const struct page *page)
>>>       const struct folio *folio;
>>>       struct page_snapshot ps;
>>>       unsigned long k;
>>> -    unsigned long mapping;
>>> -    bool is_anon;
>>>       u64 u = 0;
>>>         /*
>>> @@ -163,17 +161,14 @@ u64 stable_page_flags(const struct page *page)
>>>       folio = &ps.folio_snapshot;
>>>         k = folio->flags.f;
>>> -    mapping = (unsigned long)folio->mapping;
>>> -    is_anon = mapping & FOLIO_MAPPING_ANON;
>>> -
>>>       /*
>>>        * pseudo flags for the well known (anonymous) memory mapped pages
>>>        */
>>>       if (folio_mapped(folio))
>>>           u |= BIT_ULL(KPF_MMAP);
>>> -    if (is_anon) {
>>> +    if (folio_test_anon(folio)) {
>>>           u |= BIT_ULL(KPF_ANON);
>>> -        if ((mapping & FOLIO_MAPPING_FLAGS) == FOLIO_MAPPING_KSM)
>>> +        if (folio_test_ksm(folio))
>>>               u |= BIT_ULL(KPF_KSM);
>>>       }
>> These make sense.
>>
>>>   @@ -181,10 +176,12 @@ u64 stable_page_flags(const struct page *page)
>>>        * compound pages: export both head/tail info
>>>        * they together define a compound page's start/end pos and order
>>>        */
>>> -    if (ps.idx == 0)
>>> -        u |= kpf_copy_bit(k, KPF_COMPOUND_HEAD, PG_head);
>>> -    else
>>> +    if (ps.idx == 0) {
>>> +        if (folio_test_head(folio))
>>> +            u |= BIT_ULL(KPF_COMPOUND_HEAD);
>>
>> Once we decouple folios from pages, we will have compound pages that are not
>> folios. PG_head is not folio specific.
>>
>> But then, some of the flags below are used in other context outside of folios.
>>
>> I would focus here only on converting things to use folios that will actually be
>> folio-specific: like the folio_test_anon() above.
> 
> Understood, thanks.
> 
> In addition to anon, ksm check, The swapcache check is also folio-specific.
> 
> #define SWAPCACHE ((1 << PG_swapbacked) | (1 << PG_swapcache))
>     if ((k & SWAPCACHE) == SWAPCACHE)
>         u |= 1 << KPF_SWAPCACHE;

Indeed. that better also gets cleaned up.

-- 
Cheers,

David
