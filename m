Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793813578;
	b=wjzd/AU0igGuoSUVKxrKt/4ncl0uQZ/Jusmjxs+qgdHcERtVfQZFy3Kq3icd0aFSwH/O
	 ifkSspaW27p2SZy1IB+y1je3DYagIyvYvHNlVfe0nIOtM0DZHCD7mOwcpIU/ypERpH1lS
	 1wWqMdueccS20MkUHD3WrqWxXWNYZt6WHuVnvU5J0qzNJNFu04JTWrYZ0YD6BIRBOZ0be
	 ico/kX3cdRyXyngLfzq0P32Io7z9m24mbf0JFxE+1LElQG7dTk/KS49qiyhIqQvxAPl5h
	 NrelxUxbq8BbjjhuCdNM5aVVk+fFyhExR9M2GL4CmqAyEqSkbeeNrK2zl4u+6B8KLdw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813578;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Mu/e4yaFN9LQNUfDEaiq9ZKyo7jmvn2P77FadrJquUg=;
	b=NYfYnSCK2fxyGpVsZj4vsnlAQ3Bldlt8Jisf/SOWIfhWzYaCRCEM9mgwonOIP7A0+akG
	 oc/ObbPqBdZXaT9/0ec9u+sHIBwf87ep1Rru+o+G+Ym7CMYKvh3rthEGBjZXNXq414spd
	 /T0LGqp1oGFOcVvlExq2FWsLxWXUjqgW9Kxwbg0KJuKu3wdfRERfLYhnKCPuXTAZ4Gu4Q
	 0U6EV9NZC5SqaWyv0WZh/N3X2oRKqMIo61Z/xzEu80Q2fN0o1rKbjp8d4AoGyQoC9J/JJ
	 A+2ehIgwPf9/RbnGoPXFYupWUW4ne9lTx+XQoXot65r7DlH07mSwX+grLhro70ToqdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RJnLh6xj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0399606A902
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 17:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0399606A902
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RJnLh6xj
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6acb9c018ffso1383054a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 09:32:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793813576; cv=none;
        d=google.com; s=arc-20260327;
        b=eWXByZFkUmsJU2xQUw0i6qIsLQxZq9B3emv2Y+5qE+BZoQL7TXRRllRoIOBOhLbSvn
         hoDCqeiv8eCPBTh4pcKMEC0+lcFWR0cPjYm2irshH4x24Nst12UIiaG4X5OUMp1SWiCs
         mTPwaydRFON1s7+/bfNL3iQIwMnvw1UmyFYv7sWXe+Tvop0MJtqtX+goNsnBEVmUkHae
         EsVqv49LHXhN9mlQT/nfaaxESAOhtIfd9sevIO5cqt0lAEOgwd9dQ3/M2nPQU04eOgbl
         OnYFk3oveHrInoTW8z0ZSMzeLNfGECIYFmGtSQ6nbCYCxxjxW5YGRn+sEJpzhKdJ409n
         oSjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mu/e4yaFN9LQNUfDEaiq9ZKyo7jmvn2P77FadrJquUg=;
        fh=4rfzylhdf38+DF/o9/dGWrIIu8kkCpZ7NeWfADQ2prs=;
        b=q3MuTov2gZ9FXblkoXyAeRNxHSVE/9zHhv1uQVPiAwXKTDgD8a/rlUFzRbHiXpknnm
         M2r6xgADbXRxlRTyFPrklKMDovUkokrLh45bQTr1Hk2SMzMDbCt9/uW6KB4k1so61w2n
         SQucGkWWvQsms6yTespNlpD59H0nKxZiZVO9H/61K7DQO90DcGD7CeZ90taZ0opI/lCw
         dMIiTg9/jxjI9iguzq//8Ez17uYuC/e2E+IwIarNHW57u0QPnfene9MoSkxwR4sU1HNP
         HfvkLcACXJOX9o+1Yhs0+kuyMqK76sq6h/HlHDdV0xlgXHYDsvroaEyZnYsnucZoT+t9
         D88Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793813576; x=1794418376; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mu/e4yaFN9LQNUfDEaiq9ZKyo7jmvn2P77FadrJquUg=;
        b=RJnLh6xjfbqaIIUDfw3cp3McuWfIdf2Ng2nJ5Ww1CApa4eS9uV78kIXmxus5ZTu2tP
         XkFuwuHq3tUtk4RL4mVf0fg1DlOOrKI8y8iMjoP7SABOdttcvg6tVw70LLyZwXp+NMni
         /HVHw4kqnvbrlmj0TPZH9t/vrXFZKg5ERUKPagYIguYD198G0LQetCq60OCmm4NnTCnm
         l4r8fVPFB3CcitRtJIFBMYBLczSn3LDbvWb4iIS/A84aKXMaITJfXZwra2iGK3f9NRyL
         V511JRnoi7mHQG58uBq3gpLAVtj+UX8yo/wrCmjgIYhVK3XCMUDEwQCOpbL2BTdbXmgN
         FpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793813576; x=1794418376;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mu/e4yaFN9LQNUfDEaiq9ZKyo7jmvn2P77FadrJquUg=;
        b=hAsYyJHGDfvCtnlLdY5nxI2zvyhfaOQ9vGcAFktyyqzVnviwpDHgXwK5aiDichuEak
         nzYs8W/1nFMtM68sOCZsWJHXHOzvhVW2CWJ03+cSXcQk5rPoFWDEELSVV3IU1jHsReeY
         7rMU4bIIIzjXbkC5QtIAuleOLk/nb7uUmZbbKnE9KmUxEckdigLb34nxHXxUUZw+GYq/
         J3K/goZz9LUDQKyqaASdIyuY0JUblb5spETghrH5pKxx75nL1C8d8QkgMMZOhguplfej
         u+HflwO1lBUgKNFboWF6EJcFUMH6TeIbuvkSjE8FDl5GKEgkPB4hdudDwYVb4NxYyA3u
         b43w==
X-Forwarded-Encrypted: i=1; AKwUvBzemcxoiuiMwnfbZQLXtGUfIrxyjpwsBsCaIcRvUW5B2VL+B9y6ymv1H+zlgEz3H5ypAhShY1vWTvYGitFw@vger.kernel.org
X-Gm-Message-State: APuU4Z9N5Y2V8orz48j1pE5Z1JXbky+w8xfxr/c+XDNMY51dLdAw6P8Z
	n2HmGCqj8vHMTgnPBQf/GXHEBHSCy/npWcKqKmPqvZb4ut1oQsfs/U9rpqw5psHKuJ/X1bs5AQS
	CF22gysHDlbo+rw0J7afVi6sUo+JM1Q0=
X-Gm-Gg: AYBFou0KLSRrNNR13/6rviM9a966zAUbGO7dRpL5czj441NXXQmiRpOAewpvQuqTFTn
	CelxesqGG3hHkisxHUsojGTs9NJ7S+AD24iUo/YSItsaP/ZfoscP5kdIt+Ezq4Rf53Ohnnu2n0E
	uwRk0TA/0ZqEUv50cA/hDq8J6DcAgyeJDi/R7aJjSth9FrTKRZUQ7Og8NFnwQZzNltZCdYWNwD6
	7qV7zX07zTlTBSMV39jdrLD3QGCks/kkutq15dT3FfxSwqv62RzP+ZJWl13YNG4Gx5oAy/jVQg6
	fQXKsR344U37YLWGe60ZqqY5hEpQonIE/ai2Ne+mlXmfhbavuHRRznU4zMeEE9enVaIXte0etvN
	jqC53K8LKbS5XqOeupuRsCJQ83GwBc9zeadpDYUMYsB1RWvUjHZXsxm00T8Lcz55+YHbdRg==
X-Received: by 2002:a05:6402:5187:b0:6b5:6c8f:22c with SMTP id
 4fb4d7f45d1cf-6b577183624mr170574a12.5.1793813575918; Wed, 04 Nov 2026
 09:32:55 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-b4-ovl-containerized-sync-v2-0-4e9f08e4a052@toxicpanda.com>
 <CAOQ4uxhWy2aQV6g7VJcV+NDLPTSoGyR4Rag8uvAwN=LWnApaJA@mail.gmail.com> <b9d94891c6bbb0a18176424eadf6ff88.josef@toxicpanda.com>
In-Reply-To: <b9d94891c6bbb0a18176424eadf6ff88.josef@toxicpanda.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 4 Nov 2026 18:32:43 +0100
X-Gm-Features: AclHuK_59wvajkPMd500vbmbA1AMyOdJVXBnQNeByyLMSA4U6W7ked8knU-c4rc
Message-ID: <CAOQ4uxid3ig6M_k4W+wXh8K+P5jiCpuYRNoq+CHnzHfYjwihug@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] ovl: only sync what was written through the overlay
To: Josef Bacik <josef@toxicpanda.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
	Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chengguang Xu <charliecgxu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 6:22=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> w=
rote:
>
> On Mon, Nov 2, 2026 at 11:14 AM Amir Goldstein <amir73il@gmail.com> wrote=
:
> > I think this is over engineering.
> >
> > What is our goal here?
> >
> > Make overlayfs behave better for the (many) containers use case.
> >
> > Who in their right mind uses a host filesystem which is not one of the
> > big three?
>
> I mean I'm good to say if you use something other than the big three
> you're on your own. I built it out this way because I assumed my
> attitude of "I only care about 3 file systems" wasn't acceptable, I'm so
> happy to find I was wrong.

Well no mean to disrespect any filesystem but I was referring to the use
case or running a multitude of containers.

Who does that not on a proper distro or on their own in house distro with
a proven server host filesystem?

I am asking genuinely. I don't think that the use case exists.

It doesn't even have to be the big three, it could be out of tree ZFS
or bcachefs, but as long as you trust your host filesystem to hold
massive server workloads it cannot be a toy and it has to have
a balance between performance and durability which implies that
fsync=3Drelaxed should be good.

Hand waving reasoning indeed, but if someone doesn't like it
they are free to choose any from the available fsync modes
for their system.

Thanks,
Amir.
