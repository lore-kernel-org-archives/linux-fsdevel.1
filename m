Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313B73148C1
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771255570; cv=none; b=RH67nl+rxLV8DDd2pXc+1Bsz7w7avqRoj6CkfPLnx6C8ECVLEHl6UXkm48OAz1IhGym3LGti5QCeyp8Q+hlwPtQGs4Zir0mpSfYxYE00M7nPEOV/ca6ChOEnpaQF0AFJJQuaNI3pXwmCB2KGZE0QYTkxuzjc2OY/h8lMNV5Ju48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771255570; c=relaxed/simple;
	bh=CmF3/HmQKye28JvjZqCJspXzZtWrN+uW1X0Vu2khRF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZwNz7E4kDHZFEzUG3e1mlIp+erFGfX9FWbKeXi4iDYOPpNa1GgTz11u9xu4UXlvGemASbwogkF9tfIDdIDCTNskQVCuA0RKh05QOJBSgaqQJHCNKvB2XYy2rNWZNqtvBCWiMu7PoYmtup506l9KZ3tRu44pa/9Zmij5/IAS2tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=M1xcpNPj; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M1xcpNPj"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8f9568e074so487651466b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 07:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1771255567; x=1771860367; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dTIb+k5p8zBSSQ+UaBqdSmgyPqqIW5ZSZkOsstVD11M=;
        b=M1xcpNPjQZGSRHShzuOkNZ+32J7lwT1Oeq5P3+pl6ZlvAFTw3Hvak3yNPKdfx/fhS6
         ljUccJxVb+RclnJAEVl7YhFtYJownh53+kY8o9Fa1CaABrByOLS+2mazfd8cD/YT4Tod
         QV6DlhV0b5f8LGpYwkobvVHGNhbLDNJmoYmuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771255567; x=1771860367;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTIb+k5p8zBSSQ+UaBqdSmgyPqqIW5ZSZkOsstVD11M=;
        b=vLmEEjBn+C32amUgVQHKpCBZBs0g+w1xWItfhkKTbxXQVzVNAERCZ/eO8QIMl1DwM7
         hJ7nVnP8Hm0e1PLZTjsFbt69HpArHC9wBNMcN8UZMaXqXDw/sw9k6XJ9/gXZEP6vMhqb
         Pu9NXIBXt2vNsl7s+Rj0yoIH25FO6NKQ4kh1w3iqjHkQjMD9OlpnnHo9OIXUYqRPpKeo
         cWUpWa4LO99WZ1AaLvy6ELFOcnRgmwLAKHQ+Kg44SRTB53/E2JauK8fQ6CEEZw0AlWxR
         4eZkzhMdClKrnUlYVd8XMr4SrI5kKC45a8KcSqyTsEyayBj3HBuqO3sxiEMeOCpr4euJ
         ZuAg==
X-Forwarded-Encrypted: i=1; AJvYcCXUPyo1SRmDjZeNMQJ2VkTcXYOE73cYKNzoLDv38wM+5ZQVfm/nKrho7swmjXCtRYBWVDVnAyTcHyk2S70/@vger.kernel.org
X-Gm-Message-State: AOJu0YyWey1zCF7BMxvrUQPQHdBIbntiAUM7rV/OwnXXb3o2lWrpP8U9
	JZuRbNm8eg/MF3F9MAskc95V3NZPrVyEoRiHpf+QqKMJpdO1Nw2RVxbg4LmyqKcrl9I35IwK5/4
	IFIrUlOE=
X-Gm-Gg: AZuq6aJZ9dQgRrs0Y6j+6nyb7CDB5z3fYYRhA2+RUqQrbZMwshfrlOyOhxd4aC4tTZf
	3d55BY33bdcMZmqhZLu2JPcwO7jOl3eGmHIqG3U0RBQY6C86hIDp0E+hUC7mRnVB01Wo8pTkx+4
	M98aVvQg0F5IQiBuG8t7jsgrlvlA9WUZyBQm2gMT8cb5/HgAGhP6kQ5WeatC8outDfqaB0P/pBp
	CyeADLP79yH3ObThjnxIyHE1uiRU7grw38sou5QDHkigDJiW1x6H9cQWHFxotpHgsJoR7Yd5fIO
	lpfXnpQmUxHxR/6IMnodM0Sks+u2uZvYQh0nA2MWQHv3NjFsAz2y+x9WEZ6nLa2wpbj70nd01Mp
	C7GgD8BiWIYVsqdC9ZBB9Ndxk2o906uh0veOGE4Wv23BW75/BS5hJ5tTPHEp/MlMICYhjCJvrow
	l9WSfECXq6mSRG4aueFWA9i+Ss5h71iv4Gw56BH2tkg+uRlA6iXmv+PbhxzY1tJ3qDuz0Z6ztV
X-Received: by 2002:a17:907:940a:b0:b87:63a8:880c with SMTP id a640c23a62f3a-b8fc3a32da5mr376175566b.19.1771255567256;
        Mon, 16 Feb 2026 07:26:07 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65bad29d4afsm1833407a12.10.2026.02.16.07.26.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 07:26:06 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65a431e305eso5615829a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 07:26:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWiU/0nJIr+/fohVQEgBTqidrYRRpovufzfxI7TQUu8/TzXEh/kd+LVOKHe7onOr1AC3vkwu2g+br1dtdrN@vger.kernel.org
X-Received: by 2002:a17:907:e11a:b0:b8f:f6c5:3f3f with SMTP id
 a640c23a62f3a-b8ff6c56110mr123770466b.28.1771255566016; Mon, 16 Feb 2026
 07:26:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216-work-pidfs-autoreap-v1-0-e63f663008f2@kernel.org>
In-Reply-To: <20260216-work-pidfs-autoreap-v1-0-e63f663008f2@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Feb 2026 07:25:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj8Jp-JZRQsLaOGCWYb_qjsnHZUsdSfRpkwJOsjJozfGQ@mail.gmail.com>
X-Gm-Features: AaiRm50BVBd3nej8FT93jZ8uZ_ABdwCZUKYbqaAu7Iv8nP8SwUQE-EOubKXdU9Y
Message-ID: <CAHk-=wj8Jp-JZRQsLaOGCWYb_qjsnHZUsdSfRpkwJOsjJozfGQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] pidfd: add CLONE_AUTOREAP
To: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Feb 2026 at 05:49, Christian Brauner <brauner@kernel.org> wrote:
>
> CLONE_AUTOREAP requires CLONE_PIDFD because the process will never be
> visible to wait().

This seems an unnecessary and counter-productive limitation.

The very *traditional* unix way to do auto-reaping is to fork twice,
and have the "middle" parent just exit.

That makes the final child be re-parented to init, and it is invisible
to wait() - all very much on purpose.

This was (perhaps still is?) very commonly used for starting up
background daemons (together with disassociating from the tty etc).

So I don't mind th enew flag, but I think the restriction is
unnecessary and not logical. Sometimes you simply don't *want*
processes visible to wait - or care about a pidfd.

            Linus
