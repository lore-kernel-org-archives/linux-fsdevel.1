Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86B52BD587
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777046799; cv=none; b=lfcMslFelz6C9x5GXVXQg5AxIq1iofNDxH3YKaPzKbz5sLTAq6OZnHhyEp9Pey7mJtvTvcFaBEGlbryw2mn5t/IcO8TuWGjwyg5q1YC+jzohPHUuBBfI/j/oVBAJYtu8se8N+fFEy1UY6E4EjcvIjW673fKyiF1WksKlR2f6gKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777046799; c=relaxed/simple;
	bh=mEvVp0Rvqf8FVrHez0x9oNhMN4B/tUtss2QpImLpO4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBOKB8vGF+rPEHP9cV5zlnPKRwk5GOcd85QQuuJj8h+f5Y2dJF1xA6fuVMazkw2aRj7lSpHTjBjO6QJlt7wvijCUkDBdAcztPiJ8YEeBCvv7dkUhH+I3yiJEzLs13JebdjF22pb/PASUW44hAeZkie9a365rAdhpTKwqlzeDWnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RQfG5+8b; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RQfG5+8b"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6634bb959a2so11138445a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 09:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777046796; x=1777651596; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2ezw05aj8cQGVYpBzlBlU+9GiVUVnl/4NnGXp1uMAT8=;
        b=RQfG5+8bNIY86YmfIV/fIU//1eD0MgVAcp+BuceFQ6A9kR+Mp0/k/o20lncRFijBL4
         AWp+KdAOxLanmZWa+xNjEP12w+yb0zu83shAYlq3J9WtKi9iIjuO8SStiVH1K+1Ovb7P
         i8iJheswJkVGAvGHj2hWI/poku67JVm6m+CU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777046796; x=1777651596;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ezw05aj8cQGVYpBzlBlU+9GiVUVnl/4NnGXp1uMAT8=;
        b=W52a9dN8fpTbWxo2U3CSLoSKktyFS+elFhhzfNGtC9SZ7NUSfnIrFoEN0zYhsgrkjF
         T5/KMVeXruYIrqhj7i2nME/VTwI7k2DcwyQfQTVyhspCzlYYQGsr9GWH0SDmRSrGHePZ
         /XZLCg9D1LujAlv0xYOeeMrguzKjpMQS123/BWOgEQ4BNLTiGPwemL77innT5eJ30dtr
         hQ/tpMEIljYzzCY8N2kSVDvxjvXUO2dYUqCIq3CHxliAVhEKAjvqs1kH+Ux5jeeWDTz2
         yJr49e+BFOCBiI1Sr5THXGLznFumPFDsUdBh0tkQ09hAxhT8pGa0MiLrGuiCM4Ffywjf
         3Ypw==
X-Gm-Message-State: AOJu0Yy0dR5tvKwrzxqdjIiKGlIAnrvGPcfsbV42wL1aRAwLGm3pzk8v
	sUKnG/0JhktOLgiyoup8f/XvJWQ6t1jf4tts5f79vkvSEq46WYNSAV3pOfGeSiHOGXT3be9RZh3
	yaX5RrIkdYQ==
X-Gm-Gg: AeBDiesa5XDgTQkD/K0LwF5WFUJEYKybHahJsG2KYyJ616ODCafLaR/JeukXt0JBc21
	Bqt4o4RGMCnhY2NB9W83YwazyZgZ4RYWQec3A65wfo1HyIoTg8+qZaaGz4AWn/3yP2TfQbllkHF
	JaAVm9QXhuk/mWauGfWL0wi4sR8Vg5mGYsbJXwHI017Y4ITS0e5ObiKQEpXZWnu7S+QTKi3L5HC
	p1UHndbcD54lkKydQHA1EhFr6g8GDlrbBHMD8x+dhNDtnE+HZjET+fYkGH6LcCDvaDJbiWSWgFF
	YVY3u+9av6UyGz1SredO+YRKe3lV8sqah3GMdewAwMk8D5pqCfftClhuyLSD1BI28CA63IHAPmT
	K7dJMY+xSCghB7yNN8VksHiSZsYXbQvEkKcv5+q+PDUo03H96LAHyGuVcfvClBE3YD9P+PjNelb
	YMx1ypMRwLqqWR7JaLankKKeavDailwn8keVNTTVqbLVXVQDW9eKUPi5xdoQHzpSxCub4oOwkj3
	FzERkUxguM=
X-Received: by 2002:a05:6402:35c9:b0:676:54d5:bc5e with SMTP id 4fb4d7f45d1cf-67654d5c0b0mr9288498a12.8.1777046795829;
        Fri, 24 Apr 2026 09:06:35 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-673032b9e83sm4905150a12.4.2026.04.24.09.06.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 09:06:35 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6746d0b2b4aso10025564a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 09:06:34 -0700 (PDT)
X-Received: by 2002:aa7:c159:0:b0:676:988e:8eb6 with SMTP id
 4fb4d7f45d1cf-676988e90f8mr5904376a12.26.1777046794014; Fri, 24 Apr 2026
 09:06:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org> <20260424-work-epoll-rework-v1-15-249ed00a20f3@kernel.org>
In-Reply-To: <20260424-work-epoll-rework-v1-15-249ed00a20f3@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 24 Apr 2026 09:06:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjhgJ7J3Td5MzLE8L0ZXLqSd-bbMjf_5zy3P4kXa3xeA@mail.gmail.com>
X-Gm-Features: AQROBzBApVDgJd7MPd7tAR67BkOu2zxb75Nh_13WbSEkc1LxaonPLXPIXeWOixY
Message-ID: <CAHk-=wjjhgJ7J3Td5MzLE8L0ZXLqSd-bbMjf_5zy3P4kXa3xeA@mail.gmail.com>
Subject: Re: [PATCH 15/17] eventpoll: rename epi->next and txlist for clarity
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Apr 2026 at 06:47, Christian Brauner <brauner@kernel.org> wrote:
>
> Two list-related names were confusing in isolation:

I think many more of these names are confusing. I'd love to have more
random letter jumbles renamed. "rdllink" isn't exactly obvious _and_
it's visually very close to "rdllist". They are related, yes, so you
want them to be similar, but when it's a letter jumble, similarity
ends up really being something you have to think about.

And "ovflist" is a horrible name too, and has that EP_UNACTIVE_PTR
thing. "unactive"? I guess technically it's a valid word, but...

So I'd like even more renaming.

           Linus
