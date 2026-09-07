Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7530C227BB9
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788779329; cv=pass; b=EN25GPPWEzXMQfDMzXIGvchBLRDgNMqljO/2YWz8FJ3bJZ+/gRFTEzGyYrHsl7UBALXP0/TAEq7Iaaep6tj6BeaErRFCYaceYsE/Laf3rs0zBqDe7jJHKDBebKhCzWbZqths/FzmY1PIQhV/N2Ta6ki+UDzUV3XaPR5+EO3Fv8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788779329; c=relaxed/simple;
	bh=BR+eUj/ALV0eoXQmo7i7n34XaH7aoKJnU1bS8FGvxoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ux3olhgzX3F+aMcWyVV+RcbOTIytXNLpoW3DJLFKDSQPvbbE0yb2u2haVTqSIIqwVtGdu92vIMdURE2eoJJHOO5rhUIMiIo4kUlezniOm3uo3SA3rpKnrXsGc2zN9FzZZKGrpM4EUUkS6Q4yA54FCzcQmun1S91b8KmDTM8iLHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ns6QrfWI; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ns6QrfWI"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a600a1caf8so5289402a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 04:08:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788779326; cv=none;
        d=google.com; s=arc-20260327;
        b=gh9lBGrwOV7beO4oMhk/0bOeeoXV4Hz2Fl9Y68sJuTDeuIE6EyTiVxWWaVODhV6MtG
         ZJeflxHmRrxCk9suaxhsEhAFYnjBRrMGCyQGsBQbv+1COxCLSTk+7P7PqggJJjCfa9DE
         o7BZQfirCi0Ng/GRxjIX3Ei3iS+zjOYIBFwHCZ49xaROE+G0Meysfm1P71/h+wV6i5ek
         z1gWbmj4xmphrzDgQYboOw+r4EWvseVL/SEUsv5pGu2LNoHJ1U75IfuwF+Y5Xu6f4fA+
         cO0VWMs//vs/2HxuZQ3gh/B6InuQ6q8yV0zurdCAQ+naqqk/dX+uNOhkIValYD+ofqT2
         vShg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0/lzFsFhEaINkh+OA6BnMxyXwomqvTDkY7AyQ5pswls=;
        fh=VG+Xwjm6JXUNT6r55zQxCfKNEQHhp31ovQLLlNaXny4=;
        b=micG7Zi/cf4HqRd8DuTA55Ybs7hVDUqWxFo6JrHi4KDUX9ZUWEA6Jv9G1U4echxj+D
         tInppnQxsDvzfeSxQII4ASkQhFK76qfqa04oOyzanJIN+k4mxjwbIkh/7lvCdUqrqKR6
         WEtoJ6YqS4s9Tsl6toB1GklKW6bJ511xB3RqOywxJWe3M/MQa4FXxJSKy7mUgLVSjauL
         RBLk7mbaSnEHeM0uZDLMAu31x7GHzT+ijQbejBHv49kSYjEs6ILCVfT/NR3XOCUJRIwp
         bOknlyDkco8+RMohJVe6WecbHGWdMt/e02teRoyKEf9gMRzagnTLL7tMl9RmWUMC0NMk
         dt7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788779326; x=1789384126; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0/lzFsFhEaINkh+OA6BnMxyXwomqvTDkY7AyQ5pswls=;
        b=ns6QrfWIKW9xEXdIi6P1CN3CT+NNAsSJ9onkLx8xKYjt19n13DMRg8Di+9fwQ3B7MH
         lqPFgECZcK3Aul2YUiG9mGBeil25UMpdZMDgAxxIaHq1QpJVw5OwAn1+y4pmzyyV7VsU
         NsTQsDJtsFaASff63T/a6ZiAqJt1KsUuINB6JWHgpV0OH6qKtj+p+k31AZrCitQ++Xu2
         u3KRZ6E4/x9FkRsACCvr408ynx35VySyrMOhOZ4gQvk4G/W55W+NZORr3swGG6vgniT7
         kdAxoQF814mg8uY8z9d7ojoNSNCe7DHu3C75BmL84C9mb82+xC7SzSd89hSAOmPQyQfT
         E//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788779326; x=1789384126;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0/lzFsFhEaINkh+OA6BnMxyXwomqvTDkY7AyQ5pswls=;
        b=RxXk6azvpJtiDeG99iOujTFNAhyKz2fMkQMFPb2I1OqYP6MRFiOVA+gw/sx0d+4RR7
         fRm5VYYUe4WQ6h65HON7MayNCW3voQReT0SnnBD1SwZ8zMRof0fHcGJnqGdYkJWKf0DI
         bQkUPer6ONpzxtrNXZklE4jwQvTNupg8/eNQ2F/iw3p/U+D0pqL8TcVxn4KQppTkXWaK
         1RPnj4YXqkFL3p4Ob3571gmbgg9MO+0wV7F/rjlbhVeVH+DTz/cjmrLR+FlD1vDbqHTg
         KZoPglWCxG2AQtBA0mEcAiRP7a13zmV8s25Imrff/qyRh28mfEgPAcIUU3z900VN5mUW
         3nWg==
X-Forwarded-Encrypted: i=1; AKwUvBzdW1BAlg8wJQJsqwr7oIncgPhO7wzphjoMIjz2s2EUkTCFKIM3tzCgxXls4IoOVwdJbGuriLZCJ3YCkH5P@vger.kernel.org
X-Gm-Message-State: AFuF++kLiwXGKpbVaoCYLaCg0hs+8rSvSkx9YYkXXrCdFH1BE29ie1Kb
	YW/wSsi65GPYpybIgKeRrpF8bzd5CBk3tnV9z2oAIwb+eBEohqtzaDnG7QyBbRFmgvlARsSCFzC
	SwCcRGwWBqZ/GkXd88D/97GJV1zcfD0U=
X-Gm-Gg: AYBFou1QewnWyJX+EhtxFdT9OGekNvJuQE9XUBXVQ2hpA1XrfBWcVa/emSJhI5a8YuN
	U3gc8YLwcwavPkEOMhYUXvg2I2R9Xxf2luV13yR/hgTrXZaaounuIl1mnuWOKe7r1AMmXt6h9xk
	CkEzNrvIerxGeear8dld5cK5kfPBwpiSPU9w6OVuERoAOaUhaFUKCUDwbLIoRI82wN6yCTJ5A4j
	hTvvj01dH6zLe01gKn4OMLTB5GMiBlYIoXSY7cHBgec6jfaSy1fuFje6L/bSj8MWFiDyPTZhGJH
	PBAEZxcaxwK+sWCQe2oa5l7n10+EwIFnVFVk3tmtJsCYecZmn8tgnXzB
X-Received: by 2002:a05:6402:44c4:b0:6a5:f814:2278 with SMTP id
 4fb4d7f45d1cf-6a7e8d25c02mr5757746a12.2.1788779325248; Mon, 07 Sep 2026
 04:08:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907045517.1347518-1-cui.tao@linux.dev> <73236c69-bd81-45e1-8195-59775a34475a@linux.dev>
In-Reply-To: <73236c69-bd81-45e1-8195-59775a34475a@linux.dev>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 7 Sep 2026 13:08:33 +0200
X-Gm-Features: AcwNN1WRkYAEFvO02MfgvO2cIVdjx8ikA3HzbSdaJ9Rlgd-Ol6Vhuk6uNLapsKs
Message-ID: <CAOQ4uxj5thxY2sMkJUO__qWxVX5AdKeb+e1zoHcYfQBPyfqvhg@mail.gmail.com>
Subject: Re: [PATCH] ovl: clean up dir on casefold mismatch
To: Tao Cui <cui.tao@linux.dev>
Cc: linux-unionfs@vger.kernel.org, miklos@szeredi.hu, andrealmeid@igalia.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tao Cui <cuitao@kylinos.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 7:38=E2=80=AFAM Tao Cui <cui.tao@linux.dev> wrote:
>
>
>
> =E5=9C=A8 2026/9/7 12:55, Tao Cui =E5=86=99=E9=81=93:
> > From: Tao Cui <cuitao@kylinos.cn>
> >
> > In ovl_create_real(), the S_IFDIR case checks after a successful
> > ovl_do_mkdir() that the new directory inherited the expected casefold
> > flag.  On mismatch, err is set to -EINVAL but the directory that was
> > just created in the workdir or in the upper layer is left behind.
> >
> > The mismatch is reachable: ofs->casefold is fixed at mount time, but
> > the casefold flag of the index dir can diverge.

Hi Tao,

This is a case of:

Changes to the underlying filesystems while part of a mounted overlay
filesystem are not allowed.  If the underlying filesystem is changed,
the behavior of the overlay is undefined, though it will not result in
a crash or deadlock.

I am not sympathetic to adding code to gracefully cleanup after
this error.

Assuming that you are utilizing LLM to help you with writing overlayfs
patches please refer LLM to this commandment.

Thanks,
Amir.

> > With index=3Don, a
> > pre-existing "index" directory with +F is accepted at mount, and every
> > temp mkdir for an index entry inside it fails the check and leaks one
> > directory.  Measured on an ext4 casefold upper: 100 directory renames
> > left 100 "#nnnn" entries in the index dir, one per failed mkdir,
> > growing without bound.
> >
> > Clean up the created directory with ovl_cleanup_locked() before
> > returning the error.  All callers of ovl_create_real() arrive with the
> > parent inode locked (via start_creating()), so the locked variant must
> > be used; ovl_cleanup() would deadlock on inode_lock().
> >
> > Fixes: dfc7da402ccc9 ("ovl: Check for casefold consistency when creatin=
g new dentries")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> > ---
> >  fs/overlayfs/dir.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index 7beb0af26498..4e451bbd8f97 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -188,6 +188,7 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, =
struct dentry *parent,
> >                       if (!err && ofs->casefold !=3D ovl_dentry_casefol=
ded(newdentry)) {
> >                               pr_warn_ratelimited("wrong inherited case=
fold (%pd2)\n",
> >                                                   newdentry);
> > +                             ovl_cleanup_locked(ofs, dir, newdentry);
> >                               err =3D -EINVAL;
> >                       }
> >                       break;
>
> Sashiko pointed out that the casefold check can crash on a negative
> dentry (https://sashiko.dev/#/patchset/20260907045517.1347518-1-cui.tao%4=
0linux.dev):
>
> ovl_dentry_casefolded() evaluates IS_CASEFOLDED(d_inode()), which is a
> plain dereference, so a negative dentry would crash before we even get
> to the WARN_ON(!newdentry->d_inode) check below.  And if it somehow
> survived that, ovl_cleanup_locked() would rmdir a negative dentry.
>
> The NULL deref itself is pre-existing (dfc7da402ccc9), but the cleanup
> call makes it worse, so I'll fix the ordering in v2:
>
> +                       if (!err && d_is_positive(newdentry) &&
> +                           ofs->casefold !=3D ovl_dentry_casefolded(newd=
entry)) {
>
> Negative dentries stay on the existing WARN_ON path.
>
>
>
