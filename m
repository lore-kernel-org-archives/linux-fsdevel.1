Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983405;
	b=yB5usYDMZgPlpLMmmnd+EqOAHLS2YqD+62xfP7DA/NuKZtLNSf+5McaQozBuZtAYZVJf
	 c6qcCXuB6LN7dmcf3HwYcdSwXA/GWL5yrablGKaKku/0iZIb3xLv2kyG2wUQYefnh8b82
	 dmNRDm6ddFhzv6YOm7vXAoLEMWsiJx5cuHb+KjDL91yU8FCZHq8H5rkH969YtAmXHPkx1
	 cqJytoc2Ik9JkYyq/rzXy18E0k03ynAe2d6MjKUZOQUvJwdsKaxM2aNngEH/S47v3amqa
	 IlqnNHUd6VvENNR89QrSZn9X0Kw3mRSKrUOvC2KoY3ZCoumroz1Z/K2h7xbGeazlB2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983405;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=AKgfRWqpa4rK9V349FW23FUgQBz7Hu0ElZJb17dx9DY=;
	b=PIcYfYuXqupgH57eiknFUjXGyMdxFtb5plkklKVuaNBvvTRT2p5yWrLVgQs2A1l8i/wI
	 DwRprvLPWkR+gVTibBr63n00GE90YxlzgdDLGnXyuNQso6FcgKqDvdSOxR1PTeR1xw7Vx
	 Yr3De0tgMq52xoBklOXiPIHdZGRLL7Y9U9s+8iDXVguBoEg895MMULylCzcOOlIet6MuZ
	 32AhAdt8ZNv6xyMPZOUpjXF6OWEcB74Hp9wnZggP1ivyxlH3zpDeZXT1lxQDFs6jyG259
	 QdVxjick8CQnf++tK1YeV0IkydJGWb9L5gqgCxxKgnJkXhKtJuTAn/0KG6i/YuW+JCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=mQfKAn9f;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987FB606A329;
	Fri,  6 Nov 2026 16:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 987FB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=mQfKAn9f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AKgfRWqpa4rK9V349FW23FUgQBz7Hu0ElZJb17dx9DY=; b=mQfKAn9f4rTREvupKtVQkzEJZY
	rIcsvKh75/OlxsOlXmhFfFqNod98WDPB3l6iksRxJ7/BGYB7ehTx8FesG6JRUzV5QPC/EBWVunKHU
	ErvyUVfmfpb4mKzZtU6jvZYUwahAJ15ynaoxy7/+Dz0YcuKiXLuX12z924UC7RbUy8gwWtMkoAqwV
	dyVplN5mMwcUg+V+694Jslnmz5dPzKMV/YXsRKv1H74TfStMvOAfYCYqnEnJ5A6XZm/KpQbDTxMNW
	gc7xki4F9IyQAzqhdbOi3Fpbb33SbgbtDgDe4Z1XiYnzO9i512P6xsxVj18+GSGs4FARS3TDZktdB
	YmrvmEMw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xPN1y-009QCp-0g;
	Fri, 06 Nov 2026 16:43:10 +0000
Date: Fri, 6 Nov 2026 08:43:05 -0800
From: Breno Leitao <leitao@debian.org>
To: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	syzbot+63336d70e1af377d7388@syzkaller.appspotmail.com, Ran Hongyun <ranhongyun1@huawei.com>
Subject: Re: [PATCH v3] configfs: fix slab-UAF Write in config_item_put
Message-ID: <au4DDpKhquR7oXwZ@gmail.com>
References: <20261105165055.362-1-drifabdelmalekmohamedsaid@gmail.com>
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
In-Reply-To: <20261105165055.362-1-drifabdelmalekmohamedsaid@gmail.com>
X-Debian-User: leitao

On Thu, Nov 05, 2026 at 05:50:54PM +0100, Drif Abdelmalek Mohamed Said wrote:
> ---
> v3:
>   - Removed redundant null assignment to parent_item

It wasn't redundant, see below.

>  
> +	if (IS_DEADDIR(dir)) {
> +		ret = -ENOENT;
> +		goto out_put_target;
> +	}

I am seeing the following when running this version:

	refcount_t: addition on 0; use-after-free.
	WARNING: lib/refcount.c:34 at refcount_warn_saturate+0x76/0xd0, CPU#1: ln/172
	Call Trace:

Can you help me to understand how this was tested?

Thanks,
--breno

