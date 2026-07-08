Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADE533E360
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524302; cv=pass; b=qJ4xQousSuitCMfM1n/aiPPwHxav39Ch+DK969UWroU4ZcfdnQcjD2YQfc/RjRqCrTA4+8cueqwUAen6IkWiZTMveqBMKzkAukDMCgl+Dym9XCXvVKlfLs08CKvxhq/9yILrHtaQJcbP+SUAXvCUHNleZFVIfQThjfsHGSaXvc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524302; c=relaxed/simple;
	bh=F+RZasg/xR/5J+KDjHvYV2UkgEMCQBTFv6+LQc9hMbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cz6S7gqmDwF0AvYeXeeVEiBOnMWAtXmt3O9qL2LH5gAqkakbf1AfmrZenAFCvZolnmmqIBXMPuNyXOfvH/+mXCSwIv4uUifbRcX8OF7bnBJ2wjRtYLmsmDMwLG9pXmY4+D6j2zc9WWIXAGYhKP5DEqfz37NuyLFbieH9cBdVlMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEBhZOnZ; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEBhZOnZ"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c126fe7d0f3so104114866b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 08:25:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783524299; cv=none;
        d=google.com; s=arc-20260327;
        b=hKm84aYmyBm8ueducISOiUEIvqLqTID+nn+Xzol1LubkY3euWWHQm0gLI/jbHRH78L
         iNrcOTZ+b4X5+Cw5DM3p+pyFLiqyZfNbv6fVRxoxrpHE96ioIcNe94QMAspb7BkL1TXp
         g3gs6AHB9Mdt/Xjxg5NhaI19N4a4J/zhRiO6/Jnu/mvabducxLmtbyb//iCsr8LenwLk
         YvDYStmkHJ90SRsYZ2U/rbETr1yFcg1mA3+yTzOtZddZtMbL3M7DawqfoCLySNOULbXD
         9w4zgEZCUZ+1ANq5A12TwxXydlnWfv2XXL1v5o93bg245qNKqLYv4DqeZa7LiKESd08p
         WX3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F+RZasg/xR/5J+KDjHvYV2UkgEMCQBTFv6+LQc9hMbc=;
        fh=sZHAdi5k5TBTIymBrgIrciSfWwl0lJmfNdrUaMZw7G4=;
        b=j7gouv5+qvBFH5uL/pCmIZZwPJaOORYm/SpubfEw9ubGjWSRgqDwYuRIwKMEfi/NZM
         B8fzd/AkvZBaj7nFII7IyoTtsth8LaqIbZRzu11v2VpW+zVWr1kiArPE8pVOrT5L0v6S
         z9iNrMfLYD+Z33deXPbugni2NIwjtvFH30d/+sjHOaDdW0RTVoYbwlrYNrn0P8LKqBrj
         zgkMzNmBWW66FWqn1FbqTL7S0UhCMoAv6sdEZ0wII6NzJFzdoveijskxIkss2hygY+9v
         ZdiAgeOpoZfuWoHT5NAL+WfdzyA+5Ytqky+wJGt23TO/RcIojwtxzGYqJAu0LfCB193u
         mebQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783524299; x=1784129099; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F+RZasg/xR/5J+KDjHvYV2UkgEMCQBTFv6+LQc9hMbc=;
        b=fEBhZOnZ9Qiv/UilA9ojsaeiQYkrZ3iQH+cpcS1oRsbhqrKsYlwYWDhpaOjlD5DUBO
         Be+sBwal48A2NPlj+BGqzYFnRUdsBXBlv6wqvi39Uc22kxD+fyupI2sF7PC9BAVQsPsD
         TSWX3ptK9mB94dAMNPgapKRwNUdVifOlCTYl7cFgZXWmxltsevKEuPkAED/1vBhsu85R
         DGRTeCQiGvzJHc9nOd7fVJfcIEJz+8DTbatRQ3wHnHdpa0/oLWDxQNNwY9gWwk1NQCv8
         uzc+W6EEpi/Z6cIxxW6+lL37DLVHgsGHGu0qN9YcArnllEnCH44dRJdRbOc46bI2vYtY
         yewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783524299; x=1784129099;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F+RZasg/xR/5J+KDjHvYV2UkgEMCQBTFv6+LQc9hMbc=;
        b=R0wp8KS9QVjXyxiPWbUJ/CTMk8Abal6dXSo9hD6V9clcA6TGSPNRiKzc/U8/eUeTok
         dQygTsx2RKlQBVnEIoVtDHc5mn+FLxHeTGoqANLc5dBWgfZoO8egpiZGJXJF9gAZnsZR
         F8zrjkUFoXvWahgkc0Q3HR+tLindy36DqaUGPpNAQB5u5cCq/6j8Zgq1fOJ3L5bzVxkR
         25PkScuDnKTFFyLdNvAPIHXLc/5WDzPtD4nzd9PQ0lEEa+jILecJdHQyMyz6mir2fUKS
         GZJH93Ps4y0h0UFwz5YoHSNe0+9tyKm2UN5O4+DgDN9Nz66CmLKGtxXnTnJ2PkaeELNT
         A8eg==
X-Forwarded-Encrypted: i=1; AHgh+RrCU/XQ5lLFpWMj/mFKnP7G99UTu+Iev+kDD6Juv/IqHUpbMHR6H0ev0byhqov1DFUgW7lg6u85G4O74TPI@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl50K/g9DHBGSZLF1J/szjqaIBRa2bMcan8jdSDPJaP1XNVFj7
	QzKhzqi31tiBaMAL0OLjFiMIknlc+92NY6iZaVzfw38CzCJj1zu/V+VnX/hMablwP+5gmO1mgbj
	EKWVkJYxxxAlwWZACpRXcNir5NneKfyM=
X-Gm-Gg: AfdE7cmisf6ye6qeZs4qAQ/H0/Mv2nNG3TPLkp6hIaMdYwgtZKLhoDvYEg/n1rmYydY
	+n1hIRgKVV4EkXN4KLGdeyMewI7sE6Hp8y9HudmK2AYt2SDXU9uPkYi8JjOYrdyVBs/pIMx2nzS
	Ey+niHYvXdw+IULNfjD1qgD8EdTpHFz6l1s0JMXtgbZUiGy9hxF61wulVZZ7j7Sf58w9aCiWfHu
	TAmbRQdxoanwTGCf4r4Ex11a9q+6eYl/mhN+/v3Yt3zTrFeBVeoQsTMzQKkA9uWpLx41agubYfz
	fsYmXf1ZYwas4DmeBC6+1OrD7oj7
X-Received: by 2002:a17:907:6088:b0:baa:1d9:66ff with SMTP id
 a640c23a62f3a-c15ce05ca06mr142606466b.20.1783524299404; Wed, 08 Jul 2026
 08:24:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707-b4-pipe-unification-v2-0-eb52bddeeefd@debian.org>
 <CAGudoHFGFJZ_j-osEKnLvGYGai+SKVAJKy8B_PChWms7SN7xoA@mail.gmail.com>
 <ak4rSEAwV-RoG1MO@gmail.com> <rac56njg4yorvhc5oyrme6bt7ej2vs64umbqkz2np32wpjbcjj@wohli2ntub4s>
 <ak5nXRnSSXfA2B75@gmail.com>
In-Reply-To: <ak5nXRnSSXfA2B75@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 8 Jul 2026 17:24:47 +0200
X-Gm-Features: AVVi8CdwQx-NRnrBfyPwbTObTl95LfP59afLotzE-t0ShWh1g1QNhkDv3vlnQS4
Message-ID: <CAGudoHGAg2s37LeJzZTKTyQS4fARSdipcis-76b25x7XnWoZiw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] fs/pipe: unify the page pools into a single
 per-pipe pool
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, oleg@redhat.com, 
	josh@joshtriplett.org, Jan Kara <jack@suse.cz>, jlayton@kernel.org, axboe@kernel.dk, 
	shakeel.butt@linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 5:11=E2=80=AFPM Breno Leitao <leitao@debian.org> wro=
te:
> That said, your approach is better than what I had, and I would like to
> integrate it to this patch set. Os it OK if I give a Co-developed-with:
> tag?

imo this is too trivial compared to the entirety of the patchset to
warrant attribution. Just take it.

To be clear, I just now verified avoidance of the extra trip resolved
the regression for me so I have no objections to the patchset.

For completeness I note I failed to remove the lock acquire in
anon_pipe_trim_pool_and_unlock, but I presume you noticed (at worst
while testing).

One suggestion I have is to post the entire thing as one patch as I
don't think the split here buys anything, but I'm not going to insist
one way or the other.
