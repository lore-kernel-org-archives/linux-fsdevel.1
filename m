Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794547146;
	b=wJXm8lSk2YoA43ii0Jvxb1RL+UwmdF5y9wvJ8Hpmr/4FqG20kOpfAbPKcSSqPsFfGw4V
	 pF20RQp53xuN4ATcVqbS67khOXMzFlmEEr0e+bnPR9Y6Bpw2uKfgdBq8GgylxAK8rDlQH
	 K7xga0BeF1cW+HcLULz6X3uosl5asjpBvCO7gVNnC+nw80QiAN1Vsmu7EAFdT972DDhdK
	 wulLe8AyqK5bYRp7KyR6xj5CLsseQnuVWJJ/d4w2BMxciSw91k4iCUWBvCaXSGDROy+Vp
	 qHA3GrQplJ3HHV1hJ3rGjiE7A3wnFU+1kSHqUB/uaytVbR03NQBFGz2CX0+9/McCCeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794547146;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=SZ/WoExpnJ8hrgM/hl6NJJrxD86AhGkO6OAXDjbXUhM=;
	b=SCAv4TLW28iRXbtCnJ6jhGFq29H9gAf1HWfcDQXUJXlMmj8uP3s8MQcjw85vu/RqTAaj
	 cxPJevq1MDU1fDy3uvHUyxtOsUpOFzNcgjtw8LeYtska5eTvQOp0XNkmRWEGYN2Qu99tc
	 bpT8OotWvW4E38qNJDSUjYuy358V8BpLSb7iPEQTebu4EoV6VLOgYtJZ0HBZSR2GIQD0N
	 sRSLpUvxadEpIwfecuw3eoq+URvf6iZn4b0z2KssO5nB3T/XhdS1s6qQwN9Rj5szsN0+X
	 WT2/CkI7MVYxUke+Olu1lA0dzfk4HazSOrnH82rQIhtFGKiNd4Klh41ieg2oqtpZdlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EmDt9IgY;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C15606A321
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 05:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82C15606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EmDt9IgY
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93f269e335eso132676585a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 21:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794547144; x=1795151944; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SZ/WoExpnJ8hrgM/hl6NJJrxD86AhGkO6OAXDjbXUhM=;
        b=EmDt9IgYiZiLNjvWSV+IAK+VJTXs4hMTZg5NFCXaQX8h2/IzPDuscZQ4Non8MU01Xx
         eo21TqkqMDN2DKSqYsyiXZH40khVAsbr09nKuKeUZ+YfYLlvTyU5dmm4mXQCC2OicICq
         +WBbgzEkMZzfdz9lZL2WJQuJm+kRfmWApuAz0BO4odG18lX64PqtoZPIOSMTXa7qtWvC
         iFJSmZxtEs1GS9ds62eUUV9IpBP5NwH64gURgK697+GOZue+3wYrm1Q4z4N+C0tSC48P
         PcibbF65Bq8SiEVUp3lm6JxVA/r40lxFCgyZczt13RA3b3Cb0tFwQx80N9FA2A6LWEGv
         ygSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794547144; x=1795151944;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SZ/WoExpnJ8hrgM/hl6NJJrxD86AhGkO6OAXDjbXUhM=;
        b=M18tKY3HU5HOr+olJ/uz2Y+VyhCpzprgz5hgm6oi0ndMUFtDWW2lBRobnPLX0q64t7
         /NLI7kClw4mdGo62FIk0aTcMAGUfRMJJuPZY6xnfWQbe6m/X95QBiL+9KUNCzosXuAGK
         rmu6fcjKNusysIfC4rzDXpY8sx66+tmKqLTUNYsyrK+IR5TV4E6RNDZwDQOX0rb+PIlP
         ZJOTJitD2o3girnlhDezuF0LzW0n7s62WZX1SphkVyv9UbX2uEYtGRcbU4FdAIatS7/a
         74kCjRrM0x6ShvqIFfAP/wJj7rM1Hsxy3m+ljKHgsr4qTUF56NoR+pJHTGm4BS9mKiWN
         40vw==
X-Forwarded-Encrypted: i=1; AL+hErGMrEIDqtUte72jnptO8KYRfgMCWzC8XbygDWDnUVOiqqEhlFnjamSCLl/FOOX+OHXtGXyeM8ZO8opcwhEo@vger.kernel.org
X-Gm-Message-State: APuU4Z/xbaojTXrPiSSO3wRCPNcXezKGTKH+Z793BKtttIjmKkJIyWQv
	DhObH8KbY37npyXIP5p3f4zkaALz/mlFAAMM1BeMtUQMQI6JZ4vjz30sdCk3i/GMwbQ=
X-Gm-Gg: AYBFou1eQjB9jl06aY21w+Y0ScTaELHwGP93KXB1JTjOGfzBXqxzckGyzdQKIPyl23O
	ayaxNpm6pzzE6K831q9P241PjQxAi2+BahltmmyBRAK9vi7lzdCrhq+zWjeqw7fFYSnvghSfzpK
	4kSNzCaDq5i0YwZRzWFDK6gQEU7AYGwPvPIPKSuR7pIiApUoBZMCbf+NoKm1an0YDWcqsan6WEx
	fU5HLH3bn3xNhe7M130KakKN3awcWdOahonu+KNL9OUMCKvimYfSQAaOwGg7KuLtJ0Wk2M63lsn
	Bkhc+aRrBrhNSCuvxvZqWta0pYqs8nzK44FN+COTeRme+wCNt5rEMJ8cCpS4iJiQCEI0YyGFgTs
	zJy/XDmlJsngaweGq1chJrsI4/mNN+5NnqgX/dFYFrcehkt+R1JP4NlywKGzZrwFe+Cr3GNXl3W
	gKo7GcUOnEnBAqeTOjL57rE7jO7IfLQe9mjL4aaIztFh/bf9BMFFDSfVZZTCe9r+493pk99dL0B
	7lMZsXw1OJlkhvYSBOPMB6Zhya7qn/IUheuPYN/wMSLib7C+bkpo3l3P3e/2xd9QmE/JuvoxkE6
	dk0CkUFUjmkz5TJeEZOo7K/kxc7+cbUCM12Bme/CJP7cQHt0lcvhzDdX1JToag5hyr7evCB/RvL
	SpVnWtV4=
X-Received: by 2002:a05:620a:4713:b0:93e:646c:9133 with SMTP id af79cd13be357-9494bc53dd7mr281919185a.64.1794547144420;
        Thu, 12 Nov 2026 21:19:04 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c6025f5sm106509685a.5.2026.11.12.21.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:19:04 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 06/12] mm/huge_memory: build the moved huge zero PMD
 from the destination VMA
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>, 
 James Houghton <jthoughton@google.com>, 
 Andrea Arcangeli <aarcange@redhat.com>, 
 Suren Baghdasaryan <surenb@google.com>, Balbir Singh <balbirs@nvidia.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Andrei Vagin <avagin@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
 Arnd Bergmann <arnd@arndb.de>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Chris Down <chris@chrisdown.name>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 =?utf-8?q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>, 
 Michal Hocko <mhocko@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org
In-Reply-To: <20261111-uffd-state-fixes-v1-6-00713d368976@columbia.edu>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-6-00713d368976@columbia.edu>
Date: Fri, 13 Nov 2026 00:19:02 -0500
Message-Id: <179454714288.482102.7776276516691241493.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-11 12:55 -0500, Tal Zussman wrote:
> move_pages_huge_pmd() builds the destination PMD for the huge zero page
> by copying the source PMD and clearing its uffd bit, so the destination
> keeps the protection of the source.
> 
> A source VMA registered for RWP can map the huge zero page with a
> PAGE_NONE PMD, and UFFDIO_MOVE does not check how the source is
> registered. The destination then gets a PAGE_NONE PMD without the uffd
> bit, although nothing asked for that in the destination VMA.
> 
> The next access fixes it up through the NUMA hinting fault path. Until
> then, the first access to the destination takes a spurious fault and GUP
> has to take the fault path. The impact on userspace is small.
> 
> The moved entry must have the protection of the destination VMA. To fix
> it, build the entry from the vm_page_prot of the destination VMA, as
> move_zeropage_pte() does for the small zero page, and keep marking it
> soft-dirty. A destination VMA registered for RWP still gets its PMD
> re-armed afterwards.
> 
> Fixes: 763f43865fc4 ("mm: preserve RWP marker across PTE rewrites")
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Reproduced the spurious fault.  Change looks reasonable.

Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

