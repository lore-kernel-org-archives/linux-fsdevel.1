Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD963B47D2
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Aug 2026 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785689643; cv=none; b=n0a+rYWl46eLZPEkXxuJ7RamLH1ZINYWLX29wc5tKLGFb9FtjNgJObw2q8p3IcIt//VpKZYsaILDt8uk0Uyq3KyzGZzJCOVtQgExu0mtDFXfWy7qULt72en/37RHv7JmttFzCsnjFmE604NwJb6Jkao/JXtdb9Or3PVwx4NyFq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785689643; c=relaxed/simple;
	bh=EJw+kTqGRkMI61bTiVUY9Hf2nYqFmqoxYK+qvW10i+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EWjhaYgYOOZBZhGKMi96f6DIMsrGxXjXwlXF0ZxiiOVMtes/p2oANnXUag6PPmGwSwt5XP41wr16Whq/Z0XNLTF552QuQjbr8hAPGibTSvTsNzNTqEyniqTYGBAGE9x0Qrx9zsIvSrMeX1ju1XwUlOK7ZajrKWpNHRe2qc8ejfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ez3dR+UX; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ez3dR+UX"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69ea0595598so2919659a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Aug 2026 09:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1785689640; x=1786294440; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v+ZFmCOwSHVd+Cbwlj51Z7I8+fcWBII2I+8HftB9n3k=;
        b=ez3dR+UXspEQ+QUQNFKT+E0luRC73ilbCQUVaDaz/swDouJovnVLAARX+vczAEdvUP
         QZNoUIX+jW1KHjfKCj9yDMP0Sp/lYZlJtS1dbjTiJSqGhsryJ452TkYoaHd9p1BtIdef
         z6J71gxuE6PRrY9c/NXSTEQCgthbyHLOxbc3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785689640; x=1786294440;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v+ZFmCOwSHVd+Cbwlj51Z7I8+fcWBII2I+8HftB9n3k=;
        b=aln414D2sp4x1TMX7gR6venfh9l/fOrgdGw0fOUq+yu1erdv/zN20PsqnZZgc0AtPj
         LXqApLIKkCyl6wA4GjFZvHy+b8bAxFjkfZmV4+9TIyV91O4+UR54+ttnK95jxxGx+jZ2
         k31NL7fsmXZ0mE40nNvw8qsw5BhnzdQwC8ppXfQsNhExCFaEDtA6+Cq0B4OOgrZv0clx
         sfJ92dhywQehgvvQAw6rLa6FgmB50tpy7Ce+MYYjDUzozhMjsnj+YLJd8FB8inOZtQRj
         SrYeDpq4cgs4A1dvLPijpDixvbUQJhV+GIPi7Yo8d5x5gD1WbDThj+rj99rKDOuvS7Zy
         s6RA==
X-Forwarded-Encrypted: i=1; AHgh+RpkzCypmZnfKBmSueSzWGtDOrglLpwtN4H2fMH6RHFKnZE5g2C8r5TXpMa+wcvo9bBlQUWtx18q6DKwQmLL@vger.kernel.org
X-Gm-Message-State: AOJu0YxAzT7lrPXnGgzkyTvwKICIFa2dHYF7me1dT/IX7LfcGq06toiP
	7unf4eUt/FJXGJFkwbEmA5qjixCWA595SEwVFFp4CoUm/v67N83r6BqKzaNF13J4x1aMyZrOsUQ
	2ln9wzCI=
X-Gm-Gg: AR+sD13uktKBaHCaUW5W2YU9ClU9+0Q6YAdJ9ra/KWu/BX2hd6C6GkkX6BM92bd+JKi
	6UY4PG2e69x9cio3D7BtQCWH1li7dibZ2z/FxXKZ3CCmjVmxFzC4nAw4VLtgLnMQykoK6ZOzES4
	NfyWquJJ5rd7kA/cwzpQ4jMCllIZIU66TPPryUfdbIzTdgVagTkLTG9yaoTvzvt+mTyspmGKT9F
	DU4qEAs1u3aB4xmLFdAeixoyHETNpRMT/KgP4W+CeIXIowKBKWF6iWbt0QOH6cT3I9jgj9oMtfc
	YxcVjVrhUzcb3GwKJ876EE0NzgMoHTtA/gNB9QNJUBD4oONTBimHlNqlRQjZsXnROfglnBSUs/6
	1VjrC10PpAaVObsG7XUm/Ae3hLE+kFCfs6agxG5SuccE0sUlBVAkuPgQWVbCUI3w9BtFuwk8Avp
	wEdE51Ivue09qAcSqOHBlZvd80UbytJBS5sfwSVFzr0nmuYQJhbCFhOt3lfojLXqBh40k1iuOzt
	uAWd7vR/4oTdQe0MgzAPQyrMaPW/argHFWdog==
X-Received: by 2002:a05:6402:5287:b0:6a0:9274:b5a4 with SMTP id 4fb4d7f45d1cf-6a0a7cee0b6mr5338625a12.20.1785689640034;
        Sun, 02 Aug 2026 09:54:00 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c5b1a15sm4438445a12.9.2026.08.02.09.53.58
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 09:53:58 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c160420289bso379312666b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Aug 2026 09:53:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrzjnh2Ilbbe7TebU2navNoSIptggeH7+oq6lW4aU+qpZR+iccXcjOSUorQ4N4pZEpXOe6l9L879930pto6@vger.kernel.org
X-Received: by 2002:a17:906:369b:b0:c08:417e:3696 with SMTP id
 a640c23a62f3a-c1fe7f3a249mr466563366b.20.1785689638268; Sun, 02 Aug 2026
 09:53:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <amtbpwrhlNGJ9OK6@redhat.com> <CAHk-=wi7EccGaeo2Q5mdcvcQJ8VX7tcJWW2fHkg6vfmHGGX8AA@mail.gmail.com>
 <amueLRM-DrYbnjLn@redhat.com> <20260731-blechnapf-arten-blasorchester-4e05dd1b2c58@brauner>
 <amysHlZp6f6q498X@redhat.com> <CAHk-=wg_PtU66p4iuvzCz13P_cDCfKg2OOuV-v6wq19ua8LyvQ@mail.gmail.com>
 <am9an4HWPGaxmbcK@redhat.com>
In-Reply-To: <am9an4HWPGaxmbcK@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 2 Aug 2026 09:53:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgpt2ePzDA7Gt4JHC8uzEsi6A-3V3uM1nZO062dF_ayMw@mail.gmail.com>
X-Gm-Features: AUfX_mxTQvF14UVk0HG1pOG_w4PlWB0b4XtyzIl4-tkWu-7XIakPiTTRXj2tTxA
Message-ID: <CAHk-=wgpt2ePzDA7Gt4JHC8uzEsi6A-3V3uM1nZO062dF_ayMw@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] pipe: only enable the extra wake_up(rd_wait) for
 edge-triggered consumers
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 2 Aug 2026 at 07:56, Oleg Nesterov <oleg@redhat.com> wrote:
>
> Will you agree? Or should I tweak the comments somehow to make it more clear
> that the only reason is a user space legacy bug?

Those suggested changes look fine to me - together with just plain
commentary about this whole thing in the commit log, which it wants
anyway.

            Linus
