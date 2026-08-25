Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0059D3D8123
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 20:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787691300; cv=pass; b=sT9rI/VBiuLF9ShKJ3ETBGmr79bWgN2M29DBwoBtdYDdUEW9aLOuJDLGzh7Fl+QrRcUskAyxdioW1eS7d6GMW/AWZtfVtl3VdNP736FaKwxzhD9L8nY0uY4wsS70USHgNP7hCo21/3DPx2fThRRdbjzEkVp222EwigvZFo7IPwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787691300; c=relaxed/simple;
	bh=2244XKjPcSo7FUu6M+cqGUe64IGM2f7roqDu4ksWsg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Apo2eXvRw2cppvysiHvOOyxuBmupGS2YWxqS7J+ZBZFcVGIbmxRILLdglFS05mI6JcXKGJOe3F7iHGpITQ/cmDjjTpCG2CcP/bTouhZH6hKwuOSDtGhifOhGE3lcBLsLVrz/fBiJiRP8FqKmEUHqj6UcRmO/Pc0FXIQDt7dBpCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bx9oI+SI; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bx9oI+SI"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c207cb16cf5so22557966b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 13:54:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787691297; cv=none;
        d=google.com; s=arc-20260327;
        b=q5GCo886SOPEQyEuSHbm2RAmlfJGlbW5cRyPNgOOPWFlDpF4o9x43o3OgPaGGJOBJs
         PNIH/8pl73oPNeN51b7Rab/tpikavzeQJ9tI2Vm2BGDAktFu1eWG97trojbnLkLOe5eh
         Sc5bJKH2hS1e3A3rbGfdrPaccHOlV4GBxGFTL2Mi/z6xpWfpwFgitOYUutbF9d0dYSvQ
         OBLbpQwq9vYmj+0vg87fuy0WwDLIRHi1qGoBWiHsGmiYgULrGxgYxAqaNMCnAOK3USVx
         27p2YHgAvqE06VNxxZTSeL220rM/5cR6RVGWP1AO/96B6eA8WbbtOm10eUq9pDNWcnnp
         AZrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2244XKjPcSo7FUu6M+cqGUe64IGM2f7roqDu4ksWsg8=;
        fh=zGUa9jmRc4vm+SsmZfA6uY4ZcWUqx/CW8trfQUmgTng=;
        b=gEVi0a6DZsNb9bNDBm1nVULEWJMTQnfZQx3RshG2/V48noD4ZqPDHZl1Cv9LBkr4br
         K+iBHHtifEKEpJRdgibKFusl426nxHehzGlGwOktJOaKabhIGUyD73WJuS2jGCkk1waO
         hMDzdLoexxwn+qWj1eRNHSxjJZAMwApY1oWwfryZsg8DHeyGz93B0UM69YCHbY6EHbIN
         CU4qevHj4jZAu15QUiw55y1jCZAp9ObLkxHxWqIloPFP8dtp/t+1lvN/J+u/iT7d47n0
         ZfmnYzQ3iHvtDZlBzoqbYt5SVcM5SsdFIF0Y8NXWZ1BAFtSpAzWTxzwsSMTG1fo1cILN
         H9Lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787691297; x=1788296097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2244XKjPcSo7FUu6M+cqGUe64IGM2f7roqDu4ksWsg8=;
        b=Bx9oI+SIGRSqo6UOKxlDAbR3UssSkEqsDQWbMxEvo8TKutQ89odXX453vLjufvA7BK
         3gtGHXzaCVawJRHNjn15Mee2oY7kIORlmqg1Hmfk5Mm42W5ss7jnX5tSTzsPHLtDHKhR
         3iLb4mSC//JT0zrnoFXodC70R9hx3kZ8djoNvtbvDX5x21AA0gM5dB+DctPKCFEfpLqM
         uO1+Cp9X/8RrAEOQtDTPEIYu56guItH0mkkg7WFt33gQnovOXiyo8XquFlBF5oH0FfVe
         f6kD2e2nBvFD/ZNpfHdOlvnnNzgLVMzwQhdEjrTrV3pgwVwo0g7Vqyxtj7ITU0pqEhsJ
         Up3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787691297; x=1788296097;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2244XKjPcSo7FUu6M+cqGUe64IGM2f7roqDu4ksWsg8=;
        b=N+dT3eRiy74VODD1eCMDpIt6TQnvzbnXQK0LnKY/r0s5mYKET36yay8Msx0QlpHuYv
         w1bHjYIWySP2tOTwe1cUxuXQhh7gwTY2pNj3v+/zlBtVMY9Dc8cyPWHIreLxsD4O5KXi
         ciZ7pluO1CLhqP8+OyUxtQ7YW0y+vMJ2sdNzLEB6WxZA+Vo807hmN7ZgCNhQei0el4Ko
         sZMJS0k6aUrAaAVyY71vclJcQ3q9XhP8ngciRLUUh5f6GEaXKqOq7cAQDBZdYLn7Eo8z
         ZcfNoOuAOc/21ClPJgnBxfVkE97RDyfCz76Zs+yqdkwhkRVRzE4MhfFH9AHggQzD2Enz
         COAg==
X-Forwarded-Encrypted: i=1; AHgh+Rq9tdm4RIdsSMvHSv3eEhLOkET9hSbnEQ9cwReNIm2Hrn/V+CGjsJIpodc/0rL/KFugKiZUyS2OVP35njVI@vger.kernel.org
X-Gm-Message-State: AFuF++mZZYuPZjHvcy+3IL69iacgSZ0Rjhj9T3DcXBct3tGdz7uW48o5
	jlkA6OqZA6RFeBb1248CQyVgS+wPXBCmTfOhYaB5rpGEZNQQKNHcbN1mKT8IYNhr3BzQ9osubF5
	BstGBNWx95ag2GfcwpTw9MynXJKo6TNY=
X-Gm-Gg: AR+sD11CbIprRQxW98yoa7KRovKZxzMSIJWvfSPsOBhf0Y1+ZiibB7ucUzR0w0KAlYY
	5kXDaQBfSGGL5HvGiX2iwk263+MgA9Ivy/hgih3D4PbnV3l3ET5WQ1Rp5tS1cdmuLX5ikqYnC3e
	MqJxghESvksgm/dNgq+0IGJF70ee0vwvm7+wwcZ+QlRAKiGeNN73Vy11OYOjJTDdiX8hlaaxk6O
	Sv9oJJ+/xa1W/48rGUQt7e+0Y0ID4nu+kJB7rRmA1TDikxpKk3xaScoH/0A9gOIdR5TqrgtuPjn
	qAMoaZmVLDPzhrJfwX7SSAhDxtr1BUwJDS9HtJkt1z++AoumuzLhKXWx6VPrVq92mMW2WkKRaD9
	TjTxyhS+BzFg=
X-Received: by 2002:a17:906:ee86:b0:c24:c22c:6372 with SMTP id
 a640c23a62f3a-c250bb57107mr143752666b.5.1787691297150; Tue, 25 Aug 2026
 13:54:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824-work-coredump-unlock-self-v1-0-48fd1cca7eda@kernel.org>
In-Reply-To: <20260824-work-coredump-unlock-self-v1-0-48fd1cca7eda@kernel.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 25 Aug 2026 22:54:44 +0200
X-Gm-Features: AcwNN1Ww33jFcU4LEx-hd3VKksi-OnASObpyIOnRLYz1JTcfYRXMgye1NBcNCvw
Message-ID: <CAGudoHEsGP1P+sAWaw_tbh1NesJhSeww8869uzmaqtgk8F43=Q@mail.gmail.com>
Subject: Re: [PATCH RFC 0/7] coredump, files: exit files on request
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Xin Zhao <jackzxcui1989@163.com>, 
	Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 5:28=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> We've had quite a few proposal for exiting files before generating the
> coredump (see [1]-[8]). The various proposed solution were quite
> unacceptable. So I took some time to look what a _remotely_ acceptable
> version of this could look like. Here it is.
>
> The first patch is somewhat unrelated but without it the code would have
> to become so ugly to the point of being unacceptable so it's a stylistic
> prerequisite imho.
>
> In the first patch we make exit_files() synchronous and stop shunting
> all files onto task work only to run task work right after. For tasks
> exiting with a very large file descriptor table this means getting rid
> of _a lot_ of cmpxchg()s and hammering on task->pi_lock. The cost of
> this was mentioned in various threads over the years. I found at least
> recent comments by Oleg and Neil.
>
> So let close_files() close right away. No locks are held, the path
> already sleeps, close() does the same thing already. Kernel threads can
> just keep deferring. ->flush() and ->release() now run before exit_fs()
> and disassociate_ctty() which should be fine.

I think close on exec handling could use the same treatment.

>
> The other half is adding support for coredumps to switch to an empty
> file descriptor table before generating the coredump. That requires a
> bit of synchronization but I think I got the basics down.
>
> A new COREDUMP_CLOSE_FILES extension that allows a coredump server to
> request that the thread-group close all files before generating the
> coredump.
>
> The coredumping thread allocates a new empty file descriptor table. It
> then wakes all threads in the thread-group and tells them to switch to
> the empty file descriptor table and get rid of the old one. They report
> back once they're done.
>
> So that handles most cases where locks would be held for an unreasonable
> time until the coredump is generated but since files can be shared
> between completely unrelated processes that's not a guarantee and we
> can't give one. But it solves the reported issue without resorting to
> even grosser hacks.
>

I find this rather unsatisfactory. What if a coredumper *wants* fd
info and does not want to stall userspace on file locks? Sooner or
later someone is going to show up complaining about it.

I proposed merely dropping all the locks early, which on its own
should be easy to implement. I have not checked how fd reporting is
implemented, it might be there is no way to convey what locks were
held in a backwards-compatible manner in which case plain early unlock
might be a no-go.

Perhaps a new extension could be added to remedy that aspect -- it
would unlock early and add some extra info which fds had locks on
them, ultimately preserving all the information.

In that case userspace would need to get patched to stop suffering the
problem, but that's true with your patchset as well.
