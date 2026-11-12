Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794506187;
	b=N3VNsDEZweUaiGAVf9ThKXGYeOS38laNiQnRq3EnZcAANuDdSVymKWZtbC7KoqDJIuUf
	 4TTsVLtr37gDql2sc4g+dGb/CfwPhjZZSzos/qsnBVwvvT/8OQVIqFldOBZPUUSnXkf8a
	 tBRGAfRIW5RU2IAU5SQAYDogOooTxWzCDQaNDR6MTTqTpT36Wz9sEWDmmzm+O+pZkdJ/r
	 Xr287pCPKdBoDuk3aU2xm37Gjh8/B04z0IAfg+oCteXKqfkPJMAvjw1xvuic2sZEuQdY2
	 ImQ9+OBDcvB2oASdjvAxsfwGHVRkDB6Bi+sSoFpnHh1E30fQa21+Q0Tzr4Y0v4+N/Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506187;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=oX1FfxSvKmY7PUz36O/ZliPw6+lwphICskypKstU3eM=;
	b=AsKN+A6zFzMXFTTNAtRMiQlvKpoIEpq5kgCqGMZjDni94pyvdoNlUCe+Fvp/GlO7m9CE
	 PEqZGAy0WrdzQ0oQZgzs835dFYmnrPhLpydmtDPMa66i1mwb9qD9vTto3RdxwEi0HsN7I
	 7Maix8TVMtjIv688ewAIHGrU0QJpKbndIme56XKhbztzjog6mRzs7a85GePbzLd1N1trr
	 WLJGcNr7Yuv/3qc0WvvcvtRrt7i0j1+PN1wFr0vqcPqyJQnGy9jtdXlLbqgTXsIx1YJ3T
	 /XpLAiwzvDMvNYK7utMFDOAeh1XCBQ0wAU61CqoAOe0Q9mHpVmT/u3HMElAxm6ymoDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EHevdXBn;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319FE606A321
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 17:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 319FE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EHevdXBn
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91ea0c05c92so668526d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 09:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794506186; x=1795110986; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oX1FfxSvKmY7PUz36O/ZliPw6+lwphICskypKstU3eM=;
        b=EHevdXBnV4anAfSLKj5v8q2Iozg9+kJRetotcX6QAbpiWWKdfn3IwKbW+VaI2GAaZx
         1qceClnVl1GgIdWydNamNGFCl6PY/+1OUnJMCW2CqU0QDuIPdyY9QU1jxAV89RBRTHa1
         2lDsok4KB59SozZzLSpNfWCAD3Y0iYPpXq7vW2m1lZn8Cq3AXVNVdH/2L6JA+JVoVdAu
         QcT9Fv3EfNxygDjKYfo3ZKS4vQHT0eITMDOGpHaFNElXyCqjANHZeWKD2J2h0dWNDT2v
         rG89HgkXOJhxDBWcCS6c7h7an2NxYuBSUXIJhH5YT8eEJRaMSDwGmCuuaRJUFI87lodq
         3phw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794506186; x=1795110986;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oX1FfxSvKmY7PUz36O/ZliPw6+lwphICskypKstU3eM=;
        b=APVrHTH8C8qH+SZxA1jpD+cUae0y23jVTTf14x9zHUihgymALYcoWfXr8fN0jdHYz5
         +G9iHodXD06onR5VZ5NPdTjdD0VV1jNFc0rGQ07NXmegkBhGzIalWClPocROgYYlLNzS
         kfloDtoypFw3LI08LE5N5FmozUYWs4t7QZTnoa3w6yBOTZLCWrs0Zqu205fsXs/rTWt2
         JAtEpCO1MdDB/+GNuIdw7LWQUrNOm4IMrkatl3dcZ8dXMBxaueaYKO0druLACpzvm12B
         +Ns06xOOxkZH/KEe3luz+otBFaJITs5a+TlEk5vguBJPjlv4ui7VS9f/glBYk0rFbk8k
         Rd2w==
X-Forwarded-Encrypted: i=1; AL+hErGcwb/rHWX1L07JUKtjJpPsQb+IOksf++SUb76h7VkwAaZODJHGeFMbdSoB4BDWZCZ3qlXBn+fpjpDG3G/9@vger.kernel.org
X-Gm-Message-State: APuU4Z/CXUmkPkXnI1FRBnojUCs/7vFOZkAdJTsrIgw+foGRW0ehDv4+
	DRNvpfoucZ22nFWzMg/UMopIph9sM4RhQ/0kv+Jl8IHNdtsin6zdssvtS2EPtdA+dMA=
X-Gm-Gg: AYBFou2cWA5dgZt9baVzV2FTlMRTtvpUtKv2ZRmy5dpv4/Shmtgaqa8a7Ku/0dzcXim
	ue5NgaUu2ISZowC8nL/6F+cXoHYH+N//+XLk/1ofShijGuwnDRZWP9rU6qzAiCppuBahMNTdl7H
	Nz4HO8xiKUudB9gP7KDfPU4e3xd4l5ouoNsxfk2yk37N28YkKXFJdKHd78MNQUFXkksSWmIrIr5
	dMjjDiSd+r/ZyInxkkJVBgGd6a3Y6loNy9TXQv4JiKr/BBxz8Nek9i3m+dwx+Z0S5hirNMl1ztl
	3p66pN/kRVBlslJz122IQDhVCCa+SwXUlZCdLKAIzmAiOzE7hVpngKsIZXidlNNqF903VsVSnTz
	SVuD02Vi5yrKcZ0SDSWdecz4maigH6ob0wIpv0hLkDdbSsMCjsBC/+dy/rrtGJJs8tMqWZ3+Yhe
	5RrFmPTUHAugaVy38k+yLAZXoOMF3UkBGDLrSM+kCeJ5spclUGJ21mqeg3GEcz3klK070qzYVkl
	iOHIwXiCyombCkHm75HJcbzoSlVMq3YMAX/AXfqTVaO+INhLcvnRZbCMjz/FNUnWOakeqE4YUXR
	TqfmjDWFGAq1VI0aJYlX5Ty19o9GFQmKRzvXd4xDvdZrvag56P8Dc2WgqvYa3chxXyDpBwXXpzd
	OHCNeOWM=
X-Received: by 2002:a05:6214:858d:20b0:91e:9b17:2be9 with SMTP id 6a1803df08f44-91f24203591mr468026d6.36.1794506186056;
        Thu, 12 Nov 2026 09:56:26 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d70489sm1212506d6.21.2026.11.12.09.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:56:25 -0800 (PST)
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
Subject: Re: [PATCH 06/13] mm/migrate_device: don't let go of the fault
 page
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
 Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Glisse?= <jglisse@redhat.com>, 
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
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-6-3d2454362e8d@kernel.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-6-3d2454362e8d@kernel.org>
Date: Thu, 12 Nov 2026 12:56:24 -0500
Message-Id: <179450618409.482102.8556965317179106876.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-11 18:13 +0000, Lorenzo Stoakes (ARM) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> When migrate_vma_split_folio() has split the folio of the fault page,
> the lock and the reference which the fault handler has taken are at the
> former head page.
> 
> It then moves them to the folio which now holds the fault page, by
> taking a reference on and locking that folio, then unlocking and putting
> the former head.
> 
> split_folio() has unlocked the new folio and has dropped its own
> reference on it, so until folio_get() nothing but the page table entry
> holds it.
> 
> Only the mmap lock is held for read, which does not prevent another thread
> from zapping the entry with MADV_DONTNEED.
> 
> If this happens the folio is freed which results in folio_get() taking a
> reference on a free device page, which the driver can hand out again at any
> time.
> 
> In addition, folio_lock() can sleep here with the lock of the head page
> held.
> 
> Utilise split_huge_page() which will leave the lock and reference at the
> fault page correctly.
> 
> Fixes: 022a12deda53 ("mm/migrate_device: handle partially mapped folios during collection")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ ljs: tweaked commit message ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

I was able to reproduce/observe the ownership gap trivially.

With some effort i was able to generate folio_get()'s zero-ref BUG()

Can't say I understand the change well enough to give an R-by, but
the patch does resolve the issue.

Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

