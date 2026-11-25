Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795628375;
	b=UHjU1b2+bDRG89b8NqSh6Q42pTdB6tQAEdyVAM+BCzMPMjjKGLt1T8BNja3Z/iq3Fag+
	 lrN3IuratFJZ8BPbcpfMbI9dlHzqlzuI7G5ddalTAfTcDe42aIaASunL7RO4TRK95Lejq
	 D8BfiIWtDXoMhzUsbp/q/8mQNMyqmuQWyu/pJsFXWkgROuawkxL9SsDXDcc01S7D5SM0t
	 vFOcf0DRwKz0ErwEu7k0ynVBL1Wr+7RxJIgcg1cB1Du5tE9jBgkKHG/dfbMrsstG7S91G
	 4K0EhpyMS1KFzrc8YfqHhF8Ivs3cNV3PSeETVZ01HbbZKwClFlTNwdRvMV5s0yWsycA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628375;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=EOXTnO5Bxuk6rnfTBGwAa59VOdHMQdutSkTfsVAhh8E=;
	b=U8vh7PVO3gQw76JPPFMKFh9mC4N/0z708qkHAwbdul2UZGPeCexbMs6AD3TxAWpX7I5f
	 qqbr6+Uy82g314uoRe8yjWJ/OvCQNxZ/2RbRme093gCvB6/dddyWyOQR1dS7jovZ9Own4
	 nzpkb904W8kA3+y8yR737/fxfr3LhV3VJti8YA4YDNUqNZGdpPTYZO+Vzt22LcyQFfsqk
	 J1BUPyF35QgbV+yTriRCG7R0f3avqH1izSwIev3iPkDUx6gHBNZZZYKOPJvCe7dYYb+yp
	 SA3Q1pXY2C9mSXoqTZFzt+SvWj/xA4ZpprnD9uZleprgSHiuzliHdR9RcdPKrOmdlBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=txZbvkhN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3426606A321
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 17:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3426606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=txZbvkhN
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b8a1f59d5eso7971969a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 09:39:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795628373; cv=none;
        d=google.com; s=arc-20260327;
        b=YPCO397je1sAkT6/Yvf4/ZIYSl5tmQbPy785xEcCFkqBcu0JKQTaQFvBoHHUYCNwIp
         +z55mgbjepMYeFQTmcpO1NWC1HgnXOZ2q1vu3qX5Bp7u+4sbsUWyZlrcwJgl0yNCISBE
         NAKarnvBPhKGgVGecd50mfE0ouKIoAATxJCLUdCk0kCFjmotbcjz0mY9AHUoUlfJh1Zh
         +1sywvagu35excyFwENNhnrG9IpD87I2d3t0nkazNLHmMYp3AaAdkjpLIRFre9fFeC0J
         lD6XBAlujLCbrrxkful2cEx30wItTBoKFWqqEaVZRqZWTTJZOq3V5ZLPC8TrYJCh2YFg
         fLOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EOXTnO5Bxuk6rnfTBGwAa59VOdHMQdutSkTfsVAhh8E=;
        fh=Pp01Vtlr9LwTo6Ldt9EioUgalINqKY3yNWOHZBteFoc=;
        b=Uh/bd8xvoA3ot/lMCPzp8mcFHBrg1HRBDnRE5kIWGnBmQHUUZOgy/MCP08ENeSEifT
         wRmrzxvHSp85jr0svYSHTpSQls5klY8Wcf4swZVWPi4anoJ9JuozVfnI/jAPaKgHLThA
         fNeZ9Xaup5M2ByPDMBiGmQvMUnvGKqyUF+7XVKdxBRkkMRZ6I96oGLT7qvaWY97wJZcz
         JZaO3OyhqmK3M5zB/0P/cQteo5mMeVAYC29Xc+crZv3dD+/HT61yqxZ6jBH+/zh3BPk2
         eV4vmA//ti3xBYsYb+Yhh9+na80dhhC9Fkhl5kkpL3pxTXcN/QIuS+PoWwIwj05Vjg0M
         pvtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795628373; x=1796233173; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EOXTnO5Bxuk6rnfTBGwAa59VOdHMQdutSkTfsVAhh8E=;
        b=txZbvkhN3j2tiIdhSd2v4u+ugf0j142saCBfHlWXU7WJHkjuKzOm/tSLulPI47OuZr
         k+yiScOKxj27Vq8FkmtuwfktQInjof81S31Sg0WVq6+uWhdLHbkybzSa+e0bI21mDDG0
         jQ2XEd3YBH+maTftST1mjTzpg02sWmo4mzYcXGfnoem+hL6tdAXgnOk/jYdbKGfpcZn+
         UuuerISCFc7ioJhtwWIsq7HI1BgpihgFUZsguwVU+llbKxjl/G+XuQDlOEpVlw3R6dg1
         zcX+sonGlBwz35gXlQzLdOUYwNph87cW20+qiG1VKbUWAitRayprTj4brawGC0lrKBpv
         lmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795628373; x=1796233173;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EOXTnO5Bxuk6rnfTBGwAa59VOdHMQdutSkTfsVAhh8E=;
        b=VAi9T0eY7Cp1S62aIHgVlZ2yh3sIEskyrGwF6z+wN0yOA24PjhZX5BMQhtqZl+mRXa
         w0mh4gALgtKcy6gWCYB3/XtUGSQlrD6DWkxwxqWFWe0ijCOc9/osjeUyiTv4hT1I+iJG
         Z+F+jrdX9Utv7X5ofgIUxbmdsIK0xmkeCH25nW7xE0JyetDo0E/6xx/+7l+5+hhuAM7Z
         T1CnJKkuPuKwgvSVEW99ulacOR80TnYbePqQ1qdY0/O/4mRMcTipfXsyCn+e3Cp/l5E4
         YaDb0ELEdW4JSxnrGnx65DvrO1t+7JXP2qlTEZHBDGos1st/7gssvzQBIx32ZoFZ7S4B
         +/Pw==
X-Forwarded-Encrypted: i=1; AL+hErGM+fyO43Xs0G1kDALnXpBbHmn8VE1A9VCS13hj424YBhcvs7qk3KmoBb6Sm0RCssqH9nXNRNOEzixKdPno@vger.kernel.org
X-Gm-Message-State: APuU4Z/vqHM0R4JnROEnorRqSpw02Jj4rXnho3WpXCdGTKilAqgw/Wj0
	LKOyzqKz4yKMsWOUy9wUnMX0sZ0UX174aoghsbHtKL5F+8PGuevRVdiwI+pdnwfJdFhMgeq/Uq7
	JUfF+veiBdDIBDN6D7U3xvVmusD285XU=
X-Gm-Gg: AZFdTZev0n1Aw2SJxynpBoRpFJmMy+jEeLVC9NDcQlW2sVVZH2nusNyCKElRqLBA0jk
	sfTAYrDvxeblfowhxbhlvnfjgg8ZHzSCoFvNiMuSGakg1JvASHvwPkx0FRtojGyxl3wzKGjIl/r
	788pYlDXs6XlaVcHOtgbqg+JM+iElR4ABCsUjBzIUXvsP66QqhYCauLDrNYpxfxCzAW+KBKJZBl
	fWVqDTsq+6ka7rImZNK92ZALpJf38lb0+tFBmI0FVo+/Q0FpmCalqy99Hmb/W3ks0x7D37KozPz
	m9Q8XgnrPtKePug9HpjDkUHAN5e9AJRlMi3r9nMwuSZ0dvDmLQm68pyDPL+SlBPzE/B7Je/f08R
	5sOP/BlB1qyhSVfg1ijCVNluicg3s+g+bd0eHG/QUBylljkNgsP57eNMDhA1UR+7WYwQ78CW9xF
	Rm4bKbfLljwmPZwH0=
X-Received: by 2002:a05:6402:15d4:b0:6b7:709f:85f with SMTP id
 4fb4d7f45d1cf-6ba37ec031amr10700652a12.36.1795628372883; Wed, 25 Nov 2026
 09:39:32 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123221410.3328780-1-neilb@ownmail.net> <179550252639.1728055.4014817916838632741@noble.neil.brown.name>
 <CAOQ4uxgF6=QoD9RoAOPmxtvkq1jWf+gG1AsJzR=Kt3ROMA=X0g@mail.gmail.com>
 <aau5z6kck6a2efcjvzrt6gno6ljs4eioncgizeh7vfbc6ipkr3@hjxzdk5pvgmt>
 <CAOQ4uxjXP4Zegb2Vgsv-yBeFmhvc8FT2bDKDcaM_t0=oJ5KpXQ@mail.gmail.com> <sc6xnwguimy23dexr3eosbe64xmmewn5ml5gso4m5xozw6fqlt@2hji64vi7eaw>
In-Reply-To: <sc6xnwguimy23dexr3eosbe64xmmewn5ml5gso4m5xozw6fqlt@2hji64vi7eaw>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Nov 2026 18:39:20 +0100
X-Gm-Features: Aa3M54p0yQAs_ZPRugioiFUuwGcSeWEd2MMo5NujtG6aZBdyocbVJc3EK7LYRCs
Message-ID: <CAOQ4uxisP8YTUaexsXw4-Fxg0vand236cg5eDKirLm=kuDwSQQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Fix easy bits of the negative dentry problem
To: Jan Kara <jack@suse.cz>
Cc: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>, Jake Edge <jake@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 12:34=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 25-11-26 08:46:45, Amir Goldstein wrote:
> > On Tue, Nov 24, 2026 at 5:26=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Tue 24-11-26 14:08:07, Amir Goldstein wrote:
> > > > On Tue, Nov 24, 2026 at 7:42=E2=80=AFAM NeilBrown <neilb@ownmail.ne=
t> wrote:
> > > > >
> > > > > On Tue, 24 Nov 2026, NeilBrown wrote:
> > > > > > This v6:
> > > > > >  - fixes the autofs changes in 1/5
> > > > >
> > > > > Sashiko says this is racy.  I think it is but the original code w=
as just
> > > > > as racy.  Maybe the race isn't relevant.  I haven't properly unde=
rstood
> > > > > it yet.
> > > > >
> > > > > >  - updates d_duplicate() in 1/5
> > > > >
> > > > > The fix was seriously broken.  Sorry.
> > > > >
> > > > > >  - uses a new version of 2/5 from Amir
> > > > >
> > > > > Sashiko has something to say about this
> > > > >
> > > > >     Can clearing FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN and dropping =
conn->lock
> > > > >     before fsnotify_set_children_dentry_flags() finishes allow a =
concurrent
> > > > >     watch-adding syscall to return to userspace before the childr=
en's
> > > > >     DCACHE_FSNOTIFY_PARENT_WATCHED flags have been set?
> > > > >
> > > > > Thoughts?
> > > >
> > > > Sashiko is right, but this race is not new.
> > > > The same window exists upstream: if another thread's recalc observe=
s
> > > > the 0->watching transition and does the walk, fanotify_mark() can r=
eturn
> > > > to userspace before all children have DCACHE_FSNOTIFY_PARENT_WATCHE=
D set.
> > > >
> > > > What changes with this series is that the walk is sleepable, so the
> > > > window is longer, and in some workloads it could go from rare to
> > > > plausible. OTOH, skipping negative dentries may shorten the walk.
> > > >
> > > > The more important question is whether a child can be left without
> > > > PARENT_WATCHED permanently. Upstream it can: the transition can be
> > > > observed by a recalc from the mark destroy path, which never walks.
> > > > With FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN that cannot happen.
> > > > Every transition sets the flag, and every caller that can add a wat=
ch
> > > > consumes it,
> > > > so a walk that started after the transition always runs and fixes t=
he flags.
> > > > What remains is the transient window above.
> > >
> > > I agree this is preexisting issue. Let's not block this series with i=
t.
> >
> > preexisting, but sleepable children walks could make an
> > improbable race actually observable, because the scans are not
> > serialized and could take longer (I don't know how the scheduler
> > treats a dying process which has its marks removed).
> > Just wanted to make sure that the point is clear.
>
> Yes, the window can be larger now but it still shouldn't be a practical
> problem unless there are several watchers placing marks on insanely large
> dir in parallel. So I think we can live with the race for a while longer =
:)
>
> > > > I think a proper fix for the transient window needs a sequence coun=
ter
> > > > of scans in the connector. Each caller would wait until a scan that
> > > > started after its transition has completed, no matter which thread =
ran it.
> > > >
> > > > I think we can live with this v6 patch for your series and deal wit=
h
> > > > the remaining race later if we want to, but I am not sure and would
> > > > like to hear what Jan thinks.
> > > >
> > > > If you want, I can implement the sequence counter for v7.
> > >
> > > No sure what exactly you have in mind but a sequence counter per inod=
e
> > > looks like an overkill for this. A global one can get contended and
> > > a bit hairy to manage but let's see...
> >
> > I had a patch with another conn flag _CHILDREN_WATCHED
> > set at the end of the walk, which covers the Sashiko race, but
> > leaves some other corner cases (see below).
>
> Yes, I was also concerned about those races when thinking about that
> yesterday. Let's discuss below.
>
> > Are you concerned over the size of the mark connector?
> > I think that connectors should be rare and scarce.
>
> Yes, I was concerned about the size of the connector. On a second thought
> I tend to agree it wouldn't be a huge deal if we need it.
>
> > With workloads that frequently add/remove watch,
> > Sleepable children walks could cause a situation where
> > scan that started a few add/remove cycles ago complete out
> > or order with the most recent walk.
>
> Well, let's discuss the behavior of the walks and the flags. I imagine we
> could have two bits like _UPDATE_CHILDREN and _UPDATE_CHIDREN_RUNNING.
> When children flags need update we set _UPDATE_CHILDREN. When we see
> _UPDATE_CHILDREN set, we call fsnotify_conn_set_children_dentry_flags().
> That function checks _UPDATE_CHIDREN_RUNNING. If already set, it waits fo=
r
> it to get cleared and returns. If not set, it sets _UPDATE_CHIDREN_RUNNIN=
G,
> does the walk and clears both _UPDATE_CHILDREN and _UPDATE_CHIDREN_RUNNIN=
G.
>

Yeh, I think that mostly works, with a minor variation.

If the RUNNING flag is already set, the function waits for it to get
cleared and then checks the UPDATE flag again.
If the UPDATE flag is set, it clears the UPDATE flag, sets RUNNING
and starts the walk. At the end of the walk it clears only RUNNING,
so every time UPDATE is set, a walk starts after it.

Anyway, serializing the walks per inode is a positive outcome
and better for our mental model.

> > Only the completion of the most recent walk can guarantee
> > that all the children dentries are watched.
>
> So I don't think that's an issue. Look, if someone places a mark which
> watches children of an inode, we either end up updating the children flag=
s
> or we wait for _UPDATE_CHIDREN_RUNNING to clear. So any mark update from
> userspace blocks, until the children walk is done and then they all retur=
n.
> We hold the group lock during the wait so the mark that makes the parent
> watch children is guaranteed to stay attached to the inode and subsequent
> mask updates on the inode all result in the conclusion that children are
> watched (so fsnotify_parent() doesn't clear the children flags while we a=
re
> still walking).
>
> One catch in the above argument are oneshot marks for inotify & dnotify.
> Inotify is actually fine since it grabs group lock when removing mark aft=
er
> the event was sent (so the above argument holds). Dnotify doesn't grab gr=
oup
> lock when removing oneshot mark and so breaks the argument. I think we
> should just make dnotify grab that lock to make our life simpler.
>
> Thoughts? Counter examples?
>

My thought is that this makes my head explode..
I rather have a simpler mental model if possible, which is less
dependent on all the callers and other locks.

I think there are some corner cases, where a false
"parent is watching" state is caused by combination of
FAN_OPEN on one fanotify group (not watching children) and IN_CREATE
on another inotify group (watching children but not with events possible on
children) but I can't reason about the exact consequences.

Thanks,
Amir.
