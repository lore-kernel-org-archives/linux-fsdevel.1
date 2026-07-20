Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7856F3A450F
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571142; cv=pass; b=YZA0AMGFljAZEnnsTvCsr2laTfA0hOUi6YdmdIa+60E88+TkFuJDXfkimvxDO8ZcwjRQZmB6XCMgAShB0aJ6E38HKSBc3tbtu4b+NNFpwnYkUA8muV+GbulE6xHSm0dJZMNrTgutabFIeYAdN278fujilprrqeA8HzLGtkOEwsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571142; c=relaxed/simple;
	bh=1JX430VNbqj0hZ6Lzk0OOAcmh3W6k774gqZhhQCrP/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vd0ZVUAoP2KtKx8mAAmC5omdZHGcOt5wwaywHONueYF1FHOgXMO0aGrYBsZGhrIBh1vZlCKKM6dDLoB3PbyNh4uZowyRl4MTh/NsbEIGd7iC5iVe2KlzDFzzcWJAxAmk0zo1DOev0/THCUP2PImvQ/1YN7AF4Uh12Li5NDfWfyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWLp4eZh; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWLp4eZh"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2caced6038eso56745115ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 11:12:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784571141; cv=none;
        d=google.com; s=arc-20260327;
        b=bMHOr1wy7UMf6NJQphS+SoNOQgRv1aPs4qbq56dF7x4nqDy5J1Y5GuSiSHB6PpK7Kz
         4tbqGvJ6hYASOI9JhOp3zic9k8EN0Uy3SaYNepM/6707pq91EECN0KXcrRv0LliXqDUs
         1G1+9xfSNpzQ8rQ4Oyy0nmHq0nd7PV65QEmkfNOSkkoQqNw/xfUIoENag4Fb3hmoBxOe
         Yih4xHXHa2fJLow1kLs4ablCB3XpdSvLYFfPabgKzYOTE8UVYm9+pfGZcHF0uoEoiMfq
         RU258KLqSxAOmJHIWpnwpW4CRs0hAx5J7cvjL6LY9VLAVEP65axeCHSn+Q5MsmJu1v7K
         EdwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lNJFFcN3wjr5bUpQXM7xbGj3SPGWcRQviakfsaDwtEQ=;
        fh=JPjKkAowDhf9nk1/jATuyieCilcYvCEKnj7SbVPyyoU=;
        b=NoaHgxB4Bme0SDYRSPyqu+DbiIoUp19mqylN/Es+WtdAMgmgSJf7EcDejxH/F6TwPu
         lGr++th0pmxKD4adEL6+jEhUestn+nG4JAHKPI/NlHDTiJ4W5PvpCteM7Y5T05WwmLmm
         G15eFp4h8IwOcrzUFlnOzX1GM2wtqt8BFWP/ZX/8+HawOsfCxaol1sYuCeErEJqtS+aM
         pqvrCL/bu9lKYgoaGIEeekTjj2C4oNY2W+rl+lVpdhKa1+a98MmPHhux9HItWPrkXhjp
         l2h9RJX37t8vWBVIVh7tc4UnzQksHNaqJEWXQPRbsncL9DItF2X5GBdb6aOBMvgzNGiS
         T9NQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784571141; x=1785175941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lNJFFcN3wjr5bUpQXM7xbGj3SPGWcRQviakfsaDwtEQ=;
        b=KWLp4eZhCGEaAiHAaTC37TOMSNgeCcmI9tjMngAHzbisyIIl4DD9oLzg+2o95wMPsv
         hE6y6Jl2R+fRW6GE7j8EoS1lgNSWUYXfvXHSml+nSoWRFyXNmaPRqI3r+WomGDlOOfse
         KEN5FUQx/u367rVVi8P++/X65Pg7d86mfGno+CcG8y5Z4Ww7bl3cicaMvNnU94ZyGf31
         tgRqMiLTY80YuoEfpKD/fgdKKmmq0VGW5CPlyeiyORPA5gn6NnDOHFi3fY0LAKS55pS7
         zlCeCbqa0b/kzaq5RD9bgq2lWh1NGTSIzn4cGQvlFvEodoT9KXZhOkSsuPwxBpSCMOZq
         b47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784571141; x=1785175941;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lNJFFcN3wjr5bUpQXM7xbGj3SPGWcRQviakfsaDwtEQ=;
        b=HGWVmQLKzsXJAlPWP46X3Mv1s979/F5JaBuBoC4FnIftOsKIwKeotR61jLIs3Zg3xM
         2thMiT5ZUCbnV07BjQfH4U9EKEJJfa34MHXjTMvpB4cFqpBYi4cRstDNYi+78f4B81jS
         snaSMmK0w4kkrVHXc8bnLk/D9IT4R78Dlduuz6IeSfPG5DLxgJb9YpmOLRStyELaR10T
         cwIZujSh97YziVqyt2l7h8z5w86v8hnp0e7b9waDCJC1kuonwKxE8LaAlMrTnsRR0XBG
         4kgaGokLSAphVxPOg6yGuEQJzYXLSDpdtm9RBuKPCC0HeRWQvTB7uqlCZPVNloDivYad
         Axxg==
X-Forwarded-Encrypted: i=1; AHgh+RoqRSQLrYPqYPYjbL1YIgWwItEQ28HT/P6NfAWtvzRjhN1VMsvPQkXkcfeKVONyXC3FnBUcXuo/502k+qIQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyoCWFbuI4P6ISlBIH/75HFUEM0PsmLhrZSQrla33l9AvBGw3q9
	CUkxKricuM81V6s+WZmVrqR7PE2vLOMYfv4Elt2t34TM4gzArd/06HG7EESXG0SdoltdSXZUMgt
	crdTKhtQBt6owM2T/p+c4okMgcyvYIUM=
X-Gm-Gg: AR+sD13nuLk7LUT9T2BavAtfqDVQsQx8VH53Wvhla51QuExIkRYW0Ds/lZeuL9wa1vN
	u+rqtNo7Zi5UhPryJoQ/nTwbC/KwAwCiVW5KZqXisxATvyvE/QcACFua9yslIy5sf1AuW1VwHht
	ZbXowZVlGuaCM7dZs8pQpW9KDqvcbD8gapwMCBNaLNoTUc3QMVnXIDW7KK094pY0qG2H83rkNSk
	+yS9EO1y+K2p96l4DjbxiiOjSRjA8Bme3obt3vWoK9dZTZwRsYVbPoU3pF44mpkctjPX+UwerHm
	Zc+MiUR5GTxNUL0p
X-Received: by 2002:a17:902:ea10:b0:2cc:ac15:ff4c with SMTP id
 d9443c01a7336-2cf1f29ea6amr213030675ad.8.1784571140752; Mon, 20 Jul 2026
 11:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708000956.46138-3-dwindsor@gmail.com> <a3a376bce713ac38ce6746508239c1af@paul-moore.com>
In-Reply-To: <a3a376bce713ac38ce6746508239c1af@paul-moore.com>
From: David Windsor <dwindsor@gmail.com>
Date: Mon, 20 Jul 2026 14:12:06 -0400
X-Gm-Features: AUfX_mxSx6cvDqWkeZpCRVrryYfuXxFSwFH_5FN2Ivh39vzoR79SkwFUGoqzhZo
Message-ID: <CAEXv5_gt7BPWvdR4D1_3XJ0_XpBXWN52jeAOf1K2QJ7LL6CtPQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Paul Moore <paul@paul-moore.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 5:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
>
> I'm sorry David, now that I'm seeing this function again, especially
> with the LSM specific bits extracted into a LSM function, this absolutely
> belongs somewhere under security/.  It's only callable from within a
> BPF LSM callback and all it does outside of some BPF pointer boilerplate
> is call right back into a LSM helper function.
>
> If the BPF maintainers aren't willing to accept that, then we will all
> need to find another way.
>

Where this code lands doesn't matter to me, so I'll stay out of the
decision of where it lives.

If this kfunc goes to security/, would we also want to move eg
bpf_set_dentry_xattr similarly?

I'll roll v6 of this series meanwhile and we'll see what the BPF
maintainers say.
