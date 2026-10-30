Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793361291;
	b=quXT6CcOexJVc0ZKmZNI9N5H4IHI3gMLsgy6D3aa//yFk4PNfmymDLGaJSR3ryghKoJU
	 FwMNLfncizZVMeLDIYPLz7VtNDEizQACH0m19Qe6b0Su0DEcBWiNv5NpFJr7lYP1paild
	 6vuiLWCY+meapZ1rQ8uY5t1NIc6Ez4ce+a2ULYriXHg8bxzIXt1jgtoT922USC8SRvUUu
	 aqMcjrB415VQuuR5f1AEy9q9V+ZEpNkNGNcXgV0A1bGS5+VaIfgUbGAgVnLu8kRRqevcC
	 Oinei3rSIf2zgGg1ox3LodyYv9dOThZvZn+MKQejlrH9RdSmgiynwrvx8qmjRWDlIaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361291;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6bQ6ZZpHabfRvZSQoIyHAduDOey6ACVdCtwVDeTSY98=;
	b=3TPQ6QkNqg9fDi6HhHzyDwq46s7QK3x+MpgLIQ+lQlL6J4PMYLVdLHfjF9utcdM2BiXs
	 ArOmqkJMHEhPM1T9UTGyC7H0qbq/CO+cgM4HuHm6c4ZZclkwzBrXpVzwZudMKFzII13Iq
	 NLaapYyyI/7wNdJOhGb5BBCUrxzvDgQThDNK/7DAr3/SMsil39g9EQZ/+N5cwp0HLcwV2
	 QOklosVt60V0isudX20n+9nO0gmTM+kL+EeAhy3FngixslQQxn1Yc4wMCaHE/9rplqHoq
	 RPs+8R8HQNfzG84fZfcZ9gDder+17VyYCZvhjEDCU+Sszn8jGBcGBLaJ9jbf74uKYxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zgGFeFit;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE4B606A32A
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 11:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDE4B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zgGFeFit
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b45f9ec1ceso640017a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 04:54:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793361289; cv=none;
        d=google.com; s=arc-20260327;
        b=hUf5zmWqARB0nQl9vSwJ0guGN7+oXKT28WXUn5U/pA3tm9Iz9aCtB3MzrRdWJ7OC3b
         n8ea35z90IugJPWfV/TnhJazkUb0B3qtt/mOJa58vqo6r/SD0YOqKqnAZ6gb1BJgQQRs
         6Sh1KkA9RrVgzH2YZVQF13qW1PWbzHxTPTunLWW/pTKOkCGlWh5yLVziD4pdG+QjlLUg
         WCyTediV+BpGuE2Dbm3S4FivZFjg6bCf39jpzQuryR/kVocDgjd8T3iEMpRUt+cAyYnI
         sPDolwdaoPYsIa3e8kY6plyP3h/XplpnXxWCYox32TDIGtKuXfXpSMmQpB2vQ/eCVrhU
         Coqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6bQ6ZZpHabfRvZSQoIyHAduDOey6ACVdCtwVDeTSY98=;
        fh=uFLhbMXACkOR4HpWaNUMTKfWcWCwCVztyzt1S64aDWg=;
        b=Trw/yv6em3jiE/8PdiXqnRj5gYstqO9wZK4dJcXns67gGjcZifhJ1Z4v4MNy32DYkg
         gKyl0/ynF/Am5BJ4i2F+N/qMHtAUcyaNFisoZy5LDIod+WizibejeWKX16jpWxC0e/HG
         EdKDXvHP+KhuHtLrX6W4bkeeQoV5/14NPHLzN/PrVFZajwV1SMw+oXhR0tpFZHiM1Wyu
         mzPSBTwvwRqOt2cGLDEa7iEhBeXFDNfptEX9Cb2N9e3wwnmfrvRx8eVOe3glCJYpAt+j
         O1Hq0aoS9uukVOvUFW2MLlVoj3cNGxXnsBJD+v9bwdzAwMq4Xqjj2S3/st+Ws2z4uJ3I
         68Eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793361289; x=1793966089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6bQ6ZZpHabfRvZSQoIyHAduDOey6ACVdCtwVDeTSY98=;
        b=zgGFeFitjhi7kxcPB6FMZKpTVSC9dvTTT0WJh4vIqa7n8Tf4cbObbLBmGb10JuGBKw
         7g/oxsMH9G4Yr1y/d5skhpqjy7b+xJjMr3I2rvEnaGOdOKalZJE8MNVY5jqUpL6aF6li
         y98TRUDk75NrI/mkrQh/8jihmyVZCdeevpBcZKR5TcQJp2K+xfmHmhsCACpp40/8HCg/
         enOOeVGRANF2+jZSyKYJShpCPRXMb2VByF+N4tnBziKBONSIrkX82P+NyZAiqHPx5FOs
         EfEc0ZALBq5DW3HVORMPVjJKRdUdk4fILIYmvHYUH3Fh3G+SRhIbh1+LB1UdQuTAMwNl
         /dtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793361289; x=1793966089;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6bQ6ZZpHabfRvZSQoIyHAduDOey6ACVdCtwVDeTSY98=;
        b=b+Df6ZIL5Z5daWsflRkm+lo7lDdUHsFy08NDhERWC+P9fuMgbWZIkG9UxRJZSiQGB5
         Fd/4S9zoo6rDoeKgHq/GizRG4fRS/Ue5nSR4QCFn4sgmqZFbS9j5ADa5h2OdzyLDgZO+
         rPZevCB/AZ15ar+ZKIuJizokQWNowR/cOAQlUas1eaTWnd6NihYwRdXd1hyhWXHBQsUb
         beg/W9L9x+18tw6IIUVdobJXwoBSF3I+cGILss6wXhQmFJ34zT2eRcq47lyh9rdxuGzi
         t5voA7CWh8V0AvqInhkCX0C7qSkexM0Q+8rtpntWHXbd5UEmGpPppyDZn1HfsnC7Nbsg
         liRw==
X-Forwarded-Encrypted: i=1; AKwUvBx82e4zwwsI+sdWjj8TWvKYiMQQ8BO8MIjnZpg/P/M3FwIbmVrb9+IkIqZD/gvfQhlEv8g1YDDbrdEo2GJf@vger.kernel.org
X-Gm-Message-State: AFq9FYK8JYKp7oDsKLklh/P8XOChr5DzIclvJeZVEbuDDe36wm+wKKzD
	4u/XJWQyNQDfJlYYs8QJQs0A9ocZhbHxeKZLSUK7DsvScvZheAj6vmYPm1g6srH7rZML6TqPVth
	WJUDfaU84hbqQta3caWEc2aAdi/b7Xw0=
X-Gm-Gg: AYBFou2BwW0yxtnfmsLSvK+M+1H6GTjUlhnIxYGWswDkIucnAyQ9RB0a42Ny6mVZzEp
	G9UhK89+PnAMHcCPCpCUj0lLEolMg/f6n1JwTyUHVAlzJRPV8TxgfbycTAfPOo35PMm7UWm2/3+
	mp7RA38G8s9BAkbnGS2SJrujPc9mT1CdqXo76TqiUEEKD+CKna6ypdyQnbePoMmAMjrbHzMVpJw
	RftqxaYMtrH2Ey6dXelooqu6rQTIPfBfX69bJ7xoz3wYQL8+zkbYUI+vOjXiOTNHE41UhmuX/ij
	EcjIkJPlZJwK3cg0LH+QwqYYguUbtRI9sAxoUyAqcPP6dIK4HJ1IRLGufF04F8e4/FQUR+k9RCq
	S2t9nTEl705zL3q3ijNp9L7uGhRVbDlkM8kt8QCOo4lmSLiTgwnfUAwjHNvqlMAgybqxRag==
X-Received: by 2002:a05:6402:c4e2:20b0:6b4:2b70:4a7d with SMTP id
 4fb4d7f45d1cf-6b4d5ede191mr1079780a12.40.1793361288879; Fri, 30 Oct 2026
 04:54:48 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028154008.67451-1-dennylin0707@gmail.com>
 <CAOQ4uxgDmhddqpFawaK874cfWCp4jVDnE67eqXyDA9eumpMEpg@mail.gmail.com> <CAGEkeHdXVTQU7VS=TxPqmsXMtFFeP=LWw-y04NmcRWJrwHa8mg@mail.gmail.com>
In-Reply-To: <CAGEkeHdXVTQU7VS=TxPqmsXMtFFeP=LWw-y04NmcRWJrwHa8mg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 30 Oct 2026 12:54:37 +0100
X-Gm-Features: AclHuK-sTd0BhCfu01BaFX8UFonq1_wSWaurS4GV6csh_oR6EIVobO4gUcofd5o
Message-ID: <CAOQ4uxihz0G5jAijCOqzipLZ3=-iPd=8AUgxnwZYvFm+Dpkapg@mail.gmail.com>
Subject: Re: [PATCH] ovl: restrict casefold consistency checks to directories
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: miklos@szeredi.hu, andrealmeid@igalia.com, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 5:44=E2=80=AFPM Hungyu Lin <dennylin0707@gmail.com>=
 wrote:
>
> > I am asking because I got some patches for overlayfs casefold which I d=
o not
> > prioritize because I do not know how widely the feature is really in us=
e.
> >
> > If you are interested in reviewing or testing said patches, let me know
> > and I will send them to you.
>
> Hi Amir,
>
> Thanks for applying the fix. Please send the casefold patches over;
> I'd be happy to help test them.

Excellent. Sent you 3 patches.

Thanks,
Amir.
