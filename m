Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794638765;
	b=jrbIxFRIrlWKsZ5mn+VCd0wC3rcd4hU+Ah7u8oO5quWOLE4cyyEAivUbp7Y7D8C/udhI
	 1qLEAlARAeLaYgc6OXHFK4a7DN1mT7ThOOn+eNMa0jBeHeyO9q5EpLUfLDwPpuy0Qadxg
	 2Ab3nJlKsP8I9mBdOy4M/IuT80VRo+M2BE86kFIx5ILAHItJ9JhGnD92ljK1Oto+8KnCb
	 Xbs2VeGg/IcN4U5GJVjWer0Zcsq6CUpNkBNaglhduzMr9+eF40OVvX98HKrNYC37XBg0C
	 EP48sgNofbRBC2rcNpt1iKmOvI8LiXGgjV59/XySfszQpCpXZNWRXYU9Ql4TpToUEfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794638765;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=iHbcITGOkxyEh3nCOC1u0s4lDXjvYPiyn4teM7lM8pk=;
	b=AqO9RGjT4tKuUA4xwuLe6GEQBc+rRRtAN0XBxF8oN+Eld5M22X0cOBUnrX8vhhIzAs9x
	 jnPZ+MP6e1Jt2fdyL/r8f88pXwGiOhk50hKbt667mhZQO6eK/c1baNbPDRsBkehyrkCaB
	 beezfpkCIhA4fjWO5XV53Nj1wcnMnb0bfecPb9DdYbtb3BfWMbC3q2K8G4pTmCT7gGqO6
	 tPwlXTNFHxEjioVaQDmTQa8xmvHwvg8MFhGiDgke5jiyYTbLW85t+TAilDw8X4zcLaTIq
	 pXfjhBZRsHy+/slxYlXO6GlUH72DuJ1aCTdpYixPa65BwA5vHSfU5pmyETAEtwibE8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="ZtCC2qn/";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Z9JyRNti;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0C7606A335
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 06:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF0C7606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZtCC2qn/;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Z9JyRNti
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794638763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHbcITGOkxyEh3nCOC1u0s4lDXjvYPiyn4teM7lM8pk=;
	b=ZtCC2qn/uyy2rAWRpJ1H61dvB9FmrX4WXCPpBxk1p0PJITykd+Vky3w2uAglfdYtx8JAEJ
	AVOULBtXLigh147Tu2oe1Qp0byB1F2CyffNkRn3sTN6hZ4u6v6gxZinbOXkWp51OKqM0Gf
	Zn8R3f52wLHUhaXi39kLi0WCTj2ETtQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-bGePLvOROiSvoFGGJYWdKw-1; Sat, 14 Nov 2026 01:45:59 -0500
X-MC-Unique: bGePLvOROiSvoFGGJYWdKw-1
X-Mimecast-MFC-AGG-ID: bGePLvOROiSvoFGGJYWdKw_1794638758
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5be43747161so932584e87.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 22:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794638758; x=1795243558; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iHbcITGOkxyEh3nCOC1u0s4lDXjvYPiyn4teM7lM8pk=;
        b=Z9JyRNtiGxsUxOTxjRXOUUYL5sZxLCCF7uohgZH+ACUBNaNK77Gws4JJTUmQ3BqRqf
         xPtOeDPwvzrrQFs3XcIut12Z2E/NBeLooONPXp127Hddp42E0v0aDRUV1x2TdbaDl1Fz
         uqWfRtEB4lnwiP4XohTTUhf3i9H/cscianavIn3W156zfyw1kO2VapArMQwLF3kppbgf
         vCz47bV/WyrVsr+htOoMdeiTr9jOYiR41KXzCv3wzSsDrafgwfXq8b1xiG/tAq8JcW0h
         ZPev1DfOrt8FGDMbwXd/KM66n6uXFpj1v7dYN2umDo1grMqdfnyhCyyZwR0bCahrCo5i
         0b/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794638758; x=1795243558;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iHbcITGOkxyEh3nCOC1u0s4lDXjvYPiyn4teM7lM8pk=;
        b=X+M3/ORI0j31wWOf7EM3oTJhCrZwKxrEU7quYsdYDSJhQlKpWSmDhaVv9UyckzIZ9b
         hijVevJDvqeJMJa7JXHJil35CBZ6jnOaiWAsMe66HPCA4xrZdnAb0H7gftY5MJ+bR+PE
         hsp6/mCax6JDhRL8ZSzmbdoZNRHqoUUFJlfX8qS3i4BseGYwbqXXrwHoGnOvkj02wiwE
         jY6jfxjRx3Snh4x45TFnSUepNYbXrNsz32Q1vkGRnEGbUiJah4mWj5rBp2x/hA8mcT5S
         t575UW/ojT2GN5hxzznGF/Qv8M12BE0XtZ/wvfX6gswNhCecGzJACWOCi68CHwkspZdw
         SGCA==
X-Forwarded-Encrypted: i=1; AL+hErFtrD503WcvqA4BGlOijZSTsQy/iOU7loaHKxeI64ntVBUvE8wxOo3ZEzvHEGSa/V0AFLESFAt/V7m61/Vb@vger.kernel.org
X-Gm-Message-State: APuU4Z9nDAgmZy89qCloXf3myAZt/vE4eYOFHrSprQxgHoqLtj7kO6W8
	bhr+bFM8fIq3jo4j/57PN1cwIYWLoLBwot/eNs+cKW7rewcorqAUnj8V1ijJPe2fQeAjBY5Z086
	CQj7bBiqVc6lr9reIetZVf/p87Q8mVLzFu5+4PT31Fggbn3PjrPsNFIrD/SrQ3Tn4wQ==
X-Gm-Gg: AYBFou0j+wQvU5F8NIBImk64qGa2H0+NbRzdZRa1DnL5MSPCMjRqr0hd/0tsiYMwPuN
	OYbigxQT8zziWX7Fau6LpAyw/Z9qFRU6nCH9X0UFQF/RbUSrwRbo/zDLAtvcuHxRgrcY0BGQgm+
	yGVagjAhlvJQbj7wVbn7h7tlHDEkGMeLlBvYla8GKaGo7Pj62VwKm5DUBvuLdAgsDIxnx2ngSG2
	Ot+y7dwJaA5y3ZX2aA5n6dh4z56ry7WnqD9Tmjeo/ArAmPnJIZbJrnKtw0xsGJf+gTwts52CvWI
	nPpE8q1T3mgkoKuV5mr0HyAHT5rqKJM3UAtgteuB/ftJnynUmkI2axIOGXLzaLmeGCq09hJBrun
	zwnscKk+P3x7fT6hCaZxZApCBvU7jwkubp6CfkPzIYV14KeeTPjvRsXLcMtQ4WNHK6rj90MCzXs
	LhHMAE
X-Received: by 2002:ac2:4bc5:0:b0:5b6:4ae:5b83 with SMTP id 2adb3069b0e04-5c1709ca612mr1930534e87.33.1794638758288;
        Fri, 13 Nov 2026 22:45:58 -0800 (PST)
X-Received: by 2002:ac2:4bc5:0:b0:5b6:4ae:5b83 with SMTP id 2adb3069b0e04-5c1709ca612mr1930526e87.33.1794638757811;
        Fri, 13 Nov 2026 22:45:57 -0800 (PST)
Received: from [192.168.1.86] (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c17133e3acsm1466215e87.45.2026.11.13.22.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 22:45:56 -0800 (PST)
Message-ID: <8c79ce88-7730-44c4-92a0-d760d6f8e9e1@redhat.com>
Date: Sat, 14 Nov 2026 08:45:55 +0200
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
To: Balbir Singh <balbirs@nvidia.com>, "Lorenzo Stoakes (ARM)"
 <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
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
 <avfrWjzLQdDcmXO6@parvat>
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <avfrWjzLQdDcmXO6@parvat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 11/14/26 07:09, Balbir Singh wrote:
> On Fri, Nov 13, 2026 at 09:45:23PM +0000, Lorenzo Stoakes (ARM) wrote:
>> From: Josef Bacik <josef@toxicpanda.com>
>>
>> migrate_vma_collect_pmd() drops the page table lock to split a large folio
>> which it finds in the middle of a page table, and then starts over at the
>> "again" label. The entries for [start, addr) are in migrate->src[] and
>> migrate->dst[] by then.
>>
>> While the page table lock is dropped the page table can go away, in which
>> case the restarted walk invokes migrate_vma_collect_huge_pmd(). However
>> this is passed start rather than addr, so [start, addr) is collected a
>> second time.
>>
>> This can result in migrate->npages exceeding the number of pages the
>> caller asked for, and therefore in writes past the end of the
>> migrate->src[] and migrate->dst[] arrays.
>>
>> Fix this by only handing over what has not yet been collected,
>> page-by-page, and flush the TLB for those entries which have been
>> previously replaced, similar to the other returns in the function.
>>
>> Fixes: 022a12deda53 ("mm/migrate_device: handle partially mapped folios during collection")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> [ ljs: cleanup commit message ]
>> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
>> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
>> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>> ---
>>  mm/migrate_device.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>> index 9e5dab8e1b77..28ed706109da 100644
>> --- a/mm/migrate_device.c
>> +++ b/mm/migrate_device.c
>> @@ -257,13 +257,17 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>  	pte_t *ptep;
>>  
>>  again:
>> +	/* [start, addr) is collected if we get here after splitting a folio */
>>  	if (pmd_trans_huge(*pmdp) || !pmd_present(*pmdp)) {
>> -		int ret = migrate_vma_collect_huge_pmd(pmdp, start, end, walk, fault_folio);
>> +		int ret = migrate_vma_collect_huge_pmd(pmdp, addr, end, walk, fault_folio);
>>  
>>  		if (ret == -EAGAIN)
>>  			goto again;
>> -		if (ret == 0)
>> +		if (ret == 0) {
>> +			if (unmapped)
>> +				flush_tlb_range(walk->vma, start, end);
>>  			return 0;
>> +		}
>>  	}
>>  
>>  	ptep = pte_offset_map_lock(mm, pmdp, start, &ptl);
>>
> Is the intended race a concurrent MADV_DONTNEED reclaiming the PTE table while
> PTL is dropped for the split? That would leave pmd_none() true on retry, entering
> migrate_vma_collect_huge_pmd() through !pmd_present() and taking its hole path.

I think this is "ok" for the fix, the hole is collected from [addr, end). 

But couple of things follow. It can't be possibly collected as
MIGRATE_PFN_COMPOUND entry, only small pages. And the collected entries
in [start, addr) are wrong ones.  Finalize will recover, but the
migration will fail for those. These all are handled in the HMM walk
based migration series.

--Mika


>
> Thanks,
> Balbir
>

