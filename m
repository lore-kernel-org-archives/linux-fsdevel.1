Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5876A36A365
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 11:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781175828; cv=pass; b=gQvql5EBxMIg9WKQNwsRJhli2TRQZx2M0mg8LNsyWuH5clUWjdu5+sZ7e4UToDlNhnO81MpcVciW7dK5ti7lK03Ov4v2OMD0FdFXLQkwWnS0MzKPNKO7M/dGA9I5j5zSWQgwU9A/YsrrD4JbzOU8HpJtPb6Y73p9imf8/hw60BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781175828; c=relaxed/simple;
	bh=cHETbsmXAI1Cmtw3DF/yWUnOAWL8bhnYgym+tiYQBYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZS+IdFN5MOQWwlzJR+BW/NoLXox+JShWUfVTOs0zT9TlekT+p1zOS0RirozuTpZA0ny/CKiSYQIjvWBz5/OjLYoyKLjSTq6hPND8TYajUjuz6N6Ndw675JExUuuEHRpfUB/ceyX4QLJbgpjK0n2gxMB5MsGG6VDtcIxTGbw5Xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Rd49jsO3; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Rd49jsO3"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5177ad0cc67so63261861cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 04:03:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781175826; cv=none;
        d=google.com; s=arc-20240605;
        b=Amzclx39i/5o47TH6H/bRrtmyMFjUBqCt42PYKYNZZhAdalTmieTKELMGUfgkmDD2X
         76YYlXW90L5e0OfzE3VHE+RbFI7V6GCetYear7YCSBVBAnfazz3K1WKjHfkao/G+aeD4
         f32vlpFfHluOvkMyeroIVrqT9CVX4zm4jC8t5aYFvJ3S6an4vj9CLE0NydCE21C1H3mT
         2ugEUUeFwIBISzlIejOJPu6Qkafl/r2xVa/oAkr6lZliYDNIGg0HMcePV2l3+q8TR5kt
         /BdCpFi/uB8fYjddKjO008PSP+taiWEDx818QPGkYwOFcHaAxOXOcWA9cVdwpX92IGAX
         LV7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cHETbsmXAI1Cmtw3DF/yWUnOAWL8bhnYgym+tiYQBYg=;
        fh=uGqOIgf5tT+5aIe6qHnQiCSgkZRs0ZwSnXn9eL4r6NU=;
        b=W8TM3diWDF/X+lW3psx70+VNJ435hxhApdnubJA1vL+dPx3OJIhYp59wsumTskhn3y
         rNJmBtsVWAHDbLrzZ9gb/8+z5xhI3v4r2H9GHit28jEceASCnpPuzBNZuZsWSEf0kO8J
         1WoaC9oStvd8eWnsecjQjpdhvzsCeIFh3yxyDUnB1tB1A/LLOwVY77zNexSF3oODlpvz
         wXqdWc0+B70knM8MODvTQ++wWSB7i/mHZsGL7kHwl6nVa+vIaxj4VmF1lEGMnu05yqNX
         Db4r+H8ZJxkftJmSR4s1jRPdZ2G1wznsnGHwoglnmuPRCucQdLR6SC7NkiKW9oDUJ/0n
         5RVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1781175826; x=1781780626; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cHETbsmXAI1Cmtw3DF/yWUnOAWL8bhnYgym+tiYQBYg=;
        b=Rd49jsO3l1lY3RF2KuX+rknXELNjOpxr3qKIOIMJXqckJl2Q7OpEoPruQKFd1YtF//
         6HKpdxKxwHbuI1nGdgr8AgF4Iyfo6I43U9pgrZ5wKFNCXpwKm7WBbjdJ9Zt5BnqhuEuk
         A+6gq0nxvufyjLi6zTxBR2cfkRJpuWhRJh56U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781175826; x=1781780626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHETbsmXAI1Cmtw3DF/yWUnOAWL8bhnYgym+tiYQBYg=;
        b=YZRiI/yj3KRndt1HhuWb5ZJTODppbs07I9bm0vqgjkjHLiXG917miCMF8Bt37+OAnu
         uEH2sbbk/GW9HoVbbLOjbU5HsanOwC9M/9W4gjd04OFFiehv4QKaDL62MHyEIzU46G2I
         rf2gPw0wlnPWWupFZ6q2LhkGd9+1pWAe1wF+YInmt5tIOtGES0GPCUWl2MLxkwwgZrj0
         kCvgL5VDa+/gxzTZp9k23XjncHjmyPrMf7IA7iQF/seMZenTTP64wsknQZcPRuKuSvvP
         spV2qpOpsOXhojLG4+6CTv4XBEq7kg8H+KXs9eT1QoC2JZFAH3zMRGY9uKA3dc0hcsBu
         XEjw==
X-Forwarded-Encrypted: i=1; AFNElJ//uyMKgstBr8fNK+34TNgpu3C2M4S1V2faDa+f6n/HSou6rxhB+31oC7FD3SZBYy19aTH+5INp9NozRE3L@vger.kernel.org
X-Gm-Message-State: AOJu0YyD36kq2RLRz5q9X/f9oLlwSymr4+IPIcAz8Jbhtr3gIK1zD4WO
	y7maDX6PFlb9zbNkseKvD05s9Eg0G5yxGLuklrFQElDjWmESp1IMj1zFZGeEdOQXeejdH1XZ/gw
	yhjeSAeGxu8Fr0O6dRZjviXESVYBtLXaccZDvrY1DOw==
X-Gm-Gg: Acq92OHosglKZnLyBfK3HdCf+92pgSmcbmd9WwIMMiXZFQR88ceiemu5Uu+AmvlEQtz
	gpNgadjlRg+Ur3mcN6UJuPIdiEPZKKxthPJ7VQRZh073xgKGZja0/fPqs+5XmfygTYdqwC3h4HB
	naTNX9rnsCXiL4MEvYsnCtGzpXVbDPc1Oks/r39qtGMoSOqzWYun4FT2mp8rs8ZjIVgLZOXJbQL
	iwgw4mwsEuLHdyUWU6Q6Qv/urMJXe1DwVfobi4ZKDu5h39V4xOBfAvp32ywro73bKE/VHwsVKjE
	C7DYok+afVoLDF453iCyQVTU1QcT8LuL6/av6LJ/xAkSOXLEqws=
X-Received: by 2002:a05:622a:5a09:b0:517:8315:d6a5 with SMTP id
 d75a77b69052e-517ee3ecc73mr34001861cf.55.1781175825944; Thu, 11 Jun 2026
 04:03:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408172510.52950-1-joannelkoong@gmail.com>
In-Reply-To: <20260408172510.52950-1-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 11 Jun 2026 13:03:35 +0200
X-Gm-Features: AVVi8Cdo4QiSj1oTyoStt3uNLXQRdQ43vrDqaYk9NAzSVhSlqcEh0yVVAFo3E4w
Message-ID: <CAJfpegtR2ghZLZ2_O-YCWdMoPPEKE1naiTkmoang-=S_As72CA@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: fix io-uring background queue dispatch on
 request completion
To: Joanne Koong <joannelkoong@gmail.com>
Cc: bernd@bsbernd.com, hbirthelmer@ddn.com, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Apr 2026 at 19:28, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> When a background request completes via the io_uring path, the
> background queue gets flushed to dispatch pending background requests,
> but this is done before the connection-level background counters
> (fc->num_background, fc->active_background) are properly accounted,
> which may reduce effective queue depth to one.
>
> The connection-level counters are decremented in fuse_request_end(), but
> flush_bg_queue() flushes the /dev/fuse path queue (fc->bg_queue), not
> the io_uring per-queue bg one, which means pending uring background
> requests on the queue are never dispatched in this path.
>
> Fix this by accounting the connection-level background counters first
> before flushing the queue's background queue. Since
> fuse_request_bg_finish() clears FR_BACKGROUND, fuse_request_end() will
> skip the background cleanup branch entirely, which avoids any
> double-decrements; it will call the wake_up(&req->waitq) branch but this
> is effectively a no-op as background requests have no waiters on
> req->waitq.
>
> Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
> Fixes: 857b0263f30e ("fuse: Allow to queue bg requests through io-uring")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Applied, thanks.

Miklos
