Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0DF32A3FF
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 22:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786746508; cv=pass; b=kxj7jiBj7wqBnIwP2FZRxppuWPnFJzT18HUj0rW7slGqhsXqP6W/ZdCPQKRQbsq5EfNN8VVbVBeSokpmt0R+uZ9c/10gTLj298tRXH/gnWaQgczffT398XJbnQpr97hfh0VJylFSTNPf2OHBeRZyDpoa45fq7hop6ZH5JHh1FSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786746508; c=relaxed/simple;
	bh=0MqcfTpV4J3JQ5XxEfh9bBWGuS4YdzM6e+2A1t6TKHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTK+sRJT0FBo3Zc2Ibg+MNZ80z3vAQUXoFDYbqjh+WVYgVkP5YwaophROjblCQnhYGo0SAp4cbC106PJWiHKsxeb8Balr8JwQhornFkghtksSbqKXzbIEdepNXROdt+1hpSHk5oD5GJesa1ftsKUts9Qbz9j8SI7I/wkbc2koc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20251104.gappssmtp.com header.i=@omnibond-com.20251104.gappssmtp.com header.b=PEE4AZYI; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20251104.gappssmtp.com header.i=@omnibond-com.20251104.gappssmtp.com header.b="PEE4AZYI"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ceaf8a1265so22982895ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 15:28:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786746507; cv=none;
        d=google.com; s=arc-20260327;
        b=fZ6RFIQsjN33SX5avsw4d7ZOQ6IhFJ6ZLUx0AtYLHF5K1OnRbEbhXrZAOzMEEs9gaU
         JFMmwQyq/IBKaScnqaEKIEuMd6JD3PvTk1J7zBi85+uy0RV8QgAoV2ymJh0nVToaWQmW
         pO46WSqezHct380+sQr7p7XfrojnmCb3wE2D+s08Ken75fh6oFSfZqiwmjrIAYiQszqF
         3jKvXWqG3+CQXBwXgO94ZoEO6MGePtR29Yhoxgf2n2nUCiaCoHhd188q+MHVKkSO+fgy
         HFpawiK4jxT1gXbpbFIvYkfiKBeZ4b4qPza67HFL1r0ySYKPlQKnNHVt/HBvb/Tx2LLM
         ICeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZhuyItywL8dnIjbxpUCKZqnhY3Rj8J1fDBe80RQAjdY=;
        fh=ROW4xkTDMHfBC4np4yWutJidnc/GJUxBnUHwix05S54=;
        b=mGzL964d4rylsw7+BPx9O9ooppuq0mtzNOXI1Wyp8jV38nUjMHAq2XSYBDpHILk2On
         J6IlJKf01/gMpZv+b1zqm3UhUNqB/vJ3mEO5ee6NmmhbX+212urN8paC3N1eyleRxm/J
         k2rSkgKzDUxac8N+33XzEf3M1fO688TyTClJz1IJY4i2r9GtsFHTXWV5PJ5/+3X01N0N
         blv6JTadbBeJlbnAfOGqN9jHUO8OO7CedAkEna8nEW5bkRrVurEYgdslhfhz/zpf/au3
         eWq8uHcJzKzo4V2UeYvUeZNUMF4dLJOo9khPPHSzMeBKDDRmWqXIQH8kedeeyUgcLPt8
         q8RQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20251104.gappssmtp.com; s=20251104; t=1786746507; x=1787351307; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZhuyItywL8dnIjbxpUCKZqnhY3Rj8J1fDBe80RQAjdY=;
        b=PEE4AZYIchGZ2U9rG0NAEr7Gc0obnz5axpJJVhUrOuCCPSsBLR1r2RLO4vuA5qNFNV
         HBkMeT9MDxECBvd7j6SB3pG/+LcGtW3+40h0srb3IETkjROWMOMUZyToq8RFAl+HCayS
         wx+uw6kFpdAvLLzYm1oQqOiNLeZC1lpNiSqhWso/bsX77+KRQXWAATUd7Z3yjMmi1Nme
         A8KK7Va/uJzubh6KrYmV9Dekp0Q63KMenVtZIM5ZwKbKf8mR6kfCbFTnVdWtiIWPYDML
         sMFvQxLcgiDEotNtvqyBoHzC1RUxAAFdXKDKVAYGE4lnlj96YPxUfFJ2mvB1Iz4dhb5c
         dhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786746507; x=1787351307;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZhuyItywL8dnIjbxpUCKZqnhY3Rj8J1fDBe80RQAjdY=;
        b=kCRCWdrZZUDfwhISplG5uy93akW6IYRmP7iPauEFIszK3AXB3pkDLnWfB7AmrXUyK0
         y2Bl2htlI8zIJG26aalwRC3AVICi3oCbx8wyLiYLtIjWdINwWrRKtnGa/Rm1IJYWnc9w
         EApr6Cz14VFY4LIHyBLNxAn4lI+fu0rZybzXzlJIYYyo2cHDOh88syFVKZCrvU7kx2MK
         7HEKROfMUugW7ObTGKKUJlmNdqf9Dk68XbBNPRCiez3BmScfYm0q2oPoXr6mZiTNWEK+
         G4p7Nfnprj+aGFB2ElRGWYr+iDhvYKUxBdZ2tFkqXKe95mzvUE3n0ZHxjyQ+latsijBD
         eISg==
X-Forwarded-Encrypted: i=1; AHgh+RobLDk0zY8mTQ8U3bihH7jvpty7BF1UrVmUjIGwCMqaKCy2g5bZXKZ3fdLEKu7pIYCxbbY8GTOS9BTnwcrD@vger.kernel.org
X-Gm-Message-State: AOJu0YyL+quZqo11zj5Iu7FdisjBkVT23/b2RXtMVOuBefm/sLU18SxZ
	1EXwCqbIfUt/zWLSzKS/0o5XQjH7CMDEO9n3mXBCR3wyJJpIdDVUiyNsWpVNekkPMgP9tObEJ8g
	ghYiyuftvEP5MfAQloSMe2WkswePSF5Rg3wN4tnkI
X-Gm-Gg: AR+sD100JI9+95FknegbZy+CPHoi3dWCsPlvCkgyVGc4+xDEQBaYJGzE8tY6nep6BfO
	QJq1WX4nnvYyoQyRaegM2WZTJdW6F4CexbJfXvVCPoAcIneIC4XfiArczTvWiOVRNV5OZQ+yACZ
	UeKoVaY3ir+1ER62qWkICweegWCr63dldusO7p/hIollQAckZHKHByIlusEOSmYF7eQ9u21Q43d
	9mIiBKvTWM0D3a4t/pn/wayhMdcMN6lV00yc1NlvLo+mqyClSM9ubaMaIodIhV1JoJyAWnLfoyZ
	aBEig4M36yJYDHFWX1880mc1Y0tt0Mxicm1Xms+njiKfGp9MGLb/9mw9V00Pnq/X3do=
X-Received: by 2002:a17:903:2384:b0:2cf:c543:2c7e with SMTP id
 d9443c01a7336-2d3b088651dmr124080485ad.10.1786746506689; Fri, 14 Aug 2026
 15:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809-orangefs-mkwrite-folio-v1-1-4978a4239475@columbia.edu> <CAOg9mSSHk0eswQ9BdD7K=jutwOXUhAgacnf0tPBRNa8GWCg0zA@mail.gmail.com>
In-Reply-To: <CAOg9mSSHk0eswQ9BdD7K=jutwOXUhAgacnf0tPBRNa8GWCg0zA@mail.gmail.com>
From: Mike Marshall <hubcap@omnibond.com>
Date: Fri, 14 Aug 2026 18:28:15 -0400
X-Gm-Features: AUfX_mzxpLvTNZmZSwX9zS1epwKkjVpK2EvjhHJdeh8C40zp27Ui0vZy_pjztwY
Message-ID: <CAOg9mST1YRwbuRv-JKdOsOCdG963eSv77ACQheVeWNQ0PM_qKQ@mail.gmail.com>
Subject: Re: [PATCH] orangefs: use folio_pos() and folio_size() in orangefs_page_mkwrite()
To: Tal Zussman <tz2294@columbia.edu>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, devel@lists.orangefs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch is in my linux-next, thanks!

-Mike

On Mon, Aug 10, 2026 at 11:21=E2=80=AFAM Mike Marshall <hubcap@omnibond.com=
> wrote:
>
> Thanks! I'm trying to finish up some stuff to get on
> linux-next in time, I'll let you know when I've run your
> patch through xfstests...
>
> -Mike
>
> On Sun, Aug 9, 2026 at 4:07=E2=80=AFPM Tal Zussman <tz2294@columbia.edu> =
wrote:
> >
> > orangefs_page_mkwrite() records the faulted range with
> > page_offset(vmf->page) and PAGE_SIZE, although the write range it sets
> > is attached to the folio and the rest of the function already operates
> > on folios. Use folio_pos() and folio_size() instead. This gets rid of
> > two calls to page_offset(), removing two calls to compound_head().
> >
> > No functional change. orangefs folios are always order-0, so the values
> > are identical. However, if orangefs ever enables large folios, this
> > change is necessary for correctness with the current write range
> > tracking scheme. Tracking only a single page of a larger folio would
> > leave the rest of the folio's dirty data outside the range that gets
> > written back, leading to data loss.
> >
> > Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> > ---
> >  fs/orangefs/inode.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
> > index 7143b64b5b25..cd3273c88e03 100644
> > --- a/fs/orangefs/inode.c
> > +++ b/fs/orangefs/inode.c
> > @@ -652,8 +652,8 @@ vm_fault_t orangefs_page_mkwrite(struct vm_fault *v=
mf)
> >                 wr =3D folio_get_private(folio);
> >                 if (uid_eq(wr->uid, current_fsuid()) &&
> >                     gid_eq(wr->gid, current_fsgid())) {
> > -                       wr->pos =3D page_offset(vmf->page);
> > -                       wr->len =3D PAGE_SIZE;
> > +                       wr->pos =3D folio_pos(folio);
> > +                       wr->len =3D folio_size(folio);
> >                         goto okay;
> >                 } else {
> >                         if (orangefs_launder_folio(folio)) {
> > @@ -667,8 +667,8 @@ vm_fault_t orangefs_page_mkwrite(struct vm_fault *v=
mf)
> >                 ret =3D VM_FAULT_LOCKED|VM_FAULT_RETRY;
> >                 goto out;
> >         }
> > -       wr->pos =3D page_offset(vmf->page);
> > -       wr->len =3D PAGE_SIZE;
> > +       wr->pos =3D folio_pos(folio);
> > +       wr->len =3D folio_size(folio);
> >         wr->uid =3D current_fsuid();
> >         wr->gid =3D current_fsgid();
> >         folio_attach_private(folio, wr);
> >
> > ---
> > base-commit: 075b74841bd0065a3bda3440873c747938e69b68
> > change-id: 20260809-orangefs-mkwrite-folio-ec562f7625b4
> >
> > Best regards,
> > --
> > Tal Zussman <tz2294@columbia.edu>
> >
