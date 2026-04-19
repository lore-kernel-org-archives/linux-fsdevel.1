Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE98A1A3154
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2026 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776596778; cv=pass; b=h7UjlA0pnFx1WuRvyEJSETYwBsgGfsfIaxAub2ranxSql6bsdQENrglByq+LSGO74AO8THK/2mRTBdBbUHrs/QxWwXCdZEaDaPQ77rEhJ2VVp4i1xr9turljt0Q3w5MD6BhrtbtXxQyT5gvNQpNSVj3j/6sZao8bDOhpmasZCzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776596778; c=relaxed/simple;
	bh=m48aZWaNSdkbnGiArphonK6xL1s5rrFvzzUmXfKhPAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MiTRsyf88Ht/6iGddzEopaBxy2Ck+AfRCvxQBls1+LbyQCNX0RcAthxBXVXeTEVHhDWTzKFkO8xidROeLsWmolSS+aZGf9mlXy1+I2pQQc/Ndurp/08/VPeMzU12osAGQJ58mRyrH6S8pUQtLqFc+1lRDzGGe2w4yJ+MnYlPL4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5dA2ATt; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5dA2ATt"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9e00649769so300410466b.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2026 04:06:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776596775; cv=none;
        d=google.com; s=arc-20240605;
        b=cvSB20qXeEaaJEN94ANdu6Pu0/EyCuF6Bv2h1BoUVlvpa4q3burAZbbCnfiGb5MENd
         uEj0wKJ2PU0EJUmLACr0K739FXWMDhQiHe8OhVIyjxZVvrmkX9dNyhS0XswilRHNzWOl
         Sn7cWYFZnky1jWOdJyLZqZt/eGBykzJlQkjOQ5eEovgF4xLu9/pIfNoiuMagzlimBj9K
         +ys8AibG2buUFaSlQMvr7CgeN0Chkb3xczVdjyTbkSJFKzzgs3l6kY5bnWl+n7xLSBpp
         VI3sXGCLq+57lgTsIymzuOkyyLbNlHK3ZrUigYA+ZYdJpHw5chlzArbZwciGrW2ufnKy
         Ou1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bRYh9f9rm4qgaWe1AYdfMws1EAvTcSo9wUj5TY9rqfI=;
        fh=aB1Iqcsdd9uP9oQMpQAqbtPj5Ok5dp+mUA7FI6e/09Y=;
        b=Lcfl3A4xlFCfiyDUOnz6bUm4X1bYg/Q5th+NjtPGzKQvUB2UbsdKKh8sfERAUZHM3+
         csJiGhtPat/JoeRJbD85kyMDLq4M3LXiTkt0669XHVoBnOoKvdDWOS3Ma98Sts7i0/SD
         YWgdychHc1PO4Geg/9LSE+Hfc+AYwIuD2Yhoo722u9ssSgPdF0kD/DtYjOK618F1qGaJ
         zHkmZKmttrjoOsmPi01MdhIXeiEHKO/BAgaS1ve62cUJP4GP1CU/mdv4+YseXmH+bzUN
         jfxQO8LQitg8te9KTeZDajTuhlx6ItiGKNjTQzchUVm+vJtR3EYB0zARJj6+p8t6TWYk
         b6hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776596775; x=1777201575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRYh9f9rm4qgaWe1AYdfMws1EAvTcSo9wUj5TY9rqfI=;
        b=H5dA2ATtYQ7YgTXmVt+zAByOJV5FsneUKebYixw+ElaRo2hH8F4Tg/q6wpXji5vGkU
         FtrHPtMzN022fW0nSnubsLDTjnw5dFYaIvTJLjpD6YkCyGv/jcFDQEoOPiZ0WNFUEyDk
         LY91J1rcOA6bOjNu5OLzqzrbOPUVjTxWybdnXwdfs9iCoo8+86ftrkS6OOYLZHQTICR8
         NI0erlQ8krGpmvWqaUl8wO1sdZWuNeTFkomFJaJ1+w9CqEvJbpK8y+xMe7iX37FPz6Px
         y4oEtqNnx2ZGR965J556M6i78N9CAIrrA9ZlnmEOvwTV95LCxXotOJMAYQ2iysq4Gz1X
         hAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776596775; x=1777201575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bRYh9f9rm4qgaWe1AYdfMws1EAvTcSo9wUj5TY9rqfI=;
        b=CWng+LUCF1yTEG46H5PWbnd5K8ShtC7mZzueke2Kxs3vxQr3grOSH1s0PADMxRxYl6
         jKplDkWEqaFZnsDgA3uY+GgnIM5UFp2cv1Et0rTuNtJ6KU0UtLUxB2IEqsQDOdoTwqR2
         lCR0OAMZuUk9giOgYdaGxMJqZHRxq6vbcDFSOkMuHUWFMwxAAK5rizMJXoLR8Dv5T31j
         BXkRDA/PYme7gb2H8CPWfeWE4yCiLWaxzxzbUffB02ZMlbC54tBIakw1J0F/7I14HDo6
         nBKdsBFJPRTU333XHNz6tvT2CYhfp456R0WOXh6EQDb3QGr9Gbk1y54w7/qqZlXyEL9B
         blew==
X-Forwarded-Encrypted: i=1; AFNElJ+plpVdbn9dWk9HhAU2kzC98YU7yoAjQM8W3f2Azcck2LeppJm2HqgYYf8v4Jkd7rOzRI/MGR0b+tmsqMlR@vger.kernel.org
X-Gm-Message-State: AOJu0YxOJuF0dSn0BgmCJoRNvtSMK5LT6Siss5KovvSN7AajZ3oPBacL
	2sNRm/ynO8+W2kNRizgfCkY/wsPaTGql5NVjsOMR9UkxdkPCzusmiOGBNw6rEHkrhvJ7RUBE6Ju
	FFARChgWEfYCVkBmu3PEQawOvpfq7Bsg=
X-Gm-Gg: AeBDieu+gCb/evgTq74/VLgLJ8eZu5ZrlW6doluwXriXdIs1UFzcWFcveMHA3WGMHVh
	Ya10KK1Qhp/VyDihczIUQWxI/iU/cFcbHqUCa5WQwg/B7n9VC8rIymVCjiBKUYmH1/V3W9fRSfo
	td4hzH3sIhIzv2EGGOqcgAC0LXiRgtJYJE8eAeYg/m6wAdzY/bYN7w0IU61eIQsbxaxaqznaox9
	dza+PCYotDz9tFNhxgG00pmXKF33cWwCVbtsyjMBGZZxdBBifoTbAuwRicPKXei9mTtbAGLuYxy
	zB5ibFeSs25vQTHIo4bg7maUTwllIflIaE6Ceis6hm9W0AhTAfU=
X-Received: by 2002:a17:907:9719:b0:b97:89b5:d7a0 with SMTP id
 a640c23a62f3a-ba41b2e4b1cmr475038466b.48.1776596774877; Sun, 19 Apr 2026
 04:06:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417142503.1436446-1-amir73il@gmail.com> <aeJTecsykkHMSvNh@casper.infradead.org>
 <aeJr8Wq3qmpGk6m9@google.com> <CAOQ4uxhG0wgTAfn-XQz2Kkosh=upeE4x5r_PuYmc_H2X9snogQ@mail.gmail.com>
 <aeQDUIaxc5qBvLA4@google.com>
In-Reply-To: <aeQDUIaxc5qBvLA4@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 19 Apr 2026 13:06:03 +0200
X-Gm-Features: AQROBzDYcctQozFChvwrlPkuST13d68KRLrh3EUT43rrMeQ2v0-aKmUu3Fau_mg
Message-ID: <CAOQ4uxiiB-Vp+PSeUh5K=AZ64MXQmtpn8HHu4m1pwYu+1t=V1Q@mail.gmail.com>
Subject: Re: [PATCH] docs: add guidelines for submitting new filesystems
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 19, 2026 at 12:18=E2=80=AFAM Jaegeuk Kim <jaegeuk@kernel.org> w=
rote:
>
> On 04/18, Amir Goldstein wrote:
> > On Fri, Apr 17, 2026 at 7:20=E2=80=AFPM Jaegeuk Kim <jaegeuk@kernel.org=
> wrote:
> > >
> > > On 04/17, Matthew Wilcox wrote:
> > > >
> > ...
> > > > I kind of want a section on "no weird ioctls".  Anything you want t=
o
> > > > implement beyond ioctls already implemented by other filesystems,
> > > > you need to bring to linux-fsdevel as a separate proposal from "ple=
ase
> > > > merge my filesystem".  Almost anything implemented by f2fs is a goo=
d
> > > > example here.
> > >
> > > I disagree to this. As a filesystem developer, I belive ioctl provide=
s a way
> > > to tune the filesystem-specific features which are not supported by a=
ll the
> > > other filesystems.
> > >
> >
> > Jaegeuk,
> >
> > Note that, despite Matthew's unhidden opinion about "weird ioctls",
> > the proposed clause does not say that they are not allowed.
> >
> > The section refers to the way to submit a new filesystem for review
> > and requests that special ioctls will be clearly submitted separately.
> > Here is how I have added it in my work branch:
> >
> >  - Structure the submission logically.  It is neither acceptable to sen=
d one
> >    large patch containing the entire filesystem, nor is a replay of the=
 full
> >    development history helpful to reviewers.  Instead, split the series=
 by
> >    topic -- for example: superblock and mount handling, inode operation=
s,
> >    directory operations, address space operations, and so on -- so that=
 each
> >    patch is reviewable in isolation.
> >
> >  - Separate any filesystem-specific ioctls into their own patches with
> >    dedicated justification.  Interfaces beyond those already common acr=
oss
> >    other filesystems will receive additional scrutiny because they are =
hard
> >    to maintain and may conflict with future generic interfaces.
> >
> >  - Expect thorough review.  Filesystem code interacts deeply with the V=
FS,
> >    memory management, and block layers, so reviewers will examine the c=
ode
> >    carefully.  Address all review feedback and be prepared for multiple
> >    revision cycles.
>
> Thanks, those are all reasonable to me, as I did quite similarly in 2012,
> https://lwn.net/Articles/518718/.
>
> Some useful tips before submission might be helpful:
> 1) find a company sponsorship for long-term maintenance support
> 2) present key differentiating features to filesystem/kernel leads (e.g.,=
 Ted)
> 3) check any patent/copyright violation
> 4) share the results of xfstests/fsstress/power-off recovery test/code co=
verage
>

Good checklist!

I believe that the document already captures those guidelines,
except for the copyright one which is not filesystem specific.

Thanks,
Amir.
