Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102F0318ED2
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 04:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784693434; cv=pass; b=dCMaugojpmL4C7lQ9R72tsoHbJjuvDqUvmVKtuiBUMFTRqLdZXwBPQfbby9lFHlToTA94LNfeVLgQ5mFcSBlSzgnapoQ+nQdA7ffBSS/7HHGBiOyCbOR+z8Jh/MqiUEVlUzX30XB537TO8x1UhRC0S2uxvVyNB9SaSlp3xTAiCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784693434; c=relaxed/simple;
	bh=ich92Tm/LS9YE6r6SXwulp3OvIxfv1PmN910FTyyLRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNSBL7EhcgWPoDEiJkbiwx881tgM1XiC2yIEYqz14RwvgHaaV5qbZ0bojL+JbtsHr69LP2iZgj3UjDnkT8bIkgCOBQE4vxew6E63aR01gzv402TSaGUys72r5jfBLKSJt80PO5rRERRwqnUZkee7hdl0w0KiblEJ+YCh9eKTbkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Au5RgbZ5; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Au5RgbZ5"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7eb1dc6bd53so6754084a34.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 21:10:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784693432; cv=none;
        d=google.com; s=arc-20260327;
        b=lhTLCTwgSD4WYeNkMr1ek+mNeBm9RRtsU7k0r9lhfRw01Z8jrLC0of5PH4NrYIpW/P
         2QrJjJLDeuM1ovxHItnFkKJpdpyNbBtor6hpKmZFEbeImSqh6KCbLHVQMxYSdYeSMFIs
         fepl8mJeDgzrLQ0AUyU3EWJH1P6g3bVXSrKhf2/QDID5qrRxHr8SmBwu2ccona5ukoF8
         vd3lbyWQrkfRZ/VHrsdWh3YzMNrmGgD1ZdbDJjlgaYAeqPRBr/3lWcLn4L6yqH6qIorT
         WCGJCutqSs/WZFQkX34o6a9Ch4PAa5JjHmEe17BnQs7ZuIXOBso67KwQV1oCXpkVPG0/
         Fwqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fJMSjq3aFC6lRcaN7eGb8QQTEap9hNNAkDRO2v/AIX4=;
        fh=0LCd7t9vASFn98qz04+BHHIYuwCXZKUIHw+sZATAeCg=;
        b=k+GgdQw6sk3uRFFO3QT01xJleOzMLv9X5aO7Mq0S1QLjyjRpnBfyv7Q0Mc7YuwfZvm
         grG5FZG7QrIe+so9WJDAiiShva1Rwv0WUVKI6WjUOvo91fN2/ZCwyiI/OGFPn5K1dnuA
         pyfbZJ8Ei9hy5bEF89wRmESSUoL3BrGqWq7pq7J7a+DJDnPEuWlApOIRqa4NcqeDAiMp
         O2be6x65Q+YBhhm5Inhl6udWZtx1k5Pi1pguL8KLW416qN4CTs0t5Xv++07uI0y5RMML
         u4HQoeckSd1MViep6jVmD64Y3mi7j9n9QGJe+cjY6NQxE2UrhS2fzu9k/30xiyMM9g5F
         8e5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784693432; x=1785298232; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fJMSjq3aFC6lRcaN7eGb8QQTEap9hNNAkDRO2v/AIX4=;
        b=Au5RgbZ5PrGIr/okur3I//nSHGcz1YHH3MHdV50d7HOO4auc3T7043NLeDQFtszZAk
         LAjXf+V7fX2ZjlzMEqkapD6iJW/jNS8Ob9gbQmXwnkB9O1cD4Nfzi3kCIC2wnBXC004B
         TYijthNQH8Eno4u73a0bnk/SkdO4c1dolCfjP+oStEXQEt0pSt4pVvYfhFvpb05iEO0s
         UdUaVJc8K5XPgaMAlFleo7Z1hkg8isKseGqCxaVz7sJWXhxnSEmILVrP2c7ZFYUNvmIq
         HJyMY6Rrgc4yj+PIS2vbXpmb/KjBtflTyrdjLrb7Gz5I4nTdHJOrWoPoZQ85efEuTRD6
         SFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784693432; x=1785298232;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fJMSjq3aFC6lRcaN7eGb8QQTEap9hNNAkDRO2v/AIX4=;
        b=gcWEHL/2qYHY/u0ru3gu1ubHNPwuFJMjesAMXfZV+/04P9kQwnrpzxhhRjNVvgA0mM
         Mg8+qCftnfwUjAQ2qeLOCOGpA5+pFgE3gfd1g0FwCKWHnppo7d10t84HrVetpwFBLzVt
         KshlEitlNLdQhVcgN2kYPNuxw1RGzhexZ+JuXMoQrrXMh9rgYeDzoN3IcVeCcgi+N4B7
         VbX3edTRIXPpr80+FJhv28o6R0qfANIWryWgVQ3O30OkD0hb+4KicXKLSr3dcoit9naD
         8hVBciwYJZ0WYxUtbvundOVSqyXWZCvkS7Ptl4Ds25dImOjQ/NmwSloSzp9W7Vo5yJGv
         +PrQ==
X-Gm-Message-State: AOJu0YxmGSkXcOCAK9bWQKa1nYx+73BZmMyaK8ozy9Yudqni6udIvtTQ
	z+l9v8al6kUxO3jaEIKnKf6hw8uJFAeqS8fmVDrri73E4NYlmxog6J1jOogwCB+tDvUoqXgla/s
	/anWHHiuits2RMnHLPUaUMO2TB+ETpBs=
X-Gm-Gg: AR+sD10sodh77nHwi1MbXNkQb9fZxl5oKrUVEsBt8O/QptxYII2FavsT3cGFALxyWvw
	IDu93eYsyp8umaOiECblDKfN/JmdxGxpX4/iC1AdP7oDc+Yc6N8noHRznrk5TfQ7UF2ManeJVO5
	92Dv2RYTDR7LPxU7aY7GU9gxrh8wrJRkJpGbjAucoJneXFXQOUAj0rgvQYRq8fVSe311EPCRgab
	HDrzyQ7ILMLMxNk8IWhEEFuH+b7D2HPsRF7c02adEJlBKvnOfWXCeIU25Q=
X-Received: by 2002:a05:6820:a0c:b0:6a3:795f:5fd9 with SMTP id
 006d021491bc7-6a53683c20dmr11004113eaf.45.1784693431702; Tue, 21 Jul 2026
 21:10:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+9F0A23jrHtcGc7gx=9hSCNmjwuDWYpzf-3+UR8ELCTt1bFCQ@mail.gmail.com>
 <CA+9F0A3uywPD8vk=O3Fg7LUgY9kYLtrNNLCcf-62k4RGrgQ5iw@mail.gmail.com> <DK4SRXTMBB88.RHDTPAQOGD8J@gmail.com>
In-Reply-To: <DK4SRXTMBB88.RHDTPAQOGD8J@gmail.com>
From: Farid Zakaria <farid.m.zakaria@gmail.com>
Date: Tue, 21 Jul 2026 21:10:20 -0700
X-Gm-Features: AUfX_mx0pcrp4EW7MdxKNpSj5p3O8R1q8OH1hvB8aOtvFrEZNMGl2yrdycmUc8E
Message-ID: <CACCo2j=CGD97K_bdHh2H3T5r2G+MR-U4qHQZXhPLzpPPUSUZNQ@mail.gmail.com>
Subject: Re: Questions and concerns about BPF-selected interpreter
To: Cole Faust <colefaust@google.com>, brauner@kernel.org, 
	Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ah sorry for the empty send.
I'm trying to learn aerc email client and couldn't figure it out.
(Back to gmail for this one)

I wanted to CC @Alessandro Di Federico

On Tue, Jul 21, 2026 at 8:59=E2=80=AFPM Farid Zakaria <farid.m.zakaria@gmai=
l.com> wrote:
>
> On Tue Jul 21, 2026 at 5:26 PM PDT, Cole Faust wrote:
> > Correcting Farid's email.
> >
> > On Tue, Jul 21, 2026 at 5:24=E2=80=AFPM Cole Faust <colefaust@google.co=
m> wrote:
> >>
> >> Hi Christian, Farid,
> >>
> >> My name is Cole, I work on the android build system. We have similar
> >> goals for creating hermetic and relocatable builds in our build system
> >> (a custom, android-specific one). I was very excited when I saw Farid
> >> working on $ORIGIN support, but then somewhat disappointed when I saw
> >> the new BPF-based solution.
> >>
> >> Our usecase is mostly to decouple the glibc version used in the
> >> android build from the host machine. We've had several instances where
> >> our CI machines are running old glibc versions that cause problems,
> >> and they're not trivial to update. Ideally you should be able to
> >> download the android source and build it on a modern linux kernel,
> >> regardless of the userspace.
> >>
> >> To register a binfmt_misc handler, you need either root + modifying
> >> global state on the host, or to make a user+mount namespace. But if we
> >> use a mount namespace, couldn't we just mount the interpreter we want
> >> to use at a fixed path? I thought one of the main goals of this
> >> features was to avoid the use of namespaces because they don't always
> >> nest well; Farid called this out as a problem with buck2's sandboxing.
> >> In android, we don't yet have any nested sandboxing but there have
> >> been conversations about increasing security of the build using
> >> something like gvisor to isolate the build from the kernel, in wake of
> >> the recent AI-discovered local privilege escalations, after which
> >> these complicated kernel features are likely to stop working. And
> >> requiring root is definitely out of the question.
> >>
> >> I also wanted to ask about the security of this bpf solution. I
> >> understand there are some security concerns about $ORIGIN. Why is this
> >> new binfmt_misc + bpf solution better? An attacker will still have
> >> more opportunity to place a malicious loader relative to the
> >> executable. With the binfmt_misc solution, you will be able to only
> >> have it active for certain things, like a build, but that's only if
> >> you use the user+mount namespace to scope it. From what I understand,
> >> Farid plans on registering the handler globally and persistently on
> >> NixOS systems that want relocatable builds, does that not make those
> >> systems susceptible to these concerns? (correct me if that's not your
> >> plan, Farid)
> >>
> >> I can't really think of a better solution than the originally-proposed
> >> $ORIGIN support for build systems to use. I don't care about setuid or
> >> complicated filesystems like memfd, so I would hope it would be
> >> straightforward to just error out if AT_SECURE is set or if any issue
> >> arises like not being able to determine the directory of the
> >> executable. IMO it's fine if it only works in simple, known-safe
> >> cases.
> >>
> >> Thanks to both of you for working on this, please let me know what you=
 think.
> >>  - Cole
>

Hey Cole,

Thanks for the response. Funny timing since Alessandro, who've I added
to the email, also reached out privately and I referred him to the
mailing list [1]. You also might want to cross-post this there as it's
the original thread containing the use-cases and rationale if you can
speak publicly on the matter for Android.

Is the Android build system Blaze (I'm a Xoogler)? I think although
the namespacing can be funky, even with the BPF solution we could
leverage this at my current company (Meta) with buck2 to alleviate
problems with building against a single monolithic glibc that I am
excited about.

Very cool to here that you have the same issue as well; seems like
there is a more well-understood need to have the interpreter support
$ORIGIN than many think -- or at least that's the assesment from those
on the mailing list. [2]

I think the BPF solution Christian recommended and ultimately put
forward is technically very cool; the idea to programmatically hook
into binfmt_misc sounded cool although more than what's necessary for
the $ORIGIN support. It's kind of neat that's a superset of every
binfmt_misc solution out there now.

I'm pragmatic and appreciated Christian working with me towards a
solution. My idea was to hopefully get a more understood rationale for
the need for $ORIGIN by deploying it with the BPF, albeit in a limited
capacity due to the root privilege, to make a stronger case in the
future for something builtin.

[1] https://lore.kernel.org/all/20260722011217.45e79a08@spawn/
[2] https://lore.kernel.org/all/20260626172832.366deaac@pumpkin/
