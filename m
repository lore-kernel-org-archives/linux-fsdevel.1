Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794543932;
	b=nyHGROlQKpzw8/igPP0CkQZNEh1ByGbr+4YMYuMyPYBda2vSvym0g+Mjagn8DFbD4A36
	 qUGwb0NhQ2mGzj/224wz6OfpjbTKHTcNgzZdE4x27SCZyaFd07tF29I4xnQPensYpuqPK
	 SkdpJdjj2w7Oit7RJwtpnZVpbu42VfghGzZIKf1ufsD+qpHh5JvCYjq4CNVNfOh12HJDl
	 zBX7tvAyTOVFQ6W+I0ZMzcebbFDvtFmAKmG4l1YZlffd9IQ3rEZVJyU86Zr97L4yy87zC
	 Uo7m/e/Ivx4yvDPL3glHWRZLYqIHaBLSpIxmyn4i8SJkO0RdhEvLbs3NKbbbPpFNlyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794543932;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=IkIvwF8HYTYAvXNQ1Vf3vJhW/UWoUX7BTMENFsGTE9A=;
	b=aJuXzKKZAHCiwTcn+pvTSrtjqN5Y2UFeOc5T6AWqwVQ8jDqVdVpjrFUdZlw5qj0x4Irt
	 y4ELLJFAdtj4wOH9AvwGrAvEbYjm7cmlJ3F2CcSyzxF4aQoZqvYUalRdag8aK69nZYpVq
	 KukKIXIQbr4Mw73lCD7RAhoaAitHWhTaeuXFM5OPoKp6PasHKwmJhKKjuHTDZvMQSLeTu
	 7qxSJypcgCprD1Xf0FKuwzrknTfXWAHkv3Eg5qvtdDyZzBcjhL8vBHvbuf+of2CKO1PZv
	 963wnmhGyZkTZorDZqReZJs87ck4EMBM9+2kCL3NBNf6K/JYcnsktU7kwpue+dXz8pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=B1OG4Hxl;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2334606A31C
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 04:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2334606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=B1OG4Hxl
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91befbcad6dso11139156d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 20:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794543931; x=1795148731; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IkIvwF8HYTYAvXNQ1Vf3vJhW/UWoUX7BTMENFsGTE9A=;
        b=B1OG4Hxl38/BpIuzCGtNlDw2GD8mt487C5mv8lJQX4OTX2am2+Kkp3gfikdgAb9+Y/
         1ZKgPsiJivd+Mba4vOf3m0igPUUMTO9YSAf+1VyppPpn8UV7aBmsZIq3W4kAW8gz3K7/
         5Mr7o9YZnWVNQygQQz84uL2CrfsS90hiLVrtWRpFy2JFFR+NjpM+SJ+5EaWwydv8oM5b
         ZNFPctnZSkYg5hOeV7uqrbFp9XhRVKpyZRLM7m11rvzFi8eXGfOI/h+0ipyI0SyEFkvR
         LBqQAeJnZOg0CRLQx952LGQyQImcTolSqD9OoZTTcrVpdr55SSk2Y836a5aWfgqgM5KE
         wUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794543931; x=1795148731;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IkIvwF8HYTYAvXNQ1Vf3vJhW/UWoUX7BTMENFsGTE9A=;
        b=y9iiK+N/qcGobexRfgxnwUYNL8MubP6swBWmEOXrVOhOfc8ywpwg8YjpD/Lz6lF+bn
         zs8UqQoLhW4We73rqNC7M2B7U8xpDwrrCDJeylsvoGNTY9Ogj6Wh/GnvvXP65HnqTvfz
         Qb+blc/iiE3S+5kuZyfq5bkCtACTjnRoxukjZbdfloyP78/eCO1h1hH/zM7rHLl518FD
         B09hwfQOO5Yt/vdf1nXxVAcYjp7ddNWfBsCEHdt7UoXDrU7GA7oxQgDFLyz8phACBX6L
         hpi5qto+YLD3GtpOsCcqFbUKzGs8OIK7cm8ik9KHZA4qU+snb258GXQfVt/gBKZHeoUP
         VSJg==
X-Forwarded-Encrypted: i=1; AL+hErHyKiay9iygmoNt/xoDipuinVDTu1XETD5u1WGBLjm9he+R7vyRgazWufJ7w6V96lr4xbbKYbL3I4YTKtak@vger.kernel.org
X-Gm-Message-State: APuU4Z/x6azAGpxMrzpPBmlz6oRNP8lS5CZ4nFsjqUE0up5WYvPWBcng
	AHGPj8eW06emms6ftudkoodsftuE11/O5XTY6eNi9KIZKTa1V0PL4Of9mq7glz95RNA=
X-Gm-Gg: AYBFou02+7FU7up4vGK+urJJWC8jtW0TC1Fyy/rqzLudCZlKv7yuf2OHnds/RIjYBqa
	xDEoAg5X8kuSX2Xt9Vzcogn6w9Igyus/MgAZ3jsxVY1ayleySCTxMNyoeyb0ykzu/xEff4Hsieg
	Wd7/8cGBCvWFxOF8fGrrefgP/j/7or1kxuEMGpDxPRhUVuxEXdGfOlF3CaZF7YZRZsMpH9XxNx3
	SZmMlYwRu3oLPUZTKJIHzTRV7C/1fRkzMZXHdf8eR7rq2tz4QgiXWmtfIgXILcBoRW6nWvqTwtx
	WFDZ4odtV8KFzstq8CxUpTAMItGJskl2/DSiihdAJSDdvNBMbS1pWUNVNY0mYHmXKGwP/8R7whn
	U3r6P0g/VbqPonYFFcNFUv68zkbB5TBa4eHl/9Xm89eet7Z1vXHn56xoKI3Z20t87nlX72LReem
	ZJa6FjF/HslX/selPYSB++UtiqOPi1sRGboBXovdFCS2YJCB/5QWE6hQSEfa5BAWFSBFvefSbBv
	0Ph7n7OFZ6KDNcpbr47QPvBItHbL2tvd2mEP49B6kdYkA5I/0/4NG79MlyKdbHSblV2OchROrQd
	/HxiV6moaF9a+iQ/Nl6J43hM4OaCrt9icMA62SYBKofr2QAlIU0HbCiGtKQsDSniofAvEmJLCnn
	kffbBc8E=
X-Received: by 2002:a05:6214:2f03:b0:91c:aadc:5725 with SMTP id 6a1803df08f44-91f241e0e43mr23498046d6.34.1794543930772;
        Thu, 12 Nov 2026 20:25:30 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d458fdsm11668876d6.9.2026.11.12.20.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 20:25:30 -0800 (PST)
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
Subject: Re: [PATCH 02/12] userfaultfd: refuse UFFDIO_MOVE into a
 non-present huge destination PMD
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
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261111-uffd-state-fixes-v1-2-00713d368976@columbia.edu>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-2-00713d368976@columbia.edu>
Date: Thu, 12 Nov 2026 23:25:28 -0500
Message-Id: <179454392848.482102.8479698323718468757.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-11 12:55 -0500, Tal Zussman wrote:
> move_pages() refuses to move into a destination PMD that already maps a
> THP, but checks for that with pmd_trans_huge(), which is only true for a
> present THP. A device-private THP or a THP under migration is a
> non-present huge PMD leaf and is not refused.
> 
> The destination PMD is then treated as if it pointed to a PTE table. It
> is not empty, so pte_alloc() leaves it alone, and move_pages_ptes()
> fails to map a PTE table from it and returns -EAGAIN. move_pages()
> retries on -EAGAIN, with both VMA read locks held. If the source is a
> THP, it is split first for nothing.
> 
> For a THP under migration, the loop ends once the migration finishes.
> A device-private THP can remain in device memory indefinitely, so the
> caller of UFFDIO_MOVE hangs until it receives a fatal signal, and
> anything in the mm that needs to write-lock one of the VMAs blocks along
> with it. This requires a driver that migrates THPs to device memory.
> 
> To fix it, check the destination with pmd_is_huge(), which is true for
> any huge leaf, present or not. UFFDIO_MOVE now fails with -EEXIST in
> these cases, as it already does for a present THP.
> 
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

