Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AC939D6E9
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188111; cv=pass; b=iQG7NhML0T0rI7eAXN5xrT6Mkz4+EcRuG7uVeDss/h0AdzVDfEmiis1TND1FAu+9ho9Fp64qcUw40m4MU+x3QDfqtZLp536Qi6aeLiRjNISLjXa9VESFo9mKsoOkbn08wvUAmceFek8CH2Co1mZjADcrvXZqD4x1+SQlOeBY3b4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188111; c=relaxed/simple;
	bh=xY7PzJAuFl926gP7M2esENWf67rjFL/VYhM4pp0oYZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OC3ED9qjfh5i8b69kK0Ae4wwCjdPG/0AypNZZppYE1vWX5IDgQhrFdXwHgGc2TVBJgFD9H/UECXGQbprODlhXGKimzo+d9IaCM/42cv/11DkSwH6Ypd7TrrMvUk3p0mmUYbuWPPkwPyXbISVc/a8t1VWacuelBu6Mg0FIk38PxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3qLFVy4; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3qLFVy4"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a60f0dbeccso4662860a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 07:55:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788188107; cv=none;
        d=google.com; s=arc-20260327;
        b=r4T5hi9N+fPniyCzNl3kMjKUQyCECikXfpQnpJrOOvgXd6Q7YLiRS0xNAsUf0xieGp
         f//SWKsyTHUIhcTn1ljmyHAkcZtaEdVAAvVVnEromrEAGeh0dZ65OYTy8RO3/RKdZP4p
         htp2l98+zbaa06wXzV6Z1iyiC6Op8ZMzSM1ZDTs7nGZsVJ4VLUkHP51AjCETZVSUv1lX
         d8nN5JbUWyJ8EJ5d0X7Bx0xfVHTidkx/yuXXOWmPD3DMN3uz3VqFr0zvnqsnFYqNjGsK
         MpXqwMSQjH0PvXJuowptXScvCedT1gIRfHRNC0YFneYJSR438j7KANva+JaLBjW1Ql0e
         GdKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o8pw78oMi9uY1RnWmqztihIod3VWCHkHOIfZPGYQtiA=;
        fh=8yx//o75+l+vFP+VcL59QYpcqaPndffO48Os8OM6Q9k=;
        b=rsoWpSg3rLqhjiQPfZKcd4MkZLbNujIzttcAOAe63dDsJpVEnn7xg8L4FI7ufwFdoy
         lkybL68CHVGVc3Ua+ItZAd+bhvO1GO5q54AdrpIBMLtOmDEaFlOtJvx54C1/kTmvGQeU
         DQxTAPb7B9dpXLXnAa4oyBdzRAd2gY407LczVYnwwzYPgHQiYYW7Gor87pOawuHX6nhF
         yiMMO5TNl8PgujcywCxJ0M3SuyE7NsjKNvzHSjWibRL/2i7nH1n++TX/cmXocYk0wmYg
         3a98dBP9kj1ObCz9iOY+8k0o6/E9tdK/mV+dIXn01J0dgelEOmaKAdAteKVwjdOuVtnh
         Nr4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788188107; x=1788792907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o8pw78oMi9uY1RnWmqztihIod3VWCHkHOIfZPGYQtiA=;
        b=M3qLFVy4uPXuP55qv4JPXLBrGKvUHbq3bqWz+SC9PY+jbA4k08d/DfMLOEOjqotBOk
         v844+/fS8Ln1x8XiJYtqHtTgnCJ7kCeaAG6Kns+hm0lwkWiNFRVEXTRQBPMQXAGMLGDP
         qbFymvrWMRuXRnkvrt0nkxxYIXUvabBhfuR88bMDCHoV+4Cj9bRURtxzapkGaGBrZxK/
         xafe8WUvyKWw0XnBNzlnCbB0N+S0r3gKPp+PvotPKeKJogFCmCkhCdKeEqUCyIFbEVL3
         ObgK3xrzKWX38sPp/Hk243YZuJnqofUOcP/h9smsEMOaarrEUKxQGIDRSrA/KM7b99XX
         k4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188107; x=1788792907;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o8pw78oMi9uY1RnWmqztihIod3VWCHkHOIfZPGYQtiA=;
        b=B83wpE6487/PwZLPHI7RWO2ITRyOhODdfl4JD4OXTGN+QYHzU4+9cskujzszqYhiuH
         dCy46Y5K2WJ8/DeflHmMpUYm2SB29oW4rueKvrnUF5EMpzcv+oesafrELvP9103jh1D0
         Sm73cYOk1k9RtlI5YTry5R++MgiQFr55d6TZuNP5gwSEfTbGEMwo2pp0SqhxvDsOr2CF
         mMtAjgeGGGwThJh45K99oUlRFVn0rDPgxiVHNOPsp6d+FmQ76lOFCnhhEhzwdb5xY45w
         Vjm5I9VtlUjyu9Mxqhflm3WajddNdoLkX8v57gGJ3xhKb/v3W3f41dE68vD8uG204ZvJ
         XDcQ==
X-Forwarded-Encrypted: i=1; AKwUvBx7NufFwsKsGRuG14OKd1FVk3s9MbPnqwXhEQgiT/8HzO0hvMZlMhvKNCIx2RkSfTdH+Cp01DrlZgRNPmSr@vger.kernel.org
X-Gm-Message-State: AFuF++mnqnbpTd2I2/wiyJ/EVS/dKUe5lTRgzdvrEEy5f8zu7bd8+bqA
	OH5Rj7pxVp8u2rXW/BP78jYBcrQfRXKeYh7F8RnGt9aSMsG5XB+5KR+IRUE0wVD74AC3bD4u5C9
	kr0Xsvefy87wup5RSDXZWmBthpIGIUYY=
X-Gm-Gg: AYBFou0IYJ065j1+t7q+zR7+FDys6soDjajvBxcsHzSKMmCcyGgOt8lNOWzd1YRn1fc
	L4r3FXclV1R2SeA+LxP4F+Sa9D+jadL8351Sk+rECMxQQOVIKTkScqa6Evi3WyjkxbOMh+1SL2L
	0HOmHVnIG400kKwX11nuRifaydMWs2pcZkSCTxV+oYRrej0EafCWASdGQ5Q/XG6huvWDhOEemnG
	F1zSxnloqQ73IB0LchuUpwSSkACK7+BiMikf4BGBpwKULTjLvT5HTl5xVvJ2kUfM3x8R155JG49
	uH6RGdVg/g61r8hbJnU8E+8J7/QvSAQ9dhDCTvqp07dmiNkA+jFzTgoG
X-Received: by 2002:a05:6402:4586:b0:6a5:d907:7703 with SMTP id
 4fb4d7f45d1cf-6a60d3d5a52mr16807888a12.14.1788188107151; Mon, 31 Aug 2026
 07:55:07 -0700 (PDT)
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
 <CAOQ4uxh-NZ76hEFoNNGjyhodr9U=dvZuGVmYHVPGZ_=jRxCAsA@mail.gmail.com> <67hq7zqnvp6onwwjp24axucgxbzsko2dphielupdfzmfyk6x57@bdeef7fjkqfa>
In-Reply-To: <67hq7zqnvp6onwwjp24axucgxbzsko2dphielupdfzmfyk6x57@bdeef7fjkqfa>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 31 Aug 2026 16:54:55 +0200
X-Gm-Features: AcwNN1VUPugjGbqI4B0wT9HaChvwtiMplXNGta4vMaUOc8DwPfjODDDmdmwDO_I
Message-ID: <CAOQ4uxiQF4M_YSBMW3h8VCKR15GV6g_K5nf=2odtYetEwKHm9A@mail.gmail.com>
Subject: Re: [BUG] fanotify: destroy/add race leaves a mark on a detached connector
To: Jan Kara <jack@suse.cz>
Cc: Daehyeon Ko <4ncienth@gmail.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 1:39=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 29-08-26 17:04:19, Amir Goldstein wrote:
> > On Fri, Aug 28, 2026 at 7:36=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > > > > Now there's the question about the best fix for the problem. I've=
 realized
> > > > > we cannot just remove the call to fsnotify_inode_delete() from th=
e place
> > > > > where fsnotify_inoderemove() is called (and rely on the call from
> > > > > __destroy_inode()) because the connector holds inode reference an=
d so
> > > > > __destroy_inode() would never get called. Hrm, this is a hairy is=
sue and so
> > > > > far I don't see a good place to reliably trigger detaching of con=
nector
> > > > > from the inode. One reliable place would be iput() but that's rea=
lly ugly
> > > > > and would slow down every iput() user. The cleanest solution I ca=
n
> > > > > currently see is to stop holding inode reference from a connector=
 as I've
> > > > > proposed in the past. Then we can reliably perform the cleanup in
> > > > > __destroy_inode(). But that will be a rather non-trivial undertak=
ing. Amir,
> > > > > do you see some other option?
> > > >
> > > > What about the option I proposed to live with the orphan marks
> > > > Is it so bad? I mean it's confusing and removing the assertion coul=
d
> > > > hide real bugs/races, but maybe it's worth not complicating the cod=
e
> > > > until we move forward to re-attachable marks.
> > >
> > > I'm not so much worried about the case when placing of the mark races=
 with
> > > unlink. There I agree we can somehow paper over the problem for now. =
What
> > > I'm more worried about is the case where someone places a precontent =
/
> > > permission mark on the inode and a malicious user does hardlink + ope=
n +
> > > unlink trick and after unlinking the original link to the inode, he h=
as an
> > > open fd to the inode stripped of any notification marks which I'd say
> > > violates the promise of precontent / permission marks.
> >
> > I see. so we need a point where there are no more hardlinks and no more
> > dentry aliases to the inode.
> >
> > How about we check for this condition?
> >
> > --- a/fs/dcache.c
> > +++ b/fs/dcache.c
> > @@ -471,7 +471,7 @@ static void dentry_unlink_inode(struct dentry * den=
try)
> >         raw_write_seqcount_end(&dentry->d_seq);
> >         spin_unlock(&dentry->d_lock);
> >         spin_unlock(&inode->i_lock);
> > -       if (!inode->i_nlink)
> > +       if (!inode->i_nlink && hlist_empty(&inode->i_dentry))
> >                 fsnotify_inoderemove(inode);
>
> This looks like an intriguing idea. But I think it still has a hole. Unti=
l
> the last inode reference is put, open_by_handle() can still get you a new
> dentry and an open file pointing to that inode.

Maybe we can close this hole, because whether open_by_handle()
should or should not succeed in this case is not well defined,
We can make it defined.
Something like this?
NFS should have a sillyrenamed link to avoid undefined behavior
around unlinked open files.

Thanks,
Amir.

--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -459,6 +459,7 @@ static void dentry_unlink_inode(struct dentry * dentry)
        __releases(dentry->d_inode->i_lock)
 {
        struct inode *inode =3D dentry->d_inode;
+       bool dead;

        raw_write_seqcount_begin(&dentry->d_seq);
        __d_clear_type_and_inode(dentry);
@@ -469,9 +470,12 @@ static void dentry_unlink_inode(struct dentry * dentry=
)
         */
        dentry->waiters =3D NULL;
        raw_write_seqcount_end(&dentry->d_seq);
+       dead =3D !inode->i_nlink && hlist_empty(&inode->i_dentry);
+       if (dead)
+               inode->i_state |=3D I_ZOMBIE;
        spin_unlock(&dentry->d_lock);
        spin_unlock(&inode->i_lock);
-       if (!inode->i_nlink)
+       if (dead)
                fsnotify_inoderemove(inode);
        if (dentry->d_op && dentry->d_op->d_iput)
                dentry->d_op->d_iput(dentry, inode);
@@ -2244,6 +2248,12 @@ static struct dentry *__d_obtain_alias(struct
inode *inode, bool disconnected)

        security_d_instantiate(new, inode);
        spin_lock(&inode->i_lock);
+       if (inode->i_state & I_ZOMBIE) {
+               spin_unlock(&inode->i_lock);
+               dput(new);
+               iput(inode);
+               return ERR_PTR(-ESTALE);
+       }
        res =3D __d_find_any_alias(inode); /* recheck under lock */
        if (likely(!res)) { /* still no alias, attach a disconnected dentry=
 */
                unsigned add_flags =3D d_flags_for_inode(inode);
