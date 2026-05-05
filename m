Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDA935F16F
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 02:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777946543; cv=pass; b=Ql1sMEFrn3VVMStIhINzQjde7FwkaujyF3bMhs1J9UhZUulXlG1dk7q40w8KMz3j9vUainvAlbc0oDHVztft8gs337ps6FNnaPGao1GICOQjZdgrq7LKXMJCaguBSN2bN0pLhczOVFQIroapBGWmZDxN6q7L5NFnuq0JW6C9BEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777946543; c=relaxed/simple;
	bh=QBGR4uo4ZBFT94adMzS0OW2smvVOxlZjnZ8xICFbg8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxxpFfvX1yoJUoazjAm1C3HtvTjekQ+1GdBcV5nZeoASO5n9235B4gMWhWBUGYY830dpfFJOW67giHl8Lrnw5eiI0bIDNFPl9Fg3OJbHVJtxnfto56ienJ8wnglEqylf5EE6I4kjKxlAq51N8Cv3eodoTsYw1McM6ypsZIGamGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YTbCd1hY; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YTbCd1hY"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8379e010b01so688031b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2026 19:02:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777946541; cv=none;
        d=google.com; s=arc-20240605;
        b=Z/E4X7EjIvv9UOWxMsRP1LmsOCwMu/raXe9hgRldln+c1MQeMMABDh3L/epf4srHn+
         KWnAIxS+NdT+tb2/xx9GVD0bChDFfkeSRAaQu/Uzn4WSVJl2phHiNhxurM/511FS/scZ
         BK+7dvSAwSIVyPZVL7QCrpl8DYR1FoCwMsWGlAd4ADXQIMHz6jsrxJZYuHaKh6mWhZ0X
         5GwNFQeSwPSYWZv57FqqA6qT6Li5hgTLKdmeiRzKv/us9mi2D9Kb2+S2y6EZd8UlwmDh
         +Y2P4gCH4ziMjHI2RdkyiI/IOef9S+ncW+ORvndh62Ur4FgFYdqy8pcEW+AkwIBsg1iX
         3HyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=miwU/ecb6g7PnqI2pTJ+Cbe7pB50VxWGMEGUDTC3cfc=;
        fh=aqxjjiE25uwdn8rGEKIFrkfXQVAgQqWN6GIPIEqwXOs=;
        b=T3lWn91ymtgnRYBx3Zjls+gbD8gkwrekqs3JfVdpCNDTRSwXPhaI9Oops2m+1m3NjU
         w6+CwM+JII2gta/EjPF0jAv7vO6oI/MfbVTilBFSpvPA8Its6nP4XIoDqXtHo6BMNPfD
         LIRTVtOdPkftYi0BkBAvUgmeDyfkW/7nY60tNM8KZamUpIhwOznTOB/bncG3WTJQY7ET
         RFexDRvf0F62i6NYLIqZ7TuuDhYhWl0aQUpS/mAmgN9EH9hqxgcCl+mdkmbXjpOBWeLB
         BPeTz4MSPClu8iOu3y9FFagXK7oUNRVrWztrpV5NFdlq1YVz5sxseP42uZObRBtmKyck
         usVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777946541; x=1778551341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miwU/ecb6g7PnqI2pTJ+Cbe7pB50VxWGMEGUDTC3cfc=;
        b=YTbCd1hY7l9lEBVl0w/wv2iueY9Opq9b60f7gr2EYiXALDYdLGnZJNSYxDZ0gUoU59
         FMCsZV0oEDLmwq8QmKiq6ZrYbHSIkov7begKRKjolVzKn/Oil7irs72AOeksYKDtp9VR
         YuwulX7d9aXBeLa+Wc/5nCX0JrLstVSyHXMorJS/6TpVxwRBKCiGLdXgduORSKD9peKm
         IxtN9zOWg76wwIk5EqHMeQFD0waWhunj5eTWSRCXG+bSqvwfShcV64kApLLJJR1Unj21
         TykSnnpDFKZJpGpvz1+BdXWgiSGPTOXMjAGTmUNnuwpzVvMVYF7GmH0vfMgNX15+ItD/
         23Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777946541; x=1778551341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=miwU/ecb6g7PnqI2pTJ+Cbe7pB50VxWGMEGUDTC3cfc=;
        b=b/S9Vr2h0syAdNTxGzngnhfv6kOJMd48jouF4XnQ3/c5w4qjTXPhHtbNCp9DS+knmn
         OpsyJT0NXa7B/J7CdUN5Y3UJQAeWnA3hgpnMuJlrexuV10Z0HZ6Ji8ZAz4ldmKmQKMMi
         M7Vxih9sEzowDjltp7hs5WDWhUe+E28KqqWQpAxySERv6BtcJ4/Q7PrO0RKUePx+OI9y
         2i/CmWofnXlHksxyVWl6nqKA8s/7pnav1blBq7btCdQnWxyxgQjj0rg4MCgRAlsQFPrV
         r8VzYJwP6PAw60CLpf6yRRXq9HUjeJusVej4HMk5TXiIGDJkie4nuDF595mL2r1iqCYa
         tFrw==
X-Forwarded-Encrypted: i=1; AFNElJ8hXMZIV2RD8nCrh9V9f1IMLKUXhgxEgfN0DvVcADsZV7z2EBrVtEO7QLL8SfmIMsTEujsFAQtEXL/BouEZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzzQb9HZHyrmVCWcc8l4jyF1nN2HEqezoVfXGoyv1emjjGCmsLV
	tIwqHgOvt69qCnJaGqc1JwQd90YU9Fz2LFTGcby/gB+drscDUDrsd+LnNwU2aVn1n3uu4QTo5+M
	UzJ8kDzE9bGcOrYmc/Ej3yx8eRPP3G5vTHltrF+kl
X-Gm-Gg: AeBDievVk8oGTGHS8TQwRoWTZmYouUIqVD3CwdvmDQ1JGCa1Pxka7aTL8mPDeLEmeEY
	LeqWEI3HE3MLkv381rxoHmbwe1o6/fSi2jVlNL4t4IPUKy/ZiIlXVu5SBBJHlMAJpXCzZ3INEqT
	04zKjR9ofnZgBizzU+31B9ZN1vKxZKPrE0wG8NHGFocNuLxfbtCisDmdIslg7rpwpxZGxJYiCgr
	SblMVA2/GB+w4FCvKiU8J1bsOMttb8P6M0lIRpjlpdUnq9Yx1iD2nZgkaeQZ5Ki7XvGdQCp4cpC
	dm1Pm8Oqou8+NdzLzQ==
X-Received: by 2002:a05:6a00:9512:b0:82c:e692:1f91 with SMTP id
 d2e1a72fcca58-8352d281ba7mr11640208b3a.39.1777946541290; Mon, 04 May 2026
 19:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503211835.16103-1-dwindsor@gmail.com> <20260503211835.16103-2-dwindsor@gmail.com>
 <CAHC9VhSy5K5nQTtFUE4BScy1Ur61v7eZW067vTcUYDQeJb13Bw@mail.gmail.com>
 <CAPhsuW6sy2cdC4B7Z48-5A-yVX6fmVWxS_fWVjQxiX95KeUguw@mail.gmail.com>
 <CAHC9VhQLN5NA_ZMMNyUdMCZVdwC3VM4PUnzka8xDK5rpR2a3sw@mail.gmail.com> <CAPhsuW5nDaLAV5UfAHeX6QPeF6bs-WDkFYOzYO7Q9_O6v=jEHA@mail.gmail.com>
In-Reply-To: <CAPhsuW5nDaLAV5UfAHeX6QPeF6bs-WDkFYOzYO7Q9_O6v=jEHA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 4 May 2026 22:02:09 -0400
X-Gm-Features: AVHnY4JNEAGbbhruN9w4Ua7naDL1XKHAY7HZ8pKFMVGcMz5B9Ok6DLP24wok8oc
Message-ID: <CAHC9VhRx7L1WXYgQvWmGN0a7ssSaDKx4JPhup2E3W161sdp74A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Song Liu <song@kernel.org>
Cc: David Windsor <dwindsor@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Jan Kara <jack@suse.cz>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 7:09=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> On Tue, May 5, 2026 at 12:42=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> [...]
> > > > Perhaps I'm simply not seeing it, but is there a check to ensure th=
at
> > > > there is only one BPF LSM calling into security_inode_init_security=
()
> > > > at any given time?  With the BPF LSM only reserving a single xattr
> > > > slot, multiple loaded BPF LSM programs providing
> > > > security_inode_init_security() callbacks will be a problem.
> > >
> > > I don't think there is such a check. Also, a single BPF LSM function
> > > may call the kfunc multiple times, which is also problematic.
> > >
> > > I think we will need to make the default bigger, and also introduce
> > > some realloc mechanism for the worst case scenario. This should
> > > work, but the code might be a bit messy.
> >
> > Thanks for the clarification, that is what I was afraid of when
> > looking at the code, but I was hoping I was just missing it.
> >
> > Increasing the default is an option, but I don't think we want to
> > support a dynamic reallocation scheme for the xattr slots, that will
> > likely get extremely messy with synchronization between the LSM
> > framework and BPF LSM hook registrations as well as special code to
> > handle inodes with lifetimes that are disjoint from the BPF LSM
> > programs ... I suppose there may be a way to do it, but it will surely
> > be ugly and come at a cost.
>
> BPF trampoline already handles all the synchronizations, such as
> add hook, remove hook, etc. properly. So this is not that hard.

How do you plan to handle the issue of disjoint lifetimes?

> All we really need is to allocate a new array, copy pointers, and free
> the old array. And we only really need this in the worst case
> scenarios.

Oh, is that all? :D

Keep in mind that the code must also handle arbitrary ordering of
LSMs; in other words, you must handle a BPF LSM that isn't at the end
of the LSM order.  While a BPF LSM at the end of the LSM list is the
most common, and recommended ordering for the vast majority of users,
we've been working to make the ordering as generalized as possible.

--
paul-moore.com
