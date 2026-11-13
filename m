Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794545712;
	b=bccXYyQ4JTCwcxFtwuVTyTUcpiWsejnyD5OUVjHdS5FznrK/2a1PW1X+x72ttub1Su6P
	 hL2uxgJoxuqU8Q9Y+sb8h9UGstGWEKVfL6hAAMTBasIIlYyOuIwTUUhJTxiRU4Dj4qkBi
	 ML7oQNdsUo9MNK9RgJZuC5txIH+20M4B4bdC7iEicELpVrOh52wnOynsiuDkNoE1SrxSg
	 zRjWtCHqZGjbbfQVry3eUtn6apu1sXjTZHzhfn2DKS3KvzgE8Alpsb3sz2mI18WH4hwC+
	 wtYB4yWAZHRXB6I51jlKBMFMJfrKBYzOTZPrrAYSGAKG8W14JxKiHkm/fYd4qBB91mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794545712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=ksSqi9LFAnauiWq3VTcsn2XVnb33hHx7fgUlFBfWLfI=;
	b=KA7kBHycwzfvzK/n5MT3j+qPhhDmPBg1T62WxiNuSXRiheRcHZzD/GIvhGGIygR1zRY3
	 EIOd3n8N6rahLTGYBqs5vzw1nEANTLdwp8uIO+YMa7oVngUx3+f9OedWCSreQbXhK93AS
	 17d5EwmaD1XcU0+4LRHznKlsdFUaUcbVow393i1ATQ9lUNQ+soOUJXkCslmjDhGBtvP7l
	 6Kqh2zMzfcbkQgiV3JKP3/wUhdQDOV7o2WY7FTzua5kFhLBf2qvTUXpu2e8J7/MqkpE+R
	 GKqZEdvrqzVvqXgfGRl8PQgz8ubXZFBKr5aWU0tF5qdPUflQ8vlZvW04SXd9k+ZtkWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=PbTw7Bnc;
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26CE606A31C
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 04:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C26CE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=PbTw7Bnc
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91c847584b8so11357396d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 20:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794545711; x=1795150511; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ksSqi9LFAnauiWq3VTcsn2XVnb33hHx7fgUlFBfWLfI=;
        b=PbTw7BncmEgkZfS1fdabmtwdiOdoSK3DY5Kq/iWkXHztCq8wDKdDT/LGGhRvXrIsRQ
         Wur01OwukhRTo/Lr836rl95gCd6cHUb4rkN4guSemnh8OyJD9+YifNFz8zDz+/UN5sYh
         pMV3G7UKf4OpgC8TY954O8r0Hg3a3OR9bSwOT/w2/5fkPtB3BdFB1ih1R8D2dja9Glbv
         yNxHvDDjtFuwFFlF4QSZfmTbKWTJqdyGU+MSLV5LXPP9ZqGlQ8zncNZ1DC0JgqEck8Qc
         LkZa6Mpu8TdfzTe11xQWCw1qKEQJ+kpIorK6TeQouCjdifujJIX6oVoNG6CeFS2fHN72
         iOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794545711; x=1795150511;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ksSqi9LFAnauiWq3VTcsn2XVnb33hHx7fgUlFBfWLfI=;
        b=O9wtPRfB0oIrWazUPEvNnMp9opawBWANu/oEndCE7Cce3deCRDvS8+a8H5XGIrJ1Ww
         Bmutw8dSG9SKowyy1j/b5CfE1azczucZmWCbZFPTqJifhuqQzs8mB0m2wIK2567I87Pf
         GGgrZj1NSvwrMsLVLrv4X3m9YgOLgLbx8gF2A9EnukRC3J+iBVXoARKnS7WLSUfS3DLL
         IHr9ZlfuRoO7aWrBeUp7LAHsfrHh9JxXDaPX5eMGxO3N2Xb1HW6PXc0Klj4d3OnK4okK
         +gFe1cF6wTngpyqPx8SPl0zwPi1M7rvq92Y9eG76ki3eyTNpa1JuiPQYQQqse91AcQee
         cMkg==
X-Forwarded-Encrypted: i=1; AL+hErG12mcFD13ayQoW4kWXKRsE0jVFrRh9ls2+fT/d7nt8qEwYhorRaBA1hlJfwcGY393kFxWNOfZWoyHPE2sW@vger.kernel.org
X-Gm-Message-State: APuU4Z8c3G362GDf3wmG1BfVLS6Rzclknk8WONgJ+X6dZb5IBYRgPjil
	Mz9FLP3RntcIgDum01v8xlM34S97v3wRUpLdS/0/0CM9qyUbruNmMDwd0IpicWfDL/s=
X-Gm-Gg: AYBFou2r61Y4fagqETpoKLdJAsn0zoxa7wQP1LB8xksKM6snh4hW3S098L7jls29Dzl
	654Z3YWcSVFvJenjbrcv70/+MRkwAtZmiXOe+u3PIj08B7DCBf39nIuUncs3404fFiqDTDw5von
	jlpp8C3x+NatIbxEcE9CU1X02wXNPgRXACk2l29IJb+VOs/1j/DIf7P4J7vM76cz3WU75soSAy7
	7X9s7JB1kUtsNycJGDfE3/48Vy1dpQj+0rrSvwglLJT/eNya9JuChf9/aJfDA30AV5czRJkxkGG
	IIPmsEKJ4XUFbqww3lzCBInIRziB1d9u2FfmEimM+9JDVPfevnJw4pQd1zfTcNGdjzgP8J78Gao
	NxjRmH+tUpcgBh6Gvfo8gzQrXAQKEOkXUjP/BaNoAa6QUTq82XFHE7pIY9UGrcH3B9AaL8VK1QM
	0cmtLDeP+imZA+LWPa9QGr6Vk8eob2CFXc+SqDyJX4oOcoHcxvjkO/Q1dk3IjfNA/iIHqQ8kSmr
	hOWpW+uqp5uwLv8T07i0qt9hg/O91b7xadpHB0f8VbwL8nnTARx0OjOT9Zm9K4boQvuruAwcSSE
	d+fr2Izt7y/3iwk56uwMpkG35T26LkKgzwkK5eONQyvukpjRAo/dicCZJG2zeOIU7rX3/NVQs4Y
	uWlss/XsT8y4zJgGiHzcEP9CVWoCR
X-Received: by 2002:a05:6214:5e05:b0:91f:2abb:a7ad with SMTP id 6a1803df08f44-91f2abbad77mr1153566d6.16.1794545710518;
        Thu, 12 Nov 2026 20:55:10 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d73206sm12150726d6.25.2026.11.12.20.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 20:55:10 -0800 (PST)
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
Subject: Re: [PATCH 03/12] fs/proc/task_mmu: downgrade writable migration
 entries in PAGEMAP_SCAN write-protect
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
In-Reply-To: <20261111-uffd-state-fixes-v1-3-00713d368976@columbia.edu>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-3-00713d368976@columbia.edu>
Date: Thu, 12 Nov 2026 23:55:08 -0500
Message-Id: <179454570885.482102.16669231045892763097.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-11 12:55 -0500, Tal Zussman wrote:
> PAGEMAP_SCAN with PM_SCAN_WP_MATCHING write-protects pages in a VMA
> registered for async uffd-wp, and sets the uffd bit on non-present
> entries as they are. An entry with the uffd bit set must not be
> writable, so that the page is write-protected once it is mapped again.
> change_protection() therefore downgrades writable migration and
> device-private entries to readable ones first, but PAGEMAP_SCAN does
> not.
> 
> For a writable migration entry at the PTE level,
> remove_migration_pte() restores a writable PTE without the uffd bit. So
> if a page is under migration while PAGEMAP_SCAN write-protects it, the
> write protection is lost. A user tracking writes with async uffd-wp
> sees the page reported as written on the next scan although nothing
> wrote to it.
> 
> With CONFIG_PAGE_TABLE_CHECK, setting the uffd bit on a writable
> non-present PTE or PMD also triggers a warning.
> 
> To fix it, downgrade writable migration and device-private entries
> before setting the uffd bit, as change_protection() does, at the PTE,
> PMD, and hugetlb levels.
> 
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Reproduced and managed to emit a page-table-check warning and
demonstrate the lost WP during migration.

Will leave the review notes to Lorenzo, the overall idea looks sound,
if painfully verbose / special.  But then uffd appears to create
this pattern everywhere it touches something :\

Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

