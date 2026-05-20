Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612493A382A
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779270219; cv=pass; b=ZgYq8/trKYsJ9zcN1nLyGgFqsDQt9X9Lu0JE7avfuloYUu2hG6OpBNv7MdS/aB8QQma0UJ3wAyVyFYs1Y5yRyCOtSEh6tOyfCsG1VXfQlCjqE+VAssnlGqX98m6a+OR5L/9D5PogwbkTMB28Ws+cAuDACyosoEdLSQPJ7oeEPX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779270219; c=relaxed/simple;
	bh=JmrG1Jn9Av/Kvwr6coyxrV52OlkLrMbkrLR5Y/uQygA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MyNjVfgIboOpCKL2b6CWbzCGwYxLQi7V1fqv8uamlibE4EUT2N6Ja6DVUdMvcB97SS7qHSLcEYDGW1D1h5pdystrC7Gi0pXq8dvMELvIMyfDtUH/tuoSv0DIHMHxaBgig8inrEO9TGZWndW1OyBmlD1MrMAuY5Bi9Mk9IdsczMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzO0GplW; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzO0GplW"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67be871ed3fso10384536a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 02:43:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779270213; cv=none;
        d=google.com; s=arc-20240605;
        b=ezcq21nJSprD6+qFTmrkkweIohDMUNS02YwtK5dAV0FQOAegj26rAj0X3PSD6Py9eB
         D99tOjL+zPTnAQ903+9wqXgTYcq9U+osy92A4uyfz0kdGdFWNv2HSsDf7X6yfGAr5Kjb
         IChLGcXdEsdM0vIyDwtszKGNcTiOpFkL8hv+9zNaePMZ1JcOi2Z9PCpSzI4Z6TeCpIHT
         8Z/jT6MsqZXq3pt1AzUK7BFTm9f/41jDyCqFLdh4RcfhTmmMT9VISib5JY2B0QypIEdR
         KWuJzTJuvCjdAdDzMXasYYIAQskQuPPYSqiDfj07fOBa0zvOJ8Pd9f6OX4USbEWInahD
         CIrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vNvYpo8HmpaTLe7ddYRUxenBW8BmMG2NProsDhdfr4s=;
        fh=go7So7Tem27t/HDCWdqYWklL0qhB4sQ4Liwg5EZwJGM=;
        b=T42UT3dLtrZev/dMFUN+Rj7rKDPwFH1XPvbvWbFU421LJcU6bd6M/MhLa46kOTdp7F
         yI8DXYvnYlwrjoPztxBhyw2ofBPZpgVO0nw2BODRsIUIhtVtt1/HXVgG8k5T9F+Ova6L
         7MpFg14ZycLwya/GaNiCzCoMBINWFJUL8IhbFj67gRhqPkWzGao34FjZuPT8gilH8cqF
         c+VfJRm/GGSfx6JTTg2PxVmI6KUgSR7xj7WwyVWxjHQh/UKnSOmIKJLTvC0P9TDWquvQ
         nK/6yyKaA75Gz+Zb9+3WnyMn6eIDZMOdU6YCxUjQM3BZZlKoKoq8M1Twpm1FDFYHVCNu
         Grzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779270213; x=1779875013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNvYpo8HmpaTLe7ddYRUxenBW8BmMG2NProsDhdfr4s=;
        b=IzO0GplWp8mpG3wASYVPAVk1EFC37F3LcEP0QW8lZ6Ng45wHZ80fqAxFE8kSc0dZaR
         GVfVEF5/BJv/pMuUIcv3ItgfLnQuuBgnKmjVyhlhIeztl69YK99olRtnXSEq5AgGAeJ2
         p13X0jF3Tp3/GqPmIJcG/iNmuRu+Byi2Fo5Ie9yu9fRDcKru31IU5KLkaS0fef4/0oTu
         cMJB0lXHJgk71cbvm5GqvEkbTutxppfWiLltrs2Ax6gBj5zQ9O1WI5pQLDYyigVOEOmZ
         NlNFhSM+yI3A9Ezm2uqa0uoB05fZlygAK6LepPphfuC8fuPbiTws/RieDqn6rEGncCxA
         kFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779270213; x=1779875013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vNvYpo8HmpaTLe7ddYRUxenBW8BmMG2NProsDhdfr4s=;
        b=oc5SafexzJB9bs2XsUj6eGo+iwQOaq6SkKyl9lTxFh3iCGy8hMjTgEtnCuiHO6E1BI
         +tbyb2L+/8BjQRdbbc/U1MCqJtDPgG820puQ/lyQDyTU8ZWai+xR87UO3N/Zt8HhpXoI
         AwmuIY+l5eIc/ck1mkeuLA5Ee6s+j+dAIM2Ctc79NOEIuCKojDMIxXHSl94qyUwmoSBG
         j2oS3M2GS5OZQp0/00BWZSCr1agN2xQTsHfy/LTso3+sy/x2db//LzJc6YfwPA3Kh5Ct
         GxFEqSmgA5xUci5VQlJ7AjmoNMUToUrvjvcrUHa4hgpTWgHh+ta1k3wUiTk5iQF65zR4
         RRWA==
X-Forwarded-Encrypted: i=1; AFNElJ9qDSoUw7Om+zVLL6KH6E1iOfdUliNWkhqQjLGXC6OrdLQ3v2/Nk4uOyYYpcmncXX7+qukotFE978PXCOrp@vger.kernel.org
X-Gm-Message-State: AOJu0YwyspfXFXSiWwKqNJBUMzQKmBdKAhittxgxvBSn0FopfNV6NryT
	V4UX3RHgW4ZGjzZOELAsCxyUyizDeq0ANprG5EefWmMgmop6ZlOV9lC3dNRWj05f0SGplevghYt
	b8OeWVrHY62g2xU5j5G5VCSLN5WlBa/8=
X-Gm-Gg: Acq92OG1kykTi0/4o7FcqHVx2zVpbScyH0LFDrc2PkMnANDnuTSy9fCOkHR0uU6nYj4
	fccGwleHlU3q/saLrnACWg5vVoXkaot/lmDNPRRrq65Qq4G046/dIQMBXzfnhocNycEJv4x2xT/
	P2MTQpbxIyBYFacZRyRcnHoyOshmjNOnqiRPdOwnSWhnOfxaIcVMBimu+zxMmbnUZpu7lvfKOKS
	NWEc48GeEU/o4BgYGdoNZtxM+n0jWCc4l1mm30km/QMIy5SdJDPMvToUM9dsNvIjd5CCwhWiX2P
	Ij2HUmPCHdXABMuK0zzxgOq1ETs2uvXkD1xnFAw9cQ==
X-Received: by 2002:a05:6402:c42:b0:683:bdd8:819b with SMTP id
 4fb4d7f45d1cf-683bdd884d3mr11965323a12.25.1779270213291; Wed, 20 May 2026
 02:43:33 -0700 (PDT)
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
 <27a5593e-ffb8-4471-996f-7983bac0b1ab@themaw.net>
In-Reply-To: <27a5593e-ffb8-4471-996f-7983bac0b1ab@themaw.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 20 May 2026 11:43:21 +0200
X-Gm-Features: AVHnY4IdwSREOJlVozKHc6xuyOK40K4TP9sO6LFO_4dXGmxFef9s6c_InYrxjic
Message-ID: <CAOQ4uxg-7Tsb0GWF4LN3iFBaY7uGxR5_7PwBF+GfMWtCdfi4xw@mail.gmail.com>
Subject: Re: [PATCH] dcache: add fs.dentry-limit sysctl with negative-first reaper
To: Ian Kent <raven@themaw.net>
Cc: Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
	Horst Birthelmer <horst@birthelmer.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 9:16=E2=80=AFAM Ian Kent <raven@themaw.net> wrote:
>
> On 19/5/26 17:12, Jan Kara wrote:
> > On Mon 18-05-26 21:39:13, Ian Kent wrote:
> >> On 18/5/26 16:19, Jan Kara wrote:
> >>> Hi Ian,
> >>>
> >>> On Mon 18-05-26 10:55:43, Ian Kent wrote:
> >>>> On 18/5/26 07:55, NeilBrown wrote:
> >>>>> On Fri, 15 May 2026, Horst Birthelmer wrote:
> >>>>> According to the email you linked, a problem arises when a director=
y has
> >>>>> a great many negative children.  Code which walks the list of child=
ren
> >>>>> (such as fsnotify) while holding a lock can suffer unpredictable de=
lays
> >>>>> and result in long lock-hold times.  So maybe a limit on negative
> >>>>> dentries for any parent is what we really want.  That would be clum=
sy to
> >>>>> implement I imagine.
> >>>> But the notion of dropping the dentry in ->d_delete() on last dput()=
 is
> >>>> simple enough but did see regressions (the only other place in the V=
FS
> >>>> besides dentry_kill() that the inode is unlinked from the dentry on
> >>>> dput()). I wonder if the regression was related to the test itself
> >>>> deliberately recreating deleted files and if that really is normal
> >>>> behaviour. By itself that should prevent almost all negative dentrie=
s
> >>>> being retained. Although file systems could do this as well (think X=
FS
> >>>> inode recycling) it should be reasonable to require it be left to th=
e
> >>>> VFS.
> >>>>
> >>>> But even that's not enough given that, in my case, there would still=
 be
> >>>> around 4 million dentries in the LRU cache and in fsnotify there are
> >>>> directory child traversals holding the parent i_lock "spinlock" that=
 are
> >>>> going to cause problems.
> >>> Do you mean there are very many positive children of a directory?
> >> Didn't quantify that.
> >>
> >> The symptom is the "Spinlock held for more than ... seconds" occurring=
 in
> >> the log. So there are certainly a lot of children in the list, but it'=
s
> >> an assumption the ratio of positive to negative entries is roughly the
> >> same as the overall ratio in the dcache.
> > OK, but that's not necessarily true. I have seen these complaints from =
the
> > kernel but in all the cases I remember it was due to negative dentries
> > accumultating in a particular directory. There are certain apps such as
> > ElasticSearch which really do like creating huge amounts of negative
> > dentries in one directory - they use hashes as filenames and use direct=
ory
> > lookup instead of a DB table lookup and lookup lots of non-existent key=
s...
>
> Umm ... that's a good point, I hadn't paid much attention to ENOENT resul=
t
>
> lookups, I'll need to check on the like cycle of those, I think they do g=
et
>
> hashed. That has to be the other source of negative dentries that I've
>
> neglected ...
>

Yes, it has been claimed that some real life workloads create a lot of thos=
e.

If we can keep those at the tail of the children list, it will be best
for the fsnotify
iteration, which only cares about positive dentries.

> >
> >>>> so why is this traversal even retained in fsnotify?
> >>> Not sure which traversal you mean but if you set watch on a parent, y=
ou
> >>> have to walk all children to set PARENT_WATCHED flag so that you don'=
t miss
> >>> events on children...
> >> Yes, that traversal is what I'm questioning ... again thanks.
> >>
> >> I think the function name is still fsnotify_set_children_dentry_flags(=
)
> >> in recent kernels, the subject of commit 172e422ffea2 I mentioned abov=
e.
> > OK, thanks.
> >
> >> When you say miss events are you saying that accessing the parent dent=
ry to
> >> work out if the child needs to respond to an event is quite expensive =
in the
> >> overall event processing context, that might make more sense to me ...=
 or do
> >> I completely not yet understand the reasoning behind the need for the =
flag?
> > Close but not quite. The cost is the overhead of dget_parent() in
> > fsnotify_parent() which is often a couple of cache cold loads and atomi=
c
> > instructions to find out we don't need to send any event for the curren=
t
> > write(2) or read(2) call. It gets worse if there are many IOs happening=
 to
> > dentries in the same directory from multiple CPUs because instead of
> > cache-cold loads you get a cacheline contention on the parent.
> >
> >>>>> But what if we move dentries to the end of the list when they becom=
e
> >>>>> negative, and to the start of the list when they become positive?  =
Then
> >>>>> code which walks the child list could simply abort on the first
> >>>>> negative.
> >>>>>
> >>>>> I doubt that would be quite as easy as it sounds, but it would at l=
east
> >>>>> be more focused on the observed symptom rather than some whole-syst=
em
> >>>>> number which only vaguely correlates with the observed symptom.
> >>>>>
> >>>>> Maybe a completely different approach: change children-walking code=
 to
> >>>>> drop and retake the lock (with appropriate validation) periodically=
.
> >>>>> What too would address the specific symptom.
> >>>> Another good question.
> >>>>
> >>>> I have assumed that dropping and re-taking the lock cannot be done b=
ut
> >>>> this is a question I would like answered as well. Dropping and re-ta=
king
> >>>> lock would require, as Miklos pointed out to me off-list, recording =
the
> >>>> list position with say a cursor, introducing unwanted complexity whe=
n it
> >>>> would be better to accept the cost of a single extra access to the p=
arent
> >>>> flags (which I assume is one reason to set the flag in the child).
> >>> The parent access is actually more expensive than you might think. Ba=
sed on
> >>> experience with past fsnotify related performance regression I expect=
 some
> >>> 20% performance hit for small tmpfs writes if you add unconditional p=
arent
> >>> access to the write path.
> >> That sounds like a lot for what should be a memory access of an alread=
y in
> >> memory structure since the parent must be accessed to traverse the lis=
t of
> >> child entries. I clearly don't fully understand the implications of wh=
at
> >> I'm saying but there has been mention of another context ...
> > Parent dentry is of course in memory but often cache cold - you don't n=
eed
> > the parent to do e.g. write(2) to an already open file. You seem to be
> > somewhat confused about the child dentry list traversal (or maybe I'm
> > misunderstanding) - that happens only when placing the notification mar=
k
> > but definitely not for each IO operation.
>
> LOL, confusion is a pretty common state of mind for me!
>
>
> I do get your point though and I am confusing the traversal with other
>
> operations. I think this answers the question I've been asking (maybe
>
> that wasn't obvious) about the reason for the traversal (ie. the reason
>
> to maintain a flag in the child).
>
>
> While I have looked at the code here I haven't absorbed it and I
>
> definitely don't understand it, your continued patience is appreciated
>
> and will be beneficial when I get time to look at it a bit closer. I
>
> do still need to use a notifications mechanism to match up with Miklos's
>
> statmount implementation to get the full benefit of that in user space,
>
> if I ever get a chance to work on that again.
>
>
> So it sounds like it would be worth while considering a traversal that's
>
> based on taking a reference on each dentry rather than a spinlock for
>
> the duration. It would be tricky though, for obvious reasons, like
>
> children added during the traversal, added overhead of getting the next
>
> entry reference, etc.

Didn't look closely, but it feels like RCU traversal should be
possible if entries are added to the tail, or to the END_OF_POSITIVE
location.

When we discussed the "negavites at tail" at LSFMM
it was said that managing the transitions positive<->negative
would be challenging, but I don't know that anyone tried to look closer at =
this.

At least for fsnotify, positive->negative transition is not a problem
w.r.t skipping entry and observing entry twice during positive iteration.

If negative->positive transitions inserts at END_OF_POSITIVE
location, then should be fine as well?

Iterators that need to iterate all children can do this under lock.

Does that make sense?

Thanks,
Amir.
