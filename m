Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22D338238A
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 10:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776680075; cv=pass; b=Il9C0ghwonqW7LFB3zbisbMuuWNZsjLI/HRQCCkbb9393ilYUFvQu0cQ/8nNWPN1pCGp80vqidj1EYSiGPUeTJEOE/0VTqYmxmYW7OCFgFrp2DaXnTv5AJ5+PzvMFMD9T/9ReOaEl3KCE6hi8m5pOl4iabuq0wCpxMMDVEqq+uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776680075; c=relaxed/simple;
	bh=8lgmDExFcXpY7s3eAFFcs7uqszUfPLz6vN1ZC8pE900=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muCXa7XhcOQrNWc0WzPuizA5E0rkaj+5rNKWkrb7xt/BmNHesdanu7tWeTyTaODEMu8OhpmJpEdP0MUTn+QzncKDm49AHHZMOGEsAkubY+/J6lCBjoCHecQHkmYp8GzM1QOcjUFxMoPERr9Pt/P09ZEmyCb+nsk6TqE0lKfLBo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=V8h7J3VI; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="V8h7J3VI"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50e63771d91so4894271cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 03:14:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776680072; cv=none;
        d=google.com; s=arc-20240605;
        b=fhKIOLJmA/VyGpABldY5wau7KKAILykI4qK7ZcMALijs4knM822Ut2Pupo/D5ihA0F
         7ntsbrRH8WiTOvJpJdA2rU5HIktLCAC9z3peny6oJN6/EuQExgG95QiXmTINaor3YwH+
         ecvXCKq0BnLcOJ1yXp2q7Bn8J8SGYYIZuDi6sZYCf68GyG55XwH7pChrGcEfDUFl/bGP
         U/wmvqSOTJCquxowS6AN7eRixt8/uKmNSbnjmdGXBGmMqyRDiiGi4lX3XzuOMliNPzXN
         HMqOol8weblj8mTQ4ZUk+gXC0I3zbCmVKXZW5XUW/Jq6RoqKxyl+lA+DhyyJCnuP9scp
         rccg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4yQrDGDk/wcFrASZmcYEDDh4Yv75Vu53tanwvJ4+ZkY=;
        fh=tGcpEzPXu8pjtfuRYLeXAmim7bVW0yAgmrQ97rhXDiY=;
        b=RYaBVzWTEAk0W8O+f9fZz6SprAM04hmMK+9v7L6CaYE+mj6gbPsi8ZKzSdEBdvijLU
         iYnEJ9CYj85QZoo2sNP9gNAImU2mOofhHqsecH9c8wz0AJdaCbHGTdpMW4p+VgEtmsIA
         zVZ798vfqoHgg4Ejvu1BoP9Qbd/ke2/OlIwLsANh94pSuoV2uLy4wwzc/Zy+GdHCe0vm
         tx0LEySNPgH4lmn4Ltj0DW4GxlUZTgd3o/gmXypR3N1yS5OZvXzMRB6JhL9+raTSCZLx
         MZpohiLtJGohBKw+VQRAHNhGID8xyteaVevcevMxRCrqVYpMI8GlWEu/UmAgerkWJ3/F
         dRXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1776680072; x=1777284872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yQrDGDk/wcFrASZmcYEDDh4Yv75Vu53tanwvJ4+ZkY=;
        b=V8h7J3VIGpaoQcdgfjoNo7/2Nt37TKtJRJ/6B93IfELb/f1PEsmThMwjg4UAw21pXQ
         0H/i4Az79uxXbmlhkPcPEpOzNzHwSG27PibpCFgdd3r8DCqcIB2AIY5YHe2xqtxSrzJh
         9WUIK1NIp1fBjT7Ics8m0K0NzKd0wt4/6HgrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776680072; x=1777284872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4yQrDGDk/wcFrASZmcYEDDh4Yv75Vu53tanwvJ4+ZkY=;
        b=tNRUaXwwylKOYGScJ2IhNz1NuzBKXPsDInASt/vm7DRjDewMykI0y8i4l20DCHQoPl
         zcJhEj/wbhlImQ8Q/zeoljulqUUqYj7JDftoSu2jp7t5udygCVinory3P2vXvczNyomP
         w0YSlDvBG+OMIBGyohuQ9wWFxP8iHRh3c1cDYOtXAFy8YjmWaN/nk01RNw2Lkgoh3yJO
         72ReBwpR8KYvgI8nVHsOV+IN1vlX+ltdzV8rgmQmajOwOcYa/8/sIbssAHjMq5tDrlsE
         ytlF7qhpKpLXY/ZksPB7DqmDqRGyj4R5rSEwNmn4Ze+MvtFERysgur7RZgwK640UKHv/
         diuQ==
X-Forwarded-Encrypted: i=1; AFNElJ+gsSAn/9/mnGBl3p9YyKJVyGH1+m5kpeZUQFMQ1XSqi0gcnSzjrMPzx2itLgDVF2F6xtFbtL3hYjVAmeYe@vger.kernel.org
X-Gm-Message-State: AOJu0YzztUYubl9YNjrreq6ZW4BVROij1XpXcvPP84kHZ+EDWiuh6CG8
	yWDljzAuRkPRHwZmvk1CftTiSNF7erXlBKo1On2jcnxRX99HAlulAo3/3U4tmgIhmBZfNKmkZo8
	Vbl0kogqPFLCuLQslEFCjf//gJWyhhAvbYnYi1iaqAQ==
X-Gm-Gg: AeBDieswucrxhru4u9mtRGodQFqXOtp/jdgGhFolNLQXcG7Vs5gsO4FMiCcH9bFi0CO
	7+BK7oEKdeNhSFR4zAz0a3pTHy53PwW54fxLKuKAIE5Y/4VH/nslf136fvh98qVvXEh+cNMrd8I
	3FCOwBLh5yaEObF7KNEHnYhxGu5Ke/H2LcO6enEucn8wBct7Tmc3chXH9dX5fx1mii/8wBKTGQF
	UfWRe7B9mmteYjPZNxlklZhNZ0b6NPiHewKbBGKL/jjwP7EfMy2hGyw+1Yg2xJqUzgEUhX3y6oE
	O1bS4tIrs2TKSNMiPqBEooLG13qwxCmwerI7b2z8mqw+64BtrKI=
X-Received: by 2002:a05:622a:1110:b0:50d:a8f5:d51f with SMTP id
 d75a77b69052e-50e36c5861dmr193555201cf.45.1776680072432; Mon, 20 Apr 2026
 03:14:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416091658.462783-1-mszeredi@redhat.com> <20260416091658.462783-21-mszeredi@redhat.com>
 <CAJnrk1Z7cgKGM6s5CaOg9t+qQ206otDop6YdzGmV1dFw9M3KSA@mail.gmail.com>
In-Reply-To: <CAJnrk1Z7cgKGM6s5CaOg9t+qQ206otDop6YdzGmV1dFw9M3KSA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 20 Apr 2026 12:14:21 +0200
X-Gm-Features: AQROBzDLy1_pOJ6hHmsMyUpa8Kx0Z3MNs-rLkzH3sHWUW9SpUyLFstJGJgCljbk
Message-ID: <CAJfpegtMBZeM_f=KhNym5fW6HCXvU5ydMtmeZS4q8h5Fneu9jw@mail.gmail.com>
Subject: Re: [PATCH 20/32] fuse: split off fuse_args and related definitions
 into a separate header
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 17 Apr 2026 at 23:53, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> On Thu, Apr 16, 2026 at 2:19=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.c=
om> wrote:

> > +       void (*end)(struct fuse_args *args, int error);
>
> I think you accidentally dropped the first arg (struct fuse_mount *fm)
> when moving this over?

Fixed, thanks.

Miklos
