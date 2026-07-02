Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58DE480951;
	Thu,  2 Jul 2026 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996558; cv=none; b=iGMBOa4oFDoKxfRsThZf04CXPEgJSXIMSW3zruFHlH6e8TJscUZLNF9OUbZo0n3xcZviDAFFiabcaCoPwmxyeg5Z2xSJ1Prbqbceu1c6VxJpMl9HhnJjGYtePqZN5dhFeQHyAKG47V7ops/rMhhaMGPaYKSSZLJy8oed1/8cQ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996558; c=relaxed/simple;
	bh=2ehsPQFCG7dqB0gfauORyOk54MRv9xXLvMVwyvFcdfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXf/4J9hcYI68hohmOHniueMQ4QZbRBFYtnwux+Md+tA6hf2p3jSE3qAZHNFfNFZDFacOFSXe2vPea8VM2aMeHQHe6G/UHAtlWx8b9RcqO2ksiyyJJIVTaT+CxgAmnpV2wzIUia8YCC3m/btxcpJYA3+FHgGEC27OqSMc5xD9/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIGdnMMp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIGdnMMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022611F000E9;
	Thu,  2 Jul 2026 12:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782996556;
	bh=2ehsPQFCG7dqB0gfauORyOk54MRv9xXLvMVwyvFcdfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WIGdnMMpMr5mDzh8n4Euq3pAWpsGUjs+ClPp5mhTGgc1rAwXAPP8S/3tYhlthOXl/
	 MI1D/E44ZksaYNlbz+wIHDF/CBr9W1M3LyWd7srX+X3usGfM9szkJMaA1SoajNoCmY
	 lBUKB2s1cngqlx1dXsQzAvMDkXjyp/+H5vu/gGzU7SbDouAUlnCFnOnk49pw8UraMd
	 Tsjkc7SFqw357isJuMNsUhibOn1dpMn8BsDuU1P+ztpRUT/jllQIjk7xMmny+YYuEz
	 eNCo6txhZxxaeY8vBv3ZCinvzrMbkEa9aF2lSK/YKssBS9N6Md9JEcXM0YI6nePftw
	 k771xBbSEQBGg==
Date: Thu, 2 Jul 2026 13:49:07 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, 
	Jeff Layton <jlayton@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
Message-ID: <akZYSGoysWSb0K1J@lucifer>
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
Content-Type: text/plain; charset=us-ascii
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

What's elaborate?

"Say how much of your patch is LLM written, here are some examples".

Surely?

>
> >>
> >> I'm not really sure if having (more?) subsystem-specific tags is the way to go.
> >> (below)
> >>
> >> So either we find a very simple, kernel-wide rule for such tags, or we drop them
> >> entirely.
> >
> > Yup I couldn't disagree more with Christian here, the whole thing feels like
> > trying to 'wish away' the AI issue, and now punting off to subsystem
> > maintainers...
> >
> > Subsystems impact each other. Right now I'm writing a series that changes driver
> > code so we can enforce some sanity in mm APIs.
> >
> > I've had to interact with fs code quite a bit that uses mm logic.
> >
> > It's all interconnected, and one subsystem let's say going with 'let it all in'
> > say, impacts another.
> >
> > Yes some people lie about it, but having the guidelines only STRENGTHENS our
> > position on that, and I've seen that in practice.
> >
> > So yeah, sorry, I think it's beyond silly to push back on requesting somebody
> > disclose how much of a patch/series was AI generated.
> >
> > And [0] already essentially says people NEED to do this now. But that doc has
> > been rather downplayed unfortunately I think.
>
> [...]
>
> >> I agree on the "enforce" aspect. It's impossible, but it's still easy to catch
> >> people using AI irresponsibly today ... and that's what we care about. Not
> >> people that know what they are doing using AI responsibly.
> >
> > For me it's about empowering maintainers to push back.
>
> Right, but I suspect maintainers do have this power already, it's just not
> exercised that often on obvious AI slop yet.

Well I certainly don't feel I do :)

I tried pushing back on obvious AI slop and got a huge amount of blow back for
it because the guy wasn't honest about it.

A key reason for me pushing back on the tooling documentation was precisely
because I felt we needed a clear means of doing this.

This being the part:

"As with the output of any tooling, the result may be incorrect or
inappropriate. You are expected to understand and to be able to defend
everything you submit. If you are unable to do so, then do not submit the
resulting changes.

If you do so anyway, maintainers are entitled to reject your series without
detailed review."

But if somebody denies it, no matter how strong the evidence, you can never
really 'prove' it.

I think honestly if there's a newcomer who suddenly out of nowhere does a huge
involved series in an area they've not touched before and LLMs assess it as 90%
likely to be LLM generated,and they reply making mistakes that only an LLM would
make (misinterpreting a field's symbol and then acting as if really exists) -
it's not unreasonable to cite these things as a reason to 'not really trust'
that it's their work.

Perhaps worded nicely to say 'sorry if I'm mistaken'?

All I'm really asking is for the ability to say something like "I reasonably
believe that this is generated, so we need to build more trust here, apologies
if I'm mistaken, but can we see some smaller patches in this area first" or
something like this.

>
> >
> >>
> >>>
> >>> If the information is mostly useful during review then I still would
> >>> question why it has to end up in our git logs. It's completely
> >>> irrelevant information imho.
> >>
> >> Fully agreed. In the tree it's irrelevant.
> >
> > Not sure about that, if it turns out AI-generated patches are causing 95% more
> > bugs say that's pretty useful information no?
>
> Well
>
> a) You don't know how much AI was used. In particular, it could just slip in as

Hence 'tell us how much was used' :)

> the submitter tries to untangle some of the mess the AI created (so not AI's
> fault). Or the submitter just used it to write+translate the patch description.
> Really, the tag itself doesn't tell you much as it stands, which is the biggest
> problem I am having with it.
>
> b) You don't catch all the cases where people didn't use the tag.

Is this arguing 'we don't have complete information so let's have no
information'? Because I would say something > nothing?

>
> >
> > Or if you find that a patch somebody sent from another subsystem that has a
> > lassez faire approach to AI slop completely breaks you in some subtle way, isn't
> > it easier to push for a revert if you see it's LLM-generated?
>
> The information would have to be had from the linked mailing list posting.

That's creating a lot more work for maintainers?

You could even figure out bug rate from Fixes: tags alone using metadata.

And yes it will be imperfect but something > nothing.

>
> Given that some subsystems already started suppressing the tags when applying
> patches, that doesn't really help ... :/

Well that's unfortunate. But something > nothing, again.

>
> >
> > And is it really that egregious to include a tag? You can ignore it if you don't
> > care.
>
> I hate the current tags as they are. The question I am asking myself: assume we
> stop using the Assisted-by for LLM stuff. What to do with the other tools? Why
> are LLMs suddenly no longer a tool to mention there.

Because it turns out it's useful to have this information and more information >
less information?

>
> --
> Cheers,
>
> David

Thanks, Lorenzo
