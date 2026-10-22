Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.233.56.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792682593;
	b=DhuPirn8SMatYoLOTaRm9tMX/zhdXqNJKINxXfTPDAPhnPUaAMd4W8vc69InD8wrOCqa
	 k/fLvTo+ouTa4dpuuACL8mzLhXFlUkMmmfNQN+CgXbUvvDvKhmfVGAbUIelzxKWJ2WFEr
	 H+66Y7FCHdE00IPisUc2SVlI3N5l2n0lcqG0mvV43yTKcJ26XK72XFux0eskxOTHceoCm
	 GYP7coC/Cqyvp5uzMgEtAwiY9avZHBfvXcNPWkKOmBEvHUuAcHScw7hsXaIyN9kV8+q92
	 G5yR7YArangR++wt957aIue8FcjwE5Xq+26sO8Uzf4FqGL+BlfE3Viupriz49y/OD/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682593;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Mime-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=8JJrTWP/HOx+BykEFiIrSQ5kTeX9d9iM//G5/Gjv3II=;
	b=W4ZoouB/alrAl89CzjfOlfo1dwTBa88pFRpobBSf5VDVh5Wufx+DlAQK94rik4MFp4R+
	 ZZTnjqEb1k8j/cfjq3NYXF5y7Nz2XIR6FvbTSD3u0yjeZHmJ2Y8wp026G6+0KBXbDnW9/
	 /MIxw6gFlnRol/ywzOiuS9Aq8w7iBTUHdYoCIMBPUIcvuqr/Rvnf8tu81KV7L0dDDlEtg
	 r95uQkKKsLcEQHswyzy5HbKmFWvjXGVqD6BsRSvOmLD4GHD3qGzerne2BavfZIFHJRs+n
	 X5QCsXRo7QZ7VkPI24ZhgyRdSHGi0Pr1fNM27A3PP3+epGS73VJRrYZguCDbMri2RIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=communityfibre.ca;
	spf=pass smtp.mailfrom=communityfibre.ca;
	arc=none smtp.remote-ip=205.233.56.17
Received: from kanga.kvack.org (kanga.kvack.org [205.233.56.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C2B606ACC1;
	Thu, 22 Oct 2026 15:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63C2B606ACC1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=communityfibre.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=communityfibre.ca
Received: by kanga.kvack.org (Postfix, from userid 63042)
	id 6C7176B096C; Thu, 22 Oct 2026 11:23:05 -0400 (EDT)
Date: Thu, 22 Oct 2026 11:23:05 -0400
From: Benjamin LaHaise <ben@communityfibre.ca>
To: Cheng Yongkang <teel4res@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] fs/aio: io_setup integer wrap can exhaust global aio quota
Message-ID: <20261022152305.GP8374@kvack.org>
References: <20261022091748.3653127-1-teel4res@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022091748.3653127-1-teel4res@gmail.com>
User-Agent: Mutt/1.4.2.2i

Good morning Cheng,

This is a case of user error.  Root can change all sorts of settings in
the system that will break things.  Raising aio-max-nr to an impossibly
high value is a stupid thing to do, so it's not surprising that some 
syscalls will result in error returns in corner when root exercises its 
powers to do something unreasonable.

There is no security issue as the embryonic ioctx is destroyed before it
can be used ioctx_add_table() never gets called, and it is destroyed
before ioctx_alloc() returns.  Yes, it Would Be Nice (tm) to avoid the
extra work incurred setting up an ioctx that immediately gets torn down,
but that isn't a bug, rather it is an inefficiency.

No further action is required.

Thank you for the wasted time this morning with your useless AI slop.

		-ben

On Thu, Oct 22, 2026 at 02:17:48AM -0700, Cheng Yongkang wrote:
> Hi all,
> 
> ioctx_alloc() saves the 32-bit nr_events in max_reqs, then doubles
> nr_events before checking the ring-size bound.  For
> nr_events=0x80000001, the doubled value wraps to 2, so the ring check
> passes and aio_setup_ring() builds a one-page/127-slot ring.  The
> original 0x80000001 is still stored in ctx->max_reqs and charged to the
> global aio_nr quota.
> 
> If an administrator has raised fs.aio-max-nr to at least 0x80000001,
> an unprivileged process can create that context and make later normal
> io_setup() calls fail with -EAGAIN until the wrapped context is
> destroyed.
> 
> Observed on Linux v7.3, commit
> 08ab31164c55f20c7a2653de3186ae333470e2c1, with the administrator
> raising fs.aio-max-nr to 2147483649 and dropping to uid/gid 65534:
> 
>   io_setup(0x80000001): ret=0
>   fs.aio-nr:            2147483649
>   ring header nr:       127
>   ring VMA size:        4096
>   io_setup(1):          -EAGAIN while wrapped context alive
>   io_destroy():         0
>   fs.aio-nr after:      0
> 
> The unprivileged io_submit path stopped at the ring's real 127-slot
> capacity.
> 
> The default fs.aio-max-nr=65536 blocks the path, so this requires the
> documented but unusually large administrator configuration.  Under that
> configuration it is a system-wide availability failure.
> 
> Check the magnitude before doubling, or use a 64-bit intermediate and
> charge the actual validated request count.
> 
> I found no matching upstream fix or CVE.
> 
> The privileged init wrapper and unprivileged PoC are available on
> request.
> 
> This was found with a multi-agent workflow; the full
> quota/ring sequence was reproduced in QEMU.
> 
> Thanks,
> Cheng Yongkang
> 

-- 
"Thought is the essence of where you are now."
