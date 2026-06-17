Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF0D3B0AE5
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781726255; cv=pass; b=TdID9evupp82Onwt7xOEoMZDRsbzoSTK66FtdchuC7DSGUPViwPpQ+yiW8nUJgtz5tQCbNdvhrkuQgrAC3xgROPNPIfsRu7TIa8JdXBmN1B0/pIHIKpmVg1K/xwwBj8kguu9O6eGfyvJpVDyeJGkm6+Atq23QaYHn5bYVAfQCXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781726255; c=relaxed/simple;
	bh=zJ0IUeGHsdJdPluNaERbeBaxMQit3LG3hz6ZGuJa0tY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSm/87zdGKolYrJWiOaJleRim0hohGNrYgeZ7IsUOc12VgPI0sAd6wiZkrRVuyfUbi8zWXFKYpR7a/8UJsnDQaxi1Pm7TdCK4BtficvKX+rZLzMyJymtiwvegs8iqm62i746yD0GuBW2xSlk3oGM0vwSIWuABTheyDzX0PZ128I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oO/cUxIB; arc=pass smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oO/cUxIB"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6a0b1edbe32so188487eaf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 12:57:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781726246; cv=none;
        d=google.com; s=arc-20240605;
        b=Mjise8GFxZ/01dCfEG7tez1PAQrcZarjv7uLn/I6hcmqYEi1WeUVBYn2HjJNQQNCjr
         csNmlfstVUIKyQCVD3V4y4pk3CcRCiIMOj8vBYEwwp0UUARGjgutRVlS7lxSsLaz0Qdv
         2HGOyhuJCQMLxIuTslRgsQH4hQ0xqWX56e3JJL0EB7aimV8c+Ds41D0QvZRB7FSlwPy8
         jZLJFhGQLiBJBPVU9YlL6lZsfFkZ28+qVZ1UyeQv7SVIDB8TkXnUPThan1P+vHTczwWx
         LrBCMaPgrzPHr6Eli6ksxCA6C8XEiGkjLU72CMu9QFnmvXsFM/PrtMNLi6b/SFXpcvHL
         s8TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i6aC/adY0+BnTZkQLrAHVNjq6XIIvBAX4bGpMQTnTwE=;
        fh=EsFTwqU/KjN2Qw3ub9uPeABiaaNvCCoXwU9AVsyLFOM=;
        b=b9X0JFPI4B9ikv3fdHn1aKOTPyL1fPLZiK7PKzhlPm/w+HckdcfU/a79TQAtU8daLj
         RT6AHmfRqr2uIM709leNT5fCrL+Z9rFgxqpIDkxR5x+EzeEblWentxRY+RukwFquocZ+
         gLDADeBAWTLjLjzGVli3jOHi3DOYqXLIbY555sl4rkx2k1qPrtzxIUG+a8twt3QjMYAO
         gf8cipWWAro8Wjv9KLhormbgVmoz+6jErWH+wxCsq45iRThy4iqFsGkg/DhqsTQsEdNL
         MzCPXvwE+scoeL4gZ6RbgzmyGmfdmmWGpIYHKgvvY5pI1GUfL8/mfKG3JRf/MZNdi9y+
         ZaSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781726246; x=1782331046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6aC/adY0+BnTZkQLrAHVNjq6XIIvBAX4bGpMQTnTwE=;
        b=oO/cUxIBVolPAntAAuoSBXmkw4TumAzDD85o96DnyS4iiQj3HZ0dtSJbT0Hpo2vJO2
         /kij/dzjJxhogUHoe5spNaMHiXgh/l09z/0H7K4U5iBnd1KiAqC0g3ykXwnMFMKHpuaJ
         qHCMc7l3xUpj8fNv5TY2YVDcjkTwXuGqIbHBeK+LNDAC/msoX5rlNR0qPMlhNqixpPj4
         4slxXitO3p9gh0FITq06WE4+27Jp30zYL+yVAdJpZb7/YO02yml0dxjYD6HGb0wovww/
         2ghC51srA2wAdk+UjVuCNRZQZaRa1kRyUDb92GtXyhCBGOuFmYIhW08Lzhpiy7NFT/xn
         Qwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781726246; x=1782331046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i6aC/adY0+BnTZkQLrAHVNjq6XIIvBAX4bGpMQTnTwE=;
        b=gMebnmyWkOpXKCHnrQwPOaA3zcO3bMFASgY5gvW8kjmzHswnn0S0PU6I4YIM3XLcJF
         fzoqUAS4NG78eX41CnXxbgIlktx25YV0pGFuGkPPp0xTDp3qw4m4KJ3wpY95dL2QbnPt
         +PhATNp+QS33/dglu/t4gnweky97sEIOhY6OVTKk0vRO7e34s3QE6y7W9z1L+49lOt6o
         7LbWCjDJUGKppGJMCcS1ym0NAN02NSmjPbJxzfqqkN42hlUN0W+fH2M+m4IZ2I+lI+g6
         FR/Z/NOFyeSK5UKsRtoKJqERFfagwBL5HxlTjIiCa0JjjwgtJE6Usq5qY2eamdGf52oC
         383w==
X-Forwarded-Encrypted: i=1; AFNElJ/S/4ePBVkJfhJsmisiOOjrkO2DpHGtUWKmAt1UcqtJHosgVzONUlgOI2camG3An7id60xhBchKmmsUbhSZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyLwJifpH2362hrovXxsk20YHCfqttWRIuv2njcZuPuCS2qAQ1X
	iZLNqb9LBxsQDFu0V/Lsn6WTMj4ssnZ7KhD/B4CIovGw8tTyO4bLF+5jfqKBS6biXP7xZbdI9Oc
	3mnqHdh+K6Vd0EGK6LMo8eoqbpc+6O9s=
X-Gm-Gg: Acq92OHMpUusv+9Q/3NmAtIEMlNmDXUj39UTXzg+e8sygzzh3yDj0gV4L8AuBqxbl8w
	PKHwjSXMoHXZpYlZeVxTa/9rY9reRv+G93Vp+Vr50Q9jSegpHV9+q9zvl9KFpKB4/7G23BfErAR
	rD7W7Y8sQV9/TasBtJg/C/Xw1T8IDWx7mXQdi5tSLK7GviMyg5YrWnuRlZDFh0FbMYm/EXNPISp
	tJ6PbtTcv5AjOeF7MQNLUKyDRZliyXrdycoVEAp0kX1FEcrMIISChv3p+ebe+p4e8Vd+xU=
X-Received: by 2002:a05:6820:1c90:b0:68a:f494:e8fc with SMTP id
 006d021491bc7-6a0b60c0b36mr3762306eaf.33.1781726245995; Wed, 17 Jun 2026
 12:57:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <20260601-enthusiasmus-canceln-anlehnen-0e62317a9784@brauner>
 <CAHk-=wifX_rrDjRGnDnOqE-usptAukuXKrmuPuVDP5bOCBWzGQ@mail.gmail.com>
 <20260601173325.GH2636677@ZenIV> <83f05c55-efba-4bf5-abfe-d2ab0819e904@packett.cool>
 <CAJnrk1Y9egYizkx1H9K0cqxSYuB+7vLvQbV7Tf4C5eHFqnnC-A@mail.gmail.com> <20260617-attest-gewechselt-tragik-7ed473860051@brauner>
In-Reply-To: <20260617-attest-gewechselt-tragik-7ed473860051@brauner>
From: Andrei Vagin <avagin@gmail.com>
Date: Wed, 17 Jun 2026 12:57:14 -0700
X-Gm-Features: AVVi8CcHFrVPI3Twv4VAYTkdhufN4WGXszz_j2JUYmYPkPtYdrsmDFCM1RURvTg
Message-ID: <CANaxB-zK5q=Xw6UZTmeFtXsDZjUsPkFk=p485m-wtNTBnf4hgg@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Christian Brauner <brauner@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, Val Packett <val@packett.cool>, 
	Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Askar Safin <safinaskar@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-api@vger.kernel.org, netdev@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, patches@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, fuse-devel <fuse-devel@lists.linux.dev>, 
	Bernd Schubert <bernd@bsbernd.com>, Aleksandr Mikhalitsyn <alexander@mihalicyn.com>, 
	"criu@lists.linux.dev" <criu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 4:08=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> > After this patch, step b) is a straight copy which means step d)'s
> > fixup doesn't modify what's in the pipe. This could be fixed up in
> > libfuse to not depend on modify-after-vmsplice, but I don't think this
> > helps for applications using already-released libfuse versions. I
> > think this patch needs to be reverted.
>
> Note, nothing was merged. I deliberately kept in -next though for a long
> time to see how quickly we'd see regressions.

The bait worked. CRIU wins a prize in this lottery.

The CRIU fifo test fails with this change. The problem is that vmsplice
with SPLICE_F_NONBLOCK to a fifo file descriptor fails with -EOPNOTSUPP.

It seems we need a fix like this one:

diff --git a/fs/pipe.c b/fs/pipe.c
index 429b0714ec57..6fc49e933727 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1253,6 +1253,7 @@ static int fifo_open(struct inode *inode, struct
file *filp)

        /* We can only do regular read/write on fifos */
        stream_open(inode, filp);
+       filp->f_mode |=3D FMODE_NOWAIT;

        switch (filp->f_mode & (FMODE_READ | FMODE_WRITE)) {
        case FMODE_READ:
