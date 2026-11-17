Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794909361;
	b=NoTqkc97aLJU9+FysRHF2+fNWJYD2pbutoMHKzN3cnnmtKc/2qifnq73wnANMeckNtCk
	 zJ22abB+MFjmTzSBqRuODbHZDJhhwYmEmoMDiaPuiIld7PU3sxyINHNuwkAnKnIa7a68V
	 MElqxsK5LyQelpW3yTawUkq0Och6V5LPvnLEouEnDtXXgjvOh6aSYD91ke/gRlcbB9UAg
	 qelOCGxsySp1LkeTj0rxhJ6kXH3MSAkgR3Y1qQvblrXY/ceoomyI6Ju43FmJnwUILbk3/
	 dsz6R3iphjClrVJZz+pSM52tVVStBwiY4Df5+9UjpfUYq0vuYzzkKNOsZVkOM1jbM6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794909361;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=RXpkAmDQM3YL/W8+BChLDkEu3hDU+qLuCPRwmd9apzM=;
	b=r3ni8/1QFP39PzSrtSvGO9/RjKZ7QhbV7U28GhwIOHjI706x8jclf9uIl/w83Ab2NAn9
	 mTfDsuJf+UqHMWH9FaM8EYGbm4RDYy/vuaR07X/z/UtGmUMcOty37NVfu7RcmgkUrObhf
	 aWNsVTfjkmGZl7vQe/jtGyT1Zp+ovhmJje9oYjcweBCachvYPyLvH4/KOR9q2eCMDNIgM
	 zyrBaTnlZKJPb5neqcnla9JPEYcSrlERF+Cn9U6FUarxo8W0umP4AI7fkbSzpOdhLZHLS
	 f9pjN1P8vYaG+XEov/ONGqs0USYxNqQUev1AEmcbkcN+0FRFL/jr6e/jRc4LCukxjWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ieF745AD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B85606A31C;
	Tue, 17 Nov 2026 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ieF745AD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D6E1F000C4;
	Tue, 17 Nov 2026 09:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794909361;
	bh=RXpkAmDQM3YL/W8+BChLDkEu3hDU+qLuCPRwmd9apzM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ieF745ADkvptZ7RZ9MjF5EOCbX1p4MyKcv7xpQefcFxuUQt4dykq1m4vjzcAiDDK4
	 Y5SI04smpkSm9CXwMyK82O+uRop1RRfBovG+iN9uWzD7G8ohkUPJp/E2ijYCMFcQ6U
	 50PL0zzXZZ3oFqWsrgDqFYTrOqkTe9vIs0BeoGXCSRagFOmXXGSyxMvYAkrX1s2EmM
	 Pu3I/B4hv2Unp0MBR5GHePMi+ixtbZg6D7ESw0X0vVlii6XHu2mHaxxVOYObCtWd1H
	 mScv5Gfy4GJlJSHNQdt1yjFNUN9ziEauxef79xcUzo0heuKIX22fHyKigjUnSQCss7
	 t7jsB4B7pe/pw==
Message-ID: <4851f0db-9305-444e-8037-34bed9ecb6b3@kernel.org>
Date: Tue, 17 Nov 2026 10:55:48 +0100
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
Subject: Re: [PATCH v2 4/9] mm/migrate: keep the uffd bit when restoring a
 writable migration entry
To: Tal Zussman <tz2294@columbia.edu>,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
 Peter Xu <peterx@redhat.com>, James Houghton <jthoughton@google.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Suren Baghdasaryan <surenb@google.com>, Balbir Singh <balbirs@nvidia.com>,
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Michal Hocko <mhocko@suse.com>,
 =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 Andrei Vagin <avagin@gmail.com>, Muhammad Usama Anjum <usama.anjum@arm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
 =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20261116-uffd-state-fixes-v2-0-4397a0196479@columbia.edu>
 <20261116-uffd-state-fixes-v2-4-4397a0196479@columbia.edu>
 <2d9ec2ee-8867-4ac2-b2b5-654bf2441513@kernel.org>
 <20e72944-108e-461a-b75f-d8c4f8edbc9d@columbia.edu>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20e72944-108e-461a-b75f-d8c4f8edbc9d@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/26 23:42, Tal Zussman wrote:
> On 11/16/26 3:23 PM, David Hildenbrand (Arm) wrote:
>> On 11/16/26 21:02, Tal Zussman wrote:
>>> remove_migration_pte() makes the restored PTE writable for a writable
>>> migration entry, and only looks at the uffd bit of the entry otherwise.
>>> A writable migration entry that has the uffd bit set is therefore
>>> restored as a writable PTE without the uffd bit, and the page is no
>>> longer write-protected.
>>>
>>> An entry with the uffd bit set must be restored write-protected, whether
>>> the entry is writable or not. remove_migration_pmd() gets this right: it
>>> makes the PMD writable and sets the uffd bit as two independent steps,
>>> and pmd_mkuffd() write-protects the result. To fix it, do the same at
>>> the PTE level, where pte_mkuffd() write-protects the PTE as well.
>>>
>>> The only known path that created such entries is PAGEMAP_SCAN. With
>>> PM_SCAN_WP_MATCHING, it write-protects the pages it scans, and it set
>>> the uffd bit on a writable migration entry without downgrading it. Now
>>> that PAGEMAP_SCAN downgrades them like change_protection() does, we
>>> should no longer see them, so this change alone should not be visible to
>>> userspace. If another path ever creates a writable migration entry with
>>> the uffd bit set, the page now stays write-protected instead of losing
>>> the uffd bit.
>>
>> I am severely confused. If it was properly fixed, why should we do the below?
>>
>> You should WARN if we get the uffd-wp bit set on something that is writable, not
>> silently swallow it.
>>
> Yeah, so this is more of a hardening change than a pure fix. I think adding a
> VM_WARN_ON_ONCE here makes sense, but the uffd bit should still be set so
> writes don't go unreported (which is what remove_migration_pmd() does too).
> 
> remove_migration_pmd() should probably grow a warning for this case too then.

I don't like this hardening fix with recovery for something that should never
happen.

Throw in a VM_WARN_ON_ONCE() and call it a day.

-- 
Cheers,

David
