Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957B41A6806
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 00:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785456879; cv=none; b=ZnMnuUii8Q1q1V6Uzelrv9tiAEmjRtlQXXW6YlZaFNMiofuMyqwYI+zCz+qwF9z6IYWO4ODOb+++8q8ib5SpSq9gXgPorE26Fp6MiMJcwckRt46GzvffuYR5W8FhFhzOk3YPXdBuxLYKhLCkkerhG3/VgCmfbx5Sz7iYrWZTS6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785456879; c=relaxed/simple;
	bh=MN7ge1T5lQ1JTVCub8CTaie64yF5EP52iawEc5weizk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipW/4wMdXsKipMWy7cnEZIshy0/W/KiNe2YxhfOGJz4cxNyp2gSFoSPyhIyFF257/2/rCJnE3uHUMHRgsdteeHP1FUPc52GH3hDcg6rNWpdOJkLdAVv3AESQuzV1bEhThkGCVQBwrWBs6fkIh36SzO/6Cnb7O/NSX7O5yZp0hKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZOtBtupa; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZOtBtupa"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1c4c7ddaf6so45564166b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 17:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1785456876; x=1786061676; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QCTwPWTe36H8QlcoShrFPKk4L1n8utyt7k+WGp1VOEw=;
        b=ZOtBtupaUbCW04/GtbWmNTvregWKAfS2cWfMyHVlOQCPVmYLvX2DKlw7w7K8hG8Qcv
         NZ2BfhjMlwtvuV6nxX1xGvP57MNGviFan1pMOv6g3logA6HFrK545Y5VUbJwXW5L4QiK
         4d4POFloQLj65KWjI1Pb09BuODx4KxuBPj+Kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785456876; x=1786061676;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QCTwPWTe36H8QlcoShrFPKk4L1n8utyt7k+WGp1VOEw=;
        b=mD4lAR6gLiPLucBttlfsyAxdvBuO0dwYp99064XcmK/9HUpNy5JJoeFbiq3wbn2war
         urOQFBof3+FL8JkV8G4ilW3qw3xnmh0H2wlmrj08Wd6Grz0FuG6FuySe761U7f/v25qu
         BQ52liN9kpb30KfRZR7FH7e/XAwoXsjZxT2DUCclD3hSXsdJi7T6yyXOqKv+8b85zAoR
         4d4zzEZZq5XqAKWICF0YjMMsGzx8LQTMLfn1DOKXubUC8nHCvq2JeAAU5dIyDTvMzcl8
         Zg38UtOPVjSm18g6b6QDFT827ohS8gUka+0eUX94eXOwDnrJISjj7AOHO/DGCbN9sUSk
         Z9+g==
X-Forwarded-Encrypted: i=1; AHgh+RpQjaNNAaWV0s4PDe37JGh4tGz9M7c3Tr2G7xXN2i0Ht0SW7zLFaZK0zH38wsEl0Kk3JIVOabAW6HkUn4wv@vger.kernel.org
X-Gm-Message-State: AOJu0YxHhmbJEqCV8/+9v7If48Eac0nfeIk93zeYYL12daIR3Ar4dMyo
	jRZrQvrj2iPM1jAXIHjpDeKF1G7JH2AKvNSisUy/Ui80uCDikysRN64AnWNW7XucAW92pz5RKJH
	aBB8S12M=
X-Gm-Gg: AR+sD13OlEeTU9Ia25+zISKhA5uPC5JVmzlm0CTsOZ9dmdSLoW77O1l3u0NPr4XmGVu
	KiiHiepZ1z8OFNO2kyrE56fXBMSgalkOuLKZn5YVEnc8mFbDTgWavbCVPFkW6OKOHNp1r6QRIhN
	iZr2K5J8c/zleDTanbVLqiW17+zIDekshIcmnQU7H1ROnIZItNVvgYc/Who9zWGw+iIruW6gyDT
	Ud8V7jjxbo49WGbkXNVvXufFYGnx74cfHKhYZLRT1jyYp35Luaesm5PsZekOeQBuXHaFOGtv5w4
	4V5B52OU7dhvpgI+AdG/HbF01Zl4T5XmGH4QxTZeRaXuaPpCXsB5InJDQddU9eS8zj9/kQ1/OEr
	7/DdbJvMXMH9cF5sq9fwXpDR57yGUyvLB5tjXVDeTCKMPcGLc89Y/P/M8ybZoPro/be8ANNVfq9
	i/e6OOIVqeNDko/xiQb1tkXsGVbBL+OagSs9psxYDC8G92JpzS6h85b72lwuZYdpct8+rT2ahrA
	n1Xds6vrjojx3y9h6ngveXqfreenYHIrDUbdw==
X-Received: by 2002:a17:906:4fc3:b0:c1f:bbf3:3b33 with SMTP id a640c23a62f3a-c1fbbf33be1mr130677166b.58.1785456875802;
        Thu, 30 Jul 2026 17:14:35 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa851b68dsm123954366b.3.2026.07.30.17.14.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 17:14:34 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a07a051a81so707248a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 17:14:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrmc0y6KmwPJfnORSKUb6ZWLFPh50O7vF+523VVk4DbJOfNmudK8yi77Cwr+9MhyT8t9v9r//QK1xjEmP8W@vger.kernel.org
X-Received: by 2002:a17:907:97d1:b0:c16:29eb:e81a with SMTP id
 a640c23a62f3a-c1fa56df16dmr245684466b.29.1785456873638; Thu, 30 Jul 2026
 17:14:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <amtbpwrhlNGJ9OK6@redhat.com> <amtbxpqJ3pZwyT8D@redhat.com>
 <amteY30qxRuPzFh3@gmail.com> <amth6owVUdVOmyAL@redhat.com>
 <CAGudoHE=GjMRKGbip8nRUm34VUud_YSqGZJrfr+Vz6Qu22Mdaw@mail.gmail.com> <amu1i8rzQ3hZ-vAu@redhat.com>
In-Reply-To: <amu1i8rzQ3hZ-vAu@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 30 Jul 2026 17:14:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiUWQdiHbH9s4XKnYZwRs5vR1Azq83V4scN+N-w-VFRng@mail.gmail.com>
X-Gm-Features: AUfX_mz5zon_kbqMfY60s241UG4SIgEzvMbb41Bh6TGn6yZhyVsZ-jzWpF_8les
Message-ID: <CAHk-=wiUWQdiHbH9s4XKnYZwRs5vR1Azq83V4scN+N-w-VFRng@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] pipe: only enable the extra wake_up(rd_wait) for
 edge-triggered consumers
To: Oleg Nesterov <oleg@redhat.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Breno Leitao <leitao@debian.org>, 
	Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Jul 2026 at 13:35, Oleg Nesterov <oleg@redhat.com> wrote:
>
> Again, contrary to the current comments this is not Epoll-only...

Sure it is. As far as we know, only epoll has ever *cared*.

Yes, you can show the semantics with io_uring, but do you have a user
application that actually cares?

The only reason that ugly hack exists is because we did have that
break user space. If we can get rid of th eugly hack for io_uring,
that would only be a good thing.

So this literally *should* be about only epoll unless you have a
report that io_uring users are equally broken and use that
shit-for-brains notion of edges that aren't edges that nobody sane
should ever use.

               Linus
