Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795123074;
	b=q/cl/KMLLcg4YEjfXwBFeJiWbrm0yXrNB8nFgXuA+aioHBJOl22mU6XRx0G/4v5APIgP
	 PeOJdvpYOElblplHIadEgqPAZXDCo0IchGV5b8AJafJ8VKcJR9gZpVEJN4feDCWhrEw6T
	 H+C5r3odACACT5lESvfdw+o7IsAsxauplVoWPhBlWPUwf7tjF9mJW9V1L3L2FRdCgdozF
	 0Xbx9rLIm+EoPa8kJsDxQlwZc2uJVemdbpom0FGPyRuqvQxJPi4mzgEGHXnsGCOSNgXum
	 1wZU9S3Wn3921c1XL3oInFbqnpyl+qHgPAFxv71592GVgLuA473KwUgYsayl2qt8Hgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795123074;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Fse7p9SsspMc7R+vIhuooBKhCKsbu9xtP3buzFRAVxQ=;
	b=AkAWhQefJemtx5Beb0GA4634ObP0xLsKRcgrEgSJIl+IB9W7TkAGR21D9OS66EgzlSXc
	 PRJ2wuCi/SgrNfwP/Wjuo2YgacZFK++eOFhrRKUEeMjvtw3kxYp1yFI7xxf/POdmbZLdy
	 GYIs5jRNN7SA9+Xae2mUYRVp/y92ogcs8pC0wK2LLoIuRxca+Z+fB05pQUsFEWYVLUwPC
	 NVi2SFUzWJ7RdRlfcVH9+voT27Iti+uq4RH64+7jWVlt4Crydx6048LDQFIh73Wdyx9Ll
	 5quTDflF5SJoPr8XsR2UFTEStQP17zEuzlFSAa3wXiNUE8RIVpN0jUo52Mxwe/dLAEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OhcmJSW+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ADB606A324
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 21:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OhcmJSW+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00021F000C6;
	Thu, 19 Nov 2026 21:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795123073;
	bh=Fse7p9SsspMc7R+vIhuooBKhCKsbu9xtP3buzFRAVxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OhcmJSW+nehYY3c7/OCCcVRGjCMN25K8S9b1UYXtuiQ1qDL2wWHpMOazcNpCRIVvJ
	 OMe3AdIyhF/t+S7TqEJlqMy5EBxG4XkDZzSpQJaIMSZF5J/De+l36MC3N/HOiBXy7m
	 uYPxtEGS+QC3d2rgrJWPyTyHeqcL5/CKCfmmRSaDcgMHMNXs6xzFgkVuGJR+nfRBCX
	 9hKAwlxRq9T/SlhiSVyEDGrV6bFEpra4/K0q9JEVxbUd7zA4Szr3vm3LvM+upB49GU
	 3FqSjRho6zvKl2UwXK2+QwO+VtNu2o2wecFWhIT1oLoEd4kBUWwK6+e4Y7TTxLa929
	 0ETJmYNOmVmmA==
Date: Thu, 19 Nov 2026 22:17:47 +0100
From: Gao Xiang <xiang@kernel.org>
To: Wenjie Qi <qwjhust@gmail.com>
Cc: xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org, shengyong1@xiaomi.com,
	yangyongpeng@xiaomi.com, qiwenjie@xiaomi.com
Subject: Re: [PATCH] erofs: enable buffered RWF_DONTCACHE reads
Message-ID: <av9ne1tKVIBQgCI0@MacBookPro.fritz.box>
Mail-Followup-To: Wenjie Qi <qwjhust@gmail.com>, xiang@kernel.org,
	chao@kernel.org, linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org, shengyong1@xiaomi.com,
	yangyongpeng@xiaomi.com, qiwenjie@xiaomi.com
References: <b168501806b41e3f0be15efec4b54b371d8dd4e1.1795059802.git.qiwenjie@xiaomi.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b168501806b41e3f0be15efec4b54b371d8dd4e1.1795059802.git.qiwenjie@xiaomi.com>

On Thu, Nov 19, 2026 at 11:52:50AM +0800, Wenjie Qi wrote:
> From: Wenjie Qi <qiwenjie@xiaomi.com>
> 
> EROFS uses filemap_read() for buffered reads, including the inode-sharing
> path, which preserves request flags when cloning the kiocb.
> 
> Advertise FOP_DONTCACHE in both file operation tables so preadv2() callers
> can request that newly instantiated file-cache folios be dropped after
> consumption. This is useful for one-pass reads that need not retain data
> in the page cache.
> 
> For compressed reads, retain trailing readmore and propagate dropbehind
> to the single-folio neighbor lookup. Readahead expansion already marks
> new folios through readahead_control. Suppress prefix readmore so it
> cannot refill pages already consumed and evicted. Ordinary readmore is
> unchanged.
> 
> Tested sequential reads of 1-GiB files with 1-MiB requests on NVMe-backed
> LZ4 and Zstd EROFS images in x86-64 QEMU/KVM with two vCPUs and 2 GiB RAM.
> Each reader ran with memory.max=255852544 (244 MiB) and
> memory.swap.max=0. Normal and dontcache ran in ten paired rounds per
> layout, alternating their order and using a fresh guest for each run.
> 
> Results are arithmetic means of ten runs. Memory values average the
> run-level time-weighted memory.current means. Percentage changes are
> relative to normal reads:
> 
>                     MiB/s                  Mean memory, MiB
>  Layout   normal/dontcache  change    normal/dontcache  change
>  LZ4      2513.57/6350.61  +152.65%      169.53/17.39   -89.74%
>  Zstd     2535.57/4066.49   +60.38%      179.01/18.17   -89.85%
> 
> In this test, dontcache reduced average cgroup memory by about 90%,
> left no consumed file pages resident and recorded no memcg reclaim
> scans or steals. Both layouts were faster in all ten pairs. This
> offers a smaller cache footprint for one-pass reads on memory-constrained
> systems.
> 
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
> Reviewed-by: Yongpeng Yang <yangyongpeng@xiaomi.com>

Yeah, that was in my own plan too but I never find a slot, thank you.

It would be useful for one-time load on large files like AI models
and these numbers are impressive:

Reviewed-by: Gao Xiang <xiang@kernel.org>

Thanks,
Gao Xiang
