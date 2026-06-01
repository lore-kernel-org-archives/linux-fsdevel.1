Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6560238758F
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 07:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780300318; cv=pass; b=JcezCQSmKlLbroS4GFGaS6lGfPdv5OssZfI1pA27jDWjOEdJqIiwB/BpSfx+Aa1NyAaa5kOJkjtbICDGMcI6Jhys63wd5wb3gLhRudcxcTa9ZxPQ7jnh+VjLd8dSqQvGl5zHu6Gk1cwJ9QU3q4ZtfzpblN6Diq2IJQSvubFosFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780300318; c=relaxed/simple;
	bh=cF3bo3gTiqGgXsGQh1woooAWR3zcLL1CArsvtr5JdPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bjGhEVDRaaAi/FTYHJFgWJqE8sMc0wjJc3l2jR88TjoDc3oRg8KAI7dL5ljc0wKEH5k1OKKjfz953IUIIdvf8A9u/mpfDSpj2k+as3Ag6ne6BkiGgjE6MaU0eIxhZgKSmbtywf4+MvA+pwVv3mQCsBAsJEq7+gDPDku7/Bo9wl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCBxmYk7; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCBxmYk7"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7df8b6aca7fso1452147b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 00:51:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780300316; cv=none;
        d=google.com; s=arc-20240605;
        b=WAZpVhWFbZ2J8dYkgx2wFCoc0aEQDhVdp8MvTLYwDb8FXY2BGh5SGph9dtGsDGdWWr
         SIPlooaUA/LzjUAQTN2Xwm7cs3Xuu3H6xj912eBWb7E93VKO2ZfGI/gCNk5s2jjkA2hu
         DMmfJnrVTwAOAx4BY3rUnAIQMsuXyyQ1rbf1rAFEkpTfCUhGCPDRurkdHXf22LMTVQpk
         UeGj9oxMe6xXIcCHqpvYGAVQHjn3058UOwGxLfKF/c+AbXpyTKr/NKampQWtkYr0OI1A
         EIy8hoLtBr9oxgn5trKMoVxCfGQIf/R2TUdq+yzqQvaMNX6Y8w8E9tnSoOv3HukMaocI
         8Nbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cF3bo3gTiqGgXsGQh1woooAWR3zcLL1CArsvtr5JdPU=;
        fh=XdrB3SifvEKACYLf7fuGPXVvEt2aQ2vYggvUVM/mWek=;
        b=k350DMeRZ8vhP1R27GxnVfPqm/Tje9rA+jRCUvJmZY/3uZJ6yPEGez3WBNy5bHgY3w
         hbeCZub1pnLJb1QFB6w6WTgSZbOLweWXkf+9tbgYcmj4oMCwYoy1cyw3+GeYrPcMNEas
         WIoAjAwa1jNh+4VaDM4rd/AODOcO4Mam8wS2TKYMU29E+E10FlFeUbaAzhbEB8oDTssd
         HbgEiIx60GyBY0FzJHGjBs1t6l71Gvc6hm36ns/xl+HAaPWYI/qP9N5L9BFd8rU76MSB
         pi40tNNSb7oHjSSqJrfeq+NSRYxzFlCxwDJZKb+5091srRHi4XhzRTXRtinKChvRaaUk
         nHJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780300316; x=1780905116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cF3bo3gTiqGgXsGQh1woooAWR3zcLL1CArsvtr5JdPU=;
        b=YCBxmYk7K8FYBmNSKOZ5ACifL3eTIanoNVln2/dqRsY0I0ruGUPmIleFd2mpYqjwbH
         /iM6pDEA4TKUop9/Vy3IvwFIsIgceG6ThsC9HmOsRSPPo8a4R4u+rYUiFkxoAlj8NC8g
         gxv8tV0nfgyXPeGc7ARb0BFltEJYaK4+4MYG6VhUGoFzBdorDLYXmUs1T0IWQ1K70vVN
         DQaNRpTrsUV1/LeTi50OV8kzRbDGRFlIphjCtH+KNFU78Hu60RRfn/Og3bovP9qinngm
         7oODhbCYsDRMTs0dtHup2horsxaC0F/Hk0KYY4U8plzAI0FbIb2AEyXA09Gas3jSNzp1
         mGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780300316; x=1780905116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cF3bo3gTiqGgXsGQh1woooAWR3zcLL1CArsvtr5JdPU=;
        b=nBvyFwOGLiZIugTOqvn2k1gANWTIxpabNBXiVejFG1L+e9lILb595jW6bKwIaKX5AV
         B1TMHe1+x0e4X2eAHiOvdpkOR+yLvnSBfHUF15PXoDZiUaCD9l7lk+dmfZ0b0OMttqzo
         3FQRoscn4tfXeIufHBGWzSn2h9mZ4Y8Po7ELlv62DAJcn2XYOvWt7ZVBa0sxoATFskrs
         P2+EYDqIzLPibOPd50i3Tf/5WR52YP47dTGVXFFuULvQ/reB9hdSNPzXTZ9ZxrfVHuXF
         RG24BXFLcn26KHFjlhot72udLYQWbGxYuB4gV5SnTcOH1YRR617/TYAh/t2/0j+IFglw
         gknw==
X-Forwarded-Encrypted: i=1; AFNElJ+r+zy5tqdFY7rSuINBLEeME47Pc5oNp37Omq5zauDKMya4YIT7BTsXzUjxSIaJjci2o2Z7c6cEEx5HEsCe@vger.kernel.org
X-Gm-Message-State: AOJu0YyAuZUcVhphCKytJ68BpxvsUTuvDv+pT9pEaqisESmoClhheTGG
	F8NgFSj3ZdYOAKPUtJXPBcGtguKs/FGjUXxC9k+2aKUFRbRLDrRtw9ILF8Ee9WesDKwhE6A/s2w
	UiUnEKoeegU9/tkW4dORib4sAlqTx3iE=
X-Gm-Gg: Acq92OHpbC9EDDIQSnmpPtCsOSoVDai1bh7F/pkCcr1ZFzN3Sgw1lygb+3xBLLJXreH
	cRWdOV1XqKgkX3kExcQWBc65cODNMRQRPgyrglPFmLCt0lms1Q1GCupAEmGkEZeSY0jM8oj2ClW
	J8TiziC0OzqLqUcFPJBItBCMn7O6PH4DZaLkjhEAbdjG+ZS0HE4UkxMGhrFZjfNwtXJqgDe9tsr
	xGlALEBnibE+LCOlEr4jmubc/auz2eoagJYpJ73IeEj9BHtI7K179NyxaX7jB56AMkdjBQ06BGn
	VkuZ9ovoYe7m6BteEusL
X-Received: by 2002:a05:690e:4183:b0:65d:7fad:2207 with SMTP id
 956f58d0204a3-6605f2b969cmr4819517d50.8.1780300316343; Mon, 01 Jun 2026
 00:51:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530143514.3083601-1-charsyam@gmail.com> <20260530143514.3083601-7-charsyam@gmail.com>
 <CAKYAXd_-Y1Rx-sUd-2GWS+KBCkTi+DA0DtX9qaD3nT8payRbGg@mail.gmail.com>
In-Reply-To: <CAKYAXd_-Y1Rx-sUd-2GWS+KBCkTi+DA0DtX9qaD3nT8payRbGg@mail.gmail.com>
From: CharSyam <charsyam@gmail.com>
Date: Mon, 1 Jun 2026 16:51:45 +0900
X-Gm-Features: AVHnY4KuNaKVOm2lexidjP8dBqeXyIJJcAtznnKIUqc00Ir66msg4tGqdwWooH4
Message-ID: <CAMrLSE7T6ZyQZ4eutnek7irEWYDeg4im+tvSxWuEHWDgaseK4A@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] ntfs: validate resident index root values on lookup
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Namjae.
I will check it soon. Do you mean 6/6 patch or all of them?

Thanks.
DaeMyung.

2026=EB=85=84 6=EC=9B=94 1=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 1:37, Na=
mjae Jeon <linkinjeon@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Sat, May 30, 2026 at 11:35=E2=80=AFPM DaeMyung Kang <charsyam@gmail.co=
m> wrote:
> >
> > Resident $INDEX_ROOT values carry index header fields that callers
> > consume after lookup. Some callers already validate parts of the layout
> > before walking entries, but those checks are scattered and do not cover
> > all root header invariants, such as entries_offset alignment and lower
> > bound, index_length, and allocated_size consistency.
> >
> > Now that ntfs_ir_truncate() updates index.allocated_size before
> > shrinking the resident value, lookup-time validation can cover these
> > header invariants without tripping over the driver shrink path.
> >
> > Add $INDEX_ROOT to the minimum resident value size table and validate t=
he
> > resident index header fields before returning the attribute from lookup=
.
> > Require 8-byte aligned index header fields, a sane entries_offset, an
> > index_length within allocated_size, allocated_size within the resident
> > value, and enough entry space for at least an index entry header.
> >
> > Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
> When this patch is applied, the generic/013 test fails randomly. The
> failure can be reproduced by running xfstests generic/013 multiple
> times. Additionally, ntfsprogs-plus must be installed to run fsck
> checks.
> Thanks.
