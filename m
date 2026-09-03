Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D3D30D3EF
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 01:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788399514; cv=pass; b=tsEk1PoHunn+uoCdpdZqdpp5p1OtP+WSuIqu6pG4OucVEr831T5SIERQjXpb+F9YraJwY/3dF9XVoV7T526C7zApvR1tV7HBasA6xMATlUsVlNyzKP9L9Jk7c3z0OS0dxx9QI+aOIm2svvFN118qmSy3Di73p4rlJKQwRHDhJ4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788399514; c=relaxed/simple;
	bh=Az8ML3xziSsQ3jStY9KH6BKlBem4EKxqSIFS0wdqnVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PdQK7lcHHTvCN1M9gkVbP7GnD1zGDv+cDeKVARkomKixl83M3jDIJVPRqIBHmQgI1xoDJUQ/PdEY1buwIxAKKP36+ZvqvIRyqxTqkh7nYOksP04F0kIw3ddjf2MYdSVzv9tqmedxxCFfG6Hi4Dx+3WotRoHPFBparLRzbQi2rZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ieMt5XrW; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ieMt5XrW"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-398a4dcf289so2072175a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2026 18:38:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788399512; cv=none;
        d=google.com; s=arc-20260327;
        b=S4ZEb/StSZogI4dc+IckDZj1/5lFsfv+5rm/EawkkfrqhuVW+QXkBRMCgqtP+ZTt08
         oIjo9LW2NYmdOM422ZeM+d9Tr61ax1/2+sWzxNJSAiNFE5lOtdW8s5gzeHNz3bE09+aq
         RZoaSaAeJjsaFRf376R7JT0MHriIcQ7sxzxi0iuhaWPMYsk+LwExV6wi5zTDGgtWgONL
         Ayvqc5MeqfJfc9Hfn1+WqIBeiHWREkeULUavKsfdzVeq5E95vrgE54NfaHxt2FsIvX1R
         3xpIq/YLb26rSji7GGM+I6DAUdGwn+1h96rNPOhWJXOe516hvCu4pBPs215hsyWvdgl+
         IGQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V64QR1IsR8MyGUl9CMimjz0m+06sJhfAIW6p6kz46nA=;
        fh=ijMswcOmmMdK07BF4zso6Dpg8n3Tm9ovFsDfRsN6Rzo=;
        b=KzRvRzblEMxjUDfdyTivnIf69aKoe57ceADViU9UBrDtsVyEd/e8qpanlwtIMB5E6Q
         Y3tv50G+PfiwB6n4GDJzRZGv/u7ZC01TfLqD3jqJrrwWLJ6k11q+UdbHBtwMLuYISPcp
         l7GLkQZ/0G6NvF+iUYhrytb9rZqReG+izsg4E40BeblitiBE4CzjnXqnoU9kvQAWTi02
         t2yf7rkskzRFMNQvvwe6TJFAqtp33d+wDoV9KeVY4H91sWHKyQZDE/yn1ZOBKX4/o1Ne
         Gnb6p/JOB/fHGq/dWYXKmias3O9BGdiusLgVFyNwt8rZrYE2o29g+swwv44nV3zpEeqh
         ibOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788399512; x=1789004312; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V64QR1IsR8MyGUl9CMimjz0m+06sJhfAIW6p6kz46nA=;
        b=ieMt5XrWd/F2asW2oeONrumun9WGXZFvz32TcoQYBhzLUd9Eous5nDRCsjE1gkIJow
         euZTRZWFfh1FxrazNwawDR2EopRRy9oHytGWh/gperNGNBFMrEygCNVSIY/M8O03STQL
         eH4xRrkIzUObT+5CBkWcSRrg/A8qG4fGUGu9fPS+tuWX+J1Hy2p5Dvq7lGBX750CA7l+
         IN4RmV3hvXc/nVPoY0oc6qpebwGuI3l3JemGo22AowhZclmnZdDEvLNVJ7bi+z7QDCDi
         j3Hgc2lawmfIFkLotCEUhwZur5FI7n/wCNPAUQXa2nvIj1lJugj5MRlCBfoGd+FCzEq7
         nALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788399512; x=1789004312;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V64QR1IsR8MyGUl9CMimjz0m+06sJhfAIW6p6kz46nA=;
        b=I2tHlxcDZJ7TBq/YNMFga/o6wGCLfer8pzgvUn1IGORb5XCRTMj8b1eSI53/FGN62H
         yi1482S1n0nwW35VLv23jKUTY5bP92F/o2ijLMPsEkmL4oN+0IXIhUssxT3YhAL1wBJ9
         16iHV48LDCqSNqDEk++fjl6+BDwyqb71Q4VY7NzCufQC1osromkB6w2XNJGNRNcigXfj
         cVf8R94dQXCkD8MQFUUEjBhlFeH+Ju+lYiQD6syI57FSFQAeH4VjON9j2TPBKjdxNW18
         vbZFd+LttDFtuIrJsKGUVneMfovpKwHOrxMV5eXfsdnaKQp+gr0i6CbG9BT7ZAaoocxi
         T7Gg==
X-Forwarded-Encrypted: i=1; AKwUvBw6xvpAthIWYxfmsscIaC4Vqc0fQJuzKxPhgqsY0T5DiEPg9/CM3gApUrke1U+2SKnxwW8e4LQinXVtF4sF@vger.kernel.org
X-Gm-Message-State: AFuF++msDxOqGtS1yAkmhaQDeUuDTC0IWU71VVSjiZ/5GyTGbA9u2TeB
	ZO/BeJuC2/jzmO6MdfP/57ID6wGgvgm5APJlIdi4wSxgsVd2j1/KnWHI/EwnETgiqUgxgjFk+IA
	vOcqelK1j/mPmSadgwbuw+/9/f0yStonoQgfrtFaT
X-Gm-Gg: AYBFou2iFARDbgmbnMl5DZb1gRRXdF+oKbsPCIW+8zjJc4SG8LBMXY15pDPfq7YUSBq
	zqTXceRaI2PLTCXwcTY80fLPfo4Za6MBJFOityUxspSZKaewAL5Sx4Ak4GQ9Kx9hyre1SvkX922
	D3qkrG/5CQ3+VRsxP99nF0jGZvnrFinrHNpO1hdzQD8V4lmiQG/RWv5+oLzhTaWUL+vVwQeY7Ua
	vy9LQracXoIPYqoz0KGLoKDIXZan/cT1Ky4O2cylgSP0I+qPlsVwdMtzX3jgzEZG3CVYHZxW/2A
	CTALLxjuON/yC/cWV66tvtWe53sbhaTRKUheQDKNfd+oSeHmQs8dJLkrp8qoIwIZI7xl/VQ3ZSq
	bTrJIe//l1g7LaNE0gOHTjVuyQ8rbfqySpS0DPhw2OU/M1cSw42YnTrHYEIt5wjnCv51NxPYdRm
	mon/i/72fhBThZ
X-Received: by 2002:a17:90b:3fc7:b0:398:9be8:ea69 with SMTP id
 98e67ed59e1d1-39aee251837mr14335412a91.22.1788399511412; Wed, 02 Sep 2026
 18:38:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAE3jtcL0b8YsNiJpcXkUVoZRxFetU9o8z=JVNUCnDXN=seUmg@mail.gmail.com>
In-Reply-To: <CAAE3jtcL0b8YsNiJpcXkUVoZRxFetU9o8z=JVNUCnDXN=seUmg@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 2 Sep 2026 18:38:18 -0700
X-Gm-Features: AcwNN1V2Dk1ZXSLu1Azh2xjqw6dIZJAN5we8KwxOa0fvJ97gB8WYOupXivWTtro
Message-ID: <CAAVpQUC6RHs+ODtKtgSDy=oxV12azk5QkjO50yUDJpOAHiv3qA@mail.gmail.com>
Subject: Re: [RFC] splice: add wait-all semantics for socket-to-pipe reads
To: =?UTF-8?B?5aSp54u8?= <rockeet@gmail.com>
Cc: linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, edumazet@google.com, ncardwell@google.com, 
	alx@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 8:53=E2=80=AFPM =E5=A4=A9=E7=8B=BC <rockeet@gmail.co=
m> wrote:
>
> Hi,
>
> I would like to ask whether splice(2) could gain wait-all semantics for
> blocking socket-to-pipe transfers, analogous to recv(MSG_WAITALL).
>
> The concrete use case is a high-performance S3 FUSE client.  Once an HTTP
> response header has been parsed, the response body length and the exact r=
ange
> requested by FUSE are known.  The body is moved from a TCP socket into a =
pipe
> used for an fd-backed FUSE reply.  No userspace data buffer is needed.
>
> Today userspace has to loop around splice() until the requested length ha=
s
> been transferred.  On a fast local network this commonly turns one logica=
l
> read into several splice syscalls and scheduling transitions.  In one rec=
ent
> profile, 3,475 S3 GET requests caused 25,463 splice syscalls (7.33 per GE=
T).
> The profile contained no poll or setsockopt calls in the hot path, and 80=
.86%
> of the sampled CPU time was in the kernel.
>
> The obvious workarounds all have undesirable properties:
>
>   - looping over splice() in userspace adds syscalls and wakeups for shor=
t
>     positive returns;
>   - poll plus SO_RCVLOWAT waits for data to accumulate in the socket rece=
ive
>     buffer, adds another syscall, and couples latency to an advisory read=
iness
>     threshold;
>   - recv(MSG_WAITALL) requires a userspace buffer and loses the socket-to=
-pipe
>     splice path;
>   - increasing SO_RCVBUF does not make splice wait for the requested leng=
th.
>
> The current TCP implementation is already close to providing the desired
> behavior.  tcp_splice_read() obtains its time budget with sock_rcvtimeo()=
 and
> loops while data remains immediately available.  However, after making an=
y
> positive progress, a later iteration that finds no data returns immediate=
ly
> because of:
>
>         else if (!ret) {
>                 if (spliced)
>                         break;
>                 ...
>                 ret =3D sk_wait_data(sk, &timeo, NULL);
>         }
>
> Would a new flag such as SPLICE_F_WAITALL be acceptable?

The use case makes sense, but I think it depends on the numbers.

Another aspect would be whether we want to add a new (potentially
buggy) feature for a single user in this AI era.

It would be great if the change is proven to improve performance
of the official client that has a lot more users worldwide.
https://github.com/awslabs/mountpoint-s3/


>  For a blocking
> socket-to-pipe splice it would mean:
>
>   - keep transferring until len bytes have entered the pipe;
>   - after a short positive transfer followed by temporary lack of input,
>     wait in the kernel with sk_wait_data() instead of returning;
>   - use the socket's existing SO_RCVTIMEO as the total receive wait budge=
t;
>   - still return early for EOF, shutdown, a pending socket error, or a si=
gnal;
>   - on timeout/error/signal after partial progress, return the partial by=
te
>     count, matching the usual stream-receive convention; otherwise return=
 the
>     corresponding error;
>   - retain the existing behavior when SPLICE_F_WAITALL is absent.
>
> SPLICE_F_NONBLOCK/O_NONBLOCK would remain orthogonal: WAITALL would not c=
ause
> sleeping on a nonblocking descriptor.  The destination pipe must either h=
ave
> enough capacity for len or be drained concurrently, as with blocking spli=
ce
> today.  For the motivating workload the pipe is sized for the FUSE reques=
t.
>
> The important property is that data can be spliced into the pipe immediat=
ely
> as TCP data arrives.  Unlike poll plus SO_RCVLOWAT, this does not require=
 the
> whole range to accumulate in the socket buffer before transfer begins, wh=
ile
> still keeping the wait-and-retry loop inside one syscall.
>
> This appears implementable as a small conditional change in the TCP splic=
e
> read loop plus UAPI documentation and selftests.  I am sending this RFC f=
irst
> to confirm whether a splice flag is the right interface and whether the
> SO_RCVTIMEO-based partial-return semantics are acceptable before preparin=
g a
> patch.
>
> The userspace implementation and CI profile that motivated this request a=
re
> available here:
>
>   https://github.com/topling/ngs3fs/commit/4b8f5a69ceebd9211021a5d1149637=
3d63f2e43d
>   https://github.com/topling/ngs3fs/actions/runs/33586457571
>
> Thanks,
> leipeng
