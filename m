Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606478;
	b=iP6hwwnAriZEf7oXRJyWJCD+80uOumd6HFJ1TqNDPpVcJjCtIHAmB8lcXpaXtT2mC8Ul
	 di5KKBidhgNDQPw7xZY/+yaW6fqCDPFcfJGL6vk62Xian5dOJP62bW2AcXPMv7eAxivnz
	 b1u5A0zBnmELcttcdLFlI6sH9pyGwaSlZ80P67A/L6FkwaMbL5KpDbxiNKxmou8W9fDok
	 3oIyGNL3xYl1slmxodEqQe4cT636oaIRJ2alAyDQoMp/WEuGC9k1cZD73EEwkp1ei1pmF
	 gqk4msGC3hEO6BEOkef+ww7xliuXXqpw5PKKnFwAis5aykPI4dz0naKcBUNB6ncSIFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=au+aUwkr58kHsbNGWzHntkHpOI9D5jL8SiuAtxwKygc=;
	b=dg0IIzJQ6ceR/4qSMso/T4pnsquZ8BQvRLApRRWkKzxlFU0VTC5Ev/67LPoolhvveu7C
	 Y0fZwYonIDesDo3eLL3/+tEyRRio/TNe5StwoKQmmyQAnsLXCsvOeJnxXEVbiWcUhdXgD
	 wfyrxHuKYSUZaxkQky/95YAuJR3BmdqDddGmb5iVqrvXkkCBLSUSMVqn3UHb4IZjfCYs2
	 AzJlFsJm7oSF5Mc4NmkWbVUrbfIu0Ysu90dIynzb+bFzzh10D6XLU0zsSMwdoYoId/5eF
	 MdKy1IaHjloqFhHucoAIJUvS/kwwrQ6AvS+OayfeM9GDE6QVziWDSQ7W2iIoXhCxdcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XfO46EC5;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2B1606A332
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 11:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B2B1606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XfO46EC5
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb69f5b161so36683855e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 03:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795606476; x=1796211276; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=au+aUwkr58kHsbNGWzHntkHpOI9D5jL8SiuAtxwKygc=;
        b=XfO46EC52jl5ccgR5gMDRt0sSyg+TN4LWK+5BUM1aLXNe/3R9K5OjTR7oderP9CGNK
         nX4LZygMlG/b0GfF5ETtxDr3F1DwW+o5u6L/kuigKs+mCZVzWR/WK9CZRXewErtLeHMn
         sJYVueJeinnNyPg2RMove84xtmhwCCABe5hU1NvdXWYwuJcQ6n3wklagD5H+FOdZXw+k
         wjKAC713OiPzoWFDWN+zEXTZRKWyh6nuw1pthC+uyVpw7A6EWUy+YGtEfBwq8vvqbH1+
         YTCMzZaoqjmWjjAE6v0ylF8BfUMfahcocm3FxUMNU68ztHkrC7ZZCtBN2ReUrv9+YwOu
         cFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795606476; x=1796211276;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=au+aUwkr58kHsbNGWzHntkHpOI9D5jL8SiuAtxwKygc=;
        b=2RjO/bOgte08cPjtCnzzVKspyn7lM/8ZUrYfeU95zZQBNc3apLXg4pTO+zZLGrC828
         71Qrtl2EHkBeAGNlueDyuMYJ6TkHMRmPA1Kg/1Pqsdl01GtGBof234wCF2ZXrONrnyQ4
         ICiB4sWg1xVA1+ecPr2MD1jl1zgEl6BLiI3s/0CZiK10DLflLxwFhItnCgSA6is4VSQ0
         5huvHVh5vguMmCIMFFt4svrGBAhHJ51msrlXSvu+lSImyUJfRuIdcgJsAHBV9DuhOzXy
         ea3HwFjazgn4d+V4UZ8LcbGUtDHQCkAgml6BVM4xxxXGQ61uXt+DcbPxmIAMgiXs4mw8
         F/Vw==
X-Forwarded-Encrypted: i=1; AL+hErGxzKWNj0NXgLi6/GgvR0PeKakOMuycCX/KjE61VX8iY1xWCqR1ZPotzKIe8Us8QFP75zd0SUunhqV5WTkO@vger.kernel.org
X-Gm-Message-State: APuU4Z/jMjrpFJRvNNLgX0dPDGm86eYJZjwJdVy+e0zXZgzI5ncswLiC
	RFhW8ZsoJVw6YWNgnY6KNwsx/ygGVRIfmFtHsDBVWJNogxbdFB+i3EE6
X-Gm-Gg: AZFdTZe/6/vfYLvpYfmfcdMA5ERVPr2o8OGgNMdNvegwZpzfCS9voAiPisCqXKErEeH
	OwnthHmj2XALJ8iQmmzH62DDfRkqOTPKseonXP95QY7R9OebBPW2nkitbmOnnNe/XUZlIE2mrOA
	78POB9X9ecWeTHj4SvfRq0/fmDgoFpB80y4CSD/EqwQkBI0SuvX/ZU79V7117PcRXDj3sbAfEUu
	wtOK33gNw2fCyQP++75NvHfLDwOUHWqCPxPyQLWLNIZVYyAstJnDtK/dZhFpq8LOGv7f3fH2LoJ
	pwvUJ+uh9seVB1XRvGdPr7co7gJvyvt5fvk9C7xPo3668BbrJUHMWyB3CsUhyWp3kISfTVtDtbu
	Fqmwkb2+P7mwXOgeZUMpf3nL7ehb4lQVXu4u3qdzFfuadaOsZOl3ExBanRP8a4NIFJQ7ne9xsiz
	FWYk527nM+8cWVsEsQQUsUozrqSJ5ojQouexCBgM6K/nsEJfY7PJFLf1vZ4thSj8RfRJBBxseib
	NsubF0JIqd/zkwc1Hkld2sB2eiK5BeJCmJ3BKYkPs7lGaYk5qifdUo7zYFkEPhN9jIziPi5voyZ
	Fpkoibz3SEb82eIFKmj9oiIp
X-Received: by 2002:a05:600c:64c7:b0:4bb:68b9:f610 with SMTP id 5b1f17b1804b1-4bb887ffee2mr340117785e9.9.1795606475753;
        Wed, 25 Nov 2026 03:34:35 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a9687sm572512745e9.10.2026.11.25.03.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 03:34:35 -0800 (PST)
Message-ID: <286006b1-9f9e-4661-bd38-e5f5fce9646b@gmail.com>
Date: Wed, 25 Nov 2026 12:34:33 +0100
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
Subject: Re: [PATCH 4/4] mm/khugepaged: use NOFS while collapse_file() holds
 folio locks
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Zach O'Keefe <zokeefe@google.com>, Lorenzo Stoakes <ljs@kernel.org>,
 Dev Jain <dev.jain@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Hugh Dickins <hughd@google.com>, Kiryl Shutsemau <kas@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Rik van Riel <riel@surriel.com>,
 Song Liu <songliubraving@fb.com>
Cc: "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Michal Hocko <mhocko@suse.com>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20261125100058.15200-1-azpijr@gmail.com>
 <20261125100058.15200-5-azpijr@gmail.com>
 <8c60bed8-6857-4361-91b5-c8fed8a083c3@kernel.org>
 <66fd4450-6e17-4a1c-be76-38758a62073a@gmail.com>
 <413a7751-a368-42fd-8983-c3b44a86fd0c@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <413a7751-a368-42fd-8983-c3b44a86fd0c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/26 12:15 PM, David Hildenbrand (Arm) wrote:
> On 11/25/26 12:12, Jose A. Perez de Azpillaga wrote:
>> On 11/25/26 11:55 AM, David Hildenbrand (Arm) wrote:
>>> On 11/25/26 10:59, Jose A. Perez de Azpillaga wrote:
>>>> collapse_file() keeps the folios it collapses locked until it is done.
>>>> With those locks held, it calls filemap_release_folio() with GFP_KERNEL,
>>>> and for shmem it swaps folios in with the mapping gfp, which includes
>>>> __GFP_FS.
>>>>
>>>> As when splitting folios, allocating with __GFP_FS while holding folio
>>>> locks can deadlock in direct reclaim or compaction, and __GFP_FS also
>>>> lets filemap_release_folio() wait on the filesystem.
>>> How is that possible with my fixes?
>>>
>> it isn't, sorry. I'll drop 4/4.
> So there are no other allocations in there besides the one done by splitting?

there are, the shmem swapin, but they can't deadlock.

-- 
cheers,
jose a. p-a
