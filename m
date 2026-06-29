Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006B5419312;
	Mon, 29 Jun 2026 15:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746411; cv=none; b=tL1z6mlSk7QbOI/+0Hxk0OEwB4D1IfSXRJsoHV1RnZE27Q+MbGIK+4dbbrVsboqkmSha0qkuF+PTUtJk5MyizcknD8lJhH7jQeG8H3vonJPo5VKV3v53uohPStOjQsVl0JqHS6VKVcL0S5RZkiCcOSlxCUM545q1tU8DQAiVkI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746411; c=relaxed/simple;
	bh=A7IGft8CE14yHrv04+4rQ+KTYc/nZbATvhzLpjivnZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DtX6JIdYI5TJzHqXOLnsdlJjhoAlyjt2+nVZUjCnBgCg+BJmm3Y01/w3jO/XLMs052e96ZMXXwkWSRnqWaL65DBN7fUpSaE5vYlRpBg1Z2DsHOmZbAXW8FSwcql9Cslx2Vml+rsVpbxmUTCUtpUb1RAvgB3yQRXX8N5ADzBOHxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXIsfJDz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXIsfJDz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F12B1F00A3A;
	Mon, 29 Jun 2026 15:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782746409;
	bh=lAK889VnZ5GR1ejnB0aGy9b8XfwY8yySXBWtcqayKUU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GXIsfJDzyX6BUWkom6q69jdArKaxrNLPu+prOqdHr2uNODNVln7wtnlW4CU8QokP8
	 UngcxEWqvcTuBcgPyK10OIe24gX2KV1XUkb4ypgeK4FGuJNB24gHpHkbJhBdkrharB
	 thg2uvw5FZv5fi0+IP5mToROjvuHTtb/La2H2514ql4ZdD4tO/XDqReBVWGufCUn2v
	 zZ3xrv0xRHe0mJAJ2vSzxtfya8QHQSJrh+C/R6XXrjIgiLHVTBjmsYGpgRw3FWbBz2
	 zraz0APC6pq/JXbjbh/7yQ8qtByo3itYgemZG4ZGFkLiLGoJWgwiO0QB//7XK6J3mW
	 ldRSKvrM7+DLg==
Message-ID: <cfa56e7d-2395-44bf-848b-6103d53cccde@kernel.org>
Date: Tue, 30 Jun 2026 00:20:05 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/10] kmem_cache instances with static storage
 duration
To: Al Viro <viro@zeniv.linux.org.uk>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
 linux-fsdevel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Mateusz Guzik <mjguzik@gmail.com>,
 linux-kernel@vger.kernel.org, Hao Li <hao.li@linux.dev>
References: <20260611171425.1671254-1-viro@zeniv.linux.org.uk>
 <20260613050951.855141-1-viro@zeniv.linux.org.uk>
 <151b1c96-0ed5-44ce-b9d5-86a48d8ad592@kernel.org>
 <20260624004828.GI2636677@ZenIV>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260624004828.GI2636677@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


[Adding a new slab reviewer Hao Li and dropping my old email]

The thread:
https://lore.kernel.org/linux-mm/20260613050951.855141-1-viro@zeniv.linux.org.uk

Trying to follow the discussion here...

On 6/24/26 9:48 AM, Al Viro wrote:
> On Tue, Jun 23, 2026 at 10:09:41AM +0200, Vlastimil Babka (SUSE) wrote:
> 
>> But the argument for doing the static duration support is that it should be
>> faster, not just "not slower"? So is runtime_const equivalent or for some
>> fundamental reason it's slower than plain &?
> 
> Yes, on any 64bit RISC.  And if nothing else, arm64 has enough users to care
> about.
Agreed that arm64 has enough users to care about performance.

Out of curiosity, could you please share on which workload you observed
this (dereferencing cache pointers) on profile and how bad it was?

> Compiler does *not* build the address of global variable in a sequence of
> shifts and bitwise operations when it needs to pass it to a function.
>
> runtime_const_ptr() must be able to handle an arbitrary address; it can't
> avoid doing the general "build a 64bit value in register", which tends to
> be nasty on RISC.

It'd be nice to have some examples in the cover letter.

So if I'm following correctly, arm64, for example, uses four
instructions to build 64-bit value in register (one instruction to fill
each 16 bit) in runtime_const_ptr().

And by making it plain &, the compiler can use clever tricks to use
fewer instructions to do this?

e.g.) a quick search says [1], on arm64, it is possible to reduce them
to two instructions to build the address of any global variables, one
instruction (ADRP) to generate page-aligned address using pc-relative
addressing (within +- 4GB), and another instruction (ADD) to fill the
lower 12bits.

That's what makes it faster than runtime_const(), right?

[1] https://devblogs.microsoft.com/oldnewthing/20220809-00/?p=106955

> If you want real ugliness, take a look at riscv - AFAICS, they wanted to
> avoid a long dependency chain, so they load chunks of constant into 4 registers,
> then shift and combine those. 

-- 
Cheers,
Harry / Hyeonggon

