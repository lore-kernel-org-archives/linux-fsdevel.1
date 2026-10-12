Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826CC3ACEED
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791802126; cv=pass; b=ka6C6aNg7Nmy+5xswNnldRwEa2RI4D2dmZ0OXVuBdtZePYYPibD+WSNCnUesbCIjGhSjHS7mpTI9sGlru8Csc9p/xsJ0R80SqTPihlba7bNZCg8YuE/BBhsPAIh7y1Zkyl9Eb43inZQp5q9jz3zmjdzJ4N1iwPVrbxejVxzODTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791802126; c=relaxed/simple;
	bh=yJxWfUPJuEqTfpU+R7hcqH890XgyQDGvAsHg33GYD/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTCJW79yQSonv++/NsYflZbs9MBZXDOvI9EkL/NhMMSropqtjCXxCqcV8ODT0cH2I6qPIb4tMFcjU9rUavLhrT6n6Bb8Bgor4haZznrUbUhLB+9BAEcX5eam+wdEXrBWKQLMPonmVx4Ml0YbULpVvIDTCJKSguX16Onghdkzd+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvBFtxeK; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvBFtxeK"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c2e6df2742cso256367666b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 03:48:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791802124; cv=none;
        d=google.com; s=arc-20260327;
        b=fP8Eptee45w5N7ryYqgmqHoDwxWhXfcoquKRxbhi1bIb8hEkGvkgeTtcucdOLZWu0/
         Dti62NlIvFTugo3+J0I7DOkuUShPP9LKod67aCx4q4ZcIAj4lTnfPKiVS0Ub1riohCn1
         6ttzTE6BMUTLA3B7kPAAZz9yQgOOgf4OV5mnCwpC2e7W4qBMfqK87Z1VTENgWEnuNduk
         jGN1baC9pwSoBcA9A6j9rOV4oij/MQ7mWYpsJKug+3ldHRWkB1eGrhebXtptL6xqrwve
         2dxu91D0130tXoNQUh80ipRChx9lkPNLpvkUh8e5u1eIzGS9srxs/P8HzchiIBC+F6y+
         3gJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yJxWfUPJuEqTfpU+R7hcqH890XgyQDGvAsHg33GYD/0=;
        fh=vvUc/P/vKExtuCfuctQphhehAWhNUk6b8RoJnOJOJ7Q=;
        b=Z5cbszimf+XEazdoodrk7+of8PE+XWN6ii5VM8gjaexyvEM/rr4TFYbJsuXTRwatKP
         dpMh42UdyQCZqdAZ5+2IBuaZ9hnV0O0M8pfqa30/yDWLmdO7i048F/50j10hOEYuYvgB
         7m9Z5EjJ+9uYDVv4O/Mwjmc1MZW/Gu1Yt2UZFaBNFBnj1pm20N3OP8V4fBe2zHpWDFu0
         t6znwOAkMQPLXC++ZXkZXVtR8pYT5bg1oALfk7ByPiokW4OnyidiLfeePBqRld6hhKZT
         uxTM+6ziGwZHQVtHtFCE0GIyHVdSg6yKrNswkgeC55GRVYgn6mQf4s8cDkeeZ8WHpruU
         UJnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791802124; x=1792406924; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yJxWfUPJuEqTfpU+R7hcqH890XgyQDGvAsHg33GYD/0=;
        b=MvBFtxeKDOS0EdVSG2Bp43g81Bi6onlFsI6m7PX2arlBI/Lf9WVTJGY55yT1SPwWG7
         VQ9mZ5HJ4UgNpK7bxJWf1x7s9S6wA/KvlBGmonjzZE0fJ+jry407rP27T3xYbvwCsOHP
         o3yNZ5XMViZQnksQUsNwVOMznDRU3qDUgMNTsvA8OSeSDB5+CRVFIT8V/zvlKtDuOsgI
         DtS+tr21PELCB22XorPSM34sJzvuUotH2ZB9R/AZYEJJ/y0x5xbrznN4VjKuurYOf84t
         bpPbol/Ss626BRA2J7WIvbpHqdUwbZO9UUCyWC2xj80XpNtCofoQTI/9WOknG9ytT9xL
         88zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791802124; x=1792406924;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yJxWfUPJuEqTfpU+R7hcqH890XgyQDGvAsHg33GYD/0=;
        b=bT4ocpuzXey7aX3cTS7M8nG5gZL3gV/nvxcL91YZS+zyGEx1vu0YOmC0zug3micfJ1
         dMAaVI4yicgx35oPzqVlwNQfGpOWZ6A5Lx89r+zuHUDmaQZj1dpXemQhr41Fh9gjW0l/
         +LibwaH7r1kuaQkl3LDSVXeXk09P7Zvfl6DfP4UY17wEf3PV3nkfUQhk38EBmrgz0QBL
         DBkLqeze73DcbJ/y+u8yYl1KmgPfVXYFwpBXTSEaCKbUDEIRzi1y8a0g+rWokq1TXZoi
         MyymZ89Zya17h1XShKtQLEbjTfKxwYiV5vtQhvbnHWSYd3qfc/gwHbf3etsWD5m7i+Bq
         KNLA==
X-Gm-Message-State: AFq9FYLeYxvNEMPhXqd1uvim3oq3TuB99iQh5eQiTRHG8mibeYZNsuGM
	qV5swV6SKUQOH3um1k+1JF6OkMUcC6zpJoepZp+1xl+j6IMj+5AjMHnFqxppkQs7w5/EcnGOXTH
	92Ub4Oer/LkNY9GWMhmvqCe1LTkys0x8=
X-Gm-Gg: AYBFou1JYUlJToKkn0ehR6a8jhbwzPjMPyP/PcDZAA3gD5TFRg89KuQamufC9YLFyp2
	mjJbIwJUlW1m071D49vFsnzYP1SQlpTEKnb+cX4BV0gNxYQ1vcqpdSgE8kL2L2PmhUqzNPkri42
	TNM5/i6GXDZ7/p8S55qQilooOamldq4lpzGwLg0V7JerAkh4Tcx3qVLVxNt+Fqd5fA0eyppivUW
	FfAB1tI1Jeuu94qmYC0O3JCrRmkVU9eMmHnEvtZO8LNLSL7g4dBAZjQCNG5zflAxMxD4svDQcuZ
	L3gqhq9NFPwiE0bYH0Wl8J1sTw163rwSN2kVCXT2lDlAQe9SlZe6xu7p++8ahgeV0rM=
X-Received: by 2002:a17:907:97d6:b0:c2e:2944:d6c7 with SMTP id
 a640c23a62f3a-c31aa036549mr927162766b.29.1791802123504; Mon, 12 Oct 2026
 03:48:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
 <20260930-work-mount-fixes-3-v1-14-be34c83956ae@kernel.org>
 <20261001-prollen-rutschen-amtssiegel-31392f0a489c@brauner>
 <CAOQ4uxinQiXn=F8p92rCTzwX5AcBiN0abWW7jE9jKE+zqjb1_g@mail.gmail.com> <20261001-abgehackt-herzmuskel-worauf-80bcefb0a8dd@brauner>
In-Reply-To: <20261001-abgehackt-herzmuskel-worauf-80bcefb0a8dd@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 12 Oct 2026 12:48:30 +0200
X-Gm-Features: AclHuK9M9jsbz9zheu8tLl_AdY6hC66_jaZlchTl42QorNNsWlRmIkLJwfQ6nNk
Message-ID: <CAOQ4uxgXLcV3tmFp-gfF4Fm8ivvqGJzZXf3hmSeqo5dkzPv-=Q@mail.gmail.com>
Subject: Re: [PATCH 14/17] fsnotify: detach the connector before destroying
 its marks
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Chris Mason <mason@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, bpf@vger.kernel.org, stable@vger.kernel.org, 
	Daehyeon Ko <4ncienth@gmail.com>, Kyle Zeng <kylebot@openai.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 2:06=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> > Isn't the inotify problem described in the commit message already solve=
d by
> > 669bb5af15d41 ("fs: make sure to call fsnotify_inoderemove() only once =
when
> > inode is dead=E2=80=9D) on vfs-7.4.misc?
>
> Indeed, I forgot this patch existed. Good, then we can drop this.

Alas, not quite.

Kyle Zeng was able to provide a reproducer for the race off-list,
which is not solved by 669bb5af15d41.

He provided a tested fix patch following the same idea as I mentioned with
FSNOTIFY_CONN_FLAG_OBJ_DEAD, which he called
FSNOTIFY_CONN_FLAG_DESTROYING.
I provided RVB for his patch and I think we should go with it.

Regarding 669bb5af15d41 in your tree. I think it needs a new revision.
I will send it with explanations on the email thread that lead up to
669bb5af15d41 [1].

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxj4sYikVUEhV1pdUdzoq2U4pBa6=
RheZa7a0WanBmXkEow@mail.gmail.com/
