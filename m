Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312022;
	b=RFtL6oIBTCDJfJ1las9576qPKBHdWRYeFtNBOu20o3Hq87p10Xtpcy+0hoEPURg/UJpD
	 OEt01IXro9Jiej6NsMcgQ0FHpq307IDOmp8VQz95PS1/5Df0hzyWsobN7uQFC1Lv3i2L9
	 grAgh+2NftGzMTocxCIvmEUegN1zDRKRxCSHKln9MrGB5OPLXoBJj8DWJXZg5sxvEBLpJ
	 78YxXfKZoqqgOa6Kos+edV6S+dqB/zcK0Ivm1+/5wj11AYIyLVTadxDQ0R0BdXgNpDwRu
	 WKFPBiym96QWggXtI6WfImhUApOOdBJmQMgGBBWR/MCOqz6yS/Kwcb+WaJVOeg/KIFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312022;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=5X3zb3VH4w0Ie2RKn7QlDBjKtcvMvn58SYuQeOEmpyc=;
	b=TrEL0yU4MekLIM7Dq2c7Wg8smht1W6NqjNJbVpY19uDInPOpML2lFvCzr9SJ913hzTqE
	 lFMl2A7Miy6vogFNOFmn6VuGA68Nn9S/lyfdxYxyb01jI+nJVV2WQP/wFhoFJJ6Du5ppN
	 lI0gmEyHPTUZqPoh8ZKNMdHGpOZaMmItrdDkHss7A4j+8gf1I2KI7hsxfq+Sbah4z1XoZ
	 VEzhXzMvS9EPdbqrFs9TBzJcv6Mp1vc51ouqpv57Uc/gYGieXWTOFA0gK8USfJyHGxXAs
	 QxzpZN5AnXVcPBEJ6rMM8hyFbCyx0baiW8HyUYcks3Oko439YuHOf5RDR6uRV/sEbrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RygyfnWn;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEB4606A32A
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 12:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BEB4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RygyfnWn
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4b7252a32c8so20451045e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 04:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794312020; x=1794916820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5X3zb3VH4w0Ie2RKn7QlDBjKtcvMvn58SYuQeOEmpyc=;
        b=RygyfnWnL4Yk98O5t8EfRhHJ09wgqoKDc50vcLztTT6VXIdGWIzxp8gp/oS32JisXO
         kLYRYeznXrsblttCwXF35i/TiPDW3jopVuEIWql4OVWvjiutcXKU/UhCKEYZ4UR66O+e
         kULSXyMPCUX82fsckuZ3E8/kna98lIel4VII+ANkE31SFugl57e0klPU61lHfgCvDtTP
         MtFuBcaDmc0Sm6fZGoIl3GD+SdzoAAyrnDFRUROyQH/KkkH9EDfZSB4dt1fPJiCh/NsV
         ut2IqQIh8tubjGervp8DrB5/N+bX1ezKOwAYOMPw+my8dmAF1D4nC3K5R5n4n3eGr4qG
         fgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794312020; x=1794916820;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5X3zb3VH4w0Ie2RKn7QlDBjKtcvMvn58SYuQeOEmpyc=;
        b=qw34EfhsGz3XD3tvMqqGenhBsQON5SjU9ECZBwj1DxD431JZu68xbSccr6x2m+HKqp
         9JYluyvEsw9tVqOBvLuz7d3PI6kE3EnW/etwCIaMBb1s03lWsAKMS8WLhUNc5cjauOHi
         NYUKcv2HqvJLx9CuCLNW0XgwMV9fwG8p2yhy0U0hApEHXKvfeIXEUSA2zOFzH4uVztVi
         5URo/liYr5bK43gIRV8kfUful+TpFfFSuA9fwDJ1cQQzHsxw3Eqrtvzut3xJJ5mmTH/Y
         jnwugLE0crw88OHZP+OOOamluuNADtLbM9tFNZ150TEgFOsVs0z0cYj67v58LMa8BzXv
         jd7w==
X-Forwarded-Encrypted: i=1; AL+hErGENnnCIlJ64k8qfhyQHeo8/HoOBM0JUN8SkdRdW9GzJog4UmGSCOu9ttoR6XyvcfHB1a3OYsukzJYQh13B@vger.kernel.org
X-Gm-Message-State: APuU4Z+RzIbk4PKb2ZIyhhOvT+VaDmmSCeaxQiXoMdmFwUeUfgmMLRav
	hgkm4gsyQJRvikQ902wshLlYczmeYrfBrV17rXRaLwt6HUyCz5fR0gVk
X-Gm-Gg: AYBFou3dmCVWo1Tcn6Fg6b/M8sUUnKnwOubJ0oie0Sg3Ielk6DF6660XrQW9cr6b283
	8+wKSZa2Kvny37DuPGY1XggHb1aG0tXdyzJx7PkVTxSqicZOs0I32/mZft/S3eMPh052gVu6Xh1
	LCwbAIPYnBRPoRzOqjVVFHMfdPPjffeuanAKNAOhfkD+DSuuJNtnaoNX55K3e1abSbco9Uf8hMc
	609Ur+s4aVopbo4/8msOoDiBkk7IkC1TKfJlA5kAiFaEEtlFjgNK6FQQIpXCfcdmLxWBr26v9pu
	sHkGi2VPiaONBg0UzFjAjiDbk/E47QqP6EaTV4slmkBVYtsYhr36KgIMzFFFQNPzQGaOeJOTnnK
	BhPnu53lbAkeQXo+GNwUITzHBfCs2Cn59NTClW9BE8aPsHX6e6FuFNnRSoiYz2PVd4clGd3WrvK
	3nQ0+B1zGD/rGGY55fmaikJYwNPXYhIxkAUszh7MbtjaIeLXK9aBSAYA83heq/0p9nK3xi6jop5
	I39l7zHx1kYhVTZI6xlcjTfxib/+w51Tl/p7rDxVlv1PMFngUzdCWXs5KbBFSPFFv4lbJH3S+Rw
	KR9e+j1jlWrvHLUQtRPnzoeJ
X-Received: by 2002:a05:600c:3e07:b0:4a1:e69d:90e8 with SMTP id 5b1f17b1804b1-4ba0234a8f3mr43245435e9.22.1794312020086;
        Tue, 10 Nov 2026 04:00:20 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fea9eesm97526925e9.11.2026.11.10.04.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 04:00:19 -0800 (PST)
Message-ID: <d4bb71af-cd1f-4d42-b724-916064f4cf0f@gmail.com>
Date: Tue, 10 Nov 2026 13:00:16 +0100
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
 <jhubbard@nvidia.com>, Josef Bacik <josef@toxicpanda.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev,
 linux-arch@vger.kernel.org, iommu@lists.linux.dev, stable@vger.kernel.org
References: <20261107-refcount_overflow_stable-v2-0-c38f6809b106@kernel.org>
 <20261107-refcount_overflow_stable-v2-2-c38f6809b106@kernel.org>
 <c8dd3102-38f8-4972-ad2d-97545fd8c8d4@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <c8dd3102-38f8-4972-ad2d-97545fd8c8d4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/26 11:38 AM, David Hildenbrand (Arm) wrote:
> On 11/7/26 23:23, David Hildenbrand (Arm) wrote:
>> Similar to mapping pagecache folios into page tables, let's reject
>> additional references when splicing folios into a pipe if the refcount
>> is at its limit, similar to how we handle it during GUP.
>>
>> This will prevent more cases of possible folio refcount overflows with
>> large pagecache folios.
>>
>> Let's keep it simple and check in the two callers of
>> splice_folio_into_pipe(). Return -EOVERFLOW if the limit prevents any
>> progress, so do_splice_read() can fall back to copy_splice_read() when
>> read_iter is available. This keeps sendfile() and other splice users
>> working when ordinary reads would still succeed.
>>
>> Also fall back to copying in FUSE when taking another reference through
>> fuse_ref_folio() would exceed the limit.
>>
>> Also check in try_get_page() to cover pipe-buffer duplication by tee()
>> and partial pipe-to-pipe splicing.
>>
>> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
>> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
>> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>> ---
>>  fs/fuse/dev.c      |  5 +++--
>>  fs/splice.c        |  8 +++++++-
>>  include/linux/mm.h |  9 ++++++---
>>  mm/filemap.c       | 11 ++++++++---
>>  mm/shmem.c         |  4 ++++
>>  5 files changed, 28 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index 3641abb90d6bb..4f6b7b42bfd3e 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -1265,9 +1265,10 @@ int fuse_copy_folio(struct fuse_copy_state *cs, struct folio **foliop,
>>  		if (cs->write && cs->pipebufs && folio) {
>>  			/*
>>  			 * Can't control lifetime of pipe buffers, so always
>> -			 * copy user pages.
>> +			 * copy user pages. Also copy folios at their refcount limit.
>>  			 */
>> -			if (cs->req->args->user_pages) {
>> +			if (cs->req->args->user_pages ||
>> +			    unlikely(folio_ref_count_over_limit(folio))) {
> 
> Linus points out off-list (thanks!), that fuse_ref_folio() should have
> really used try_get_page() right from the start.
> 
> And that we should just not fallback to a copy, in particular,
> if the refcount is invalid (<= 0).

now that is said out loud, makes sense.

> So the following is what I have for now. Once we remove the limit
> handling again, that code won't change, which is good.
> 
> I went back and forth with folio_get_checked() naming, but decided to
> not mix in the "try" as that just reminds of our speculative refcount
> handling. (folio_try_get_checked / folio_try_get_referenced)

agreed with that.

[snip]

> -			if (pipe_is_full(pipe))
> +			if (pipe_is_full(pipe) || *ppos < folio_next_pos(folio))
>  				goto out;

nice!

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
