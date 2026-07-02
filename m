Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDB0431E55;
	Thu,  2 Jul 2026 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782998825; cv=none; b=qIA7BjhUfd71pPjNRJWwRjzMhFyGPT/HnuhbfrAgrOwv22DArkPVb+5mVE+DZ1+nGaUrYG/oJQkB14L3loFPp0ljxy7xid8nwoN+DeqgF7mMFwpTv9pfT+8TBA89u/ansY5Lf6g+8m3jR3yFhMklWr9O2K5nYk3WeyHOXTCgvF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782998825; c=relaxed/simple;
	bh=lSqo6O6WZ+rDfnb7vMn5V/d/pI1JVJxXS2FNIESa+Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8CwQAkZKRggiPTqgIEU6x3zkh94RyFYdB+Ew9t7FmDattccLq44Y1pqZfxMO4vKopqeW8wdbEXIuvQgxXjIS901ebmnyuBp9lzXz8CbfZZnIAUU7+bKhknoNKgdS7xMV59AfjuhXh5K6qJjEbFjGNbWP4UI2n+IFmuLjC4ZaoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcGXSKu4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcGXSKu4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF0F1F000E9;
	Thu,  2 Jul 2026 13:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782998824;
	bh=zC+CbGWapRoHKyQI3zNE/DEViQmuDGCBN+60Eb79jsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZcGXSKu4UBl6s6DCC939ScwNnKE91/22cbrs2i119LT85uIaE5c4h4iEnAoux2+vJ
	 lLk42HWsiStY5YEn9rTc9BhhLCHxPfggO+TVw73gQf3UKa5RJophgJGJPEp4RfPqeB
	 ZX3nq5YOI+krrZMNGRUDp6A4S94qvAKjfzbeA+2bP0z39PTJxz3sFUNb32t36F4h1b
	 9XSjpomX7Z9jU4vrr5YcpxpAMDZV3uCOq45LR1POC53QZYd7Kmhn1g1N7GQapZrWOy
	 ju4OmkcZVsJAW2J1hSpRCLlgEzO00l0FOn7rnt7jqaYJ9Vjn3y98kp6mkHhnanVXqZ
	 YRUwdrkREwXmQ==
Date: Thu, 2 Jul 2026 15:26:58 +0200
From: Christian Brauner <brauner@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, 
	Jeff Layton <jlayton@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
Message-ID: <20260702-weitreichend-aufgearbeitet-flausen-fd92f38bbba0@brauner>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <5e7b9d23-4291-48fb-bdc6-47db82d33c80@kernel.org>
 <20260702-seekrank-stilrichtung-mitentscheiden-69a64ee097ec@brauner>
 <1f29f48d-b9ff-4de2-a392-dc05781728be@kernel.org>
 <akYz2aMIco1fbD-t@lucifer>
 <54d3a698-a275-488e-ad36-ef423db30f70@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54d3a698-a275-488e-ad36-ef423db30f70@kernel.org>

On Thu, Jul 02, 2026 at 01:51:10PM +0200, David Hildenbrand (Arm) wrote:
> On 7/2/26 12:04, Lorenzo Stoakes wrote:
> > (thanks for the cc-!)
> > 
> > On Thu, Jul 02, 2026 at 09:46:37AM +0200, David Hildenbrand (Arm) wrote:
> >> On 7/2/26 09:27, Christian Brauner wrote:
> >>>
> >>> I think we should just drop any attribution as a general kernel-wide
> >>> rule and let subsystems require them as needed. Then you can have all
> >>> the complexity in mm for this that you think is needed for your
> >>> workflow to function. This is precisely what the subsystem profiles are
> >>> for. So maybe just add:
> > 
> > A single comment is complexity?
> 
> I think Christian meant more elaborate rules. More than just "If you used LLMs,
> disclose how you used them."

Yes.

I'm going to follow netdev and start dropping those tags from the
changelog completely too. After speaking to some bpf maintainers they
also don't use the tag. So I can safely assume that 3 large subsystems
don't bother with it.

So seems to me that such requirements should just move into the
subsystem profiles.

I think as a global policy this has ran its course.

> > And is it really that egregious to include a tag? You can ignore it if you don't
> > care.
> 
> I hate the current tags as they are. The question I am asking myself: assume we
> stop using the Assisted-by for LLM stuff. What to do with the other tools? Why
> are LLMs suddenly no longer a tool to mention there.

Tbh, I think that's equally pointless. There are also very few instances
of non-AI attribution with Assisted-by.

If the tool mattered to what was done significantly then it should just
be disclosed in an appropriate paragraph in the commit message. The tag
itself is imho equally useless for this. I really don't need to know
that you used grep or git-sed or tcpdump and it certainly doesn't need
to spam the trailers.
