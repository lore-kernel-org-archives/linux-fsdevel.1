Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD141A6815;
	Fri, 22 May 2026 04:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779423391; cv=none; b=bLcb4wIQkeTJrq+5z4GncgoC93HQdGqCIQJY07mO4xDY+CdFJwwd6eTAGdbd5p8Bh+rYO4GdBNX2U7shgmKGkk/1xQSTeNoXKHVXrWIskqSnQm0cByyxkzV/S7dhA5xEGjXmUtR2ZTXBnvtuw9VnXz3wcG3rJR8UTaNlrUFk0+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779423391; c=relaxed/simple;
	bh=e8DE6IUx6FSR2ZffYvMccjUpv8nxYHv5SjUx1D56mTk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=f72mxFPusQw7mn2Ap76wn+VxRN7iEg8DKgbjihhv+r3xcU+Jr4fYNi0qqAy0pkMFmkMZmRe92XkWy1hXiSItWlvcJMGvPOg1sbmAeTy/if3sM4+xjYgzcOefUg3Mt2uDVBtA2W9mq+T9nUkOu1PYBVITDuxkq7vaV9x/cLAO/iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=OYxpQTA3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WnrJrEtL; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="OYxpQTA3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WnrJrEtL"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 35D6E1D00013;
	Fri, 22 May 2026 00:16:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 22 May 2026 00:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1779423386; x=1779509786; bh=Q6kX+CGPIjcycczuR9Ih0lQn0HMsEucKCPf
	fGw0bT3E=; b=OYxpQTA3AUUdK6frGTDxdjmQ4pQfbHAbZfGwBXJVm4uVIrFM719
	etwqJs8mKlPK2DAAROUtuv6crx5Wp2dFExJ0/80LQcA2Zc4udHSqv9n2PSNx8KqO
	3t1IOXPpqORwq6ykHfERu+e4/fCav2n2wc1kcJN9d7/jbHCAPtg8j/Ic3lXrAsmf
	NI+NKDMzQI+MxlFUjP2vkLtA/43yQaDJwb+yEFXb3kXTMjVK+nUX96YAxuAtZNh7
	jXyeX9epdMHjCcF0AzMztiNfxnCjFRcYGHSD0I9rMOuZI9bsMc6bWMGi5D+ygO5N
	5jO/pYVg98tD7ciYDbOC1grsG3WwuexUlcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779423386; x=
	1779509786; bh=Q6kX+CGPIjcycczuR9Ih0lQn0HMsEucKCPffGw0bT3E=; b=W
	nrJrEtLVYOfZLucthei+1j1HXqsTSS4bAqbkk8yDv/Urlw1/BJHdNUWPaPfCvht4
	mDpXFsOFTUdBSQCgSu2MTVkuIyrSwzu4hGLjUgHo5mKhJkB4qANbw8vHOfTyqDJY
	neAseVjbvYfpt9VbHVfVY+owMMmOGgypbIVF6Sc3UxNOqIuPFzsQmM8+sOhdnrNP
	5Rojyk9ylD4zOTPNw7xNGc9cuVMGR+g6T0HiC7+uAK36yzuaCM9aawIGyydawxkN
	ucqEXaXpXPM8fOiGJinZe71sjTf3DCZsiTNEgxauWgt81ntLADqKK0nusZaCi1jN
	da5ajbMDg5ZTIZpuYD4sA==
X-ME-Sender: <xms:mtgPamM2pGD9lB-OVbAMawYF70eaeZ-4RPROvsKkDj9HjjiFCqltZA>
    <xme:mtgPaqJhjNwFaf6B17MKTOHvyGiA4puvBkzTy4eaZ19tpd0CSe48-Dw4dFmwGZNT5
    iI0EtNaR7ORWFVCHGoTQZvn2JHBx5WaU6y8rv72EBEpVwsyBQ>
X-ME-Received: <xmr:mtgPagqmP6QD11l7O7fpeC1FI3pOtjCIxjHthGXB_0-m5jENCYW5uvgr-Q3_K7l8ng6ETKZb15jtQu4fgLA1pk6NskAvo4c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeelfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdguohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprhgrvhgvnhesthhhvghmrgifrdhnvghtpdhrtghpthhtohepmhhikh
    hlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidp
    rhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopehskhhhrghnse
    hlihhnuhigfhhouhhnuggrthhiohhnrdhorhhg
X-ME-Proxy: <xmx:mtgPamPtnHl3XxwSPJzZWxhPRUwRwCJsqhnxq2Otw0WE5TGsqL2sWw>
    <xmx:mtgPapiY11hPn8086Q0jY-K9y4wtDkDPNaInGDylA5P5JcerVCpL4Q>
    <xmx:mtgPaqYI5UNqE9NKyAGAWXxncFsEGXNpSMIpufk3COJPhLKP5lPi9w>
    <xmx:mtgPathjDd7-oUvh6C1ZP_rm27EDjvBJ8pzCDe_KHdw_6LY9E1-vdw>
    <xmx:mtgPasb3PQ-JDBg6OsGw6ckUQTIUzLGy56ZVnkFJzeP7-jr0K77-3eH0>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 00:16:22 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Ian Kent" <raven@themaw.net>, "Jan Kara" <jack@suse.cz>,
 "Horst Birthelmer" <horst@birthelmer.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Jonathan Corbet" <corbet@lwn.net>,
 "Shuah Khan" <skhan@linuxfoundation.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Horst Birthelmer" <hbirthelmer@ddn.com>
Subject:
 Re: [PATCH] dcache: add fs.dentry-limit sysctl with negative-first reaper
In-reply-to:
 <CAOQ4uxg-7Tsb0GWF4LN3iFBaY7uGxR5_7PwBF+GfMWtCdfi4xw@mail.gmail.com>
References: <20260514-limit-dentries-cache-v1-1-431b9eb0c530@ddn.com>
  <177906210551.3947082.4313294634549021141@noble.neil.brown.name>
  <bc359831-e653-4269-9d57-742b48d56d9f@themaw.net>
  <yk2hem4zwinm4glenpc74to7sm5kyriksgwn6mxh7t4saotiba@7zik7jcnbs5m>
  <b320ff9a-7f6f-44c3-940f-33f79cc5569f@themaw.net>
  <fglq7n2brxwdsu7and6nt6xpgdziua754yzgxkmd33pmk6tor4@noxa5ajva7wg>
  <27a5593e-ffb8-4471-996f-7983bac0b1ab@themaw.net>
  <CAOQ4uxg-7Tsb0GWF4LN3iFBaY7uGxR5_7PwBF+GfMWtCdfi4xw@mail.gmail.com>
Date: Fri, 22 May 2026 14:16:14 +1000
Message-id: <177942337499.2234587.15757857859187727669@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 20 May 2026, Amir Goldstein wrote:
> On Wed, May 20, 2026 at 9:16=E2=80=AFAM Ian Kent <raven@themaw.net> wrote:
> >
> > On 19/5/26 17:12, Jan Kara wrote:
> > > On Mon 18-05-26 21:39:13, Ian Kent wrote:
> > >> On 18/5/26 16:19, Jan Kara wrote:
> > >>> Hi Ian,
> > >>>
> > >>> On Mon 18-05-26 10:55:43, Ian Kent wrote:
> > >>>> On 18/5/26 07:55, NeilBrown wrote:
> > >>>>> On Fri, 15 May 2026, Horst Birthelmer wrote:
> > >>>>> According to the email you linked, a problem arises when a director=
y has
> > >>>>> a great many negative children.  Code which walks the list of child=
ren
> > >>>>> (such as fsnotify) while holding a lock can suffer unpredictable de=
lays
> > >>>>> and result in long lock-hold times.  So maybe a limit on negative
> > >>>>> dentries for any parent is what we really want.  That would be clum=
sy to
> > >>>>> implement I imagine.
> > >>>> But the notion of dropping the dentry in ->d_delete() on last dput()=
 is
> > >>>> simple enough but did see regressions (the only other place in the V=
FS
> > >>>> besides dentry_kill() that the inode is unlinked from the dentry on
> > >>>> dput()). I wonder if the regression was related to the test itself
> > >>>> deliberately recreating deleted files and if that really is normal
> > >>>> behaviour. By itself that should prevent almost all negative dentries
> > >>>> being retained. Although file systems could do this as well (think X=
FS
> > >>>> inode recycling) it should be reasonable to require it be left to the
> > >>>> VFS.
> > >>>>
> > >>>> But even that's not enough given that, in my case, there would still=
 be
> > >>>> around 4 million dentries in the LRU cache and in fsnotify there are
> > >>>> directory child traversals holding the parent i_lock "spinlock" that=
 are
> > >>>> going to cause problems.
> > >>> Do you mean there are very many positive children of a directory?
> > >> Didn't quantify that.
> > >>
> > >> The symptom is the "Spinlock held for more than ... seconds" occurring=
 in
> > >> the log. So there are certainly a lot of children in the list, but it's
> > >> an assumption the ratio of positive to negative entries is roughly the
> > >> same as the overall ratio in the dcache.
> > > OK, but that's not necessarily true. I have seen these complaints from =
the
> > > kernel but in all the cases I remember it was due to negative dentries
> > > accumultating in a particular directory. There are certain apps such as
> > > ElasticSearch which really do like creating huge amounts of negative
> > > dentries in one directory - they use hashes as filenames and use direct=
ory
> > > lookup instead of a DB table lookup and lookup lots of non-existent key=
s...
> >
> > Umm ... that's a good point, I hadn't paid much attention to ENOENT result
> >
> > lookups, I'll need to check on the like cycle of those, I think they do g=
et
> >
> > hashed. That has to be the other source of negative dentries that I've
> >
> > neglected ...
> >
>=20
> Yes, it has been claimed that some real life workloads create a lot of thos=
e.
>=20
> If we can keep those at the tail of the children list, it will be best
> for the fsnotify
> iteration, which only cares about positive dentries.
>=20
> > >
> > >>>> so why is this traversal even retained in fsnotify?
> > >>> Not sure which traversal you mean but if you set watch on a parent, y=
ou
> > >>> have to walk all children to set PARENT_WATCHED flag so that you don'=
t miss
> > >>> events on children...
> > >> Yes, that traversal is what I'm questioning ... again thanks.
> > >>
> > >> I think the function name is still fsnotify_set_children_dentry_flags()
> > >> in recent kernels, the subject of commit 172e422ffea2 I mentioned abov=
e.
> > > OK, thanks.
> > >
> > >> When you say miss events are you saying that accessing the parent dent=
ry to
> > >> work out if the child needs to respond to an event is quite expensive =
in the
> > >> overall event processing context, that might make more sense to me ...=
 or do
> > >> I completely not yet understand the reasoning behind the need for the =
flag?
> > > Close but not quite. The cost is the overhead of dget_parent() in
> > > fsnotify_parent() which is often a couple of cache cold loads and atomic
> > > instructions to find out we don't need to send any event for the current
> > > write(2) or read(2) call. It gets worse if there are many IOs happening=
 to
> > > dentries in the same directory from multiple CPUs because instead of
> > > cache-cold loads you get a cacheline contention on the parent.
> > >
> > >>>>> But what if we move dentries to the end of the list when they become
> > >>>>> negative, and to the start of the list when they become positive?  =
Then
> > >>>>> code which walks the child list could simply abort on the first
> > >>>>> negative.
> > >>>>>
> > >>>>> I doubt that would be quite as easy as it sounds, but it would at l=
east
> > >>>>> be more focused on the observed symptom rather than some whole-syst=
em
> > >>>>> number which only vaguely correlates with the observed symptom.
> > >>>>>
> > >>>>> Maybe a completely different approach: change children-walking code=
 to
> > >>>>> drop and retake the lock (with appropriate validation) periodically.
> > >>>>> What too would address the specific symptom.
> > >>>> Another good question.
> > >>>>
> > >>>> I have assumed that dropping and re-taking the lock cannot be done b=
ut
> > >>>> this is a question I would like answered as well. Dropping and re-ta=
king
> > >>>> lock would require, as Miklos pointed out to me off-list, recording =
the
> > >>>> list position with say a cursor, introducing unwanted complexity whe=
n it
> > >>>> would be better to accept the cost of a single extra access to the p=
arent
> > >>>> flags (which I assume is one reason to set the flag in the child).
> > >>> The parent access is actually more expensive than you might think. Ba=
sed on
> > >>> experience with past fsnotify related performance regression I expect=
 some
> > >>> 20% performance hit for small tmpfs writes if you add unconditional p=
arent
> > >>> access to the write path.
> > >> That sounds like a lot for what should be a memory access of an alread=
y in
> > >> memory structure since the parent must be accessed to traverse the lis=
t of
> > >> child entries. I clearly don't fully understand the implications of wh=
at
> > >> I'm saying but there has been mention of another context ...
> > > Parent dentry is of course in memory but often cache cold - you don't n=
eed
> > > the parent to do e.g. write(2) to an already open file. You seem to be
> > > somewhat confused about the child dentry list traversal (or maybe I'm
> > > misunderstanding) - that happens only when placing the notification mark
> > > but definitely not for each IO operation.
> >
> > LOL, confusion is a pretty common state of mind for me!
> >
> >
> > I do get your point though and I am confusing the traversal with other
> >
> > operations. I think this answers the question I've been asking (maybe
> >
> > that wasn't obvious) about the reason for the traversal (ie. the reason
> >
> > to maintain a flag in the child).
> >
> >
> > While I have looked at the code here I haven't absorbed it and I
> >
> > definitely don't understand it, your continued patience is appreciated
> >
> > and will be beneficial when I get time to look at it a bit closer. I
> >
> > do still need to use a notifications mechanism to match up with Miklos's
> >
> > statmount implementation to get the full benefit of that in user space,
> >
> > if I ever get a chance to work on that again.
> >
> >
> > So it sounds like it would be worth while considering a traversal that's
> >
> > based on taking a reference on each dentry rather than a spinlock for
> >
> > the duration. It would be tricky though, for obvious reasons, like
> >
> > children added during the traversal, added overhead of getting the next
> >
> > entry reference, etc.
>=20
> Didn't look closely, but it feels like RCU traversal should be
> possible if entries are added to the tail, or to the END_OF_POSITIVE
> location.
>=20
> When we discussed the "negavites at tail" at LSFMM
> it was said that managing the transitions positive<->negative
> would be challenging, but I don't know that anyone tried to look closer at =
this.

I had a quick look.  Most users of d_sib walk from the parent->d_children
with the parent ->d_lock held, so they shouldn't notice a movement in
the list.
The two exceptions I could find are d_walk() and the readdir code in
libfs.c.
I think the main problem case would be if they were holding a dentry as
a cursor which transitioned when the parent d_lock is dropped and retaken.

d_walk already needs to cope with a concurrent rename messing with
its cursor so possibly something similar could be used to trigger a
restart.

libfs readdir walks from a DCACHE_DENTRY_CURSOR which will never
transition and so won't move spontaneously.  That is exactly as safe as
walking from the parent.

So I think d_walk() might need some help to avoid getting lost.  It could
probably simply check if its cursor changed ->d_inode between dropping
->d_lock and retaking it.  If it did, then restart.

It isn't clear to me that we can track a "end of positive" location.  I
think we would need to move negatives to the end and positives to the
start.  Can you see a down-side with doing that?

Thanks,
NeilBrown



>=20
> At least for fsnotify, positive->negative transition is not a problem
> w.r.t skipping entry and observing entry twice during positive iteration.
>=20
> If negative->positive transitions inserts at END_OF_POSITIVE
> location, then should be fine as well?
>=20
> Iterators that need to iterate all children can do this under lock.
>=20
> Does that make sense?
>=20
> Thanks,
> Amir.
>=20

