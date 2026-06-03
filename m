Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489FB49251B
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 22:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780526603; cv=none; b=gpC40Tq0u3uERf7wivqtoRzeqP6YMrCom6OmQujrVIUr4/6f65e2TUGNgCQgfpAiIVsttaIGRx4/pZPNLpdq4CKGkS3+QsTtoXLFJKCWEi//G/02HuJgndsFnpKukgNSTlKvUDdMDwAdKCF/MeS/rvBHQGPVAjA8pgWlHjD7w9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780526603; c=relaxed/simple;
	bh=bpSKopOh+lqC+IlYALKlFknmtsR6CYYa845dkB+uwqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RF2e5DhK0o9ziYBssAAtupUmpcYU2ri4irxmnpb0I8Q7/oFFZ2U/9kJaK/t1ZSGYYlcztDKdDbZh9M+OlpwPK+OVvrwCU5tEU2sXuTtLHFGXme8jEygIWLMBskfarIejRw1weSWt6hmHHVl2tcX+PG/LsYw3D+vVtx9e8ZwN4ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wjj7uirC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wjj7uirC"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490bb83a3f6so666655e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 15:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780526601; x=1781131401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTE44OxcHCqYjYX+doIy+3NqUmI4SQrZkrHVFocDs+M=;
        b=Wjj7uirCmuM3oEx9Vkzc5+uo+3QV5z2Tw+aUW7f5mIXlMdcg8ub1+BrDboEcF4IBgh
         UuzgCxmX0Udg7LvXiOlztwQBl0xCSU1hkEjxgt5PsrLs0S/RJhoQYriKRSqchOzbXnmM
         HBFFdzuC30b6XcHVBX7JF5MqTCLyaFZr/VdloqdIHj6exver28+uqVOtUTDN7Jt58u+5
         gGNwkNbUgN0FgT0RYFVQCtFD6lJ5vlMSmvWr7x598wn+lRmwSPTtNLj0aAkYcK8eqGKL
         +ihWY7zZ0xgV72sw/XrRzJNJR2siE6s7ng79IokAeNf1f2U67BKiyuHRAV8SrCLTD68Y
         w+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780526601; x=1781131401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iTE44OxcHCqYjYX+doIy+3NqUmI4SQrZkrHVFocDs+M=;
        b=foOVjVuqPAjO0CjgN3aUOfOsNyDnQhZaIEGYWn3FuP5jA9ruJkmeAbOamDYdqC699M
         gbAakiZtHCjgFzlr0dAMrw8C6s8lz8VnIFfV7I2UWooJVTCvFOO1CcROyoyXyi+onKft
         oSt8yKUxDEkdw/tWVv20IP5QmhyBI2eU/6SpnfyVyXCoFE8yuKuiDnZp2S+oMUpiaQpZ
         0Sq/pC2knGh2JRm/PSD2sYqOR1+vjEDuDi4C9kOqCYmQTj5L7DxUd9s0ONbDcJbffhBp
         VYB513QlKN7hrqYdMcDgb5aSAaYgrmQ/f9LCyu0FN9QWZIh9TDhKJ2Pbhv18TglOAT5y
         9inA==
X-Forwarded-Encrypted: i=1; AFNElJ/qcXCquc6kfTz+JE8cNIHn1GIRPuvizqVaZqgQeEMVjtC4ps4wpAdR0HfDEUSvYidV+ouLaX79bIbUY+KZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwELhgohD8AOOvIj8yTA8yCqR/tDNhgNaVuzlYM26JP0g68qS5s
	PPTO+FlhaWrpCe5Y/cRe0LMVN4V+pFIcC2gNguN242YoLSmxR0Mkvsgq
X-Gm-Gg: Acq92OEWoN+J0kaOxdMl/i/zKwEauVBQYrXPsKpFLtqpkpzy6zndHzYGdWVhobx3e05
	J+DGljaAOwtVBVvpJeVA3pDs3jqgvIaRD93lftdH8NcH9/39fk4JLSWEjpakt8CCewoAsHyXI1B
	UjqOP6vTp7dcBi4pAPqgngwLxe9VyJNhYmNtLOPqlwIp2UapyiywP1ZKoCrTiL8JoqBibXnFz4T
	XItVNmV7pU8qI3MvplMTdfT85/KA13cgIXOEO1RAws4QeL+M1UHfPije7WEqn/C3fiNrQ5S7OBK
	muNkkGHhVl/a7u8732smdTTEz3uoJjgoMo15jV1YmfyMfaGMpIGT/ezZnQD7OH4/Z1yNXNZj5+b
	sYzYMC9CRdJYGCmfYubDgOTymtamjhRZAk8Paud1gn5URmJoix1JogHqjA5US7oqlgabffPuV9s
	IFQ7h4Os7zD2wFigU5vxIbCNYDpKe1NA==
X-Received: by 2002:a05:600c:a09:b0:490:688b:f9f8 with SMTP id 5b1f17b1804b1-490b5fe6672mr83368675e9.27.1780526600498;
        Wed, 03 Jun 2026 15:43:20 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490bc391aaasm29855955e9.1.2026.06.03.15.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 15:43:19 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: luto@amacapital.net
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	brauner@kernel.org,
	david@kernel.org,
	dhowells@redhat.com,
	hch@infradead.org,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	pfalcato@suse.de,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Thu,  4 Jun 2026 01:43:11 +0300
Message-ID: <20260603224311.834796-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CALCETrW3XcNLuB1Y6PSkxQDSK2o+=EB2AAd25SjWQqcJemwnbw@mail.gmail.com>
References: <CALCETrW3XcNLuB1Y6PSkxQDSK2o+=EB2AAd25SjWQqcJemwnbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Andy Lutomirski <luto@amacapital.net>:
> Maybe we should keep an API that does an optimized copy, from one fd
> to another, that can send from a file to the network with at most ONE
> cpu-side copy.  Not aiming for zero like sendfile / splice.  Aiming
> for one.

Yes, this is what my hypothetical future patch will do.

One copy from pagecache to pipe, and then network uses that buffer
directly.

> But splice_to_socket involves
> MSG_SPLACE_PAGES, which I think is a part of the mess that you
> dislike.  And the path where one does copy_splice_read and then
> splice_to_socket has to be a bit complex because of tee and (I think)
> because splice_to_socket cannot assume that the incoming data is just
> ordinary unshared buffers.

My future patch will provide new guarantee: pipe buffers are always
stable, i. e. they will not be externally-modified.

So hopefully network code will be adjusted to use this guarantee.

But pipe buffers will not be "ordinary unshared buffers".

They still may be shared with other things because of tee(2).
(But they are still stable! They will not be randomly modified!)

But network code can do "pipe_buf_try_steal" and thus ensure that
these buffers are not shared with anything else.

So, network code can be modified to use "pipe_buf_try_steal", and you
will get "ordinary unshared buffers" exactly as you want. This will
give you in total exactly one copy.

Also: as well as I understand, previously, pipe_buf_try_steal was
kind of lie. It may return true for buffers created via vmsplice with
GIFT. (I did not check this, but I think so.) I. e. pipe_buf_try_steal will
return "true" in this case, but pages are still shared! But, thanks to my
vmsplice patchset (which is already applied), this is no longer true!
So now pipe_buf_try_steal is absolutely safe to use!

Finally, we can degrade tee(2) to copy, and hopefully this will
allow us to always be sure that pipe buffers are not shared with anything.
This is possible future direction.

-- 
Askar Safin
