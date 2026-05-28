Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA30D19F11B;
	Thu, 28 May 2026 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779982628; cv=none; b=LDPegQ6LgNngCTT+4y+LLs4lvBdn1rxTRvVwpsYdn3zKHm0TuhKG3UchVY/YQeh6BZFSRsYyt9L9LnDTPRm9MWamo/ZaZmDBN3wWmLHBRMNz30NpzLCJgT72S0JPkpMSOjWrbthBZOpopECiQNCklJYa3NyO63pCBIppp7VcIH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779982628; c=relaxed/simple;
	bh=UvZhOE2beGt+JfbB29hrRjxwc3ro/bcu2TES6dE/gIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vq3qS94FrrdxickNxVZmxu0PTt/0T0JQqTIldSoQLhYHqRSZR+/fczqUCFY/aLlMNQKtKp38rqOWTBtTQeqlTdsC4PA7Z7Xr8uKa2fg6ah1xRZECYzubhY2AlgXV8lIX8SSQ9NmfqIqLLkmm6kd9SJfEipugNLQZzCnNDwKiIw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQMYV3ZK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQMYV3ZK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB6A1F000E9;
	Thu, 28 May 2026 15:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779982628;
	bh=UvZhOE2beGt+JfbB29hrRjxwc3ro/bcu2TES6dE/gIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UQMYV3ZKcZd4PTfDuCGUUCmHgppui9/Vm/kGrVy0q6tnmbMql5N9huBmxl8OhHmPq
	 NZXe7O+u4nVXHvTE/mXhF7eqPUUxLaqX+2FACM1qI2tTOBZxU7lhh3Fy2moNpxgsT3
	 DKt/0Y/mqQ+5TDNs4DWalqXQ2Efn0bhAzIRdX/ox5/QrhL3riv8HF6k+l8OVLy0zvv
	 CBUN1Xjy3S/ddU+RTWxf4YFyACT+c+NQhxHW+dgeTe3NPW5pf9hCSHwWDo0DTkFDPg
	 JOEP8qewIj059PxVLOsFuAwy8nEh6oDYCqOHRb/+2poEJhV7mK06Gg8Cg4w6vRLym8
	 6hg3qeubdPNWw==
Date: Thu, 28 May 2026 16:37:01 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, liam@infradead.org, vbabka@kernel.org, willy@infradead.org, 
	jannh@google.com, paulmck@kernel.org, pfalcato@suse.de, shuah@kernel.org, 
	hsukrut3@gmail.com, richard.weiyang@gmail.com, reddybalavignesh9979@gmail.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/3] use vma locks for proc/pid/{smaps|numa_maps} reads
Message-ID: <ahhdeYDAY7BvqxYU@lucifer>
References: <20260426062718.1238437-1-surenb@google.com>
 <a27344e1-6f0c-4686-99ac-fc2cfcc5bb06@kernel.org>
 <CAJuCfpG3xZhL94E=yR1KsWs6fVwcdoAECoOaV3UOeB10TXmOeg@mail.gmail.com>
 <0ce6071b-0c99-4119-9ab4-a2d9c00b99a8@kernel.org>
 <CAJuCfpHPs54_hc_U9DCxtv=xikKHJMtqCEDN_4Y5aDqKhoBDnA@mail.gmail.com>
 <20260526184944.18c28d6980fd29ff12fbbe22@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526184944.18c28d6980fd29ff12fbbe22@linux-foundation.org>

On Tue, May 26, 2026 at 06:49:44PM -0700, Andrew Morton wrote:
> On Thu, 21 May 2026 08:16:01 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
>
> > > > It might be but the point of this patchset (and the previous one that
> > > > made a similar change for /proc/pid/maps) is to reduce mmap_lock
> > > > contention, not to speed up the read operation, which is not a
> > > > performance critical part.
> > >
> > > Well, this interface has been around .. forever, so if there is a noticeable
> > > change in performance it should be called out.
> >
> > Sorry, I missed your reply. I'll see if I can adopt Paul's test for
> > /proc/pid/maps [1] for benchmarking smaps but I would expect similar
> > results as was reported in [2].
>
> How's it coming along ;)
>
> > [1] https://github.com/paulmckrcu/proc-mmap_sem-test
> > [2] https://lore.kernel.org/all/20250719182854.3166724-1-surenb@google.com/
>
> I've moved this series to the tail of mm-unstable to permit more time.

Well I'm not sure it's _vital_ to get stats for this, it's pretty much an
extension of existing VMA lock work in /proc/$pid/maps -> smaps, and the
logic is sound.

There's no reason to believe there will be anything other than a reduction
in lock contention here at least under whichever workloads happen to hammer
smaps, but doesn't feel like there's a downside!

Cheers, Lorenzo
