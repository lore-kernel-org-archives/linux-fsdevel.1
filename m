Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CC136F439
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 10:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773138700; cv=none; b=pKhL5+QM2RL6aLGeJ3+AcIW4LAyo9sMGan5jFzdbXqmQ6/NFdqItQWDPrgmP1XHz2BaPqMpbpQDP1hSVHW1159tRjD7QwDeA7sKRCmypni7uMhtWJu5QiC08alw5Erzlx71+i1M7lgS+D7iVkA0stfW/LsdRoI71zbFq5XxZXWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773138700; c=relaxed/simple;
	bh=ZIZPQTnbTGvqosbrmC3HJlaKHjmaD2P0Q1OJRB+XgRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeOfuqX+CSCRg6LFDwi9KN1X970H+JpfLur99DWYyo8mEMZXEU3/Ee9CRwA+in+/ML3yX9CFybyo6V6omzO8kMCUVBAwRG018TLN+yrfpWYLDl4ZC9Os8aNynqipVhADSkIPTOO4F4q+mAvX7FAqi/zaeZ4oWhQW2Gtg6kBX2bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9dWRws9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9dWRws9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DDAC19423;
	Tue, 10 Mar 2026 10:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773138700;
	bh=ZIZPQTnbTGvqosbrmC3HJlaKHjmaD2P0Q1OJRB+XgRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y9dWRws9PdpJnoeu0T262oB1L1PX5dhWw/iTNCC4wxVArJWEuoYzVNgkLnxnYGdY/
	 GAfyVHjWRliWGVCKxnM4zvFhgnMIQwptg1gAYs+/wTSXTiPYMiOvi/54lKiHLBaxYH
	 RweRqPrs7sjWrfSHn/IbpHWMnhsxj1v/5bvF18g5FnsXtbmiAw0vcVvPlWeBXJwPzp
	 PtxOCh/XxcDYrwyrFw/yygqtwjUobWO/xmL1/lh+DNQeQp2KDpfi5yXY3+CpFQZINX
	 UFdM//OIzuehJXtAKBx/k9uavNqi4pEcV+TyPd1v625ijON3+E9PS3pPpwBZ14XR/E
	 qxecwWmAS6NKA==
Date: Tue, 10 Mar 2026 11:31:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
	Tejun Heo <tj@kernel.org>, "T . J . Mercier" <tjmercier@google.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/5] fanotify namespace monitoring
Message-ID: <20260310-inkompatibel-staufer-7c862857ac62@brauner>
References: <20260307110550.373762-1-amir73il@gmail.com>
 <20260309-einrad-mitarbeit-18397e65afd3@brauner>
 <CAOQ4uxgmttSum2a2gKBkpdzg4110rpaH4mayy=9+QzWjFRNB6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgmttSum2a2gKBkpdzg4110rpaH4mayy=9+QzWjFRNB6w@mail.gmail.com>

On Mon, Mar 09, 2026 at 04:47:20PM +0100, Amir Goldstein wrote:
> On Mon, Mar 9, 2026 at 1:33 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Sat, Mar 07, 2026 at 12:05:45PM +0100, Amir Goldstein wrote:
> > > Jan,
> > >
> > > Similar to mount notifications and listmount(), this is the complementary
> > > part of listns().
> > >
> > > The discussion about FAN_DELETE_SELF events for kernfs [1] for cgroup
> > > tree monitoring got me thinking that this sort of monitoring should not be
> > > tied to vfs inodes.
> > >
> > > Monitoring the cgroups tree has some semantic nuances, but I am told by
> > > Christian, that similar requirement exists for monitoring namepsace tree,
> > > where the semantics w.r.t userns are more clear.
> > >
> > > I prepared this RFC to see if it meets the requirements of userspace
> > > and think if that works, the solution could be extended to monitoring
> > > cgroup trees.
> > >
> > > IMO monitoring namespace trees and monitoring filesystem objects do not
> > > need to be mixed in the same fanotify group, so I wanted to try using
> > > the high 32bits for event flags rather than wasting more event flags
> > > in low 32bit. I remember that I wanted to so that for mount monitoring
> > > events, but did not insist, so too bad.
> > >
> > > However, the code for using the high 32bit in uapi is quite ugly and
> > > hackish ATM, so I kept it as a separate patch, that we can either throw
> > > away or improve later.
> > >
> > > Christian/Lennart,
> > >
> > > I had considered if doing "recursive watches" to get all events from
> > > descendant namepsaces is worth while and decided with myself that it was
> > > not.
> > >
> > > Please let me know if this UAPI meets your requirements.
> >
> > I think this looks great overall and is very useful as it allows to
> > monitor namespace events outside of bpf lsms. I agree with the
> > non-recursive design. You could generalize this approach by deriving the
> > watch from the namespace file descriptor? Then you can get notifications
> > for all types of namespaces.
> 
> Not sure what you mean?
> Which type of notifications?
> This RFC generates notifications for all types of namespaces created/deleted
> under the watched userns.

I misunderstood that part. Yes, that's really useful as is.

> 
> Which notifications did you intend to watch for other types of ns?
> DELETE_SELF?
> 
> That would be easy to add.
> Would just need to move the n_fsnotify_marks/mask to struct ns_common
> (also from mnt_namespace).

Yes, I was thinking about a way to monitor namespace destruction for an
arbitrary namespace.

> 
> >
> > If we ever want recursive watches, then we just need to add a separate
> > flag. This is only applicable to userns and pidns anyway.
> 
> Yes, if we wanted to.
> 
> >
> > I want to put another - crazier idea - in your head: Since pidfds are
> > file descriptors and now have the ability to persist information past
> > pidfd closure via struct pid->attr it is possible to allow fanotify
> > watches on pidfds.
> >
> > I think that this opens up a crazy amount of possibilities that will be
> > tremendously useful - also would mean fsnotify outside of fs/ proper.
> > Just thinking on the spot: if you allow marking a pidfd it's super easy
> > to plumb exec notifications via fanotify on top of it. It's also easy to
> > monitor _all_ namespace events for a specific process via pidfds.
> 
> Anything's possible, but we need to make sure it's worth it.
> Aren't there already enough ways to monitor a process via ptrace/landlock?

Oh god, no. ;)
ptrace() is way too heavy handed for usages outside of debugging tools
such as strace and also has the downside that only one ptracer can be
attached at any time. I have no idea about landlock but it is an LSM and
I don't know why an LSM should have such notification abilities.

fanotify on the other has no odd limitations and it naturally ties in
with filesystem objects and with pidfs we've made processes filesystem
objects. So I think this is a very natural fit.

So you could just register a pidfd with fanotify and then get notified
about exec events for that pidfd with arbitrary metadata attached to it
if need. I've wanted this for a long time and one way I thought about
going about this is by somehow plubming this into poll for pidfd but
that's not going to scale as we grow more notifications events for
pidfds.

I think fanotify is the perfect fit for this with its extensible model.

> 
> >
> > This obviously needs some thinking wrt security etc but I just want to
> > put the thought out there that the integration of pidfds and fanotify is
> > possible.
> 
> I was thinking more about watching the entire pidfs space, but sure.

That's certainly possible too. Initially it would have to be scoped to
global admin privileges but ultimately you could probably filter by
credentials - if needed.
