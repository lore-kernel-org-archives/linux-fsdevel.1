Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.233.56.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684135;
	b=TL7b4qNfSwLjvIcu4zrFAVM30nJglDnRGGAYcxI/BkFrozkGGszehw6MkuaX13sT56x9
	 zrQAiN6aMHT2sfzexpj6GbHR7j540tM6pubjCjkphajB7Grg5vwsPkfKDqo2xVe5UzEJ3
	 4BqIe3jWjmBNy8REWvokS2Hh/nYkk6pwR9unLUGViJWaQqs5S5JgmpxqzhUxw84riZE4Q
	 LrVeI+03RssNZuoawHM70DskUuigOTU+O3H3u1wpsDQFNjHsB0Jgo1lb7V4pmCk/JgiiY
	 4g1QTZctmTIDIvlaLeBsXu3Z993Jtfds6qE82yj9RpWBvFgFfPZJf+YBpZgBBEN6VRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684135;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Mime-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=CB/i0bwdwuyPYAtBftDJk8Vi4sVEsy1QZuQF5zLlv9g=;
	b=tBNi8Wd4MKL17X6i7YHGYHYrpVLoR8iNMh3pmGN895jgOZpd331OrfCFGddn1La4Myk5
	 s4EhUQvr+dsq9z0VqIvzIjS7ii2Pegkjr7MJPDw6oBqrYmxcXOzROVh64NiKr1Hd4+NhM
	 zqmMrVBctUFJB05+U3QhyMSlkirLXllzT+QHRDqHoshKsiVL/bMAsioLgf57WKRCqczID
	 iQCZNylZYGNZWoTKINdFxkDYCiTn640g3pHCnoQXOQqnEUBjys59H5nzeI3f46fCRVGkw
	 7c3Qxlk/FzJHdqjUG9ByuOJKzFu2GnfZAzJi5PwqzLXnJQdNOHCaxzAoZZegNyfmkMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=communityfibre.ca;
	spf=pass smtp.mailfrom=communityfibre.ca;
	arc=none smtp.remote-ip=205.233.56.17
Received: from kanga.kvack.org (kanga.kvack.org [205.233.56.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D9F606A319;
	Thu, 22 Oct 2026 15:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11D9F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=communityfibre.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=communityfibre.ca
Received: by kanga.kvack.org (Postfix, from userid 63042)
	id E64D66B0987; Thu, 22 Oct 2026 11:48:52 -0400 (EDT)
Date: Thu, 22 Oct 2026 11:48:52 -0400
From: Benjamin LaHaise <ben@communityfibre.ca>
To: Cheng Yongkang <teel4res@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] fs/aio: io_setup integer wrap can exhaust global aio quota
Message-ID: <20261022154852.GQ8374@kvack.org>
References: <20261022091748.3653127-1-teel4res@gmail.com> <20261022152305.GP8374@kvack.org> <179268384018.50580.15623131516982541149@gmail.com>
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
In-Reply-To: <179268384018.50580.15623131516982541149@gmail.com>
User-Agent: Mutt/1.4.2.2i

aio_nr is never updated.  Your analysis is entirely incorrect.

		-ben

On Thu, Oct 22, 2026 at 08:44:06AM -0700, Cheng Yongkang wrote:
> Hi Ben,
> 
> Thanks for the reply. I agree with the security triage: reaching this path
> requires root to raise fs.aio-max-nr to an unreasonable value, and I am not
> claiming a memory-safety issue, privilege-boundary bypass, or UAF. The impact
> is limited to global AIO quota accounting under that configuration.
> 
> I do think there is a factual mismatch regarding the execution path described
> in your reply. The validation raises fs.aio-max-nr to 2147483649 before
> dropping privileges and calling io_setup(0x80000001). In that configuration:
> 
>   1. max_reqs retains 0x80000001.
>   2. nr_events *= 2 wraps the request to 2.
>   3. The wrapped value passes the ring-size check.
>   4. aio_setup_ring() creates a one-page, 127-slot ring.
>   5. aio_nr += ctx->max_reqs charges the original 0x80000001.
>   6. ioctx_add_table() is called and succeeds.
>   7. A subsequent normal io_setup(1) fails with -EAGAIN.
> 
> So, in this tested path, the ioctx is not destroyed before ioctx_alloc()
> returns, and ioctx_add_table() is reached. The ring is small while the global
> quota charge is large.
> 
> I agree that this is a low-value, configuration-dependent correctness issue,
> not a security fix. My point is only that treating the configuration as
> unsupported is different from saying the wrapped path is cleaned up before it
> can be installed.
> 
> I will be more conservative about AI-assisted findings going forward and will
> set a higher bar for preconditions, security impact, and whether a patch is
> worth maintainer time. If you consider this configuration unsupported, I will
> withdraw the patch.
> 
> Thanks,
> Cheng
> 

-- 
"Thought is the essence of where you are now."
