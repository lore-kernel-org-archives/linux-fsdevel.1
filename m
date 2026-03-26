Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445731A9FB7
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 20:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774555222; cv=pass; b=eFsmjhKccHSpwuF/j/Qbmcc0DCp0LXFEywsh5yg5iWK4mDbVCxMpa1GIK2p/I7IU8ODaS+S7kbcBgzFFQXhGxbkGpELmP99oHuEcUbuSvNe1J0AuWCCKpgQpe/VQmRloFaQnIcSfjcBOvzToqby6CdvYVsOopZWItuxGNB9Cb9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774555222; c=relaxed/simple;
	bh=sAvbtxCyY1rtegUGgvklekEfShw+EdSi9nbkkTLqtko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EuyvxWRIjZcH5C+YP9tqT8ZkTVJ+YaZVN+OPHebiy/iWp0t/lfJkfBr+5BRyeQcyNow4D7qYM6hvWDRLY9QVjGc5CC0fzuElLkudoI9kaT7j+QQSRgPRNxWNGvcx0WRAWZK8iiXlyuzSpioI/Vb3iRWS9PPcKjOjrMiC2cwqLcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SnlBiCnl; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SnlBiCnl"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-66a8242c1d8so2935a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 13:00:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774555219; cv=none;
        d=google.com; s=arc-20240605;
        b=BY7jvA3MYiVywv86O5mlFMyNebovj6ROmVF5WFzRUC2dJqQwmYZ9fQMNUxeKFCT37I
         j8BUdNAQGacmyukdgHqoZeGdcpzkFe0H+AHCK5NiX5MftBE4HgkvohrSmGcAzJGwPWqu
         TwyI1aHtP4uXA+bDllywyL3m5Ul6OY916VNeX3hWqK9FDFvTlTUFoEwXto4ZbH0ONz1y
         NrlccTHybF7lGVmqZ4SPNIZMxBZxu/qPYwxJtszyjujJvUG4p6Ub76/HoCGGCrvzut66
         qwBMLXi7U9wjBLoJQgu3jAgi9oRHIZgrXajylD2sMZde7iJIJlv40ir3h6dO6lRr6BCk
         3u4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sAvbtxCyY1rtegUGgvklekEfShw+EdSi9nbkkTLqtko=;
        fh=G1ODeOQY4xXKnouwW9BxsqGo1RzeafUYd4bCdX92iV0=;
        b=fEmqV7SWa6GT2Q7qt5leTYZvj70D9BdpMMHDnd893pkNKvb1zbcE/PrulX39Ox42CH
         SOnoho0+RFAlNkEee1hXmqLZemSZP9/tlihxVRhalU2Fd57P3gPlTAnI+zRRoRumMitO
         SVy1OYs2ZTUyQeQJZqWUcp3gY9VSgwo1VpnUqZd4OJnhX1XJT/P/6f4MeeENod1JlLEb
         jIqXOovDG49GR5E+jiCzX3geswQriGekLcPa1THZFF4o2tBQDk45PWoqGeAooD4cL1oE
         Wo3a8J13UXzTIcXgr0Leq8y3M9FWR43yGVXAezJerrcJYFNizNHr67BazkxrrD8dtg+d
         EkBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774555219; x=1775160019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAvbtxCyY1rtegUGgvklekEfShw+EdSi9nbkkTLqtko=;
        b=SnlBiCnlWf1y1FlN2uhARD8/EYVDfxRgL+IBgHpviHG6+a9kDVhyzbWuazTxF8v1A6
         0GW58jNe2uPMkj0KA1GYxXjtH4o7DbEWfIEA79+gj2P6wIrlJmhOiak+OuktiwDBZe16
         OlDZ8oaXnRb1TipejE/kjC7bi4qio4zBYwsi1QDBEyo6PEYWEeP2rOYjVtTYK2xnANog
         IGBQczJwaSWM/I/y6ylQwgbX+f2Ok7kJKZFzqp7xZoMQJJvaH6KaZFpsigGjGB9KJF1B
         LVsSroWrXZ/xA35wl+58xBTr30fqF8G7aun+Q/1imDeNjnNFPGe4LQEdUDYGtmH7QqVK
         W2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774555219; x=1775160019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sAvbtxCyY1rtegUGgvklekEfShw+EdSi9nbkkTLqtko=;
        b=DPwHdrWS5U2XCtLLuFEz2wpJIajP3Jp2MERfjURauWAcdM5ugHwMmx28g0TJnJ+eIA
         JITpRJJR5iFLk93d8W25A5VS2zCsxY2nUTP0FIn9b5FwD2o19RjDdJZbfKhGs3ChA4U+
         83j5dXUk63rveGT/OS5qcdJSfV5EcaWhhtERyswxjgDZ3HfuF0Hmijl012m4iNR7ZrAZ
         R8i0g0Q51L/EDWRKoVL0VCMLwQC4bZ+lG5OXwGYsnUC4ZrmmkEsvAn561sP0Wg5LHOPc
         fTHI7WoQ4DVUwWUdEprr5AhIgZYYaKv5JRQlystxqcd5rYGJCiv7n4wgGkNNO32DghB2
         L3LQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/vtjX8TGzudCAOOFbi9G+Cbiah2aST7cfpJ0WHsWGv8EM1p+qXm7vO2TlkAKY2JVaXdoeJdy6AOc9tmuF@vger.kernel.org
X-Gm-Message-State: AOJu0YxaudoqLG3Ws370yRXct74GUzk34iU1Ed+KsHz9BjaaqU18jxD7
	iPBy2whske/WUCrD0d+iM3rbCJnmF5d/yt3vD3JhyzrTXphqrBudzOG/mJo8jW8aJYv7HN1EjhH
	29+qQBzZFG3bjjTQ+pDeijvLqsj5xcAcAFHCW9rnf
X-Gm-Gg: ATEYQzw5waNNiU+6czN3yFOLGIgB368uXJfIkmgIcqRUB0KkMJMDqb84juajrauX6pO
	iQVxnVACy8435A4hFYYxQnk2k+FPTGKjX6lJ6YSOrKvbEQuQ+Hz3/XoMW6yHOrwzjZecR/72Oox
	Va2/qklKJK1FDtEeU6MRNfHM1itvy1mwWcpzHgcK/DcnlQFM+cNmYUnSzkI6DNu0O+YyHDJeZqh
	iTP3YKTsC+LkNPJq/NR8vQO3tL51N91SLxgpICOWPAnGqF9vjjJCNV0cmGTLXU4k2jq/pMI19Ae
	JMlCQJmZaIQiK0MXv4me6ApyH4WeT+AmOmTB
X-Received: by 2002:a05:6402:4613:b0:665:7112:ee03 with SMTP id
 4fb4d7f45d1cf-66b19dcc282mr12264a12.14.1774555219028; Thu, 26 Mar 2026
 13:00:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306003224.3620942-1-joannelkoong@gmail.com>
 <CAG48ez0H_Z-NQvfOeczECz_sO=MzVDvu+8m+msB55rcAPfQOgQ@mail.gmail.com> <CAJnrk1aTnoDwDVdgYrcN3tHm-_j79GKYY=8q_Lu=xi8=Cxi4bg@mail.gmail.com>
In-Reply-To: <CAJnrk1aTnoDwDVdgYrcN3tHm-_j79GKYY=8q_Lu=xi8=Cxi4bg@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 26 Mar 2026 20:59:42 +0100
X-Gm-Features: AQROBzCGjXCNQQerS2w1DtLW2jwJku1pDgE-yVJzRKpzcPByNNh6dNrnifnY7GU
Message-ID: <CAG48ez2o=OzSjuPYm44gCDrG_tqzXC3=PCJHXCBVJyYmemtzsw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] io_uring: add kernel-managed buffer rings
To: Joanne Koong <joannelkoong@gmail.com>
Cc: axboe@kernel.dk, hch@infradead.org, asml.silence@gmail.com, 
	bernd@bsbernd.com, csander@purestorage.com, krisman@suse.de, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

On Thu, Mar 26, 2026 at 8:55=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
> On Thu, Mar 26, 2026 at 12:33=E2=80=AFPM Jann Horn <jannh@google.com> wro=
te:
> > Am I missing something that prevents normal io_uring operations from
> > grabbing IOBL_KERNEL_MANAGED buffers and accessing the wrong union
> > member?
>
> Hi Jann,
>
> I am going to be submitting the changes for kernel-managed pbufring
> compatibility with normal (non-fuse) io-uring requests as part of a
> separate patchset. You're right that there is a functional gap right
> now where trying to use kernel-managed pbuf rings fails with errors.
> In those patches, an iter_kvec will be constructed for
> IOBL_KERNEL_MANAGED rings instead of an iter_ubuf. I'm intending to
> submit that patchset upstream in time for the 7.1 merge window before
> it closes in mid-April.

Ah, thanks for the explanation. Please CC me on that patchset, I'd be
interested in taking a look at how that will be implemented.

Thanks,
Jann
