Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE19526E6F2
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 23:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773791393; cv=pass; b=NOWUHq+fhB3U3Mjth1LCGRPWVIXyflgnx/Mqqg6UycfXb6ZD44B8NeJwo6vKP0SMP2kGIdJANbsDhnR5Z29XSsPaRLYto6MNu90hQtR5B2iKNz38dj6OWHKKjq5U52WoVBC0MwR91ktSfUIRrDYsxsLLSh6oqLete2Vg12N02w0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773791393; c=relaxed/simple;
	bh=wcaG+C6cOWgbfGLYrP0G7G71WLiy8kaZ497R0zwz8Sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aofV52FtZLtH4SWK6yxRlJUHj89YTg21is7OKhvkqDlpLAfp21ouCLMYO49NtiUSFif8LmMAwxuh+HY9xT27Snid8QcQTJt3wZawD4MeXzHmaoaiqagfnhTLIRTeGeP+6JEMReybMMZVJ9UlW0W35//TD9ny1ILW1V8/pEzV0Eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOoVwwm7; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOoVwwm7"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43b3f91a7abso1915890f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 16:49:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773791390; cv=none;
        d=google.com; s=arc-20240605;
        b=bF4cV5Xcl67tSQV9U4w7e/vd+0c6m/w3OSJhb6FwKVTMPzT0LbXpT8zqfMjqi/yB62
         6AvqyLIKe06/rs0CBFeaDvqKTPpz+MSRYc3fuw8VRX5QiPsyqRAst9y2iGd4oiXI2VVc
         SFgtK3Ucy9+E0vs4sNjT7JMFQec3b3UH04W7CwC3TmNcoi4a80d1R9Pv9cPSNykaa8W2
         p6/ZHvB2ApBztBdNC3xuQTILT0sWXbKn+LNMpac7yTZSKtjxSstzExwUbIp9wOZQmtAw
         SE1zF178rF8q+wEEuQe0FyivX3EDAaXEUu9Ow9kbT2TJBkVBNufDL7hZzfbRBTrJgmK0
         ZXww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dvl4dgHacgMTo7qphvK4lNzfyiRHrOjJ61hs+qQmiyk=;
        fh=SM2G5hoUvEghAYqSb2/L9NYG15aF0Gm37cH6iRDffMc=;
        b=PgzJT7H2UKUYCgdYl5WuDy3PVrEEEd4Ah17JC4p6JBt7bwFlIy7Gcv+uj6nE7pb49I
         OU6FI4GloPIWs+Nkfv/UaemZgH65qWb38j7En8CLH8vwDcwvSEjVbVAUoqRN2esPJJoa
         Ga/3JctTQ+JFKne6FvhIlMosJTeQy+FocCa7ilGRIk1ps9mFI3KKzHz0PJMbCWRRkf2i
         P/D6eSd0FwlHVkKc5NnwEFcK1sn3uwPGiUzCot4eqsEE9h0hYk4dw1yIDMFlWrzLh7tZ
         hvlwC8eQaMCVB3IVQUmS0C2p3HBD8haWCCkP53ev5icGwEgE1i3OF/0SIFH+sZ8/mLaT
         zsOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773791390; x=1774396190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvl4dgHacgMTo7qphvK4lNzfyiRHrOjJ61hs+qQmiyk=;
        b=QOoVwwm71l4uL+fJoa48R6OIaTBm3ANIOzXoO9Xf89D0gJLOiO7wGmMkwFpPd66RM8
         IgeC4gZQRcDtb9kvNrKuy6dzIWR62V8ejwTdLM4/fJ4Ns+7RPnar9VHT2r2tkKBu2pL0
         NX+agMJ/suV7Usq8CBlVoLfEAdqlDmOKjhYQGV/inQMwPPVCmKpHjaVqhdng70xLXozv
         CjePf/7vjgEYtmMZR3IgUoOWGPIr/fESQMK4ltK+S2r2Ge3/fKQ7hEnPV0bBj883KlFK
         JJMqj84IaaV1xY937yN9DhVi/XvCKiu6Fb2AT1qnY3aFETQu/iU+TjIG05mTrTui0cgm
         3Ezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773791390; x=1774396190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dvl4dgHacgMTo7qphvK4lNzfyiRHrOjJ61hs+qQmiyk=;
        b=NTPlH8vPCzov9QDdpAjrJQfowEd+EiwExKHQHBLLVX86XgSQDaYG7XGmqPsc/mWkWR
         pruzE5hHZTQp4xURmaMLcWW0CwHlq54EsjCCwdgx4yr/O4RA5YPyAGqSjdpgeaaK6Dv0
         +cZ0dCR2SiscWPVa4818ELqFUIEsc8LMkL832F2FEspI6yGC5f3dM5GwDTB0PgoKmktT
         hExSTApYH0IT6W6dbQQN+/nrAkro1XvHsUW6U0pFLJR6RIzaUvhdCcx2SiCq30udghYd
         HD9EPusXVdKXVHE5RpyZRjekJh/x3RNC6fZvleg+Vqxw0YJymPB/ifXGNIdKpLNVP72p
         Zh5g==
X-Forwarded-Encrypted: i=1; AJvYcCUcIRuo7kJZ+o8OamYogIoPvGy+WFsSglDy6ATbm1pz/6d40++O+qlPrtw+6qZb47OStdhdN7I1HsgnLtoR@vger.kernel.org
X-Gm-Message-State: AOJu0YxXrZU3H7meD1RBz9GDN3/uNMgbst8n+Di/D7Dnz4yoB7MVM85A
	RyAWvRXJsRpsKdMP6rff0CGgZDWmMRjIl0WV9SKMu6zP+fQ0k3e+sEZpbRt43LdmLZhjXhaGDFG
	Rgjv6EPAalxBuDlCFlzoK5Aq+4i6sT8ENZvggT9A=
X-Gm-Gg: ATEYQzzVKUTjibkyqU8wIUXKf+7geEgakxD9DHSHXEHFICcwaiTQAYBM93kmCdZDiKw
	yO1y1iII2k2TwrhRYtVh0xjG7O6TBfAjMmcvOOBV8C7ttN0lnwNY+MfPCTmO+BYqXmZglrYqiZa
	w2OhaEu3fDfY5V5Wek/UNC9M5+ctz0/aw6HiXhTN0ZZUlhCvAoeab7zwTCl7g4bo+PZA4PF4wNM
	N6szN/eBLuvb38z1QmFFtFJ38EEaUkZ2LCTeJwXau9QUdZFSPV1QXl88/Jp6t8NmKp2bgsJg2n0
	UNVr7g==
X-Received: by 2002:a05:6000:40de:b0:439:b539:787 with SMTP id
 ffacd0b85a97d-43b527cb618mr1756334f8f.53.1773791390094; Tue, 17 Mar 2026
 16:49:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312194019.3077902-1-mszeredi@redhat.com> <20260312194019.3077902-4-mszeredi@redhat.com>
 <20260313230934.GG1742010@frogsfrogsfrogs> <CAJfpeguqNU_Q62vDS6nL_w3wBtGU8osE4d9pRFKFMVq-ATRFMw@mail.gmail.com>
 <20260317233913.GS6069@frogsfrogsfrogs>
In-Reply-To: <20260317233913.GS6069@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 17 Mar 2026 16:49:38 -0700
X-Gm-Features: AaiRm53gg6TOMDuWetiI0fRaO_dSrt0T1ACeXEn6Wy9neCtab-Rb4FcJCWTa-2o
Message-ID: <CAJnrk1Z4ntEKfDrvsUJLoTP2tfvUo9Sth1ogUqN+5dxP3p+y_g@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] fuse: don't require /dev/fuse fd to be kept open
 during mount
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-fsdevel@vger.kernel.org, Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 4:40=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Mon, Mar 16, 2026 at 12:29:53PM +0100, Miklos Szeredi wrote:
> > On Sat, 14 Mar 2026 at 00:09, Darrick J. Wong <djwong@kernel.org> wrote=
:
> > >
> > > Perhaps my broader question is, what /does/ happen if a fuse server
> > > thread starts processing a request and crashes out before replying?  =
I
> > > guess that means the request is never completed, but in the case of
> > > !(synchronous FUSE_INIT) we'd just see the whole server terminate, wh=
ich
> > > would then release the fuse dev fd?
> >
> > Right.
>
> (I forget, what was the purpose of synchronous FUSE_INIT?)

"FUSE_INIT has always been asynchronous with mount.  That means that the
server processed this request after the mount syscall returned.

This means that FUSE_INIT can't supply the root inode's ID, hence it
currently has a hardcoded value.  There are other limitations such as not
being able to perform getxattr during mount, which is needed by selinux."

from https://lore.kernel.org/linux-fsdevel/20250827110004.584582-1-mszeredi=
@redhat.com/


Thanks,
Joanne

>
> --D
>
> > Thanks,
> > Miklos
>
