Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9713A758C
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779438483; cv=pass; b=eo8oB3K8MRmU1/Om5JeFZ60L3FxMKJU1bsiOHnCNnMLcIbR9vHThL5/jJkUN0wuwmHgLG/DOIM60V7TUDhWeSIbZQrIXBqdynjayfApGAZd6OqutDFV+42X6qVYkR395QrqHRplNgMWC8H37DIV1GzFtKOnqWiuTqeRqSU6nyUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779438483; c=relaxed/simple;
	bh=7r2gBuMhM44NR+JK4St4QAFZrYtKOk/VaGQacEfJnKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQO7lBpTF/6+X8/3blC36cKniSPuHjC3LgEqml+NDN+cx5yP/N7/rP3MJRETrk5GYP6Yl3cgae1ZnaVo+Dw4WBy+cbEm5KYmDiA+Zjj88rY44UGuSTcVzd+iOIKqIF1BG6yhwVC6yrpAtMgRijDeaZBqHq8ssIVOdrZTeTbafXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=It8ZCXqt; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="It8ZCXqt"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-68719234fd8so4660550a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 01:28:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779438480; cv=none;
        d=google.com; s=arc-20240605;
        b=jg7f0NZfkXPAlKGTsd1GMZPnWovbShVP20Q2+z8afey4nC3XLgGsp1udpA9PfpUNyM
         lVeqQlq8Yx9qXHYrPCHtLNGCKksm/6bkuPaS9Q5rHWuf4rDFTmIMSrx5VAc0AFryORRP
         fpgBDHkSXpOyikRdfMi1RKCi9smCioFZ3O6au3MxS8GtAamYwrOfDagmPgJs/rM3FJeC
         rUmemI5whSKae10VTuaGAo2lMjYPFeZWNq9dRo5hVx8rZPnOQf8mzMuAO3QqLI29p12m
         0/IeoIdYIlSPsljXMPTgQVPlMTCIZHniLoNt3oqFDy/zBa8M9bkZf07RtF/R/SbFlNPB
         XS1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EmVNo6jDtJSjdQTOXTvmSBk7k2K9G5daWxUbreWjLMk=;
        fh=tV5LSC387lg4y5/r6SaN4BmWusfVxMUKrndMQrCXiiE=;
        b=fxELH/PXLLM86RF7acnxB4m/fVUyqWzo1BvWdykuLkRz8R0ZcvNYyyVa1c761ykERT
         OZhdVbgwMwB1BNO8otk8qYME5yGQuf0hoquyiSPvde2RycrUO3nAs7D3i7y7u7amlc5i
         YW5/VKfHFYCXoDTIn6Oz4x0Mo34oVqsU4r6xa4Cy0V+OC5BRVMVhqpiiqHfcCexkzjwx
         8jr4TQxmxJSxuebgeDKOH6GYlcHJ79+LLJ3ogI6Hk8RM/4XLzDaJy5Zi+erMrM2DlqJ2
         dpQ5RNJroOr8nm5vMrObMZUfoAyb0xCqXtNFI4lYXFr2TxIooGXkEGaUFfzA70zSKzyD
         iAmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779438480; x=1780043280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmVNo6jDtJSjdQTOXTvmSBk7k2K9G5daWxUbreWjLMk=;
        b=It8ZCXqthE46C/aiyLfXUhe2E0cMAiIEp3uDqWnO3hHIfdFJCJXq2za1WWGF3+f4QX
         SEC2WiEBt35htoxVKlF5Zux03L0Nx8+/3vYjdFOmOd+oAZhEFlf/hM2h6qeU4I3XUMDy
         URLxBGzBUy695CF2uPXMHgl3PJM/KKB1JfOmRw9Lc4FOt9eoAs/uPNYBmL8RvB7+JFWV
         GBmHszDlGBOPKchbL/zIPSs7JZRcC9KnCLWPdh2oiknIvADHjR/vSM0PILKaoDmvraPp
         uoyLUw68/eOMmiaD6DpRvPPWpXPOh4F7RDUL42Bv9CuUU/G//BXsU9SMdn3xFv/OSuhm
         LVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779438480; x=1780043280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EmVNo6jDtJSjdQTOXTvmSBk7k2K9G5daWxUbreWjLMk=;
        b=Cb9wuqfUjfYZgjm/w/npjGWUKVuLzBv97qACZLEmo9y/TvamEyT/l9DrzlDBFET7rE
         iB63Qbu2C1Y/ScVPtyxf/shbJ4hG+J0l/abfz7YpIyxF4ilBWcnMbNhkU3T1S4AlGGxI
         hxoLxHdRAZD28CVTv8HumuGvSgGAXPk7iOnitOtnN1Q+VguiS/EfZunqfb8UtJDfdIwh
         1YymQqQ0N0Xzft/KkbZ2FQwIlqBw1CYQpbE88GUl9yIu+OLwECQVCPCRANHywc7GxlSm
         BWoRceVMTsIp0IKhdyaTUEHY6vOo5EHFIwYbYorOepMW3NmeuNu8CxADO1mpdMiq8KeN
         4DOg==
X-Forwarded-Encrypted: i=1; AFNElJ9qWySQX2DyiZ1epdkvIBe9xctUDFgykehaXqe457HrFH6oIUh1LzLfVAm61lUSLPmSotMwc12iw3dVUhvC@vger.kernel.org
X-Gm-Message-State: AOJu0YzDA0EdlVrM1KPuW45C2Pxus9apdyKEEBGyztcNHnhvJmAJy5AI
	5b/vHlGupHqfpBAyck2BGlTH/xXG9uNEYtc9eC99D/mSxuZF14Gl4Zn9bDpb7haZKFMcNS6XVkr
	qImk82nkywR4GNw0CYuaojQIi9dWM06w=
X-Gm-Gg: Acq92OEBrhNzXy14cVylBmtiO2n8M1NmGHvpgTXKNoPSNBIveyBNe8lxglrRPbTAMP8
	OCY3mEUDYVgOGDVxeQDOpg07fm5NpJ33pN0lCT1HeB8d8XbMyC2oIPeJrI9unKiGqs230/CMuhe
	DWOLXridjzIF/EHgk1pO19Adtrp2n5FxBLnnI75O2id2WECEUJSOYzaDPyCJID8Ag2r2tl1ANK7
	y9JmvphOiSlRT+VACys+HgmoubJ81xho8afF3/7DW4tw8XbhuAd9+hwBQkYM+voTTQBmLg8uID/
	LQjzZ1Oj0A9NJUXHyUUJXGzGq89xdEU9r6gL/ea+ElzNYxS65CUd
X-Received: by 2002:a05:6402:34cf:b0:672:88a7:3885 with SMTP id
 4fb4d7f45d1cf-6889cc31c77mr1306011a12.18.1779438479681; Fri, 22 May 2026
 01:27:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514-limit-dentries-cache-v1-1-431b9eb0c530@ddn.com>
 <177906210551.3947082.4313294634549021141@noble.neil.brown.name>
 <bc359831-e653-4269-9d57-742b48d56d9f@themaw.net> <yk2hem4zwinm4glenpc74to7sm5kyriksgwn6mxh7t4saotiba@7zik7jcnbs5m>
 <b320ff9a-7f6f-44c3-940f-33f79cc5569f@themaw.net> <fglq7n2brxwdsu7and6nt6xpgdziua754yzgxkmd33pmk6tor4@noxa5ajva7wg>
 <27a5593e-ffb8-4471-996f-7983bac0b1ab@themaw.net> <CAOQ4uxg-7Tsb0GWF4LN3iFBaY7uGxR5_7PwBF+GfMWtCdfi4xw@mail.gmail.com>
 <177942337499.2234587.15757857859187727669@noble.neil.brown.name>
In-Reply-To: <177942337499.2234587.15757857859187727669@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 22 May 2026 10:27:47 +0200
X-Gm-Features: AVHnY4K58sqIeVhBw4bI2EZncNnFvHpby1N7jR9vtMSo_H_WSo0pNjJr7-Da8bg
Message-ID: <CAOQ4uxhJZkX+xLstoy_BcfoLt47xLxDFautG+MxLXc3jXsnxDg@mail.gmail.com>
Subject: Re: [PATCH] dcache: add fs.dentry-limit sysctl with negative-first reaper
To: NeilBrown <neil@brown.name>
Cc: Ian Kent <raven@themaw.net>, Jan Kara <jack@suse.cz>, 
	Horst Birthelmer <horst@birthelmer.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 6:16=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> On Wed, 20 May 2026, Amir Goldstein wrote:
> > On Wed, May 20, 2026 at 9:16=E2=80=AFAM Ian Kent <raven@themaw.net> wro=
te:
> > >
> > > On 19/5/26 17:12, Jan Kara wrote:
> > > > On Mon 18-05-26 21:39:13, Ian Kent wrote:
> > > >> On 18/5/26 16:19, Jan Kara wrote:
> > > >>> Hi Ian,
> > > >>>
> > > >>> On Mon 18-05-26 10:55:43, Ian Kent wrote:
> > > >>>> On 18/5/26 07:55, NeilBrown wrote:
> > > >>>>> On Fri, 15 May 2026, Horst Birthelmer wrote:
> > > >>>>> According to the email you linked, a problem arises when a dire=
ctory has
> > > >>>>> a great many negative children.  Code which walks the list of c=
hildren
> > > >>>>> (such as fsnotify) while holding a lock can suffer unpredictabl=
e delays
> > > >>>>> and result in long lock-hold times.  So maybe a limit on negati=
ve
> > > >>>>> dentries for any parent is what we really want.  That would be =
clumsy to
> > > >>>>> implement I imagine.
> > > >>>> But the notion of dropping the dentry in ->d_delete() on last dp=
ut() is
> > > >>>> simple enough but did see regressions (the only other place in t=
he VFS
> > > >>>> besides dentry_kill() that the inode is unlinked from the dentry=
 on
> > > >>>> dput()). I wonder if the regression was related to the test itse=
lf
> > > >>>> deliberately recreating deleted files and if that really is norm=
al
> > > >>>> behaviour. By itself that should prevent almost all negative den=
tries
> > > >>>> being retained. Although file systems could do this as well (thi=
nk XFS
> > > >>>> inode recycling) it should be reasonable to require it be left t=
o the
> > > >>>> VFS.
> > > >>>>
> > > >>>> But even that's not enough given that, in my case, there would s=
till be
> > > >>>> around 4 million dentries in the LRU cache and in fsnotify there=
 are
> > > >>>> directory child traversals holding the parent i_lock "spinlock" =
that are
> > > >>>> going to cause problems.
> > > >>> Do you mean there are very many positive children of a directory?
> > > >> Didn't quantify that.
> > > >>
> > > >> The symptom is the "Spinlock held for more than ... seconds" occur=
ring in
> > > >> the log. So there are certainly a lot of children in the list, but=
 it's
> > > >> an assumption the ratio of positive to negative entries is roughly=
 the
> > > >> same as the overall ratio in the dcache.
> > > > OK, but that's not necessarily true. I have seen these complaints f=
rom the
> > > > kernel but in all the cases I remember it was due to negative dentr=
ies
> > > > accumultating in a particular directory. There are certain apps suc=
h as
> > > > ElasticSearch which really do like creating huge amounts of negativ=
e
> > > > dentries in one directory - they use hashes as filenames and use di=
rectory
> > > > lookup instead of a DB table lookup and lookup lots of non-existent=
 keys...
> > >
> > > Umm ... that's a good point, I hadn't paid much attention to ENOENT r=
esult
> > >
> > > lookups, I'll need to check on the like cycle of those, I think they =
do get
> > >
> > > hashed. That has to be the other source of negative dentries that I'v=
e
> > >
> > > neglected ...
> > >
> >
> > Yes, it has been claimed that some real life workloads create a lot of =
those.
> >
> > If we can keep those at the tail of the children list, it will be best
> > for the fsnotify
> > iteration, which only cares about positive dentries.
> >
> > > >
> > > >>>> so why is this traversal even retained in fsnotify?
> > > >>> Not sure which traversal you mean but if you set watch on a paren=
t, you
> > > >>> have to walk all children to set PARENT_WATCHED flag so that you =
don't miss
> > > >>> events on children...
> > > >> Yes, that traversal is what I'm questioning ... again thanks.
> > > >>
> > > >> I think the function name is still fsnotify_set_children_dentry_fl=
ags()
> > > >> in recent kernels, the subject of commit 172e422ffea2 I mentioned =
above.
> > > > OK, thanks.
> > > >
> > > >> When you say miss events are you saying that accessing the parent =
dentry to
> > > >> work out if the child needs to respond to an event is quite expens=
ive in the
> > > >> overall event processing context, that might make more sense to me=
 ... or do
> > > >> I completely not yet understand the reasoning behind the need for =
the flag?
> > > > Close but not quite. The cost is the overhead of dget_parent() in
> > > > fsnotify_parent() which is often a couple of cache cold loads and a=
tomic
> > > > instructions to find out we don't need to send any event for the cu=
rrent
> > > > write(2) or read(2) call. It gets worse if there are many IOs happe=
ning to
> > > > dentries in the same directory from multiple CPUs because instead o=
f
> > > > cache-cold loads you get a cacheline contention on the parent.
> > > >
> > > >>>>> But what if we move dentries to the end of the list when they b=
ecome
> > > >>>>> negative, and to the start of the list when they become positiv=
e?  Then
> > > >>>>> code which walks the child list could simply abort on the first
> > > >>>>> negative.
> > > >>>>>
> > > >>>>> I doubt that would be quite as easy as it sounds, but it would =
at least
> > > >>>>> be more focused on the observed symptom rather than some whole-=
system
> > > >>>>> number which only vaguely correlates with the observed symptom.
> > > >>>>>
> > > >>>>> Maybe a completely different approach: change children-walking =
code to
> > > >>>>> drop and retake the lock (with appropriate validation) periodic=
ally.
> > > >>>>> What too would address the specific symptom.
> > > >>>> Another good question.
> > > >>>>
> > > >>>> I have assumed that dropping and re-taking the lock cannot be do=
ne but
> > > >>>> this is a question I would like answered as well. Dropping and r=
e-taking
> > > >>>> lock would require, as Miklos pointed out to me off-list, record=
ing the
> > > >>>> list position with say a cursor, introducing unwanted complexity=
 when it
> > > >>>> would be better to accept the cost of a single extra access to t=
he parent
> > > >>>> flags (which I assume is one reason to set the flag in the child=
).
> > > >>> The parent access is actually more expensive than you might think=
. Based on
> > > >>> experience with past fsnotify related performance regression I ex=
pect some
> > > >>> 20% performance hit for small tmpfs writes if you add uncondition=
al parent
> > > >>> access to the write path.
> > > >> That sounds like a lot for what should be a memory access of an al=
ready in
> > > >> memory structure since the parent must be accessed to traverse the=
 list of
> > > >> child entries. I clearly don't fully understand the implications o=
f what
> > > >> I'm saying but there has been mention of another context ...
> > > > Parent dentry is of course in memory but often cache cold - you don=
't need
> > > > the parent to do e.g. write(2) to an already open file. You seem to=
 be
> > > > somewhat confused about the child dentry list traversal (or maybe I=
'm
> > > > misunderstanding) - that happens only when placing the notification=
 mark
> > > > but definitely not for each IO operation.
> > >
> > > LOL, confusion is a pretty common state of mind for me!
> > >
> > >
> > > I do get your point though and I am confusing the traversal with othe=
r
> > >
> > > operations. I think this answers the question I've been asking (maybe
> > >
> > > that wasn't obvious) about the reason for the traversal (ie. the reas=
on
> > >
> > > to maintain a flag in the child).
> > >
> > >
> > > While I have looked at the code here I haven't absorbed it and I
> > >
> > > definitely don't understand it, your continued patience is appreciate=
d
> > >
> > > and will be beneficial when I get time to look at it a bit closer. I
> > >
> > > do still need to use a notifications mechanism to match up with Miklo=
s's
> > >
> > > statmount implementation to get the full benefit of that in user spac=
e,
> > >
> > > if I ever get a chance to work on that again.
> > >
> > >
> > > So it sounds like it would be worth while considering a traversal tha=
t's
> > >
> > > based on taking a reference on each dentry rather than a spinlock for
> > >
> > > the duration. It would be tricky though, for obvious reasons, like
> > >
> > > children added during the traversal, added overhead of getting the ne=
xt
> > >
> > > entry reference, etc.
> >
> > Didn't look closely, but it feels like RCU traversal should be
> > possible if entries are added to the tail, or to the END_OF_POSITIVE
> > location.
> >
> > When we discussed the "negavites at tail" at LSFMM
> > it was said that managing the transitions positive<->negative
> > would be challenging, but I don't know that anyone tried to look closer=
 at this.
>
> I had a quick look.  Most users of d_sib walk from the parent->d_children
> with the parent ->d_lock held, so they shouldn't notice a movement in
> the list.
> The two exceptions I could find are d_walk() and the readdir code in
> libfs.c.
> I think the main problem case would be if they were holding a dentry as
> a cursor which transitioned when the parent d_lock is dropped and retaken=
.
>
> d_walk already needs to cope with a concurrent rename messing with
> its cursor so possibly something similar could be used to trigger a
> restart.
>
> libfs readdir walks from a DCACHE_DENTRY_CURSOR which will never
> transition and so won't move spontaneously.  That is exactly as safe as
> walking from the parent.
>
> So I think d_walk() might need some help to avoid getting lost.  It could
> probably simply check if its cursor changed ->d_inode between dropping
> ->d_lock and retaking it.  If it did, then restart.
>
> It isn't clear to me that we can track a "end of positive" location.  I
> think we would need to move negatives to the end and positives to the
> start.  Can you see a down-side with doing that?
>

One of the intentions (that may be lost in this conversations) was to
avoid holding the parent inode lock over the entire children iteration in
fsnotify_set_children_dentry_flags().

This function only needs to go over all positive children.
That's why I thought about moving new positive to the end of positives.
Maybe this works if we keep positives at tail and negatives at head
and also have dentry shrinkers work on the negative dentries at the head
first.

Possibly, we can make sure to set DCACHE_FSNOTIFY_PARENT_WATCHED
if needed when making a dentry positive, to avoid some races.

NOTE that DCACHE_FSNOTIFY_PARENT_WATCHED can allow false
positives. It's an optimization flag that is auto cleared with
fsnotify_clear_child_dentry_flag() in case of false positive.

Also, it is possible to set DCACHE_FSNOTIFY_PARENT_WATCHED
*before* dentry is made positive, for example on start_creating()
because whether a negative dentry has DCACHE_FSNOTIFY_PARENT_WATCHED
or not is insignificant.

Thanks,
Amir.
