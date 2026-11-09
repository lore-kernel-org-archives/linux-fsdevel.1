Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214669;
	b=Py0kP1L2EclErgcPc/keQvwK39nDl3OWMBf91a6ovBOdupPvB5YsCODFoeZl8LzXJrDp
	 Ep6xldjK41koXm4Biv+Y7t1PbN2d7Ug8UD2ht/KxFIY9azxLVCroSkrfZPJL5iQv6JEFa
	 pOVcVJ2p6asv+3LAsVmC82Rz8FVQ/rlVV8gCdpCG849bvmnVTSnm2Ed8zhSMFUC0nPw8x
	 N2Z4z2WpF6ljzQx+ruxUpCYMggDW0bGC8uPGri8opygdmGPpnroR1p6qegXItYmbiLWLd
	 TFpb7ND8ZUozKN7zbN71TrqPdRN3PZNGzhbV0Z4Dm087gYPJYBBV2C00XyzIMBJZq6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214669;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=6gPNbhKnS4UiPYe9GkhcEdm+Vle3xI8UXMcC7kdMJ/8=;
	b=F1kVAbYSzFLcHX8rMYR7mAYUkt5NiOzT5crbINITZCw5vT13ofHwEY30SrYq0QdtteVK
	 Mxfp/vg+6LyGY2VfPHxOQaGd/ZBRK/zvmjQh2Gpj3vIVkFvEm8QJUZ7LIejMujRpfQnds
	 drs4g74UljW539g1vEGQu5iQcc5kwP/A44J3SyEmSeCHPyxMYfCiE77VCIzcGydA34SXT
	 dE16TKmOm/WAvJLQrksEoGV6VW+nCU2jaAttdczgtYk1qScb1v4jITgKY3BZFnNsvwcQj
	 ovODzSCTbj5zPaIoaQNZjoe/lI/dikqvDl5M87SSGYJd+xk/U7lQRFldodyE3Ehef7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WX99d5g8;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896DB606A325
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 08:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 896DB606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WX99d5g8
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so9121115e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2026 00:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794214667; x=1794819467; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6gPNbhKnS4UiPYe9GkhcEdm+Vle3xI8UXMcC7kdMJ/8=;
        b=WX99d5g8HsNJ2Xc3dJWqBEteZ1Yzefr2XigtdxHvKUPJpgca1CoZqq4dp9NTaNP6YU
         bfxXvVbrXNq1MdQzDcVoMJst5p/JdASrGhqAQ35GgrQgGpWZpMZlArfgaA1khdBAvC3f
         UCgBrQaf6/SWaIrIz1cfg3VI8DlRIOxG1IFQ8rIXoFZQPGYzqcNzDEqWjIR9CgfeTAw8
         NE+Bm718A9eCD1tFyyGwavlgkgZz4MK9/UkYHD7WODjq9NCi/wfmLAsHbxT2jEtokNMQ
         8Q5NxTbvsYh5rJzdZ+Fl9IzESFScMGEZ1Re6QX6Qo6SLBiZakqLIE2CVv/0RDj39F8Jv
         /HqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794214667; x=1794819467;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6gPNbhKnS4UiPYe9GkhcEdm+Vle3xI8UXMcC7kdMJ/8=;
        b=F0loHm5MMH+igWm+WEErJoJooN+xwLk7HL97Eg/g54B9iMrvc2Gg2kWjntsgH364u3
         NZlAWYR639vPbJjk/Iy8VMnz35BaT9SR0RoEJU5YPb0wFR8RA8ZiSPgE6OB94HQTecnq
         TlmwgMX9pZHjERPKoOyJGfVFjaOwJPVLIp7zTgeW7DXXRX0LPAkfneqejg00xhVgSdIA
         4g0ISGMVumTQ88mmK+E1C3sJuQPAvIvlyCzx9WNUfUlFT2ix0Lipkx60xUI3XVa8dURp
         bPmLZ5pHHKf0u+/NsF9QzQGyoTYzgURScPKY7E4JscBrFJT2wE7Ezr7RC/X/brwFPoO5
         F0Ag==
X-Forwarded-Encrypted: i=1; AL+hErFnjZqowqUcCGh4yhW7TTIvKrFlg8mRg14fVRlYl3J97xyBZPwdgE0dx61x9ge7vIJIExA+J6B6m4vgPa83@vger.kernel.org
X-Gm-Message-State: APuU4Z85hryscAgg0Mw2dGxw4ZP5GSC7/vehCX7it1JReOpyT9niEIUH
	ND8XFO8LIbk79TJ//srUm4DNVAgmZGCGxRfOBJrTHf6pEvKVeNHRzw+O
X-Gm-Gg: AYBFou23YgjezB+4sd5bNJr2KiBPQam5i9y3nSW2j6mhAvaQrbWlLEV2x5Y8/2bxtpM
	3o19KaEtNYds5ttvbAvr9OEBTOoeNfCfVqGAGEdxDk2PjuXvKS5BnlhRdE3pIE1aYcO/ADHu/PE
	h1kN6bm5IQRx9m6v3Zf6y7H/l+1Igl4nSHLPxnyh2kwxlzPbK53lAXMN06RVh+J5lX4KhU9X0nC
	9P2O9m7nJsZArGLKVYI0tqZAhOcFFvv7Is/eXuv6tDgbNZN2KkcCzXV2inTFMeYVsOmV8sHXPl+
	wn7jEBkR8wgABQTfPgXU5bCk6ERlslhxCbDuigpQvX8vF5lPaTl+Kq3Ev7OJb2F5D77HUr2cs1F
	HkoOBYlEnRfFuixhncfEFqgEEBaJqchgIXrspq/Alzn2ara+fLlL4MVXCtvh5ZzXwJMfZWptDMr
	acaY2TX1VCTpJRmsqSXt9GFlpL7cDeGBkYUczE3DI+w5y80VN+XDZVSHXfj1wnFVKs/qRIh79q2
	4OWIeWpvizPJNItbw58Xtnb2z1zMU5VN17ILxEXVUOWBSGLIbRlaky7XnMbaAxbDyrJLjSPYBw/
	tTvTMoTZVD7lrVphG4CUvPA=
X-Received: by 2002:a05:600c:4f86:b0:4a1:fa21:fd90 with SMTP id 5b1f17b1804b1-4b960d9b17dmr61969495e9.9.1794214666809;
        Mon, 09 Nov 2026 00:57:46 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b79501502asm149200295e9.2.2026.11.09.00.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 00:57:46 -0800 (PST)
Message-ID: <a9fb2d3c-d518-49d3-9479-a25fa2cfc5b3@gmail.com>
Date: Mon, 9 Nov 2026 09:57:43 +0100
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
Subject: Re: [PATCH v2 2/5] mm: limit pagecache folio refcount when splicing
 into pipes
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Song Liu <songliubraving@fb.com>, Rik van Riel <riel@surriel.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Steve Sistare <steven.sistare@oracle.com>, John Hubbard
 <jhubbard@nvidia.com>, Josef Bacik <josef@toxicpanda.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev,
 linux-arch@vger.kernel.org, iommu@lists.linux.dev, stable@vger.kernel.org
References: <20261107-refcount_overflow_stable-v2-0-c38f6809b106@kernel.org>
 <20261107-refcount_overflow_stable-v2-2-c38f6809b106@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261107-refcount_overflow_stable-v2-2-c38f6809b106@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/26 11:23 PM, David Hildenbrand (Arm) wrote:
> Similar to mapping pagecache folios into page tables, let's reject
> additional references when splicing folios into a pipe if the refcount
> is at its limit, similar to how we handle it during GUP.
> 
> This will prevent more cases of possible folio refcount overflows with
> large pagecache folios.
> 
> Let's keep it simple and check in the two callers of
> splice_folio_into_pipe(). Return -EOVERFLOW if the limit prevents any
> progress, so do_splice_read() can fall back to copy_splice_read() when
> read_iter is available. This keeps sendfile() and other splice users
> working when ordinary reads would still succeed.
> 
> Also fall back to copying in FUSE when taking another reference through
> fuse_ref_folio() would exceed the limit.
> 
> Also check in try_get_page() to cover pipe-buffer duplication by tee()
> and partial pipe-to-pipe splicing.
> 
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  fs/fuse/dev.c      |  5 +++--
>  fs/splice.c        |  8 +++++++-
>  include/linux/mm.h |  9 ++++++---
>  mm/filemap.c       | 11 ++++++++---
>  mm/shmem.c         |  4 ++++
>  5 files changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 3641abb90d6bb..4f6b7b42bfd3e 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1265,9 +1265,10 @@ int fuse_copy_folio(struct fuse_copy_state *cs, struct folio **foliop,
>  		if (cs->write && cs->pipebufs && folio) {
>  			/*
>  			 * Can't control lifetime of pipe buffers, so always
> -			 * copy user pages.
> +			 * copy user pages. Also copy folios at their refcount limit.
>  			 */
> -			if (cs->req->args->user_pages) {
> +			if (cs->req->args->user_pages ||
> +			    unlikely(folio_ref_count_over_limit(folio))) {
>  				err = fuse_copy_fill(cs);
>  				if (err)
>  					return err;
> diff --git a/fs/splice.c b/fs/splice.c
> index e6d43329ed3f0..df73a4e65118b 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -956,6 +956,7 @@ static ssize_t do_splice_read(struct file *in, loff_t *ppos,
>  			      unsigned int flags)
>  {
>  	unsigned int p_space;
> +	ssize_t ret;
>  
>  	if (unlikely(!(in->f_mode & FMODE_READ)))
>  		return -EBADF;
> @@ -977,7 +978,12 @@ static ssize_t do_splice_read(struct file *in, loff_t *ppos,
>  	 */
>  	if ((in->f_flags & O_DIRECT) || IS_DAX(in->f_mapping->host))
>  		return copy_splice_read(in, ppos, pipe, len, flags);
> -	return in->f_op->splice_read(in, ppos, pipe, len, flags);
> +	ret = in->f_op->splice_read(in, ppos, pipe, len, flags);
> +
> +	/* Fallback to copying when hitting folio refcount limits. */
> +	if (unlikely(ret == -EOVERFLOW) && in->f_op->read_iter)
> +		ret = copy_splice_read(in, ppos, pipe, len, flags);

here it can't tell where the -EOVERFLOW came from, if another file
returns -EOVERFLOW (i.e. tty_fops uses copy_splice_read, and
n_hdlc_tty_read() returns -EOVERFLOW after dropping the frame), it now
gets a second read. also, the first read already lost data. so the data
read returns different data, the dropped frame is never reported and
returns the next frame instead.


-- 
cheers,
jose a. p-a
