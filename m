Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508879;
	b=hi2WAjkwcGdz55huFu5rxR/j8TSvKOstlr7XQ1J5Ea9/iOsLmSV812C0U+znEEPkZyFM
	 f50yms9NGv0kEBPxIcIiS29M7bE4NKJXib9E8AoeqUswieTj8qZjrW62lxj95ut1PcB3U
	 5qPTfmLr5ATxa/8MnZvvycUCTHgcrCiRsrAmIk0WM8k8Vl5YlvLrqF++zDdSWjq9jgJbr
	 c84A7TvuMTUxGtFnlJgxlZJiUiTEsmgSRIsLoc0Ddtp+ZY+rL4y47i1P8WWCvb/tJj4BO
	 6t+0QUdv9o7/BghqmlIIrF9kw78vqw3H7G8rMdlBflcZ6SVmVOcNqh4f+a73spVu1Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508879;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=UiA1ssc1fM8eBuo2DnRY95RNeWhnyd0r69dfKPpEwvw=;
	b=BUKfDBxSsKRTqY07+9kYCCp9QX9mXPBgILbSZpbYrP6k0FEMJM4y1bRyw8bQ+wmDaAyc
	 ezoT+2D5z8QjB71vPdcgX63h3F2u6uGCqaiczdZlAJ8lVkNsCyDvjgpfprypgATpFq65N
	 ++laPaJ3mNneYJAyNKpONv3Kz2hXj+mvoSdls0GNhuuoMoWNVvjLgfgwRw9vnoz94fZnN
	 Kp2C6w4KpAQzychAFu7b/62jCtD59kb6QUxNWF21sc2IKwLuI7j9h8qkrfr0NTaS75kr/
	 eJE/P9QGbU5ebe4giQQnXeLrWmC6OVjQpISYcMxrhDvF3aXS8AP0/5MVgCN7i5iGdcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=kWdD8O8D;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8A3606A32E
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 18:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E8A3606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=kWdD8O8D
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93cc1ab5f6cso7536485a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 10:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794508878; x=1795113678; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UiA1ssc1fM8eBuo2DnRY95RNeWhnyd0r69dfKPpEwvw=;
        b=kWdD8O8Dg9JjRQF49RLM+2ucMyabFJdaYcTF6OjPoyCSEQ2RDViJMttopDyTewO1RJ
         Ytd0HE/vu/f8ayqUFYOKPyPHfWzXjy/qGNztZmNLXo78HZUbd3KMih/KClPN8/BDCWl2
         nvak9hgggY7vBZ/rbu3AuQo05ZZ1yxrfOA3IhpLavJy8vl8/lX+IKcmz/sGjlvoqajvH
         tO7IVVnJxCwFmin96jhUpcmSMBUdww4tcAFRgdc7LbGXxgk9OIHzFMdtugcvx9d/3fsD
         N6SACfLuC9Xdsxs8jieSzt4qfCZUo10AebNgTsiw6i1dPJe0W7YIufXdVnNLkqVaN5sv
         PQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794508878; x=1795113678;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UiA1ssc1fM8eBuo2DnRY95RNeWhnyd0r69dfKPpEwvw=;
        b=MxPRwWPeeXW9JigyW1VJUl7jxSR143ZVKJjodqPyG16YSaMM1ZRQ/6o+jxJ1/a0nQ3
         swjRevzMYny9KG3+8RWhQ/b+ZpjQc3IRPQeYyZDd2ASJgOOMsNWD4ao5yb9WWGl2gsL1
         QUk0YDtldqna+PQbtXp6GwR1Cx5NkrmYfXF0rVpRvGwyK53G3wBIQmFtxS81zp/O6bgu
         U1bqqbSb9GQzlTGyUkeixNw2Z7Uneg1t2shCSoJeNe1Wqt8m0148ARXgIW8xGjmq39JN
         NML8bH/ICLI0OxrU1LhQY2Y+uMOQxkjDNnSP/6G50SCJZbM+WWL7zoyJ8M9UNcSPnG2c
         Ab7w==
X-Forwarded-Encrypted: i=1; AL+hErHg7XrxMH++Ljr3NvlSwriv1yWIXdaRFRBN6hTmhQAV8L+pNnAudLxZGJNvHx0fo27cVP0tDr59OzqzTRB5@vger.kernel.org
X-Gm-Message-State: APuU4Z9fPuAUB4FvFn4E6/q9Zu5z4wi0xKNZ22EeNVTRYvOSLgvBCkSI
	n9qNsYa1VngMLhDmQdpcCUFWsi4neBImaPcm5AIpFqYANh9hJ9dOJYvA6Nd3CZ2Y/Pk=
X-Gm-Gg: AYBFou1PWrUeNugT8sD0PUi/CT/Ll6EmLdSaWoWxLuEZK8jPzSdB9P5dmK9wREneUA1
	bXKrp7r3CXn29sTsGiAY1SQGBfvQ4hLatfNVFuxQBAYVawqIJp1z0YBQsdz60bIRdkJ3hFTGjA/
	tUa+Z/cs6K++vXHRAbLDCiTI+R6t4KHEtTjIt3Sgo4TxkXRR0WyICseQd/+sAxyBhoV+NtHgQiS
	6pyuKkp+ZxTfJGQt5A7NUQme6MgNDECCriUxVli6lTFdHm3KQEUg7/lmENjztbJl0q4VwdtCvWO
	GNTSt73lELRpbcvSDBvvMY02RlNh864JcmNZAXLammTRkpTkgHR7/D7ciBdrNvfzwHDZOls2vZB
	G0QItN+GyqmLxzQC7kpXeZtVdEgmUZnc6SDQnhgXUr66YEsqxnp2WTSCLc0b1I5NJrIZ+L0MAUQ
	JbDOjFapIY27leNVH748DkzN5x2ryqL+FbfvKaPcLRmCgphXuvUYFh1oCdzmWwRQzPa1AEmOgeV
	OJKM4wWE2Jby5rjpmTyrcnS+d3k5h9Y+VgsCctjcDcfMpwD30U9vkMYAhdILt69e/SBaYwJId2I
	ov1UlOAZx4vcgW91yS9iIKv1bU048nG0yfzdzi/NuwNdmnz/41zp0GL7oh1NOElKC6/UXdJ2Xxg
	TGIu4oLs=
X-Received: by 2002:a05:620a:472b:b0:93e:f9ba:690f with SMTP id af79cd13be357-9494bc84c75mr45006885a.73.1794508878117;
        Thu, 12 Nov 2026 10:41:18 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c3600adsm4935085a.42.2026.11.12.10.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:41:17 -0800 (PST)
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
Subject: Re: [PATCH 13/13] percpu: queue the balance work on an unbound
 workqueue
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
 Rick Edgecombe <rick.p.edgecombe@intel.com>
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-13-3d2454362e8d@kernel.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-13-3d2454362e8d@kernel.org>
Date: Thu, 12 Nov 2026 13:41:15 -0500
Message-Id: <179450887590.482102.12180028123925629664.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-11 18:13 +0000, Lorenzo Stoakes (ARM) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> A burst of small atomic per-CPU allocations can fail with -ENOMEM while the
> machine has free memory and idle CPUs, as atomic per-CPU allocations are
> only served from pages that are already populated, and those can be used up
> before a worker gets to populate more.
> 
> Consider:
> 
>     caller on CPU 1                     kworker bound to CPU 1
>     ===============                     ======================
>     allocates 8 bytes, which leaves
>     one empty page and 4088 bytes
>       schedule_work()                   woken, waits for CPU 1
>     allocates 8 bytes, 1023 times
>     next allocation: "no space left"
>     gives up CPU 1                      populates pages
> 
> The allocator keeps a few empty populated pages in reserve, and the work
> item pcpu_balance_work refills them.
> 
> pcpu_alloc_noprof() queues the work item using schedule_work(), so only a
> worker bound to the CPU of the caller can run the work item.
> 
> The issue is that the caller keeps that CPU - a task keeps it for the rest
> of its time slice, and a softirq keeps it until the softirq ends.
> 
> In that time the caller can use up the reserve, resulting in an atomic
> per-CPU allocation failing.
> 
> Fix the issue by queueing the work item on an unbound workqueue so that
> another CPU can populate pages while the caller keeps allocating.
> 
> Fixes: 1a4d76076cda ("percpu: implement asynchronous chunk population")
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ ljs: tweaked commit message, comment ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reproduced with a cpu hammering atomic percpu allocations with preempt
disabled. Results are pretty cool.

In about 1 second of hammering allocations with the full 13 patch series:

                        Base       Patch
Successful Allocs      1,188      131,072 
Failed allocs          4,097         0
balance worker runs      0          169     
successful retries       0         4,096

Micro-bench obviously, but pretty stark difference.

Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

