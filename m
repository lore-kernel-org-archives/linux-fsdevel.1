Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9993138A711
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141300; cv=pass; b=H9zi4wBaG4wY1WmsN9wnUuHEcUMGZ2MnC0+Qy4+3fHwKuSbl4lIRk2Q169c5EuPZVo30u8kvGuiwvyhRBITY4VYMHjWVuemP0cx2JFnYD+zTd4icHKl5TqJDdK6D2q0TcfGbv+G9tFAqt4SLP7NqMq7BFyqmq4aIY7UGMsDDB9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141300; c=relaxed/simple;
	bh=dbHtgtjj1uiCpkKO0izFY5I6j7foesFHL/JsNithh3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUpiI7ZANwldTa4jxEXbIHKpbdhIBJbJYTdrhrJFrghAMkVRmloTNc2NKB+ODnYhck0pAYKTWVXYB5lUgi85WgOgXE2HB6CJwgfT2+5L8u0yThAq8AcIyVi4WBvD8W5KFVOp5Sy1mQTmr6A+9uvtvWEfoKs9jKM6ixHAZLTs+ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmhTVabR; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmhTVabR"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-661f8ea8a2bso5132786a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 04:14:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773141297; cv=none;
        d=google.com; s=arc-20240605;
        b=kWNgYoR3enKsbK8gEusJv9iLU2KLL38LoDr8dnHuuh+7iobT9p1NxzOiE8E7NYa9cJ
         42c4C7zNuIEZAGFuHSY2seaW0ORj4Nq5z/CIa6rKE/xO51I6jpe1vqWx/odzLaokFtRc
         u5IHGl92ANCPyCiU9EXcRbnev6kzS1i6AzzqquKxGH76MGSeyylQw6Mk2D0axg9B923Q
         YqlBjRM6cI2HOHDtiaJiQM39gBCawe7FZyB0tAx7OFN/BMzHMnpTQHCk8bCvByQLTskW
         mSIkF2ODabtkQ90f1yWvHKKqxVVKvA7fwxnzj+Ud9bTgriZqNNk0vAlpUHDXrGm+x2wc
         /KqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dbHtgtjj1uiCpkKO0izFY5I6j7foesFHL/JsNithh3U=;
        fh=lHDOyPk3whSDIo+2UHjBFvLwRQpiAOA5WqRCRSHQjGY=;
        b=lApLlfNgG3cPYsAkJ40+loYWts+gAkhAAWvb5KZmHsOrsxyMy+bO8zhmAOzk9eC3q/
         sZcDKENVi5WEHRYYDB9vgPiek3g1LnxgSqqiyKX1UEoWaQuxMiBpgBvZrEQ8HGasbO2Y
         Xu7inb9OM/fSx5d8JYEHrB7IFFujl+eOm6kWch/wEdrwc60WPv0/9voVX2GdGmPjfLBD
         fNgCtw9w4jSfjU3CdCoLemxeF/udb2X1/uJkygUvXCIxpAJkZUtcV++dsNfW+P9o2U36
         MM76fdeglZ3dlPH9H7+QSTRg6476Mj4U2W74PcX6zbGYZjDKzqJ/XTzYx26KHhisW60K
         ciNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773141297; x=1773746097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbHtgtjj1uiCpkKO0izFY5I6j7foesFHL/JsNithh3U=;
        b=cmhTVabRfcMrc4wSXFnp3OcwjLUjUzFFp1itpIDQLtUXsvzwjdIXq0+v0GG+hV9s9j
         fu11+h70q3XaFt2qM+Dk/QvzbQJyVHlHSlVlUK95JD/0O+pKckjeWtiPr1KH/FjCbtIt
         MCrQdBCH/CwlYlhg7siXxu3jqPeW9t4DgfqjWAjMHhXDtYzRiQNHdzrMWTtj5hU2G7Qa
         ZNd5y/GjKVbqAdIttKjAhyaNsBpzXavjSZq6x8SVBlOXzIbzjXlvtXqJahVR30r9ciCh
         wn2AozUI0qUrgRRZuhiyUXL0uA6hFsG8cj6sDmI+G7AveN6eprpzQm7W/X8LHB7QZ+hT
         GSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773141297; x=1773746097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dbHtgtjj1uiCpkKO0izFY5I6j7foesFHL/JsNithh3U=;
        b=J7R8fMvfh37+6hBjtqalF84madnRdrEwYpiUqHBGBZMFKiL0hAORyeNGVffe2Nf1/I
         GCEIf5Nvko4iuJgDsWIy8hQafjIRVfW57nS6FeeqwQM6ZXQrTSF8+w2KxhcaqO4u8gx2
         SyUBTgLsMsO4c86JMp0zuXwBifhDnNhlTw6wX7RNj7yjfz9RByqRWTHR5zcYQ9pyp07T
         n9PTMbMjiMXi+10uFea+Gsba0UtXS03SHjDZFVysSps3P767/3iS0hyXdnmgAH/NwEg9
         useLZnU2UgghrqkGu0fO6dsvtTnhYg5r3fZWx2qjq844mgVdUCxru6qDfnlVLNVyoy6m
         Hulg==
X-Forwarded-Encrypted: i=1; AJvYcCVEXPVuzWSXaIeHJMnSqgm7Eeb6YDWeaadVHMV8l1hRVUIOlUWnVlF1+mTjT08XEj4MDh4z5UNqC1piUGI/@vger.kernel.org
X-Gm-Message-State: AOJu0YzkqPdbGwy2r3W0yKJYX20yDhk/g+CBFkWPTfnmaOtZ2OXaCj4C
	rAxyC3f30tyzRSMPEuAZPA0O5MAPOdqCXDt3VG58W/XRE7w7DuwGqvIdt8PsmxQb4xgolcoMCro
	v/GZrNaZzGsGt8yOHrJGVlIA60bhpQXQ=
X-Gm-Gg: ATEYQzwbZrbz/rJXxzkaKDje6/P+Nwx4GRyQOlXS9OzT7YK4+D3IVtLgOaMtDywVDqg
	moXL3d/YdeyiTxtXuTCFGg+pfgmEuwiG0Ic7xp9IJyuUNnWjLIeUmPjGHUoawvjQwDgp1Q87htD
	2O1dbwZOhJMXfmpZ6q60QeEmClNG0IFdmB5gBt+PNjy0FICpCN0acKMTKc0ebC0HT6IVtNuhqcl
	40e/Eca7h9TJDsO+upS8/W+nWm65biAqh1XqGNuZM9kJaVOxkjrRtwNr3hWrtMNkyJtzGab6LNu
	dDnVyxIazOPdY/dEebjnxNg9gszV6mQCm0amiwBE4w==
X-Received: by 2002:a17:907:9810:b0:b96:fbeb:f791 with SMTP id
 a640c23a62f3a-b96fbec06cbmr326472066b.47.1773141296269; Tue, 10 Mar 2026
 04:14:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307110550.373762-1-amir73il@gmail.com> <20260309-einrad-mitarbeit-18397e65afd3@brauner>
 <CAOQ4uxgmttSum2a2gKBkpdzg4110rpaH4mayy=9+QzWjFRNB6w@mail.gmail.com> <20260310-inkompatibel-staufer-7c862857ac62@brauner>
In-Reply-To: <20260310-inkompatibel-staufer-7c862857ac62@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 10 Mar 2026 12:14:45 +0100
X-Gm-Features: AaiRm52y5lAAEAvon4UNdmu-oz74AEop0QTJY2p9s25yMxH4bm_VCMdHdlASpVw
Message-ID: <CAOQ4uxiXE3Ko60_Y6ZNmxkORjOFTCACR0PeTz51nZKWHMR=+og@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/5] fanotify namespace monitoring
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, Tejun Heo <tj@kernel.org>, 
	"T . J . Mercier" <tjmercier@google.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 11:31=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Mon, Mar 09, 2026 at 04:47:20PM +0100, Amir Goldstein wrote:
> > On Mon, Mar 9, 2026 at 1:33=E2=80=AFPM Christian Brauner <brauner@kerne=
l.org> wrote:
> > >
> > > On Sat, Mar 07, 2026 at 12:05:45PM +0100, Amir Goldstein wrote:
> > > > Jan,
> > > >
> > > > Similar to mount notifications and listmount(), this is the complem=
entary
> > > > part of listns().
> > > >
> > > > The discussion about FAN_DELETE_SELF events for kernfs [1] for cgro=
up
> > > > tree monitoring got me thinking that this sort of monitoring should=
 not be
> > > > tied to vfs inodes.
> > > >
> > > > Monitoring the cgroups tree has some semantic nuances, but I am tol=
d by
> > > > Christian, that similar requirement exists for monitoring namepsace=
 tree,
> > > > where the semantics w.r.t userns are more clear.
> > > >
> > > > I prepared this RFC to see if it meets the requirements of userspac=
e
> > > > and think if that works, the solution could be extended to monitori=
ng
> > > > cgroup trees.
> > > >
> > > > IMO monitoring namespace trees and monitoring filesystem objects do=
 not
> > > > need to be mixed in the same fanotify group, so I wanted to try usi=
ng
> > > > the high 32bits for event flags rather than wasting more event flag=
s
> > > > in low 32bit. I remember that I wanted to so that for mount monitor=
ing
> > > > events, but did not insist, so too bad.
> > > >
> > > > However, the code for using the high 32bit in uapi is quite ugly an=
d
> > > > hackish ATM, so I kept it as a separate patch, that we can either t=
hrow
> > > > away or improve later.
> > > >
> > > > Christian/Lennart,
> > > >
> > > > I had considered if doing "recursive watches" to get all events fro=
m
> > > > descendant namepsaces is worth while and decided with myself that i=
t was
> > > > not.
> > > >
> > > > Please let me know if this UAPI meets your requirements.
> > >
> > > I think this looks great overall and is very useful as it allows to
> > > monitor namespace events outside of bpf lsms. I agree with the
> > > non-recursive design. You could generalize this approach by deriving =
the
> > > watch from the namespace file descriptor? Then you can get notificati=
ons
> > > for all types of namespaces.
> >
> > Not sure what you mean?
> > Which type of notifications?
> > This RFC generates notifications for all types of namespaces created/de=
leted
> > under the watched userns.
>
> I misunderstood that part. Yes, that's really useful as is.
>
> >
> > Which notifications did you intend to watch for other types of ns?
> > DELETE_SELF?
> >
> > That would be easy to add.
> > Would just need to move the n_fsnotify_marks/mask to struct ns_common
> > (also from mnt_namespace).
>
> Yes, I was thinking about a way to monitor namespace destruction for an
> arbitrary namespace.
>
> >
> > >
> > > If we ever want recursive watches, then we just need to add a separat=
e
> > > flag. This is only applicable to userns and pidns anyway.
> >
> > Yes, if we wanted to.
> >
> > >
> > > I want to put another - crazier idea - in your head: Since pidfds are
> > > file descriptors and now have the ability to persist information past
> > > pidfd closure via struct pid->attr it is possible to allow fanotify
> > > watches on pidfds.
> > >
> > > I think that this opens up a crazy amount of possibilities that will =
be
> > > tremendously useful - also would mean fsnotify outside of fs/ proper.
> > > Just thinking on the spot: if you allow marking a pidfd it's super ea=
sy
> > > to plumb exec notifications via fanotify on top of it. It's also easy=
 to
> > > monitor _all_ namespace events for a specific process via pidfds.
> >
> > Anything's possible, but we need to make sure it's worth it.
> > Aren't there already enough ways to monitor a process via ptrace/landlo=
ck?
>
> Oh god, no. ;)
> ptrace() is way too heavy handed for usages outside of debugging tools
> such as strace and also has the downside that only one ptracer can be
> attached at any time. I have no idea about landlock but it is an LSM and
> I don't know why an LSM should have such notification abilities.
>
> fanotify on the other has no odd limitations and it naturally ties in
> with filesystem objects and with pidfs we've made processes filesystem
> objects. So I think this is a very natural fit.
>
> So you could just register a pidfd with fanotify and then get notified
> about exec events for that pidfd with arbitrary metadata attached to it
> if need. I've wanted this for a long time and one way I thought about
> going about this is by somehow plubming this into poll for pidfd but
> that's not going to scale as we grow more notifications events for
> pidfds.
>
> I think fanotify is the perfect fit for this with its extensible model.
>

I have no objection to utilizing fanotify beyond fs boundaries,
but if we do that, I think we need to carefully partition the event flags
namespace.

As I wrote in the cover letter, I see no reason for FAN_MARK_FILESYSTEM
watch to be in the same group (fanotifyfd) as FAN_MARK_USERNS or
FAN_MARK_MNTNS for than matter.

I would rather use something like FAN_CLASS_PROC classification
to explicitly say "this fanotifyfd is only for process/namespace notificati=
ons"
and in this context user would use completely different event constants.

OTOH, maybe it will be less confusing to add new syscalls
pnotify_init()/pnotify_mark() as a frontend to this separate class of event=
s.
If for no other reason, then because fanotify_mark(2) man page is
getting out of control ;)

> >
> > >
> > > This obviously needs some thinking wrt security etc but I just want t=
o
> > > put the thought out there that the integration of pidfds and fanotify=
 is
> > > possible.
> >
> > I was thinking more about watching the entire pidfs space, but sure.
>
> That's certainly possible too. Initially it would have to be scoped to
> global admin privileges but ultimately you could probably filter by
> credentials - if needed.

Or watch all processes in a pidns.

The leading rule is if the object (e.g. pidns) is accessible in
the context of the event, then we could setup a watch on the object.

Thanks,
Amir.
