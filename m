Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206505;
	b=2XFWns5Pio+PqJvqmLVmuYye9qrymHv7aLBnXHPDsBfii26vc7XPxYY4DV/fg8Q1TPBE
	 +hl+6pQ56x05B82/VYSSruGZZgZNgHqkz63CDaSDb0HVBQoZNpf4rW7GoaNRHqhlRHBee
	 27i1M7lp96cc4jxf6wPv+zgGSJCntgUo4rtX1WohyAoJ6l8zApHh3E6T3CIGCE6LrU5N6
	 ShM4WHbB14jKWTEx/WtNxl4q2jOI3sw4ugFBhB5om9JTVjJ12C12TkACDEYR9Mke+BTPR
	 D5ffhQPKlqE79K41eRIGbwhHVpu0PbueadHFDY9nnz89lox+2TlFMOBPVSj6hkrLZKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206505;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=PRHEIBcRVtOU9mxXH6oSTTLdGiFLeS2r2uPk2vm17iM=;
	b=YOwcOAUsORE0RkSNa920T/pkF/8uMInZAGD+C37LbRD2BAHn0AGBlsuIomRZXVtGrbMa
	 0aVx9TqHdXd/tN1p6KpUzTM8rsd7+Cca7mbJOVQAr52uF6TQ3u2K5O6pkK8FhapSfuyj+
	 k6M1WrskXw7tL22JTYxaWcv9YgxHB9T3rK4u/vApT4JVMBPrC7FbjiSn6tMJ6NE1b7qbc
	 +0CKISppduD9m8X84adLCodgcSSGC7FRWRjkH4HM4/F18HXpQZa1UF4cJpM6iBJZDSpFN
	 TA5bKjah2CM8GtP72NM/tINLaqObADnkNv+dzzhv/VRppJG3SMAK5uyzw//9AmyhAtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=YZTcsWCI;
	arc=none smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B311606A338
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B311606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=YZTcsWCI
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-988c7371716so420700241.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 09:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793206504; x=1793811304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PRHEIBcRVtOU9mxXH6oSTTLdGiFLeS2r2uPk2vm17iM=;
        b=YZTcsWCIUypnB5n4D/hsVZ4sYhEwp0OAWBZMIpgCIgC9VKYTguiLg2qUrAb1YtwQXm
         fBX2qjbMohrDsF8FpU3xT0wg+Z/De85xmZkcivTaFPK/xC2rSJQKjq22NWOhc1lGVidr
         hM8JGH+eSNGpRlvJh4EuWmmvnFfWam7TOV3FYkuqC4/2+sI4BlGechXv6xOQOVgypb6q
         zWTc1Wh0ex2ijemeCLiISE7AQnNSqdbH3U9hHcLHJdV8/WdwHyqp0xajG5zARiSHdoqr
         pOVMKySmKrvxR+H5Dzu0wqmwb1u32hxlg1K0CKnzvk4A8gUXWUD4WI0PaDrMBKpYlNaK
         M9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206504; x=1793811304;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PRHEIBcRVtOU9mxXH6oSTTLdGiFLeS2r2uPk2vm17iM=;
        b=FoKmmpPPpg7R8T3ky1YhpWtN3bSvcTlU+a8yh3OMxiLymBBAxFIXQtCQWWG++I78lf
         HMYGMFekwNrJ1q8+mKTiuvREY7uk9VH75BCzRAgTHoqkCiafnTkw6JfWowIot5V5CRC0
         74XLjSAJnbiCSYFRy6JSvOxK1/KTO/hFw8DNPuCQWOmJd4xETbTcZ4mFOxugRYmq5olU
         lS+b6iUz0zyRakxxny4qWK7YUdHBrTbPtLtWXgYoXHSgSfoNlbQRSjTBvYW5xjkr8GMm
         dTFQL4EsB8oe7Zslc1w1HzQUzBCSEXWSc8jOqQjdjo/Izj8eOAxkfdvWpGBLEXvqK28/
         dfgg==
X-Forwarded-Encrypted: i=1; AKwUvByloYHfsoepT14FBr8TztwbouW7//m6NzClKy86Tiwn0REn8SBd6f1BEg+DY1h/RrLPWNAAwu63gE/v4dLC@vger.kernel.org
X-Gm-Message-State: AFq9FYJT49MXCKCTEp+JmAn+vk6OZj01ue4TcejOSRx8T76JcWP1oQRv
	fAfCvGZumDowU6szMR0Ibqkfpv/7O/msYymrqTlNhIfWhuaHjzyDOR5pAhFvZUcf8Uc=
X-Gm-Gg: AYBFou17x4lGv/Q00zxaFn2JWGY8cacHuMR+GFh1QmyJaA5q1ajOaO4zsJ+vWa1zZZs
	s2vgi3tSAOk0Vt/oVdwwb0eLQ9qw3gRpkGkKfaUOlswxFYDJbtYanVf4fbTmM+TvWTXEbu18djb
	9KwykNK9Sb6ff7UzqR4T+aSXxZqrH+KMZSkbQp3lLcJP5Fruh5plHeeI/6b9V7K/Cjx04xzBui+
	2uit6gpa98OG8racClv9ig4+0G+4JE9f+DLCjeLKa+nFxXwA/1vptdt1AzNYlR6Sk22FdvDogwT
	pm0HxNtuMV2tEifKu/rxiPUnUXSs+AaInWYpocHNDd1SE70UQ2BqAvandzL+T0HeptrrrWclq1d
	DHjgCJl82qP6Nseq2BjSEaQO+SMe+wkB3jenfuEjnGLi2zAZOJqpNYH+dhol15pmhI3WWJlQSZx
	F5uound6NEGM9j3NieD91mqZc50lbkvQLTSzXi+4o3DfoEL26/WQ42Rw5vyNPiwOvKfdLiUi0jO
	u97mvyqfwxU/kJncSCkst8GXrey8wD4sRorjZZvTNCh6TZXpK+qn4QMJmZk7pL/fAKkwgCqJe46
	txPuyCRs41K3UskFQ0Q+BiQBQMjv9ka1m2v1ITJkcFsDDglqHpR7zmhahdk3zXrn1XCkPdtM9zG
	LnhgJWRNLb13MUoH4IgWVJxtHfup0qg==
X-Received: by 2002:a05:6102:a54:b0:7b1:6028:5475 with SMTP id ada2fe7eead31-7d03a505a71mr1235376137.12.1793206503993;
        Wed, 28 Oct 2026 09:55:03 -0700 (PDT)
Received: from google.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cea3d32a48sm6300543137.9.2026.10.28.09.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:55:03 -0700 (PDT)
Date: Wed, 28 Oct 2026 12:55:01 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Hugh Dickins <hughd@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 04/46] mm/memfd: make f_pos accesses atomic
Message-ID: <auIoupm228FQTNGi@google.com>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-4-6f74bec9a5bb@kernel.org>
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
In-Reply-To: <20261027-fixes_core-v1-4-6f74bec9a5bb@kernel.org>

On 10-27 00:17, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> Commit 9c225f2655e3 ("vfs: atomic f_pos accesses as per POSIX") made
> read(), write() and lseek() on a shared open file description of a regular
> file serialize on ->f_pos_lock.  The flag that asks for it,
> FMODE_ATOMIC_POS, is set in do_dentry_open().  A memfd is a regular file
> too, but its struct file comes from alloc_file_pseudo() and never passes
> through do_dentry_open(), so it does not get the flag:
> 
>   CPU0                                CPU1
>   write(memfd, "a", 1)                write(memfd, "b", 1)
>     pos = file->f_pos  (= 0)
>                                         pos = file->f_pos  (= 0)
>     vfs_write(..., &pos)
>                                         vfs_write(..., &pos)
>     file->f_pos = pos  (= 1)
>                                         file->f_pos = pos  (= 1)
> 
> One of the two bytes is overwritten.  Two threads writing 100000 bytes
> each, one at a time, to a memfd end up with a file that is far shorter than
> 200000 bytes, while the same program on a tmpfs file never loses a byte.
> 
> Set the flag when the memfd is created.  As for any other regular file the
> lock is only taken if the file is reachable in more than one way, and
> nothing a memfd does in read or write waits for another operation on the
> same file.  This cannot be done for all alloc_file_pseudo() files: anon
> inode files such as eventfd are S_IFREG as well, and a blocked read holding
> ->f_pos_lock would lock out the write that is supposed to wake it.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: 9183df25fe7b ("shm: add memfd_create() syscall")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: minor description tweaks ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

> ---
>  mm/memfd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 7d2da23157003..6f5fbce74f21e 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -484,6 +484,8 @@ struct file *memfd_alloc_file(const char *name, unsigned int flags)
>  	}
>  
>  	file->f_mode |= FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
> +	/* a regular file like any other: POSIX.1-2008/SUSv4 Section XSI 2.9.7 */
> +	file->f_mode |= FMODE_ATOMIC_POS;
>  	file->f_flags |= O_LARGEFILE;
>  
>  	if (flags & MFD_NOEXEC_SEAL) {
> 
> -- 
> 2.43.0
> 
