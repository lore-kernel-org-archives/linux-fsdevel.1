Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526666;
	b=pgkUOtXJ4EysKok0hoaCd2b4orON4uHZMMUCFMyqxVOKfFocPz3zTpwecUHSlu/jFht3
	 kURrJaXhCCbwwsajC5xDWEwvxwA+ZAzRwju4sZiLgJnc/M+q+x76XNAA2mONB7Nou0GW2
	 wrN1nQhuXMS9JzOvCtpsWqvSWE0L1jqZfEAeWpswvj5bYLYapRsiSgArLo2gX56dnS1Oj
	 ewZ25Rfxz5z/fA9FF9WWFBKneTG/5RvF+FTWCBf2lF1qRISASHnLMrSc9cyOuAsDftEHe
	 Gw3CRDztPsDOLeP83Zl2NbTmXwMpLnAsN5/87hzC46Ww6MgTmQ+GD5ZKsFDAteoyL6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=j2lGOfpuqWA9c5CeS3NsQ/3TJJfRuyj6wTBADsS42iU=;
	b=KgqHpe3cpw8HgH2yT8Aww8MSE4LpmvpBSpXyPn5mUEthIsYTviXlu9q1Q1lnvBxv1VLG
	 uqJ5vIhGd2ZgA+8CDoY+hFE/qf7fq0SwIH7tKPxp6q6p0lgsM4sZed4GGPXAimwz/GV/A
	 cnnHtxhFZI2Hyr2o/4WHZn60y1AAHYqvBMAJI6GijNWNFNLBkq3lIa7sBkBltWt54xR8p
	 ZazrXPQTvD6QZrURdrQYc1r6dEJ8x+YxwBJLgARSpssstVvXl+Ngvft8AAX2G2wwgQC4G
	 0tskYLyo57Mbz3kUF+lfwPc1Rs8xnqWcGPXVImIjB3kB8b0VmnsSBkvO/FVnxyArPgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="e2qVYdC/";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB0B606A321
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 13:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACB0B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e2qVYdC/
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso24650425e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 05:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795526664; x=1796131464; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j2lGOfpuqWA9c5CeS3NsQ/3TJJfRuyj6wTBADsS42iU=;
        b=e2qVYdC/mXdjFACrZz+884sYdtZuVnERtWgcQhcsucfmOtRPjnYpcroO1cl9kYtRrz
         Ipz+u4I+zinaMDaKG9o+E5noYTt992UI3Ana8d998e3XOlokRkou7fZ4YKzI+NvFFgvJ
         ASYWizXvFH2Lu0l3xKj/mpyg9xKlN/tOvjqKNh/0CBlOpFU4EgIKn9guL186RrGdMWwn
         HDkLXY1jUcMNWSZDxI+xwV1UQ022sX1aX3eigoLqFxqR67l/iUKRPgVZNsap7uuOrrVa
         4vN8Gw8pKQMm+mEP/GB4J3/mlMyYNCZehrYM+9PNIwihO8Abe6FaR/dLZbGVXccuFaLd
         yL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795526664; x=1796131464;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j2lGOfpuqWA9c5CeS3NsQ/3TJJfRuyj6wTBADsS42iU=;
        b=u+smvClOb8bWFPMj4qhKsUdxbU26GTtYTJ9bWOxzWyrqadTOhkhuMWveIXm6k3pvic
         K96lxUI3nZMeduHO5VcDAY9MefsSCgWEmdgvI/o1tvvh22JB+6Y3OW/lRFzOUtCFCnBv
         K2OzI/ms8DkYKsAfVvskzekNqK4hbbgP7y0eLRvhW6Z7QlR5Q8GgCoQDecKOjBWhCB5V
         WRRY8GuEudpZA0s3t/if7YVqRvrStNVjCDz5EeRrLJnOSQ+9XMiYtt0crdvItCHFod2f
         RyZecsfjt/CQKy3J2pghEPk/GpD20sKKuXcKKL7q8hHv6+eRLMQ/B9Ud48S6Pv1827Rt
         /L4g==
X-Forwarded-Encrypted: i=1; AL+hErF7/lca/yWsG5GpEGPSJFsDXtWFHG64H2sdRSk9/3rB/bi+tPjhxAKH6jCXOOvyt7Xwjt2XiNvAtUyyJCf4@vger.kernel.org
X-Gm-Message-State: APuU4Z/WaEVbqZr+QbC2LKIE0RX7ZINnj0poPk8dMlIXzrQ8vtSZRrS7
	mmnKbMZKdH2PXSAqRZepH7IgJG7wQnHNf2OIch+hXomjwU84ocA/VPrc
X-Gm-Gg: AZFdTZd6WWp/JcVK3eUOAfA7m1KaMtRve09iAS5LQryHpN1/RZ/i38Ob5/Nw0Y8Feui
	gh25jZCQJWHcFLcbX2fVO27z/cRy+NcESz93pJYwH8PcYCS7TGlVGReSEx3FSIGo3v3wom/MYBM
	9XpFWaqwXU8peUk+hSA3tRV+BEPZ26rzrQSAmoRu5BNIv+kRYOezjL8sfrM3LiHUOdyR1Z22RMU
	rfgglBvrUAn+bP8dUAD5N9FT2GppgPLQSgDKAAvf6oisP1Wh0qw80b2lYFoFueLqRH8nce3Jrz4
	x2OS1bm/pYbtuQ5loqJLuhSg0pNhMLfvtUfxBIMEsyIjKGYCnKwOYHlPKJIj5IcbNB8o1I0r3XN
	Y6ZO9Apo8p4KAaocA4/JcOEzZyEJbKdINskqOw1hdx2McLbWDPvXVfvVrX4/SNpatlsoJV+8odg
	3NlOlevT7+KD6P/yt2Z1Ntms/o8eXInK1PVRAuJZB+C04RTa6ppIkPk0iEtcVo13zuiX6P+C90r
	bAjiDAWvXMM324D1VSmPtlP766n6qtSVjH/wnzTPKUFB6CV7FczhgnRcejDpJsMuokUtO1+8wku
	qyMTXdEsyu4PzJViCQKxDB9BHDRN9zBu9pTsWNImIrjYDA==
X-Received: by 2002:a05:600c:64c6:b0:4a3:598e:e7a8 with SMTP id 5b1f17b1804b1-4bb887c2c98mr274938815e9.4.1795526663725;
        Tue, 24 Nov 2026 05:24:23 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f281sm26298695f8f.22.2026.11.24.05.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 05:24:23 -0800 (PST)
Message-ID: <7465de57-8d97-4952-9daf-d95bdb4b7e78@gmail.com>
Date: Tue, 24 Nov 2026 14:24:20 +0100
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
Subject: Re: [PATCH v2 0/2] mm: fix deadlock on the folio lock when migrating
 and splitting folios
To: "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 William Kucharski <william.kucharski@oracle.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Johannes Weiner <hannes@cmpxchg.org>, "Lorenzo Stoakes (ARM)"
 <ljs@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
 Chris Mason <mason@kernel.org>, Chris Down <chris@chrisdown.name>
References: <20261124-migrate_reclaim_deadlock-v2-0-03cc147e1e36@kernel.org>
 <66e5f9e3-17d4-4635-8919-c67ed562f9f0@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <66e5f9e3-17d4-4635-8919-c67ed562f9f0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/26 10:47 AM, David Hildenbrand (Arm) wrote:
> On 11/24/26 08:56, David Hildenbrand (Arm) wrote:
>> Whenever we allocate memory with __GFP_FS while holding folio locks, we
>> can deadlock on the folio lock when triggering direct reclaim or
>> compaction.
>>
>> For example, evicting inodes with a populated page cache takes folio
>> locks, and if we happen to need one of the folio locks we already hold,
>> we'll deadlock.
>>
>> FUSE makes this example easier to trigger, because it evicts inodes on
>> the last reference. A similar deadlock with FUSE was recently fixed in
>> FUSE [1].
>>
>> Let's handle folio splitting by simply running in NOFS context. We only
>> perform small allocations, so it doesn't really make a difference.
>> Interestingly, this also fixes one of a handful of possible memcg v1
>> deadlocks.
>>
>> For page migration, change the code to allocate destination folios
>> without holding folio locks, which is in any case the right thing to do
>> to reduce folio lock holding times.
>>
>> Some of this might also be fixable using Jan's work on deferred inode
>> reclaim [2]. However, that is not stable material, and not allocating
>> folios while holding other folio locks is an improvement on its own.
>>
>> Unprivileged users can trigger this deadlock with FUSE and
>> mbind()/migrate_pages(); however, it requires multiple NUMA nodes and
>> quite some luck.
>>
>> I reproduced the original deadlocks with FUSE and made sure they can no
>> longer be triggered with these fixes. Further, I ran the usual migration
>> and folio splitting selftests.
> 
> @Jose, could you find and fix other cases where we allocate under the folio lock
> with __GFP_FS (and direct reclaim enabled?).
> 
> I think at least do_set_pmd() might have a problem when allocating a page table
> through pte_alloc_one(). And I'm sure there's more.
> 

sure, I'll look into it :)

-- 
cheers,
jose a. p-a
