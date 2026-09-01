Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A9033BBCD
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Sep 2026 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788299645; cv=pass; b=oXZJxfNvNnRP2xxfwCeXmAjViE9jkq9GGKXhD59hQrTWHC4YBW+abPgl+vMC8wgae8QtzDxlGqtxYuPOaMVeiZAogwTaYJRd44HGQuBwArwVhFlf+qbrHqqW8SBOf5OoNbcHdjOSqH2Knq1nMy23q1S3HZp5FhYPtc2g/XK7DHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788299645; c=relaxed/simple;
	bh=2DT7FP7BPZ1eoJhHnEpBuM/xBGteevUXEVBoPMF0chI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=apasbkASuKYxb6+jNraOAFPXzXek1S5dSPTbBCTVG2yxx0iw6PMLIYRwh5XlRuLH/xcwUeI06mrTtFlbqHL1muiMTFbhUpCWBKpz7oIT+zE+lf6JPx4JI44zcnxD1xm4CG5h9Se36vpLaI7OFrB6DRzVUHqlXtFpE5gOQR6dHP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJvUUQ3z; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJvUUQ3z"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a668ce86abso621036a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Sep 2026 14:54:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788299641; cv=none;
        d=google.com; s=arc-20260327;
        b=dCUJf+vVv4iMAlxom9Oj7kjdCeG7gX0IMwBvz69G56hEqi6QD4u/OnKcOw61HlNXC1
         xMEJ/cdeh8h3ya+PbJV9soUDSkkTmusvPfEmQn1Ot51djIN6M4WmDbyMSuSzeQiRjVvX
         6Mt42CMv+htDgXN8U0dksiKAfXbCOZl3jisdMaX1C3LslTqvKPwjQVFujV9HAMrs7Tlf
         TF+PnHqPFU4w8EdxV5w68VcMB/vidKXWYWG1jb4EMF3Hb8Xdcr6IkI/9WHxEKHTD+ZPl
         J09JbeZbYX3Cz3lp9QyIHlSE8+td2y9OmIbLh3JBKhx8mhPtGTg72lxF2zdVXA+enNT8
         LmSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=e+QO0pCFT4WJWzkhg3As90KN0BRrxKJyGKfL2ctXPfE=;
        fh=k8i6TGyTfzWVI4UdZID0I2vujeGXbdj/tU7HG8quHF8=;
        b=YsFZy12+ruWpgmtYHR+HowWRV2GwLiioGlZqBTQndFnImXZXBTINYGXjx2E11jln8w
         KESKJ0kqvn9ilMqaSEgqQ3HqmueTVCtc7jENi1DPQvk5Lo5eYgA/YM9HZOWXvpEKkfBS
         vRarqZQBJgLEbM44n+o7ol5s+dfmsAKCZqsfGTRTRxq5kw00X1RPMMXujv8HcKDVPjiW
         raJ6YqwrEOv3cdmNu/jvsqbzyG3FPAE6t2Yfz0a63Dimu0OtT1H9TRP6T8Wg6Fby54G4
         +JaRB9/ydXKUmXngXbfBVUMeYsm+/ELD4cqA1Aiayhv21AVIX4VtsW9o9vG97UzIMfvX
         DaRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788299641; x=1788904441; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e+QO0pCFT4WJWzkhg3As90KN0BRrxKJyGKfL2ctXPfE=;
        b=KJvUUQ3zJPeMQ02Vs4R/QAxrzcWwVIic4PrYD9AKXWoOqZCEUtkcssWmWiIRTNXnzE
         Bi+jpS8Sr9Rpl4//ojkthzuJuyvSwT5rSe9qM4Lajp8EarpwqTq6d/mZf40klNse6Iow
         18srw9v9kw4RGqZcdKJDNKqjKjLzluvQ0soio+TD5k6cvqZx9OU0udlfDEoNPozLy371
         8ROu6BIKDXMqYPjdcmBDLgAda9eN5Jt8DdIOl/IRWLa8JHZRl3o3HexLpEcNckJuEgqC
         6OkF9+CCAFR6Fh0vkfaPhZByOE760OK3yr953cvGbZaIVseFXIPT6aSonAWZv1Tb62KS
         Fnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788299641; x=1788904441;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e+QO0pCFT4WJWzkhg3As90KN0BRrxKJyGKfL2ctXPfE=;
        b=VHj3OqQthSg/441fs6CIlBf7YNhZyA/fl/e3HC6zUKDpHNtoEn3UJpkwuit0qDRG6r
         qYDmNDT0kxX0LFO8H8Ns/Al/NDvkwR95LlSEhTTr9S80XaGLI0fzanOLFqD6P9QXIWHs
         ONZVTlhkc/oebbG/1Lv8lt+2fCZIhceq5/BFy3EmBpmHa8GEo09xGOicRQrcIx8YTnjS
         3lHU50FznfAzf/Sg/lOLvKqq966Y0u3Pf/QYhPCD2b6ca3L0fFYbCT0wwm1MtKahVrYR
         n+tJMT2vw9KoByP+xmvBWv94nwKq7KQ8yfMJfP2kPLMruCZZ5U3fXpYko4hEOzBAKgPs
         /b+Q==
X-Forwarded-Encrypted: i=1; AKwUvByLY6x5CR1WF0KOPVu2hErHoxH5vZRhIa8SPeCPDzXZExn/k+avgMXQ3AEZ4Uh4/mbiTSJeq4x3W2tx7zAe@vger.kernel.org
X-Gm-Message-State: AFuF++la5zwKF9ZPxjtjipBIOcWk5uA6EqBfBKv9ss+8pqh9r2DVxfx7
	U4w2khMOVFhvVdW3P62QvzPa62LmBnxv/WdZkGdkwleax9FgUu1+pqCQakQCyKIY1IgphXvYQoq
	GUcbHaF8IDOLJZgKuYs6/QHYHmQharag=
X-Gm-Gg: AYBFou3vodJLdDJoELI2d+l8dyQX0Y5KA31GxsoVxAxWS2b6LHqCW/wClJ4ozeeUlB4
	URHqW9WGfWv5hTujPntZakjU9LNMIyQa+SloOhs+vI9m9zZCxWSVd3G4mcDNTqIJF8JdN9YaS+r
	GS2Gz8gA4Mn7HQjtiCBUlLnN4fXK7zW/Kqdn4hjPRrva8bCRx79NVQDbMNQUyTaCxCBRITNAhNf
	WzCItco4rTsaR6F9s9BrKhZdj1OgcdoyukHEWxwJZjq7BskS8vqZR0/hUGu+qPoF6Tgz7e4qIVX
	JFyQyAZlxz/A2YXSajknIEqHlQenjcN3J24EV9lL85B4lQ==
X-Received: by 2002:a05:6402:388d:b0:6a6:32f5:90b4 with SMTP id
 4fb4d7f45d1cf-6a682af9bf3mr433560a12.22.1788299641132; Tue, 01 Sep 2026
 14:54:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827045007.3831259-1-4ncienth@gmail.com> <yjfqzckumtd32dgqidi5sndvth2t67mjwah4kt4jiahlx2a5uf@if55sinfv5o7>
 <20260828042421.964822-1-4ncienth@gmail.com> <ptco7s5x7tjzp42dzlsitibdigpwucl2whwrq37tknjpo7x2lc@b7q27ldlorak>
 <CAOQ4uxgB9anyJcWem04w65VCJdxbbb2cQDZ_u8qMusw3xpB9Gw@mail.gmail.com>
 <63aj7jbfaoamdmcurlge2c2kqpliaifgq4vbythrrxpfyr5vtm@z64myom426zd>
 <CAOQ4uxh-NZ76hEFoNNGjyhodr9U=dvZuGVmYHVPGZ_=jRxCAsA@mail.gmail.com>
 <67hq7zqnvp6onwwjp24axucgxbzsko2dphielupdfzmfyk6x57@bdeef7fjkqfa>
 <CAOQ4uxiQF4M_YSBMW3h8VCKR15GV6g_K5nf=2odtYetEwKHm9A@mail.gmail.com> <6n6r5zvcu5ojihyb52rhejlky7xrn2a2p4l2cgfut5lsscunek@bcnpy7bifjrs>
In-Reply-To: <6n6r5zvcu5ojihyb52rhejlky7xrn2a2p4l2cgfut5lsscunek@bcnpy7bifjrs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 1 Sep 2026 23:53:48 +0200
X-Gm-Features: AcwNN1X2wk4gz3HnoVHNNq5flErNnw2c6AEvCyTCJFxAmecZI8LXUWIc5FpWY0Y
Message-ID: <CAOQ4uxjbEY12XMmfCXTPTpASmECCXcGBQR+bS93k=4vgqzFDZA@mail.gmail.com>
Subject: Re: [BUG] fanotify: destroy/add race leaves a mark on a detached connector
To: Jan Kara <jack@suse.cz>
Cc: Daehyeon Ko <4ncienth@gmail.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000dcd635065a72f4e4"

--000000000000dcd635065a72f4e4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 6:57=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 31-08-26 16:54:55, Amir Goldstein wrote:
> > On Mon, Aug 31, 2026 at 1:39=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Sat 29-08-26 17:04:19, Amir Goldstein wrote:
> > > > On Fri, Aug 28, 2026 at 7:36=E2=80=AFPM Jan Kara <jack@suse.cz> wro=
te:
> > > > > > > Now there's the question about the best fix for the problem. =
I've realized
> > > > > > > we cannot just remove the call to fsnotify_inode_delete() fro=
m the place
> > > > > > > where fsnotify_inoderemove() is called (and rely on the call =
from
> > > > > > > __destroy_inode()) because the connector holds inode referenc=
e and so
> > > > > > > __destroy_inode() would never get called. Hrm, this is a hair=
y issue and so
> > > > > > > far I don't see a good place to reliably trigger detaching of=
 connector
> > > > > > > from the inode. One reliable place would be iput() but that's=
 really ugly
> > > > > > > and would slow down every iput() user. The cleanest solution =
I can
> > > > > > > currently see is to stop holding inode reference from a conne=
ctor as I've
> > > > > > > proposed in the past. Then we can reliably perform the cleanu=
p in
> > > > > > > __destroy_inode(). But that will be a rather non-trivial unde=
rtaking. Amir,
> > > > > > > do you see some other option?
> > > > > >
> > > > > > What about the option I proposed to live with the orphan marks
> > > > > > Is it so bad? I mean it's confusing and removing the assertion =
could
> > > > > > hide real bugs/races, but maybe it's worth not complicating the=
 code
> > > > > > until we move forward to re-attachable marks.
> > > > >
> > > > > I'm not so much worried about the case when placing of the mark r=
aces with
> > > > > unlink. There I agree we can somehow paper over the problem for n=
ow. What
> > > > > I'm more worried about is the case where someone places a precont=
ent /
> > > > > permission mark on the inode and a malicious user does hardlink +=
 open +
> > > > > unlink trick and after unlinking the original link to the inode, =
he has an
> > > > > open fd to the inode stripped of any notification marks which I'd=
 say
> > > > > violates the promise of precontent / permission marks.
> > > >
> > > > I see. so we need a point where there are no more hardlinks and no =
more
> > > > dentry aliases to the inode.
> > > >
> > > > How about we check for this condition?
> > > >
> > > > --- a/fs/dcache.c
> > > > +++ b/fs/dcache.c
> > > > @@ -471,7 +471,7 @@ static void dentry_unlink_inode(struct dentry *=
 dentry)
> > > >         raw_write_seqcount_end(&dentry->d_seq);
> > > >         spin_unlock(&dentry->d_lock);
> > > >         spin_unlock(&inode->i_lock);
> > > > -       if (!inode->i_nlink)
> > > > +       if (!inode->i_nlink && hlist_empty(&inode->i_dentry))
> > > >                 fsnotify_inoderemove(inode);
> > >
> > > This looks like an intriguing idea. But I think it still has a hole. =
Until
> > > the last inode reference is put, open_by_handle() can still get you a=
 new
> > > dentry and an open file pointing to that inode.
> >
> > Maybe we can close this hole, because whether open_by_handle()
> > should or should not succeed in this case is not well defined,
> > We can make it defined.
> > Something like this?
> > NFS should have a sillyrenamed link to avoid undefined behavior
> > around unlinked open files.
>
> Hum, right. That could work.
>
> > --- a/fs/dcache.c
> > +++ b/fs/dcache.c
> > @@ -459,6 +459,7 @@ static void dentry_unlink_inode(struct dentry * den=
try)
> >         __releases(dentry->d_inode->i_lock)
> >  {
> >         struct inode *inode =3D dentry->d_inode;
> > +       bool dead;
> >
> >         raw_write_seqcount_begin(&dentry->d_seq);
> >         __d_clear_type_and_inode(dentry);
> > @@ -469,9 +470,12 @@ static void dentry_unlink_inode(struct dentry * de=
ntry)
> >          */
> >         dentry->waiters =3D NULL;
> >         raw_write_seqcount_end(&dentry->d_seq);
> > +       dead =3D !inode->i_nlink && hlist_empty(&inode->i_dentry);
> > +       if (dead)
> > +               inode->i_state |=3D I_ZOMBIE;
>
> Do we really need the I_ZOMBIE state? I think we can just check i_nlink a=
nd
> hlist_empty() directly in __d_obtain_alias(), cannot we? Once this
> condition is true, it cannot change until we go through
> __d_obtain_alias()...
>

OK I added convenience helper inode_is_dead()
names are debatable...

> >         spin_unlock(&dentry->d_lock);
> >         spin_unlock(&inode->i_lock);
> > -       if (!inode->i_nlink)
> > +       if (dead)
> >                 fsnotify_inoderemove(inode);
> >         if (dentry->d_op && dentry->d_op->d_iput)
> >                 dentry->d_op->d_iput(dentry, inode);
> > @@ -2244,6 +2248,12 @@ static struct dentry *__d_obtain_alias(struct
> > inode *inode, bool disconnected)
> >
> >         security_d_instantiate(new, inode);
> >         spin_lock(&inode->i_lock);
> > +       if (inode->i_state & I_ZOMBIE) {
> > +               spin_unlock(&inode->i_lock);
> > +               dput(new);
> > +               iput(inode);
> > +               return ERR_PTR(-ESTALE);
>
> I think a failure return after security_d_instantiate() could be unexpect=
ed
> so we need to do this check before calling it.

You mean before and after.

>
> > +       }
> >         res =3D __d_find_any_alias(inode); /* recheck under lock */
> >         if (likely(!res)) { /* still no alias, attach a disconnected de=
ntry */
> >                 unsigned add_flags =3D d_flags_for_inode(inode);
>
> Thanks for looking into this!
>

See attached patch (again helper named debatable).

Daehyeon, care to test this patch with your reproducer?

Thanks,
Amir.

--000000000000dcd635065a72f4e4
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-fs-make-sure-to-call-fsnotify_removeinode-once-when-.patch"
Content-Disposition: attachment; 
	filename="0001-fs-make-sure-to-call-fsnotify_removeinode-once-when-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mtj7er400>
X-Attachment-Id: f_mtj7er400

RnJvbSAyZDNkMTkzODM3M2JmY2IyNzU0NWE1OGZmZjE2MDBmMmYyY2NkZDMxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBUdWUsIDEgU2VwIDIwMjYgMjM6NDA6NDMgKzAyMDAKU3ViamVjdDogW1BBVENIXSBmczog
bWFrZSBzdXJlIHRvIGNhbGwgZnNub3RpZnlfcmVtb3ZlaW5vZGUoKSBvbmNlIHdoZW4gaW5vZGUK
IGlzIGRlYWQKCkRhZWh5ZW9uIHJlcG9ydGVkIGEgcmFjZSB3aGVyZWluIGZzbm90aWZ5X3JlbW92
ZWlub2RlKCkgY2FuIGJlIGNhbGxlZAp3aGVuIGlub2RlIHN0aWxsIGhhdmUgYSBsaXZlIGFsaWFz
LiAgVGhpcyBjYW4gbGVhZCB0byBzZXZlcmFsIHVuZGVzaXJlZApvdXRjb21lcy4KCkNoZWNrIHRo
YXQgaW5vZGUgaXMgcmVhbGx5ICJkZWFkIiwgbWVhbmluZyBubyBubGluayBhbmQgbm8gbW9yZSBh
bGlhc2VzCmJlZm9yZSBjYWxsaW5nIGZzbm90aWZ5X3JlbW92ZWlub2RlKCkgZm9yIGZpbmFsIGNs
ZWFudXAgb2YgaW5vZGUgbWFya3MuCgpBbHNvIGRvIG5vdCBhbGxvdyBvcGVuX2J5X2hhbmRsZSgp
IHRvIGFkZCBuZXcgYWxpYXNlcyB0byBhICJkZWFkIiBpbm9kZS4KClJlcG9ydGVkLWJ5OiBEYWVo
eWVvbiBLbyA8NG5jaWVudGhAZ21haWwuY29tPgpDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LWZzZGV2ZWwvMjAyNjA4MjcwNDUwMDcuMzgzMTI1OS0xLTRuY2llbnRoQGdtYWls
LmNvbS8KU2lnbmVkLW9mZi1ieTogQW1pciBHb2xkc3RlaW4gPGFtaXI3M2lsQGdtYWlsLmNvbT4K
LS0tCiBmcy9kY2FjaGUuYyB8IDI4ICsrKysrKysrKysrKysrKysrKysrKysrKystLS0KIDEgZmls
ZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2ZzL2RjYWNoZS5jIGIvZnMvZGNhY2hlLmMKaW5kZXggM2U5YWY5ZGU3MDc0Ni4uYTc2MjYwMDky
ZTI2YSAxMDA2NDQKLS0tIGEvZnMvZGNhY2hlLmMKKysrIGIvZnMvZGNhY2hlLmMKQEAgLTQ1MCw2
ICs0NTAsMTIgQEAgc3RhdGljIHZvaWQgZGVudHJ5X2ZyZWUoc3RydWN0IGRlbnRyeSAqZGVudHJ5
KQogCQljYWxsX3JjdSgmZGVudHJ5LT5kX3JjdSwgX19kX2ZyZWUpOwogfQogCisvKiBJbm9kZSBt
YXkgYmUga2VwdCBhbGl2ZSBieSBhIHBvc2l0aXZlIG5saW5rIG9yIGJ5IGEgZGVudHJ5IGFsaWFz
ICovCitzdGF0aWMgYm9vbCBpbm9kZV9pc19kZWFkKHN0cnVjdCBpbm9kZSAqaW5vZGUpCit7CisJ
cmV0dXJuICFpbm9kZS0+aV9ubGluayAmJiBobGlzdF9lbXB0eSgmaW5vZGUtPmlfZGVudHJ5KTsK
K30KKwogLyoKICAqIFJlbGVhc2UgdGhlIGRlbnRyeSdzIGlub2RlLCB1c2luZyB0aGUgZmlsZXN5
c3RlbQogICogZF9pcHV0KCkgb3BlcmF0aW9uIGlmIGRlZmluZWQuCkBAIC00NTksNiArNDY1LDcg
QEAgc3RhdGljIHZvaWQgZGVudHJ5X3VubGlua19pbm9kZShzdHJ1Y3QgZGVudHJ5ICogZGVudHJ5
KQogCV9fcmVsZWFzZXMoZGVudHJ5LT5kX2lub2RlLT5pX2xvY2spCiB7CiAJc3RydWN0IGlub2Rl
ICppbm9kZSA9IGRlbnRyeS0+ZF9pbm9kZTsKKwlib29sIGRlYWQ7CiAKIAlyYXdfd3JpdGVfc2Vx
Y291bnRfYmVnaW4oJmRlbnRyeS0+ZF9zZXEpOwogCV9fZF9jbGVhcl90eXBlX2FuZF9pbm9kZShk
ZW50cnkpOwpAQCAtNDY5LDkgKzQ3NiwxMCBAQCBzdGF0aWMgdm9pZCBkZW50cnlfdW5saW5rX2lu
b2RlKHN0cnVjdCBkZW50cnkgKiBkZW50cnkpCiAJICovCiAJZGVudHJ5LT53YWl0ZXJzID0gTlVM
TDsKIAlyYXdfd3JpdGVfc2VxY291bnRfZW5kKCZkZW50cnktPmRfc2VxKTsKKwlkZWFkID0gaW5v
ZGVfaXNfZGVhZChpbm9kZSk7CiAJc3Bpbl91bmxvY2soJmRlbnRyeS0+ZF9sb2NrKTsKIAlzcGlu
X3VubG9jaygmaW5vZGUtPmlfbG9jayk7Ci0JaWYgKCFpbm9kZS0+aV9ubGluaykKKwlpZiAoZGVh
ZCkKIAkJZnNub3RpZnlfaW5vZGVyZW1vdmUoaW5vZGUpOwogCWlmIChkZW50cnktPmRfb3AgJiYg
ZGVudHJ5LT5kX29wLT5kX2lwdXQpCiAJCWRlbnRyeS0+ZF9vcC0+ZF9pcHV0KGRlbnRyeSwgaW5v
ZGUpOwpAQCAtMTE2MCw2ICsxMTY4LDE4IEBAIHN0YXRpYyBzdHJ1Y3QgZGVudHJ5ICogX19kX2Zp
bmRfYW55X2FsaWFzKHN0cnVjdCBpbm9kZSAqaW5vZGUpCiAJcmV0dXJuIE5VTEw7CiB9CiAKKy8q
CisgKiBTYW1lIGFzIF9fZF9maW5kX2FueV9hbGlhcygpLCBidXQgcmV0dXJucyBFUlJfUFRSKC1F
U1RBTEUpIGlmIHRoZSBpbm9kZSBpcworICogZGVhZCBhbmQgc2hvdWxkIG5vdCBhY2NlcHQgYW55
IG5ldyBhbGlhc2VzLgorICovCitzdGF0aWMgc3RydWN0IGRlbnRyeSAqIF9fZF9maW5kX2FsaWFz
X29mX2xpdmVfaW5vZGUoc3RydWN0IGlub2RlICppbm9kZSkKK3sKKwlzdHJ1Y3QgZGVudHJ5ICph
bGlhcyA9IF9fZF9maW5kX2FueV9hbGlhcyhpbm9kZSk7CisJaWYgKCFhbGlhcyAmJiBpbm9kZV9p
c19kZWFkKGlub2RlKSkKKwkJcmV0dXJuIEVSUl9QVFIoLUVTVEFMRSk7CisJcmV0dXJuIGFsaWFz
OworfQorCiAvKioKICAqIGRfZmluZF9hbnlfYWxpYXMgLSBmaW5kIGFueSBhbGlhcyBmb3IgYSBn
aXZlbiBpbm9kZQogICogQGlub2RlOiBpbm9kZSB0byBmaW5kIGFuIGFsaWFzIGZvcgpAQCAtMjIz
Miw3ICsyMjUyLDkgQEAgc3RhdGljIHN0cnVjdCBkZW50cnkgKl9fZF9vYnRhaW5fYWxpYXMoc3Ry
dWN0IGlub2RlICppbm9kZSwgYm9vbCBkaXNjb25uZWN0ZWQpCiAKIAlzYiA9IGlub2RlLT5pX3Ni
OwogCi0JcmVzID0gZF9maW5kX2FueV9hbGlhcyhpbm9kZSk7IC8qIGV4aXN0aW5nIGFsaWFzPyAq
LworCXNwaW5fbG9jaygmaW5vZGUtPmlfbG9jayk7CisJcmVzID0gX19kX2ZpbmRfYWxpYXNfb2Zf
bGl2ZV9pbm9kZShpbm9kZSk7IC8qIGV4aXN0aW5nIGFsaWFzPyAqLworCXNwaW5fdW5sb2NrKCZp
bm9kZS0+aV9sb2NrKTsKIAlpZiAocmVzKQogCQlnb3RvIG91dDsKIApAQCAtMjI0NCw3ICsyMjY2
LDcgQEAgc3RhdGljIHN0cnVjdCBkZW50cnkgKl9fZF9vYnRhaW5fYWxpYXMoc3RydWN0IGlub2Rl
ICppbm9kZSwgYm9vbCBkaXNjb25uZWN0ZWQpCiAKIAlzZWN1cml0eV9kX2luc3RhbnRpYXRlKG5l
dywgaW5vZGUpOwogCXNwaW5fbG9jaygmaW5vZGUtPmlfbG9jayk7Ci0JcmVzID0gX19kX2ZpbmRf
YW55X2FsaWFzKGlub2RlKTsgLyogcmVjaGVjayB1bmRlciBsb2NrICovCisJcmVzID0gX19kX2Zp
bmRfYWxpYXNfb2ZfbGl2ZV9pbm9kZShpbm9kZSk7IC8qIHJlY2hlY2sgdW5kZXIgbG9jayAqLwog
CWlmIChsaWtlbHkoIXJlcykpIHsgLyogc3RpbGwgbm8gYWxpYXMsIGF0dGFjaCBhIGRpc2Nvbm5l
Y3RlZCBkZW50cnkgKi8KIAkJdW5zaWduZWQgYWRkX2ZsYWdzID0gZF9mbGFnc19mb3JfaW5vZGUo
aW5vZGUpOwogCi0tIAoyLjU1LjAKCg==
--000000000000dcd635065a72f4e4--
