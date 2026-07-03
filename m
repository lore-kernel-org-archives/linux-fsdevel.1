Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BB92DCBE3
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 16:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783094520; cv=none; b=nozTGIkGwNYsOhXCWVdodlBiMhHQTkFbsnZVKaL0tHJOlh9fCFtfOk3iuLjwT5HkeZopD1DRMp/ErUIqP2RQRts2HTQLB23Ks04UR2wiDmwpd6kIJxVGDuQYihqpDYbP93SR8RQYwiAgDGFddrtZM+t4BFOMkGCzkaTOQf732RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783094520; c=relaxed/simple;
	bh=9YuOF15IPP1HI1sscOhmq+2MStl4C7rJ6xkqwUcNMTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nnd4PxjPG4oD8hw2RsH6F3Awurow46nyGNLqJmqHoYW2wZQpApQiEjRFe8xO1GaUjs9L+W5FRjbQVHUhm7f/V5GSY18ebZ7bCa0JuLNUx3OKooUsIzRy6FCuw9f9ktH+hzDPxwSCAy0HIiMWNLh6zH8zKOGJgPe2yxKQnFB7Fm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSLpYBA2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSLpYBA2"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 573541F00A3A;
	Fri,  3 Jul 2026 16:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783094519;
	bh=DZtSo8uL3EPh7J29JFnthaBXCpnQ02mmW8CYbPkPZeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oSLpYBA2a4sbJE2kK+FnFzycmQdzwowWxWzexwHR/A2N1lO2PylwRWfB85rhftZiB
	 DdJRmiticTkI/OPuZ4OltPcNvIl22e6Ex2ss+EoLtBouyXqIOz9nTYpvn8ocoLukB3
	 pWQV7OmYDsxBwRe7wsy352FLjdUho2rwMc7Be3MTzFXl3+li9WeFW0fFW98VTmocp0
	 ZLIEqzdoEQlRSfFg59hFfyzgoCRuLfFz9YF5NYf+m56HNAQtwAsnoMU2hE2JCOmq4s
	 eER+uBizmACSvt0qZ3eIBPTJxPc3vOxgdehb0bbEZH6wDF+UQm/QzMb1MOpNfbZACD
	 UKN7354qt7TEA==
Date: Fri, 3 Jul 2026 09:01:57 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: Enjoy the Summer!
Message-ID: <20260703160157.GA9368@frogsfrogsfrogs>
References: <20260703-vfs-summer-jam-22b2edbbbc44@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-vfs-summer-jam-22b2edbbbc44@brauner>

On Fri, Jul 03, 2026 at 05:34:52PM +0200, Christian Brauner wrote:
> Hey!
> 
> Summer is here and many core developers and maintainers will be taking
> vacations during July and August. I hope everyone gets some
> well-deserved rest and recharge and can step away from the fray a little
> bit.
> 
> The VFS tree will remain open but expect delays in patch processing.
> Please don't spam our few overloaded maintainers and reviewers
> unnecessarily.

<nod>

> As with other subsystems we see a lot of AI generated patches and bug
> reports (publicly and off-list) where the submitter functions like the
> Mouth of Sauron. This is not acceptable and such patches will either be
> ignored or heavily deprioritized.
> 
> In general, over-the-wall, vibe-coded, complex RFC submissions can never
> be expected to get lenghty, in-depth reviews especially if the submitter
> shows clear signs of not having actually spent the time to think things
> through or doesn't understand what they are working on. This is just
> taking up valuable development and review time.
> 
> Throwing mountains of code or an endless firehose of tiny patches over
> the wall to get your name into the kernel is not a success story.
> 
> On a postivie note, the last months review discipline has improved quite
> a bit in my opinion.

I'm glad to hear this!

>                      But I want to emphasize once more that regular
> contributors especially with lenghty submissions to the subsystem are
> expected to take part in review.
> 
> Review doesn't have to only mean "look for memory leaks". We know that
> LLMs are suprisingly good at finding various issues. They have no taste
> however. So review should focus on maintainability and design with the
> longevity of the subsystem in mind - both internal and external apis.

+1

FWIW, $LLM has been quite good at finding coding errors in xfs and
xfsprogs.  However, I observed that as soon as I started asking it to
review design documentation and to examine maintainability, the tone of
the emitted output switched from cloying to redditsnark ("I wouldn't
call this **good**..."). :P

> Keep up the good work and enjoy the summer!

You as well!

--D
