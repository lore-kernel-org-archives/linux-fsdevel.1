Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794546510;
	b=3AGN+XunOAHntThxRSZrwP3uWGUjT/xx4Uvp27buUzlRBF27l7vmJhyci8kzmMpD+4cP
	 yLdhELyT8wL16hPZ/tz5ZNMJmlkwDOYhkJGsvTmBQO6mF59WYYIVtFr5TSOx8rwYqlkva
	 aWgZXEbL/khVTM0H2H3Evq0/fRRsjxWiPmu27rziXhrJrMvXOit2nme4RGAq7QOzYlA3C
	 DnBwOukZAjfrD9gIGxXMtBKgLSeLOwr05RNwDm/mWnu5Cmp0oBMpIkvu3G+s/xpQhaGe8
	 dIOa2nezja/gW1VNiKn/ZjZmzZZ4vG5HUrRRhGE8U5Ex31IMMeUh9xphhfLjpTqa37g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794546510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=LmFjzwEPLh1WnvAWN35VH6q9XGy6Q88rO7whGWc3zyY=;
	b=uLyrbaG2eD3hJcUCZgJitNtX2gggp/h/1Jmskr3aDY8nuvhtWnSVOQxUzeumDdYFN0E6
	 AgkD17iMiXf1kyse9bZV66fFlwXg5zJ3ascKKsw8/05fDiCTXskfnimBG/hMqCs9/a4Ls
	 z917XylYheZWCApV0pm8jWZm4llIK0ORq1faqx/7dbFiPFdMswwNgUYbZrUVs7nU1EapG
	 BAURaZV3mF8SMtWTAvZcKuSoxL6fM7DPeKJInHVj6oLMMHFjVU1qdWXtMY8HrCDOR7Z0r
	 NuVf5i4E/5zMGhqKpVa9XH4hxV6rg0NUQpAAg2xAuyhXdYWdfqjeR0qcmYSBK+7TcZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=iKzF8SE4;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97180606A894
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 05:08:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97180606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=iKzF8SE4
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93f20b304c0so83971085a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 21:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794546508; x=1795151308; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LmFjzwEPLh1WnvAWN35VH6q9XGy6Q88rO7whGWc3zyY=;
        b=iKzF8SE4igTO5PjE/vkTiUA/wc411ldVAWTTtqWvysMLBnScY6X1rKvxfKsCnViAp/
         h8cj5pP2Qw9AjaHlKmiDrNdR1fGFREemtkoKNcCZhqvK+xjqQXJJAo9yPRqD0Q6oPhzF
         2ypLTwvEiWk13ynC86wAHvvfOpEWGCghPcpUHfjIvhStdVf8ckeiIUQU61sKG5PRsQiX
         HPrPhqTkkWFXxcHMe7pu/LTzpgdlHxHAFVRZr7LJ5npL2CnVw2QBII4GZ0pZcUBMK4VF
         rMtA3e9cW2ujyEuULVSYOEA6g5bWxbvWPmz5g8zhiHKhVy0HsrI5+9L4G1ubVt19UN+M
         SMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794546508; x=1795151308;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LmFjzwEPLh1WnvAWN35VH6q9XGy6Q88rO7whGWc3zyY=;
        b=FO4xa/xSdQgWdb1FXkrgLnBb72YwHOeE8vVY959lsM4N/kSqGi77r2yZBXviga5vai
         vpxNA5v/kRfgYCpytLD6eUGk0+Qlohf8BwwmaOn9v/xdmIEBOpSpBgoS+SlRndQsTSpk
         Yn740UvxPxZ5ZNJ3zTQSg0zyolF2hTTA+Ddo4sEEL2uyIMroy0kYMAfKBt48w33mKyak
         gPCes8NUEsuZ7GxExWe3RxeKiwv5DM4hmMSNBUAWwyze1FfKbca/LFm5ouY8TdGTErMy
         HOhAYyzBTgDQ2uWvKJpjVOzVOPZkTIlGK3Ff+l4Cry9p/xHV+lzV5+WPwXI/ntsg4Y4b
         Mqpg==
X-Forwarded-Encrypted: i=1; AL+hErH0vwrbbTiBRPMI9regdt80blJ61CgMDhvDw02ta08MmEgjbeDmqabUVUJoUuwmNL/p0eFSSyr7/lU55wDU@vger.kernel.org
X-Gm-Message-State: APuU4Z+tb8NQSATuVyaRmOOItlw+inNEVnH139hwcnODNK4cN3zSNtld
	F2n3akbrlWBNFkREcQaFSMX4xWB+6BDeZwfHw0OfyKZlOpF2THkkyyse96ncztP8rdo=
X-Gm-Gg: AYBFou3RSP3hexD8X1pYX2ypPMamp5gRedolI8e3A39W/2QqVw9AIzDZYs5u2T172KC
	ZGcpTC668M8BAs9pogJo7Q12bOJ1QQ3zUv8reZvO7xQuL03N4Gw94frA7BfBAGcpQTjTHJ21uu6
	4b4X3JCe9BuTPyL2jobYgjpKgwtbn/KdhTQ/jlc8VzYlADUHYI1av0u9T2DF8LRc7TVe7JBslmT
	vuO9cUlt35nZZID4RyHKcdqI//DTO8DsPQ1cG7DC2xgS3MVvUs6DqaOlUgAp3SzDuJsf2vBMufm
	GaX+Yzp3Mnf74g5vEx5rWvmZ/NDDEZhIvxWEAPa1eYtsOTkxErtCKRj+zaE9on9W5dDOT2PTsuP
	ro913es2FDoThaxjZ1pkpvLYD8ogWeujM89ol9Vwaqcl6h4YdN0tzXR/389JoJxdnqFHOngqmV7
	xMZPG/WmBjPXS7aRoIdvLVMDvB5QzsYkOa3tn3RrgHBJ1b9mbshpGOmqU3frLgg06pqIt8FCX3y
	l3Kdw/c6a3CxQ1w/KdLUDcLig52w1lX8uSY/XUi/i+Wf/7a/vYEddNssh0Vz2OnACyYkaAXmKDE
	ucS+IOC13jyLU0QpfVNSVrC4mUjk7yB1poal54N2vqo3Pc3Qu5Jtrtbmu+n7TANQmLGGY+GTbyX
	ZC7oycSbUfCvOP7yqIUwaBL3XCIbEgw==
X-Received: by 2002:a05:620a:2987:b0:93f:2a56:2772 with SMTP id af79cd13be357-9494bcbc465mr254819685a.78.1794546508039;
        Thu, 12 Nov 2026 21:08:28 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d452b0sm12300596d6.11.2026.11.12.21.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:08:27 -0800 (PST)
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
Subject: Re: [PATCH 05/12] fs/proc/task_mmu: write-protect device-private
 THPs in PAGEMAP_SCAN
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Tal Zussman <tz2294@columbia.edu>, 
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
 Peter Xu <peterx@redhat.com>, James Houghton <jthoughton@google.com>, 
 Andrea Arcangeli <aarcange@redhat.com>, 
 Suren Baghdasaryan <surenb@google.com>, Balbir Singh <balbirs@nvidia.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
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
In-Reply-To: <avYQteUm963AKJQ7@gremlin>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-5-00713d368976@columbia.edu>
 <avYQteUm963AKJQ7@gremlin>
Date: Fri, 13 Nov 2026 00:08:26 -0500
Message-Id: <179454650651.482102.17667443707760097412.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-12 19:34 +0000, Lorenzo Stoakes (ARM) wrote:
> On Wed, Nov 11, 2026 at 12:55:13PM -0500, Tal Zussman wrote:
> > but does nothing for a device-private THP. The PMD never gets the uffd
> > bit.
> 
> Sigh yeah. Device-private feels like another 'just have to happen to know to
> update X million open-coded parts of the code'.
> 
> We really need to find a way to abstract this stuff.
>

I've poked at it a bit, but zone device creates this issue in many
places. The core issue is really that softleaf can mean 20 things,
and the number of things has been piled on heavily.

I don't know how we solve this, it's just a rats nest of complexity
at this point.

-- 
~Gregory

