Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9022F2BE7CD;
	Thu,  4 Jun 2026 19:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780602765; cv=none; b=p6TIlfz7Y0CbMJDkm8z1ucZmMm+JPnbJ08xdFjSCtz9ptikgOHBanHBwPHHri8s/96YylbGmV4lHqSxju0dr7mUEwji2bVRhufYbH12vuoBrUxk6XN4dlF8SyL0wglEdtqUWdASOjJO9U3A+P4IVSNHvnX33LAbpMNxhogmv0m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780602765; c=relaxed/simple;
	bh=mIKLTDwE/7XnDlM+Wic3OGmrWlthwW9jYpeO68RttzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIJA5LpQSeYtr4rFIwSpoah8pfkFwyQwzyehQqj2uTmKi+0o5MANrGRwlky9t6V9/S7g66B7XNqWPKUcRMMwQ8aOTF8UFWCQiuTpoufDWRi8Ix4IxIZrdSkZGji34dClvtQm2d+FskV+Aji6Y6l+4L15LyUqpFKmGPrUHo+Mm2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfzsMKUO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfzsMKUO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2DF1F00893;
	Thu,  4 Jun 2026 19:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780602764;
	bh=mIKLTDwE/7XnDlM+Wic3OGmrWlthwW9jYpeO68RttzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FfzsMKUOlObmu5OK/0v9NiUeZlIYhv2y1WNoKK1XZAHQUrUCBD+fyRgxOMeycF4jK
	 hk5eJ1gc0q0hltxMHkeYsgjfXzAvDWO/BbRK5dRi/2ff62lBGX4Ne7E5E67CLfjmip
	 q9cbWDcu/naAAdaXqkWASZYJpsY8H+rrHUjHrhcT7ZlQpGD6/y+9Dup6yPunV1XNV5
	 DyMaNmgvT3+uJ1XjA/m3H2MTQS9NirZ82jE2zzaDfUtpkysjFM+MhHsWOfq7FiJfOE
	 9MehWz+U8x5MwB3yJzE0GCz/IqCZarDBIOfUtiOds7WePTYpeM4ClUpdfPJobSzUFI
	 vGXrCTBzi3AuA==
Date: Thu, 4 Jun 2026 20:52:37 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, shuah@kernel.org, hsukrut3@gmail.com, richard.weiyang@gmail.com, 
	reddybalavignesh9979@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/3] fs/proc/task_mmu: read proc/pid/{smaps|numa_maps}
 under per-vma lock
Message-ID: <aiHXZokM0TekWmog@lucifer>
References: <20260426062718.1238437-1-surenb@google.com>
 <20260426062718.1238437-2-surenb@google.com>
 <ahhMEBYM9bixF2Lg@lucifer>
 <CAJuCfpFJvuFZkgKwJ11RjDXYhTz-a31HO9-5C+Yc=KxbsGvB-w@mail.gmail.com>
 <aiElxkLHn2yC3W_3@lucifer>
 <CAJuCfpGWeLz7RBVYHTnMpH2O77yb9MtjMKRK1LrgijafC_0mSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGWeLz7RBVYHTnMpH2O77yb9MtjMKRK1LrgijafC_0mSw@mail.gmail.com>

On Thu, Jun 04, 2026 at 12:26:14PM -0700, Suren Baghdasaryan wrote:
> > > > We need to pull out the patches from Dave's series and remove this option and
> > > > default VMA locks on by default :)
> > >
> > > I didn't see any followup after Dave posted his v1. I agree it would
> > > make things much simpler but I don't want to delay these changes too
> > > much.
> > > I'll ask Dave if he plans to continue his cleanup. If not, I'll pick it up.
> >
> > Great thanks!
>
> I checked with Dave and he will post the next version in a week or so.
>
>

Great thanks! :)

Cheers, Lorenzo
