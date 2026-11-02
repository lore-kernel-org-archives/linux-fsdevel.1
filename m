Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793601607;
	b=qiKorG02oDxheQaA+ETPNXMRmXASN5MVOFJDzh+c+LRu/yXKqfV6DLXyaYxDuMgcOt87
	 XbCtm4fK7dju074K1MfpIsWUZfck5n5PcTyXLiESezPzTOVGiJEcq/A/jdgDxEM5phrKs
	 AQ+YIMMQdhyrg2JbolQkSJROaZTxt+uSLHetw1+qyjhAQZbZNJEEy+/X1XPMxM/oE4ZP9
	 wyMAKj4AjMqYMuyd7R0Db2NmwWhR0RsuLCuGl0DH4FkEAZrtVvyOmRfAsMRTNMn7mySIX
	 3W4XiP2XKd00xSTTM7gj8NdZnTjFXSMaZD6AAbHyEt2mXTVmi56wkS8P2PmSsTk4rdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793601607;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=47fs60LXRPRVsAKKNOF0L3fpWdYry5GJUN7TOHqj7vI=;
	b=f0qrigkFNgIW6dyqrcg6+rkg7uqiImCqwJ70bCQCNU1haUyHg8w+pi5OjEp8G81k1g6D
	 OL/Qq857bpHGjp+7V6kT8CxKP26DqKn5yznndxaQNgBXwJHcfkIr19/w+qFCeEhRf1Fnl
	 LjjFWgOXt5Bm//jFb5aZGuMdBsZvL1/moqk8jSZ6LReXiO/S04uQ+SNW4TpTrlzicVI2C
	 0/BdftUdenPOg4xFLyBQivWixx9kvhV8Ll54WZjcJvuai8CkUmB4oLYDUw0qi9fglyDW5
	 iPxCpKKbb+VEd2Ro3V8XtaooN0a6IfIwL006yZT5BTc1d1jHvwvezBIZJb6gyiaKSgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m3G6ZBYO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EA0606A326;
	Mon,  2 Nov 2026 06:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m3G6ZBYO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC7D1F000C1;
	Mon,  2 Nov 2026 06:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793601606;
	bh=47fs60LXRPRVsAKKNOF0L3fpWdYry5GJUN7TOHqj7vI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=m3G6ZBYOEGTVvZpwTzcl1ib0RJRbexXPcIAyQK9UxCv2lIo3F7csLlUhVRzgHtZPA
	 8W498j85QbU1Wtk1g/xVygGfDLx2RLFKh6o9sxAz/6OLCUA7Aftd/2xl2NX+hl9Uby
	 tsm1Ov6nBCrdlH+Xy5hpqvInZsnD6Kts+sEHQq429PME2dJiCbBcyEjras7q0pG+ZX
	 GBfdpQ6fmBU/jhGCXDmAo9HVRAk2Vf+wBgktbUExvp4UUqkXiBygz3yNj1aj+DZDcX
	 jP0wjRKKRRUoJaRpzMVJ1A+vQR7P5Dxk4+S9RQeXrMIwGOeZaZkcYsZkuZUjzqxKZm
	 vbO3hJL05Zn+A==
Message-ID: <eb6c0b28-657b-4795-8c96-600964633946@kernel.org>
Date: Mon, 2 Nov 2026 07:40:00 +0100
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
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
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
 <9e5333d5-4f56-4308-b990-6aa048d9e907@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <9e5333d5-4f56-4308-b990-6aa048d9e907@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/26 19:59, Vlastimil Babka (SUSE) wrote:
> On 11/1/26 19:01, David Hildenbrand (Arm) wrote:
>> On 11/1/26 17:34, Vlastimil Babka (SUSE) wrote:
>>> Johannes is a long-time expert and reviewer for the page allocator and
>>> has agreed to step up to a co-maintainer role, so do that. Thanks!
>>>
>>> Additionally, page allocator is joining the MM transition, following the
>>> MM core updates from David [1].
>>>
>>> Patches will be collected in the mm/page_alloc git tree and integrated
>>> via the mm/linux integration tree. To signify the change from Andrew's
>>> mm tree, remove Andrew as M: - get_maintainers will continue CCing him
>>> on most patches via the catch-all MM entry. David prefers not being
>>> added for mail volume reasons.
>>>
>>> [1] https://lore.kernel.org/all/20261030-maintainers-v1-7-97278f8a5f54@kernel.org/
>>>
>>> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>>> ---
>>>  MAINTAINERS | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index b68bc3626709..d7cfb28a9029 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -17720,15 +17720,15 @@ F:	include/uapi/linux/oom.h
>>>  F:	mm/oom_kill.c
>>>  
>>>  MEMORY MANAGEMENT - PAGE ALLOCATOR
>>> -M:	Andrew Morton <akpm@linux-foundation.org>
>>>  M:	Vlastimil Babka <vbabka@kernel.org>
>>> +M:	Johannes Weiner <hannes@cmpxchg.org>
>>>  R:	Suren Baghdasaryan <surenb@google.com>
>>>  R:	Michal Hocko <mhocko@suse.com>
>>>  R:	Brendan Jackman <brendan.jackman@linux.dev>
>>> -R:	Johannes Weiner <hannes@cmpxchg.org>
>>>  R:	Zi Yan <ziy@nvidia.com>
>>>  L:	linux-mm@kvack.org
>>
>> Want to remove that one as well like I did?
> 
> I think you meant the website and this is the mail list, so it stays.
> 

Ugh, don't review patches on Sunday evening I guess. :)

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
