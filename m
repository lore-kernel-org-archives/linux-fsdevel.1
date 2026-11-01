Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559607;
	b=hK7uODu5kR4iu6fj00OVpM/ssVbcoJtDooMJ7A8GCevR+XNiWPQO76eJBXRqL0bLcZec
	 UqUc36VOF3etiLgSTViFSt9DlCwBzQimIVaEmAdNlb8VzBYtcWgSN8VieVQYnwZHNlhOL
	 xtMlj0TLQmikhCmwKnUZXxnOAF+ztWEc9bFige8MR2qHxo1sw/HdhdNNlWAqgkiY4715K
	 FC/mNVetGoEP6q0WLZBBIeHfnDT9vOXBgzvOXVrzqwTfP77+0Rcvl/AWqWGkEIHSgpiSo
	 HezAIvSuvnLSnUORpNVqbP6lY5gqnBzuG6JgLRICK/fP3miTcHsPZovNpqk3lsEByvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559607;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=MxfPYzUODAbakcjk2CC+IJxAYHeIOBK5M+06bYfQC1M=;
	b=Q2+ASbNavLTE6V958A7N4sbHDK5bzE3c9NcOxdZF6G212bUMxHiAXCMY/APD3Kq7911E
	 HQaxfwr3nHvdGfx2Bp9aM9Jbtji6k/QRBfWnX+xR3dsyreig82PvY7m3cPxQrnnrbN6X/
	 w2ThXTTAM31Fr70avXqoKuGl+qjXGeFr7fkiZ2Xh34NsR/7YdVyBjk0jFCMb/2CUXGpcG
	 Urnp1dzR2tsH4onwfzKh2vtFUG/IqMQG5PD1+8ZCzKKC8Nr+0cwS9k+5z0XBe8EbOUhSe
	 zeDJnPkpEmMlOOX/JSHiD/XbSKGaBcEYHWS28pH6jLl+Z/jCg0ro14BXeFPsGNBX7wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="huWTi/QQ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E49606A326;
	Sun,  1 Nov 2026 19:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=huWTi/QQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52031F000C1;
	Sun,  1 Nov 2026 19:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793559606;
	bh=MxfPYzUODAbakcjk2CC+IJxAYHeIOBK5M+06bYfQC1M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=huWTi/QQCOV96TzGPmhJM1WK3XMMqPuZWbjc1d2pJGbauI8sXQdEYFL2IduNXM24/
	 DJesLf/kwa/UDT4mJMv4JmQtVXH9SiKITzA8rHBRmotDPy73w6am+gBhR0GsrLOZ5B
	 CYJUxgUqi+HT4KmCQ3VfGE1+2o49dK57E++U3d1F0urQlBUD1npsaMpGNtbJsAno1I
	 2BsOCSMhQovkaJRu8PPdMS9lpA7KQz/mLOJ5DLED5PC1UVhHAACPyq8SXETcnMJmmx
	 iJyzpcFo8vEJKsMr+rkLFJgpPpJHi3nupUc1FGdtJSO0bwmZ332OuZwvbk8ll7KSWC
	 8h5PYjZZBEC2Q==
Message-ID: <9e5333d5-4f56-4308-b990-6aa048d9e907@kernel.org>
Date: Sun, 1 Nov 2026 19:59:58 +0100
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
Subject: Re: [PATCH 1/2] MAINTAINERS: add Johannes as the page allocator
 co-maintainer
Content-Language: en-US
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>,
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Mike Rapoport <rppt@kernel.org>, Gregory Price <gourry@gourry.net>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20261101-maint-page_alloc-update-v1-0-27e8c246b13d@kernel.org>
 <20261101-maint-page_alloc-update-v1-1-27e8c246b13d@kernel.org>
 <4026ed95-62c7-4680-9bee-7507330a4217@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <4026ed95-62c7-4680-9bee-7507330a4217@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/26 19:01, David Hildenbrand (Arm) wrote:
> On 11/1/26 17:34, Vlastimil Babka (SUSE) wrote:
>> Johannes is a long-time expert and reviewer for the page allocator and
>> has agreed to step up to a co-maintainer role, so do that. Thanks!
>> 
>> Additionally, page allocator is joining the MM transition, following the
>> MM core updates from David [1].
>> 
>> Patches will be collected in the mm/page_alloc git tree and integrated
>> via the mm/linux integration tree. To signify the change from Andrew's
>> mm tree, remove Andrew as M: - get_maintainers will continue CCing him
>> on most patches via the catch-all MM entry. David prefers not being
>> added for mail volume reasons.
>> 
>> [1] https://lore.kernel.org/all/20261030-maintainers-v1-7-97278f8a5f54@kernel.org/
>> 
>> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>> ---
>>  MAINTAINERS | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b68bc3626709..d7cfb28a9029 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -17720,15 +17720,15 @@ F:	include/uapi/linux/oom.h
>>  F:	mm/oom_kill.c
>>  
>>  MEMORY MANAGEMENT - PAGE ALLOCATOR
>> -M:	Andrew Morton <akpm@linux-foundation.org>
>>  M:	Vlastimil Babka <vbabka@kernel.org>
>> +M:	Johannes Weiner <hannes@cmpxchg.org>
>>  R:	Suren Baghdasaryan <surenb@google.com>
>>  R:	Michal Hocko <mhocko@suse.com>
>>  R:	Brendan Jackman <brendan.jackman@linux.dev>
>> -R:	Johannes Weiner <hannes@cmpxchg.org>
>>  R:	Zi Yan <ziy@nvidia.com>
>>  L:	linux-mm@kvack.org
> 
> Want to remove that one as well like I did?

I think you meant the website and this is the mail list, so it stays.

