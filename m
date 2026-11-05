Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903006;
	b=11Tfu49OQqH9QZxxN+aan/0KQyrF88HKLyJ0Rlf5aaPbpNp/YXbRco03d/Qt/kGCETmd
	 XmEMB4AmVkCzSDXsj9OvyCUkdxFbNkJB+4p5X1JMTthYMfbX9vn6ih/4omdu1bfikkzdD
	 Pxo6WE2vSFgl553gPHDIUGN43JAy+fv045OCv+QeYPBx29RP6wJ2TfEQzMVJmvoG97Fv5
	 zicY3Ot8DyHMnFnKSiggfaDWQ4rd1eZsmaMtnpKrJ8Oz3XyB6YmCk37BJqIpjDdGyaz7M
	 loqZbDBciXjt+J+jJhH/CMqkbXC4Qhzo9KXMTbNqtZjFnq3QIYQ3xnZEVfMpSvKDqvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903006;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+/AxjgSXWf+cy5I45OzU0dqZHLKBrML4mhrI4rJ0JBo=;
	b=OjCfXYPWev0B2LUv2sGK/By/cTZfZvmm+6zOs3rvhrIQ+q4w2b0CBowdoo15SY9Y4nYS
	 WmSl4aYdaRTz+yPz34uhmW022pbPlHY0+TUpHgff28oEm2GHS0XHTW5Lq5WX5DsdmLyUK
	 KSgRahIj7XJrY1oBzu8tAxMfvxURrRYXaLI0MWddniYlKFbY5T35vqS3mG+CNCior+UN/
	 AZLV31wBOp/UEVnB7WgREj1LtijDtPLZxBFJsByDyxHmknGEMncSnRAw5i6IT40ITBjhc
	 3KAQm8qzxk4j1rF/BmpILy8uiSAppXnKfCyeiM5Nxm4AMgcBTMZeQ7FzdZTOlgESNrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=k7IY6gyk;
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8949606A326
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 18:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8949606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=k7IY6gyk
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91ea16d8072so4784066d6.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 10:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793903004; x=1794507804; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+/AxjgSXWf+cy5I45OzU0dqZHLKBrML4mhrI4rJ0JBo=;
        b=k7IY6gykZWF7iOT+4ZIqfJBkIn4zPpQHXxj3tXTnLcLszExGz0PKwNm7+Aap9zo6b0
         QzAjEEjYUPHEswrOiwqYw0y14VnhDSvoWD1act1MPrW8FIdDCLDueaOqP5Vc5CkorDvU
         WSbTwYwgiENy9CjKELpnvd7ui2jG5bFriC2m8S/L+cmCbNTfkAmu25msPGHxiwaDfRhU
         Dw8DKgwwGW7BKIA5tDnr+D30b29DkdU3jxgzhwYLIpCrBRR0GrByMRF+nPS1izBhorUL
         p5WlbN2xkYeZO6FWLopUrrsi868gUCgHoiJZPHo9/oX9qquX6xjDihvd87yufSrnELr5
         +rZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793903004; x=1794507804;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+/AxjgSXWf+cy5I45OzU0dqZHLKBrML4mhrI4rJ0JBo=;
        b=uTwpf3r34E5QNlaQoNPQwG4+Bjhft8EXbBw0d5ibr/zM5G1yRCZPCbf3H5IOwj7T94
         F8jkqwiox3oVSIu6UY9F5GOEEu58UWTlNm332cvwt7Su3417b9jT6cFvrzlQXBjPjryV
         72TBs8HmCMk5soMIsLuLYCDXI0m5QJY1uVZICJYfh8xKMCnmHU7a/rCQTf8bjwcan2ur
         3ReqwzbtVCm39/C4khWrIro6lqcZoCJz3JRXLz5mbmevK7Lc5yZd7DuNRzgmdf00Nl61
         +bBU1tXqBXpuk7gM+hQQ8VaA8XFIjGNMah1WsSC3ewHezaw95kdHnxPGWa5GXJMQtVXX
         n4Lg==
X-Forwarded-Encrypted: i=1; AKwUvByNPYt1cPp+bzAfywIXK0BDDQJzAs1T0GMY/S7H5b9KrO9ANfxkuPjCj2cUEwr3ymojvosyEqEWZjCFULmE@vger.kernel.org
X-Gm-Message-State: APuU4Z/cMV7pa7/wQl3U2rpkRkPW6nfqRFVtibEyTOqvmKGYzlmVSc80
	3ONBDi175Zsf3YIZzRYs94pFRRtK2dlL068tVFTdpQ/XMBqax4UrM2++zT176MChwoc=
X-Gm-Gg: AYBFou2NMLvn5D57BOduvIgobxLyG5s7k8gAh0dECj1b117YWqf7ZGO/ROmj5l4GaDD
	BKbCZJ+lX58ncxOPNy0HCk9NAI02Co5Q4EgUI3BN3Latf9FuUyMHTujFtBTMhHNYZttKVaFOa3d
	Ct+zt1m47+eG+YZOZJYwymOENsZ5P2bwU8WOXZ4m4nuWGyVvQ/B2C7w74aMZMIwlwOe4SBra+zR
	buhdduN1o8Qt2FT2XmU/a2xLwMt5dJ93AgBtOeawEJSTzRvitCMHwsYzyFajTT9Gh53V5DDqpJH
	Dkg0klk9dDRf5fFPxTrac7hSqiDTcQ+bJai4hNrsx8jAVnyD3wZuE86vProfvl7626Om5lYEPAV
	Tk0JGC0B1o0PZsnSRjJ8DKT4dnCpk8ti8v4WjQKHb0NHam/6kp5jeMP1kMp9jaTopWLux8NfeT7
	N47D/ye9rO4Q3DNAJ3FXfza3vFgUwVnPaxIpBF0r7XP/6AeXOpxlXGOOfPIWhQiXFFWDJKlMULy
	mf4CuTXbCepfd2GiEIgss02DSckUo0KjwN0npuj5gnlG6U8KogAEAYR7fRhGucdGuFdLOMb05bx
	q/EtVpzwM9uqIdOFrHLE6NKI2B/bH371ESAm0PVZIfjBFvacHUUB2Q6S8LJxXUU5ZYU=
X-Received: by 2002:a05:6214:519e:b0:91e:a629:ff92 with SMTP id 6a1803df08f44-91ea62a03c7mr7156656d6.42.1793903004406;
        Thu, 05 Nov 2026 10:23:24 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6aa7a97sm1556826d6.35.2026.11.05.10.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:23:23 -0800 (PST)
Date: Thu, 05 Nov 2026 18:23:22 +0000
From: Josef Bacik <josef@toxicpanda.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Christian Brauner <brauner@kernel.org>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>,
 Tahera Fahimi <taherafahimi@linux.microsoft.com>,
 Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 01/90] Documentation: add a design document for cells
Message-ID: <20261105-cells-v3-reply-serge-7c41e0b9a6d3@toxicpanda.com>
In-Reply-To: <auy3kgm1YytennDE@hallyn.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
 <20261105-b4-cells-v3-1-bc9095937a84@toxicpanda.com>
 <auy3kgm1YytennDE@hallyn.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, Nov 05, 2026 at 11:06:26AM -0600, Serge E. Hallyn wrote:

Thanks for going through this. I'm going to answer your last question
first, because the rest follows from it.

> So what is your goal here?  You list several properties of the current
> namespaces implementation, and imply that they are a problem.  But what
> is the final goal: is it to implement a security sandbox that is
> stronger than what you can currently build from userspace?  That's the
> impression I get.  Or is it to avoid bugs in userspace, by simplifying
> what userspace needs to do?  Knowing the goal will help review the
> patchset.set.

Both. I want a security sandbox that's stronger than what userspace can
build today, and I want the interface to be simple, with fewer footguns
and fewer unexplained consequences that turn into holes.

They're the same thing to me. You're right that you can get a lot of
this out of user namespaces today, you point out one way below. But you
get there by taking things away. You start with a copy of everything the
parent had and a full set of capabilities, and then you have to know
about each thing that needs to be dropped, hidden or locked. A cell
starts as a blank space and you add what you want it to have. If you
forget something with namespaces you have a hole, and nothing tells you.
If you forget something with a cell, the thing doesn't work, and you go
add it.

The document doesn't say any of that up front, which is a pretty big
thing to leave out. I'll fix that.

> > +Privilege hangs off ids.
> > +  A user namespace gives its creator a full set of capabilities over everything
> > +  the namespace owns,
>
> Yes this was explicitly one of the 4 user namespace design goals,
> and I don't really want code running on my system that I can't
> later control.

You can still control it. A capability you hold in an ancestor user
namespace applies to a cell like it does to any other user namespace, so
root on the host can signal and ptrace the tasks of a cell. The user who
made the cell controls it with the cellfd, and a cell only lives as long
as somebody holds one. When the last one is closed the cell is killed,
so you can't lose track of one and have it keep running.

The only thing that's gone is the special case in cap_capable() where
having the same euid as the creator gets you everything. I don't want a
uid to be the authority.

> >  which puts a large amount of code that was written for root
> > +  within reach of every user.
>
> You imply that cells don't do this, but the capabilities section below suggests
> otherwise.

[...]

> It seems to me most of the bugs relating to capabilities in user
> namespace were not about the privilege leaking, which you seem to
> suggest here, but rather about kernel code under an ns_capable()
> check being reachable when, without unprivileged user namespaces,
> unprivileged users could not have reached them.  Since you open quite
> a few capabilities for instance with net_may(), that code is still
> reachable.  So you are probably reducing the reachable code, which
> is good, but the above is over-stating it.

I agree that reachable code is the problem, that's what I was trying to
say and the document says it badly. I'll rewrite it around that.

Here's what is reachable. The user namespace of a cell owns its uts, ipc
and pid namespaces and nothing else. It doesn't own the mount namespace,
so there's no mount(), and a task of a cell can't make any namespace, so
it can't get one that it does own. That's where most of that code is.

The network namespace isn't the cell's either, so CAP_NET_ADMIN in the
cell gets you nothing by itself. It takes the right in the slot as well,
and whoever fills the slot has to pass net_may() for each right on that
network namespace themselves. So an unprivileged user can't use a cell
to get at any of that code unless they could get at it already. Somebody
who is allowed to do it has to hand it over, one right at a time.

So it isn't nothing, you're right, but it's a lot less, and it's opt in.

> >   Who may do what to whom is decided by comparing
> > +  uids,
>
> It's also decided by namespace targeted capabilities (and LSM
> credentials).

Yup, I'll fix the wording.

> >  and whether two uids are the same depends on how several runtimes agreed
> > +  to carve up ``/etc/subuid``.
>
> Well, you are adding one more runtime (https://xkcd.com/927/ :)  This
> particular problem would be better solved using a subuid NSS module.

Fair :). The difference I care about is who enforces it. /etc/subuid is
an agreement between the tools that read it. Here the kernel hands out
the block, and it makes sure nobody else has those ids: a legacy user
namespace can't map into the window, and a filesystem that isn't the
cell's won't store an id from it. There's nothing to configure and
nothing to agree on.

> Of course userspace could do this now - create a userns, create an mntns,
> set up the mounts, and then create another userns with identity uid mapping,
> so then the container cannot get ns_capable(mnt_ns->userns, CAP_SYS_ADMIN) to
> unmount.
>
> I can envision this being a good strategy for sandbox style runners.

Right, and this is the example I'd use for the above. It works, but you
have to know to do it, and the inner user namespace still comes with a
full set of capabilities, so it can unshare a mount namespace that it
does own and we're back to relying on MNT_LOCKED. You then have to take
that away as well.

> > +A legacy user namespace hands its first task every capability there is.  A cell hands
> > +out none.
>
> This seems misleading.  It hands any that you want, you just have to specify
> them differently, right?

Right, none unless the builder names them. I'll reword it. The point is
the default.

> Every task?  But you do say setuid() drops them as usual.  Are you saying
> that the first process is uid 0, and capability inheritance just works
> as usual?  If not, then some examples would be helpful - and in that
> case it sounds like this would be an unexpected method of operation
> which would confuse userspace (which can be dangerous).

Yes, it works as usual, the document is sloppy here. A task that is
started in a cell is uid 0 of the cell and has what's in the slot as its
permitted, effective and bounding sets. If you start it as another uid
it loses them, the same as if it had called setresuid(). "Every task"
was meant to say that this goes for each task you start in the cell from
the outside, and not just for the first one.

The two differences are that every task has no_new_privs, and that file
capabilities are ignored. So what a task has let go of doesn't come back
at the next exec, uid 0 or not.

> Also I would continue to be careful about uid mapped filesystems.  If
> the host creates a cell with host uid 0 mapped to uid N in the
> cell, can a cell process chmod u+s the file, and collude with an
> unprivileged host process to run it as host-root?

No, on both counts.

Host uid 0 is never in a cell. A cell either has a block of ids out of
the window, or the one id of whoever made it, and root doesn't get to
make one of those, that's EPERM.

But on disk ids are the real problem, since images are stored with ids
from 0 up and the mount is idmapped for the cell, so uid 0 of the cell
does own files that are uid 0 on disk. So nothing a cell writes imparts
privilege:

 - S_ISUID, and S_ISGID on anything but a directory, are dropped from
   the mode of whatever a task of a cell creates, and from any mode it
   sets.
 - An existing file loses its set-id bits and its file capabilities as
   soon as a task of a cell opens it for writing, or is handed it open
   for writing. write() clears them already, a store through a shared
   mapping doesn't.
 - CAP_SETFCAP can't be put into the caps slot, so a cell can't write a
   file capability.

That's the "Files" section of the document and patches 62 to 64, and
there are tests for it. Please do poke at it, this is one of the places
where I'd really like more eyes.

> Also, how does this jive with criu?  Is it introducing any cell identifiers
> that can't be recreated?  I believe that historically that has been the
> biggest blocker to a "container" like object in the kernel.

Good question, and there is one. cell_info(CELL_SELF) tells a task the
id of its own cell, which comes from a counter and is never reused.
Nothing needs that as far as I can tell, so I think the answer is to not
tell the inside at all.

Other than that I don't think so. On the inside the ids are always 0 to
65535, whichever block the cell got. The rest of cell_info() takes a
cellfd, which only the outside has, and cells don't nest, so there's no
cellfd on the inside to restore. The pid namespace is the cell's, so
clone3() with set_tid should work given CAP_CHECKPOINT_RESTORE in the
slot. What's missing is a way to pick the pid of a task that's started
from the outside.

That's all from reading the code though, I haven't tried criu on one.
I'll add it to the list of what isn't there yet. Thanks,

Josef
