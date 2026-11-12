Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794483841;
	b=Tp5sSFyLl4SqNmrxAsfhiAqJNHut00JMF6tPTGvpU1rgWZM5mFo8IFDiC+TzBC8LGkG3
	 gTy/spY7AfbPAgNIL6LyYxylMmabDGYpZqrpqI+ZrAiDaiHH+Cz7dRBhzkvtQG0PmjbMb
	 SQnUVWULGm/njehXpb1Oyk8a8eR1rU1URF41LpNMso2YwE7BB5yI+PLOwefqKUcW3IP39
	 B4NmcJATJDTbEhiu2RA0loN5W1eEXYUFN93ehmMfWbhaT+z079NbvuruvHZcWcc4EiZAI
	 GKd1tQyom/ylzxI70hgeeQTHXPRWx0grL0Sy1obdfvhDnzPwFd1Nm/Cmjp6ey/0dSVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ha0beh8JKKzYfv/K+pKtKWX8urpG8eLvtCtoo4UumEo=;
	b=XzQ+dU1ezxKacemvBqA/YVjS7xsoveILprqb91HRX1bmOlu5T8gCwkaEFsMUG6iY9cMY
	 Fp+SKK9UICJY+u/8NEaKM5XyzA/P/ubZ3s6A5lkDysZWJzQSS+851n1Uap+DHE1ZNBvAP
	 VacXmNsJOzsXdXAUacNrxFWS0BG9vLCtKz3C36fnaxmDb0bRpDx4dRwf3zR0f31T+8AAX
	 kYSyRc5BNWETScbwBKOzI88YCDlfmYt9hOL6hl7vc+O/RcxRz6hORtXLgLeV9KkmDHs75
	 iZLE/o9UlMh3+a9HtfndmZUXPjGwgOzTqV6gudN+o1LGCyhW8H2KD6IbbV7px3u2F5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b="b/lbyuG6";
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C382F606A323
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 11:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C382F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=b/lbyuG6
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-497614c95f0so2334206f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 03:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794483839; x=1795088639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ha0beh8JKKzYfv/K+pKtKWX8urpG8eLvtCtoo4UumEo=;
        b=b/lbyuG6lR+6vKAU+X1Ta8UHOzjGKSfwK+61U1EPR2UmaqNEpCra4VPtvBGw/3qwaz
         W0xvX2ujFqLmT0memFTDbiydrLTLob65N/sUVxDajbYqsVL73jK9dTzbeRaCe01ty9uv
         foTMLLf06igqgikYzzNqO/5uBg3mY7ARJTuNk7QKkVNN4tSHBaymHpolRLKqh8rmRbFN
         AdmEN5ZpPgSf5G3ryL38KP5znR3lc4YQ8YNFp7w6VTp1Jp7DGYT3N2iPOkCUvlp4S+cX
         UFim998d1Anx6AFYoH4RG9LRq3IVXvMmK1qNX0YDJn8MUar9ScOLvoH6DEPDzPx4Bf/Y
         +Mdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794483839; x=1795088639;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ha0beh8JKKzYfv/K+pKtKWX8urpG8eLvtCtoo4UumEo=;
        b=zkrotyxbgRd29Ij8xrbcAYSmmAAdoni2QDJQv7QmG0TLn+7IK/I7+HkVws7KzkX8B6
         3ipwh7lZwD4iu9ZkbLCO3LrkoIB0MsRR44QZBDKNBfbip0hiAsS0t8UTdDTcJNiU84oG
         DOiMQrojvTfBa8O+05WrO7KmqOdqAmHcdnLWGVw6aL4/1SzkHuuRLkjRHYrXxrtT94na
         +W9X529GOwax+/8iyxTW3FJuLKjFSz2HDdoozKntYG0dD/R+edPACzREsPORV4DKz7cU
         ojq5bKbzd0IcLAvUVvV3RI2xfk+nKnCt9mGg7yUg9Ue4nGJdLomKWnIm+eLI6yMBdLaf
         OHyQ==
X-Forwarded-Encrypted: i=1; AL+hErG+XvtKkdwa08N9MAj0A3y2T+5HNzI5adLT8/49ggxx43D2MbPYg6Q+rI5OiVS5sogsryn59ECJ2a27S1L6@vger.kernel.org
X-Gm-Message-State: APuU4Z/J/fy58V+4sTnPTvLoghDjJUNKpD0Oy9GmStH4HFA7rKptGIy2
	ZPOPccNcdCDZoO9AEbF65q+lhB0+Fwy092H/yF/0BxE+zRC3qAB+p7gedJlsRnsb56E=
X-Gm-Gg: AYBFou0o3f38YC5sO2qNkjoH1R2xjN3FtLcCiE78dnVQdvYwbGZNuial0gj/UeBV4p3
	ZzOeWohw91jHOy3JvktRuSSGTKHRNeeFCc5k3MWxDHvsOAXE/wUQhk0C2wvTE7mZpRGUINen0Aa
	5mZ7ScV/m6wOwd+BzSJ46AhYkeXGizUGsrMPmz3m25EDv6Jr2q4QkuIPVsNhdxnz0y2bRHvO3xN
	TpqgYhd5YlKZ0aTsNV0KdQDw+GYjdXN3rLQwczH/lcUiavTc+3zC4MkGwdGNntz0bdHkXsC3oUW
	5uZ0Tf+qoTb/nND/Ak4CFVtxW1FF0hAwHODh4reK1mBftWrsYk7rEucWWG0Z5GDUxgfXv+gwo9/
	d5NIJT+f7oZRtMYw0jn0uza9LjJ2xIej/c0c2Xsbz56jaamSpW4kYDbxe7Fztu1fq0nr44UyvLQ
	A3dyiwrkNfFMu4CllLUnAGLu7gIqzENMMR5sLfACAgGHZ1EBZovPJjrIrAU28PredpbHVHqaA/7
	tx1Jc9lpxTnbw+H7kQ3Paklq+d4lT/a7VCXEh7s0cDD1q/cStADhCetqA86b36TJOOtu2Ou5vhq
	QO/iv0VG1TOIF3zJ+++WcmGT0qmMmYkJ6GIrB/pCocYaP9o8cMo3VQOMq9f58OW2
X-Received: by 2002:a05:6000:4a1e:b0:48e:7470:9eb9 with SMTP id ffacd0b85a97d-499c89861b0mr10174390f8f.43.1794483839022;
        Thu, 12 Nov 2026 03:43:59 -0800 (PST)
Received: from localhost (109-81-94-245.rct.o2.cz. [109.81.94.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498366c4e07sm15559590f8f.49.2026.11.12.03.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 03:43:58 -0800 (PST)
Date: Thu, 12 Nov 2026 12:43:57 +0100
From: Michal Hocko <mhocko@suse.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Usama Arif <usama.arif@linux.dev>, Kairui Song <kasong@tencent.com>,
	Balbir Singh <balbirs@nvidia.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Yu-cheng Yu <yu-cheng.yu@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>,
	Josef Bacik <jbacik@fb.com>, Chris Mason <mason@kernel.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Mark Brown <broonie@kernel.org>,
	"Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 01/13] mm/mmap: free gathered pages before MMF_OOM_SKIP
Message-ID: <avWmfXu39vtp0DM9@tiehlicka>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-1-3d2454362e8d@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-1-3d2454362e8d@kernel.org>

On Wed 11-11-26 18:13:15, Lorenzo Stoakes (ARM) wrote:
> The OOM killer can quickly trigger again after having selected a
> victim. That victim might not have freed its memory yet, but its mm will
> be marked MMF_OOM_SKIP by this point, so the OOM killer will ignore it.
>
> This can cause the OOM killer to kill an innocent process when the first
> might have freed enough memory to relieve the memory pressure.
> 
> Fix the issue by freeing the memory before marking the mm MMF_OOM_SKIP.
> 
> Note that the task which calls mmput() might not be the victim - if it
> took a reference on the mm (e.g. ptrace), it may hold the last reference
> and release it when it calls mmput().

I do not follow the reasoning here. MMF_OOM_SKIP is called after the
address space has been unmapped either by the last mmput or the
oom_reaper (or both when they are racing). Now all your patch does is to
call tlb_flush_mmu which I suspect is to release batched pages. But why
is that needed only for the oom victim and why there was no final flush
in unmap_vmas?

> diff --git a/mm/mmap.c b/mm/mmap.c
> index 7618e72766a5..4cb18b217048 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1313,11 +1313,18 @@ void exit_mmap(struct mm_struct *mm)
>  	/* update_hiwater_rss(mm) here? but nobody should be looking */
>  	/* Use ULONG_MAX here to ensure all VMAs in the mm are unmapped */
>  	unmap_vmas(&tlb, &unmap);
> +
> +	/*
> +	 * Free the memory before marking MMF_OOM_SKIP so a re-triggered OOM
> +	 * killer will only skip this mm if it's already freed all it can.
> +	 */
> +	if (mm_is_oom_victim(mm))
> +		tlb_flush_mmu(&tlb);
>  	mmap_read_unlock(mm);
>  
>  	/*
>  	 * Set MMF_OOM_SKIP to hide this task from the oom killer/reaper
> -	 * because the memory has been already freed.
> +	 * because the memory has been already unmapped.
>  	 */
>  	mm_flags_set(MMF_OOM_SKIP, mm);
>  	mmap_write_lock(mm);

-- 
Michal Hocko
SUSE Labs
