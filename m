Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7472427FB35
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 01:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775006519; cv=none; b=TYwLK3nLBWkZfCVanvy6hGeb9XPL6sIS2GaNZMNVHWKX7qQkVM1bpzC8iUZBGNnXmkvbl1EgKOIo6u1cYJSIaGkmeVW4oQ9Xi+MEYnn6UzsU2uQsIG3Zd8qtat/lzq3xcmTNrUDvhqLeltxotEXgV65WOOzjfwwMybG+fO755Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775006519; c=relaxed/simple;
	bh=CbkMwhWMz8dtPiachTmp3+F6ybdB8kYGsYf5YH5rBGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ka7nyrgHQ0c3LCOfNZ71RF+nAuIV4fu6MpeSUDT96PIgOWepWrhcTULPH6dnnp3S7wvZtekh9jjFB/yK+v/B3HvCgbQ+amQR9KUuyz14Zzll9xIZ08OYGcGczlgPGfIA3Xy5+F7Zm0kmelBClDxEoFJEj+Wh56VaHkIxps9b/Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYqZs+AV; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYqZs+AV"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9bfcbaa81eso183446066b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 18:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775006517; x=1775611317; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bmhnUFXqeLwqLZtF5KspnNYogJH1UNf/6F3rO1eHco=;
        b=bYqZs+AVC6PckgtyJVwleWJnziUY43fsHmSEETYK8hs5ln0Mq60EQNmnOjwhxzLUY9
         axA9CauHvZfpZ5oqYP0wC/iXxu0HSPKpOfTOiKTG9C7nj1ARlaHJwzFjif5kPQ4fjrGJ
         FCp2GqYRyWa4ZcJDIcvcNjC85bzHW0Ssbso9dilKIlsQbh/6h7W07V7vOrZQIyhPyXvq
         5pihJxrooBW9rsEPEQxjGdXuacsovsRoYMHz+VYsey2neH5o/eTE5lM6yKgA5rMS077E
         H/b2VvArKeZSMW+d94M/NNUfEStlifVTd8ME5WdRRI47EDfxGZGVtUCe+bkBByuIfF7U
         MOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775006517; x=1775611317;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5bmhnUFXqeLwqLZtF5KspnNYogJH1UNf/6F3rO1eHco=;
        b=niz6rdzWK/ho0a0xs0WyTNCAo+5K71r7V57EL6zDfGF3jfQphz2ZtVcKgUEdwa9Ha0
         V6BGFawY2ojkxAG07S2jtQiUSsIfZiqxBBUQLfWjjkROOVKyWDtbEnhLD1s1wbXZRQ/q
         72YOZVMXSCofhr84j4gzfxI3krh4NGYRA5Dz02A0j+BTTSCuUPicfAKBVIpFLNME+kcC
         az+kNlEO+t7iJEWtzhvw6cx60RpsyR0dg5xV4hUWBgZmEp8J4DzdulYeDd/fHsgqCWyW
         UoPJzMThmiBN6rEsJTu/04VvH14Jgf+94uM6qaGWtDmEMQua/FcYqyJzWtAas4q9r1j/
         ROoA==
X-Forwarded-Encrypted: i=1; AJvYcCVk2qrCRYbzdddr0JQqycOoWoqYYgYxWGEsbai7Hp68L7kQNWvHW1IPUszZur9HYZAGfp79h6oUqqygEn71@vger.kernel.org
X-Gm-Message-State: AOJu0YzLit2pommGhzGT+n8P4xgOLimxLQMiHBVDoVbPhk1JMSsXE7tE
	yg1p89sG5H1bV5yhrcy4zbsRDUVtmu16ro38BRmBAirYbZ2S8qsUcDfg
X-Gm-Gg: ATEYQzyQg3OKsgL8ndoFZyjg4nzIYm2zMVoSBQI6OdNq5GkdrhkhfnjnuPK0Xe/DZ8/
	OK48ArU33yaigtQVA9ROqlpTuXs5AkinZk4sAMcQkGQN3oXfnOi9Icc5R8IE+0VkaImuLpSriOJ
	CrKFkeF9B4ld/xpNHjN6NFDIKgJepOMtY2oMQYNxTsOY9ISvLo3YVTJo9ssZxJrCGRwb5pPlQn3
	8JhaeY5qwF5VUbFh/SLbSmRP6CXzJqu5k0uzrGfcb1tCXac99PtrjTkjcSaWSvZGDwQGzKGFOja
	regb0u/qY+k7NHGCFG+IBxo/618sfyoXuIDSBFY02MPe4Ot+zzOLfhI9G1fpbosFd4yacf+eO05
	WCvOFsV3LWfEFG208GT5rYuSYJU4d2XLIdV+V/s8tH6FUBNIWwA1FWGSySPJzxmp5oJKBKmukkc
	eDl/H0+2TvStRU1z2S40CiD0IblHJbjRvA
X-Received: by 2002:a17:907:a688:b0:b98:549d:8367 with SMTP id a640c23a62f3a-b9c13902737mr106157066b.17.1775006516238;
        Tue, 31 Mar 2026 18:21:56 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7b225193sm464786366b.57.2026.03.31.18.21.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Mar 2026 18:21:55 -0700 (PDT)
Date: Wed, 1 Apr 2026 01:21:53 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Ackerley Tng <ackerleytng@google.com>, willy@infradead.org,
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	michael.roth@amd.com, dev.jain@arm.com, vannapurve@google.com,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [RFC PATCH v3 0/2] Fix storing in XArray check_split tests
Message-ID: <20260401012153.leisn7umca64ltce@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <cover.1771831836.git.ackerleytng@google.com>
 <6ada27e1-8f85-4b85-8c25-bc9207b2624d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ada27e1-8f85-4b85-8c25-bc9207b2624d@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Mar 16, 2026 at 05:23:17PM +0100, David Hildenbrand (Arm) wrote:
>On 2/23/26 08:34, Ackerley Tng wrote:
>> Hi,
>> 

Hi,

Hope I can help here.

>> I hit an assertion while making some modifications to
>> lib/test_xarray.c [1] and I believe this is the fix.
>> 
>> In check_split, the tests split the XArray node and then store values
>> after the split to verify that splitting worked. While storing and
>> retrieval works as expected, the node's metadata, specifically
>> node->nr_values, is not updated correctly.
>> 
>> This led to the assertion being hit in [1], since the storing process
>> did not increment node->nr_values sufficiently, while the erasing
>> process assumed the fully-incremented node->nr_values state.
>> 
>> Would like to check my understanding on these:
>> 
>> 1. In the multi-index xarray world, is node->nr_values definitely the
>>    total number of values *and siblings* in the node?
>> 

I think so.

As the comment of struct xa_node says:

 * @nr_values is the count of every element in ->slots which is
 * either a value entry or a sibling of a value entry.

And I play with xas_store() and xas_split(), then dump the xarray, which shows
nr_values counts value and its siblings.

>> 2. IIUC xas_store() has significantly different behavior when entry is
>>    NULL vs non-NULL: when entry is NULL, xas_store() does not make
>>    assumptions on the number of siblings and erases all the way till
>>    the next non-sibling entry. This sounds fair to me, but it's also
>>    kind of surprising that it is differently handled when entry is
>>    non-NULL, where xas_store() respects xas->xa_sibs.
>> 

Agree with your.

	max = xas->xa_offset + xas->xa_sibs;

	if (entry) {                          // non-NULL entry
		if (offset == max)            // respect xa_sibs
			break;
		if (!xa_is_sibling(entry))
			entry = xa_mk_sibling(xas->xa_offset);
	} else {
		if (offset == XA_CHUNK_MASK)  // NULL entry, run all way down..
			break;
	}
	next = xa_entry_locked(xas->xa, node, ++offset);
	if (!xa_is_sibling(next)) {           // .. until a non-sibling entry
		if (!entry && (offset > max)) // then respect xa_sibs
			break;
		first = next;
	}

This does has difference.  Confused a little.

This is the reason why we see the nr_values is not updated as expected. When
xas_store() an order 0 non-NULL entry, it just iterate once. Then count the
difference as 1 instead of total counts it represents.

>> 3. If xas_store() is dependent on its caller to set up xas correctly
>>    (also sounds fair), then there are places where xas_store() is
>>    used, like replace_page_cache_folio() or
>>    migrate_huge_page_move_mapping(), where xas is set up assuming 0
>>    order pages. Are those buggy?

This is a good question.

When I look into these two places, I noticed the purpose here is to replace an
existing folio in pagecache with another folio. This means the old data and
new data are neither "value". So we don't expect nr_values would change.

One place we would store "value" into pagecache is swap, IIUC. Maybe we need
to take a look into that place.

The rule seems to be not mixture store "value" and "non-value" into xarray, it
is safe.

>
>Zi, do you have any familiarity with that code and could help?
>
>Thanks!
>
>-- 
>Cheers,
>
>David

-- 
Wei Yang
Help you, Help me
