Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13EE3CAA5F;
	Thu,  2 Jul 2026 10:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782986686; cv=none; b=ugDWMWMgRE0eDorZzjpID8v+WxDSc0IWxgIEg7RhL+QegVq55Fc43uq+SXVD3X/UJ76uLMJIMHlAcztGsN3jc9rc/471mqpmakwVQYDNdpSOoZs4nELX27Pc7qum19ELrjzqUQwYsPxyM3DtdNQ55g7CioPd1oZYVTj3+zVYA5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782986686; c=relaxed/simple;
	bh=FLS8wqt9YcnWtQJAIXCot5XuAdPCMwYooUjU3boREzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbuuxShsKljvUOkCXqZ43Pyrs9qzUM+4p7S0q8y1QOWWxoEfz/MptnTCvxcQUdvggwAaKJSY2mOQketlEL7SOSXkbKtArLrmu9yVkWFYJ7Xny3eoS5vdQiKxQS3PcfboC/h3z4at9PSnvUP9FfIuXqGO4jB68HeIAUhAGM6rPOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJi3aTz0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJi3aTz0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000821F000E9;
	Thu,  2 Jul 2026 10:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782986684;
	bh=FLS8wqt9YcnWtQJAIXCot5XuAdPCMwYooUjU3boREzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mJi3aTz036V9TI4faopvlYouaxsLK4CRlT+PnGdTMRwIwh32sNrVsdBQdqu7farzj
	 UczRnXgeZcs7cUMlO202X+YByva/pv9LDETjiUjrY4IAHJyUXOeE88FjZm43s5FWv0
	 VIOfaq7wVdhImcy5vB11H2E4czO9KuvF5MUXJ3nFTIrt5LhmhuAEuEEPN4DZOHBmbG
	 tcCoCWPAxqF0ZB5bhvfeI0nU0YGXwNATAPw3zGYffpJEPjOLpIUA7sp9WB5Rt66P18
	 1sLgRKz+Br0Xpv+V4hJz+ivvEtGpllw55B1qf89cHRiCqjehhVJYlgEgsEmqC5tIWa
	 fpzW+NAUDqDIg==
Date: Thu, 2 Jul 2026 11:04:35 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, 
	Jeff Layton <jlayton@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
Message-ID: <akYz2aMIco1fbD-t@lucifer>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <5e7b9d23-4291-48fb-bdc6-47db82d33c80@kernel.org>
 <20260702-seekrank-stilrichtung-mitentscheiden-69a64ee097ec@brauner>
 <1f29f48d-b9ff-4de2-a392-dc05781728be@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f29f48d-b9ff-4de2-a392-dc05781728be@kernel.org>

(thanks for the cc-!)

On Thu, Jul 02, 2026 at 09:46:37AM +0200, David Hildenbrand (Arm) wrote:
> On 7/2/26 09:27, Christian Brauner wrote:
> >> What would be much more relevant to know is to which degree LLMs were used.
> >>
> >> Assisted-by: LLM # translate commit message
> >> Assisted-by: LLM # generate some test cases
> >> Assisted-by: LLM # cleanup logic
> >> Assisted-by: LLM # everything and I have no clue what any in here does
> >
> > I think we should just drop any attribution as a general kernel-wide
> > rule and let subsystems require them as needed. Then you can have all
> > the complexity in mm for this that you think is needed for your
> > workflow to function. This is precisely what the subsystem profiles are
> > for. So maybe just add:

A single comment is complexity?

> >
> > Documentation/process/maintainer-mm.rst
> >
> > alongside
> >
> > Documentation/process/maintainer-{tip,netdev,x86}.rst
> >
> > and lay down the rules that you require for LLM based submissions in
> > whatever detail you need.
>
> I'm not really sure if having (more?) subsystem-specific tags is the way to go.
> (below)
>
> So either we find a very simple, kernel-wide rule for such tags, or we drop them
> entirely.

Yup I couldn't disagree more with Christian here, the whole thing feels like
trying to 'wish away' the AI issue, and now punting off to subsystem
maintainers...

Subsystems impact each other. Right now I'm writing a series that changes driver
code so we can enforce some sanity in mm APIs.

I've had to interact with fs code quite a bit that uses mm logic.

It's all interconnected, and one subsystem let's say going with 'let it all in'
say, impacts another.

Yes some people lie about it, but having the guidelines only STRENGTHENS our
position on that, and I've seen that in practice.

So yeah, sorry, I think it's beyond silly to push back on requesting somebody
disclose how much of a patch/series was AI generated.

And [0] already essentially says people NEED to do this now. But that doc has
been rather downplayed unfortunately I think.

>
> >
> > I don't see how this additional commentary you want would ever be
> > enforced consistently across the kernel or who would even enforce it. I
> > don't need more beaurocracy to chase after people in my subsystems tbh.

Again, asking LLM submitters to write a single comment is 'beaurocracy'?

>
> That's certainly a good thing to discuss. (below)
>
> >
> > The other thing is that I think this Assisted-by annotation is just
> > noise in the changelog. If you want to know in detail what an LLM was
> > used for when generating the patch it's mostly a signal for how
> > "intense" of a review this will get afaict (already questionable imho
> > but sure that's just something to disagree on).
>
> I'd be happy to just have such information in the cover letter. Without any
> tags. Having subsystem-specific rules on the disclosure on that might be more
> reasonable.

I disagree, I think it's important to have it standardised and simple.

If we make things vague, people won't do it. And reading through a cover letter
in its AI slop entirety (and boy does it generate a LOT of text) to find the
mention or not (and hey what if it's not clear?) is just objectively worse.

>
> I agree on the "enforce" aspect. It's impossible, but it's still easy to catch
> people using AI irresponsibly today ... and that's what we care about. Not
> people that know what they are doing using AI responsibly.

For me it's about empowering maintainers to push back.

>
> >
> > If the information is mostly useful during review then I still would
> > question why it has to end up in our git logs. It's completely
> > irrelevant information imho.
>
> Fully agreed. In the tree it's irrelevant.

Not sure about that, if it turns out AI-generated patches are causing 95% more
bugs say that's pretty useful information no?

Or if you find that a patch somebody sent from another subsystem that has a
lassez faire approach to AI slop completely breaks you in some subtle way, isn't
it easier to push for a revert if you see it's LLM-generated?

And is it really that egregious to include a tag? You can ignore it if you don't
care.

>
> --
> Cheers,
>
> David

Thanks, Lorenzo

[0]:https://docs.kernel.org/process/generated-content.html
