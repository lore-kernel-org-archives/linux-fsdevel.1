Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792532922;
	b=HwjgYpLAEEh6yYTWP305hckqaxWMJ611QLA0Xt4rGY05yYNTAjj83ofawz7JudtK/f1i
	 GKfFk7ei2x5NBmWU0S10nyMGH1/eIbxZP7lgflgys3KiaXYkj1KD5GGj5pRQp2b0jyn5u
	 W1pNO+MDjAFSDT93WkL/8lBAgfa1FruCHKJuJAsGM+vEYx1OtvCSLBWCdgibDAasoBY4/
	 zsEF5f6skEt6J6XRdlq3sW0/4Uf4TM4zyrfDYO3Qz5qc7lmmQx3JDG1LExak6GSjJJtN+
	 x51DSd79qe5piJn4gyrEDodPQ8ZcBim1nQG2OTDLE4w7m1a9YzXG7HYzZ4Oi6OYgXDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792532922;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=lwH5lbGW7Jp7v2pgahH/8u5d5Q1US/ZAJYtMLpAtA4s=;
	b=1E3fkSVlJ/aHq0LlypY6dBdiWPBEJRBfz9vvGIqWSR2EJHJV0bTjL8lD+57PKQtZnSZc
	 qAFLpZM2oXrnbDWv3q6Um7JwYeZ/ofPzBUjtQhFusdly9gFA5tsisSDzAoMH0C3CfJMUF
	 J6laU98cEahIwq73klwpBjsLxOXc1pIYm76S1NBBRgS/Lq7VWzBzSRrur8QEidn63Fnnd
	 s8s8Vio5t4sCSE+LxebG+H6lecyR857Wodky8Gc/symIaFIe+66ogRuNx+V79C8c1qY99
	 AdVCpwNEpLg7G8qZWKErEq4pdSIGp7T1nFp0t0EsgfY3opp7wQPyAZ69kGP1pXxqpKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Vnm419Qa;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E07606A323
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 21:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7E07606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Vnm419Qa
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-917d595138fso958976d6.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 14:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792532920; x=1793137720; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lwH5lbGW7Jp7v2pgahH/8u5d5Q1US/ZAJYtMLpAtA4s=;
        b=Vnm419Qa/kjE27NqFknpFQG1AEpyq49ddgDDuGG4m4PuK8jB4BIucxesyWwSf4SEa0
         uSz2H8eWQ3QAQVj6mvZloHz1ezWLtzmCORiSuo4nvX/Y89/2PHrTr2TW0P6Tm5o1c13y
         kFggrh0Im+PIpGTSB7fqkFQNt8NQtpgWN8Og3tQl5MkWnwnj8MF/yt/hQt64q5Q4ESGC
         hfbLwpJB1hqraCnMet5mFnXiToBilJJr7Z42YzL3pjg2EM6cMOlxUZWGIUnaMwpSxLeW
         e0X1EurcmLyvexnjMFYKgO/omwKsQow1isD1OoopS7BI9x0SWOD2yG9zXJviPhqLpw95
         dF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792532920; x=1793137720;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lwH5lbGW7Jp7v2pgahH/8u5d5Q1US/ZAJYtMLpAtA4s=;
        b=FWz8lwM2rg4ibD/v2IpEl6lrVRio9zPxfOZ1HB+fzKa8di5lTMjzBgTfdkunwHAsFb
         hre4hgERan1ew28cye4hD+VvjdQ5I5Fj7+C5j5JlD26H4sOsWPjwKeM3gP5MvFK8IEJd
         3bBuMxtxnJxKmCXrtvv1C3/kI+mdk4ONWVTibjlQkMc1P3XU0YTShll1ZHjWHJ1P4WGb
         fekeeE4jTtTVf25uoocKa4nwcZfiuoaUA4I/aSphtQZFLMkNT11YcioW3Y5Y7IpfxYQk
         EWWYn4P1RQ4fIjh9j6+LnaHpiFI7WVns7SgzQUNQXPm8dGQBPHb1dmNCzJY4IPiciF3p
         HgiA==
X-Forwarded-Encrypted: i=1; AKwUvBzmTV3d97glqciqN1hqnhUAAZC6vecdki+4Uk8mbpYOXVc8rZrNvM+KqS8rrz69daBnSIfd4vb7RanSsHZH@vger.kernel.org
X-Gm-Message-State: AFq9FYLZEsRbxa9MGsMFUFJiusmQBZAog7EoHBU51x1+wVCAcRtDixsp
	DT1fPBBfGR8B0T1Ebsk9BK0/fDeF0E8IcE/W67yxvkWY1qRNWdwVwHeXDb2UxceTsqk=
X-Gm-Gg: AYBFou2Rh/twjRMCZPdyujXjYmcU9hcI+mvf6lARw6LYC7cCClJ0FnEdtETEyLQeTHg
	KTBquqtiJ6Gjgl/GoZ6+BtL9bMQjA9ou116SoAo3DvpDP48aQAig9DDS+03SVBeRCzzWbfl9T3f
	g2ujyakJKZB5mEPhqQSEXqtsaEYP2XEa/CfEsez/0K4NDWfxeJjZYwkcWkn+v1o7bGS4C2oQIGE
	xpKtUvEYzCSs0OM4qCHUFl8MXvJu9aIWf2rqkAn1ZucNc+oCOZiytRxk6KpQTEQ6jozTpZJMg5/
	Wv/7kHZ8bVUTX/KlBQqSvM7wCwNOTgjpedQMO4xDP3E0wE9eOHSZN0soTwzM28V2D7CQoVgI83d
	HP9wNNm5cLvIReSrGcN/lP+6w2o1uuF2L51okw3LPKXHJC4oOBhHTEro5J46hjYAyJZz0J75IOD
	EHri5JLh29IJs8xABnlkN9dlW5V8nnb15P8ZovPXsaKloyuGNv0WNfYu1FLxwQc8YBizIsaLhIe
	rHa2FbKm12gUGP0aJuwr4h3VEPnFDgyH/dxNZ2uwgePBQ==
X-Received: by 2002:a05:6214:3c86:b0:91b:5d3a:5105 with SMTP id 6a1803df08f44-91c12f580cemr1790346d6.51.1792532920531;
        Tue, 20 Oct 2026 14:48:40 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10bc99a7sm8625276d6.22.2026.10.20.14.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 14:48:37 -0700 (PDT)
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
Subject: Re: [PATCH v6 07/39] mm: assert mmap lock held, use new flags API
 in vm_insert_page[s]
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 Helge Deller <deller@gmx.de>, Sebastian Reichel <sre@kernel.org>, 
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Anup Patel <anup@brainfault.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Janosch Frank <frankja@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
 Youngjun Park <youngjun.park@lge.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Michal Hocko <mhocko@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
 Xu Xin <xu.xin@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-rdma@vger.kernel.org, selinux@vger.kernel.org, 
 linux-sound@vger.kernel.org, bpf@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
 fuse-devel@lists.linux.dev, Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Bert Karwatzki <spasswolf@web.de>
In-Reply-To: <20261013-b4-mmap-prepare-vma-flag-sanify-v6-7-1aa3c9b139f9@kernel.org>
References: <20261013-b4-mmap-prepare-vma-flag-sanify-v6-0-1aa3c9b139f9@kernel.org>
 <20261013-b4-mmap-prepare-vma-flag-sanify-v6-7-1aa3c9b139f9@kernel.org>
Date: Tue, 20 Oct 2026 17:48:32 -0400
Message-Id: <179253291264.1207257.80392040365771672.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-13 16:04 +0100, Lorenzo Stoakes (ARM) wrote:
> The existing logic asserts that an mmap write lock is held, bizarrely, by
> asserting that an mmap_read_trylock() fails (which is not the same thing).
> 
> Assert the mmap write lock here and switch to using the new VMA flags API
> while here.
> 
> Note that the vma_start_write() is explicitly broken out from
> vm_flags_set() here in order to use vma_set_flags() safely.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price (Meta) <gourry@gourry.net>
