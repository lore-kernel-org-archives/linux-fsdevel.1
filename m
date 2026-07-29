Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3AC455185
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339608; cv=pass; b=YW+y2DxxJHOLeFJqw+NWgduVWEQ9G9fFPgOtaUCyqoQ4BojQ4zaW4RVHUCd3w/34MpbZnX2DNBiMwJaK4wqTFOM9215NI3WABGBOC1XHWczFPyHMboU6mZDvet++jKpzjP0f7K3xgc3KQn+wU6QqWafK/5Du/PPFchy0wdBGmys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339608; c=relaxed/simple;
	bh=pKHjwNmvw7Hfpsuu6wywi31u0Fkptl+wmfXa+l8StWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKq/Pj9N2P8a0c0tuwFQ9qapWrp7y+FQ8XhOv6uesKo7wpaS+dHAALyTh8Y1VkyrKf5KMq1L0Mb4ISyIu5ygd+ei/DorWuZP4Z2qSOFw3Wswbea5NlO+SAo7/cnXzAcDIsblCbhrMhdtuhJH8P/XWoKIosmY7hll/u4yiS5SAQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=ErohCOiL; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="ErohCOiL"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39c9452244aso9868211fa.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 08:40:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785339601; cv=none;
        d=google.com; s=arc-20260327;
        b=qEx3RwLgxhzitFHRiTljwrxlx5pTtILZ34i8+/VSeo4MVYJLQ4ONo3WX3IcMKFDF6C
         tMv5kbbIbgVCUX29pfyd1W5jIdVUAc2XCIjIGG3th+h0KKeDHFo6dJqOLTkeLG3TMrwX
         OfC4h0lB0QI139gnYGrnh4cv5CHLgJ2NqhzNvhbWurnsGfagafz14wCy90LqUWzUycEK
         keQJXqONj9+M4tmaZ3SSAUUUY+Tx63CL2yqsGzX6YUmU8Cu3BcP47Cyy59uoRXZAxNKR
         u0rnJZVMUVvHSbAylXRgKWBVCp3QIU9jcNy+QkzUkVUxQE3YYTUGb4/XmzTw+1TPeeM2
         uIQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w6CXgqRhP8sSUJRGXfSNnO5xg4skk+Ggctjyg0yJVDM=;
        fh=gHhEcUOotr/pNMEoL32jb+qikGrZEoMpEABd7AujqAg=;
        b=pyhUy4c0YcuakyT7F2ezU5hGBIBF6Wpo0YlDcMITVoc8dB8L9UtfKJJMRRc+4MRuLx
         rktNa+jgXS2eCkZnC65RNY/0iraXByM3uzdcL80QSOvXlzXIOkUETBgvEr9Xhn/ihpq4
         VKPsEL/1+c7HWVsi71JUc9EVLDijAt/HgXJkGggcorXXeI+OkmtrClR55MADHp/oh36/
         qseOfYrbe/vQcDNL4fnp4roUUOOquMkQ84YjEeEaZse9EIbmxgXzgtbkj/tU8MStJSci
         vtLmBLhjBeaeYu467bWbbJ1YgjIa/DMT5mnxqunO5Ar3v0dtMPMqINHWYHT3Ru/9MNU5
         KTYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1785339601; x=1785944401; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w6CXgqRhP8sSUJRGXfSNnO5xg4skk+Ggctjyg0yJVDM=;
        b=ErohCOiLNvh+mNq0scQq5qOw8N60WQ7fzhWqU4qaQTctc23wl6ScxxyHwfs9aSGkG/
         2AQVjyTsPsgkp47QK8YZQJuVGup38OVecPhvOnXfHvMC2onSZW5jrUvKbYqQDxpTKzJn
         II10kHTmAcutKDHngPakjD2Gxm8tL0N/JwEuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785339601; x=1785944401;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w6CXgqRhP8sSUJRGXfSNnO5xg4skk+Ggctjyg0yJVDM=;
        b=FNGx/sM7L80Vowtz7yLNvGbR4rlMJqCQngf3QNAym87vP4fqWtVlRMu1Xi7m0sOLWr
         Bi9j5pErZ9fyEMMSuCJxo1GK4usd5NUQcwO6Dy600KMHwcBMbLMTqz8VDzhbYJDU8A76
         jztm36Irq0NozLPSIVvk7qBduNmPheOuWNn3LMcohDCxedgUSG6h72P2gqCcpHP8/3xX
         21SyNlrM774vZHyiC3h3YQxpKrMR+WHpfmje9XMGrRLaxdnbSHiGgQoItHJQlyLdkQx2
         j5Ye6MrgCDozP0RTuyaXKZqQJ2qXzY37u8QlpfNi3aRa86bel667+U0pHgKwD0lFODw3
         N/aA==
X-Forwarded-Encrypted: i=1; AHgh+Rr3ywE22cCx/f6z7rFlm7ep2S75JTrL8bYcDofK4+qJaklRRne00nvNZttxoVaZ7LH/b05nk00GGFSkgJJb@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+MRrMO/zC620T8b5F8H8aUBs+pyuLEGRqbJ5vMCI7kN/hZ/tJ
	hG1guwL8djhl+W2lLAVniMGsZ7wFAuzexZ0P7xhP2mIE1iRNLZd6wrYmUgZ8DwiYnvuzQptxcUB
	yvmo4XwXSnDpbdPxXvI0IfBgLvxmqMf+KXtlW8OeNaA==
X-Gm-Gg: AR+sD105Uhlvm3i7DL7qyYCuvAJS41Juwayu1JQtqzuQhTA5CHXbrXxVI2z8PG3vPQf
	4jjIWw6Vg1BlBwPo+x11VkplnWRMoFIyX2Enh4MxizIQLKGPFfXdQ4BvBOLWUvRd45v058ISfZe
	AGfNGZtFfkQPX7zRzr/dM8B1eDlcYtxh81lJB1uKXCiutftf1e33P9G4eL2QlRvogf36Ebqb99O
	byFRkW1FwzES04DJHYgliLQy8s5GQhYeYqWwWBZpR8o74ULby6liyr2QZn+WJKSmll6t47EyI5r
	93Via2Mj9WM3CRqr6IGQLQ94sqhk6IicbaJyP9EYQWWwUVKo7zQR5CU8ZWbBpd+st56CAQn4wmT
	J
X-Received: by 2002:a05:6512:33d5:b0:5b0:1359:3dd4 with SMTP id
 2adb3069b0e04-5b2d02252bdmr1659614e87.5.1785339601486; Wed, 29 Jul 2026
 08:40:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACwKKmANzQaVSLni4QkvfoL6Axd3_3mYvCrsWRazXg0QeO6y3w@mail.gmail.com>
 <dtryuddxj63ibzfzmktla4ypj7vnxj5gia66joet3lp6zgzpot@btjuuubvckv3>
In-Reply-To: <dtryuddxj63ibzfzmktla4ypj7vnxj5gia66joet3lp6zgzpot@btjuuubvckv3>
From: =?UTF-8?B?wq3qtozsmIHsnqwgLyDtlZnsg50gLyDsoITquLDCt+ygleuztOqzte2Vmeu2gA==?= <yjkwon0026@snu.ac.kr>
Date: Thu, 30 Jul 2026 00:39:49 +0900
X-Gm-Features: AUfX_myjFnAw_-9Aotfr6dBJ9oqKbTWsOAo5sgxSn9vtdEctE29R1VzTvdJOXs4
Message-ID: <CACwKKmB_wwUoW9g_hgqESwKeEuM2k4MiAUn+6Nu=zpyE1VgmYg@mail.gmail.com>
Subject: Re: [BUG] fsnotify: concurrent mark updates can publish a stale
 aggregate mask and lose events
To: Jan Kara <jack@suse.cz>
Cc: amir73il@gmail.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Honza,

This did not come from a real application. It started as an LLM-assisted
source review, but I only reported it after reproducing the lost
FAN_MODIFY/IN_MODIFY events on an unmodified v6.12.95 kernel.

Thanks for the feedback on the report length. I'll keep future ones
condensed to the substance and the race description.

The fix you describe makes sense to me. Happy to test any patch
against my reproducer.

Thanks,
Youngjae Kwon

2026=EB=85=84 7=EC=9B=94 29=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 9:40, J=
an Kara <jack@suse.cz>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi!
>
> On Tue 28-07-26 14:32:33, =EA=B6=8C=EC=98=81=EC=9E=AC / =ED=95=99=EC=83=
=9D / =EC=A0=84=EA=B8=B0=C2=B7=EC=A0=95=EB=B3=B4=EA=B3=B5=ED=95=99=EB=B6=80=
 wrote:
> > Concurrent updates to marks from different groups on the same inode can
> > leave the object's cached aggregate mask missing an event bit that is
> > still present in a live mark. An operation started after both mark-upda=
te
> > syscalls have returned can then be filtered by fsnotify_object_watched(=
),
> > so the matching fanotify or inotify notification is not delivered.
> >
> > I forced this source interleaving with diagnostic scheduling barriers a=
nd
> > reproduced persistent FAN_MODIFY and IN_MODIFY loss in 3/3 independent
> > boots for each interface. A control update that caused a fresh aggregat=
e
> > scan restored delivery. I also observed the same loss-and-repair outcom=
e
> > without kernel instrumentation on an unmodified v6.12.95 kernel image i=
n
> > 3/3 independent boots, with 9 strict hits in 30,000 attempts. I have no=
t
> > identified a memory-safety issue or a security-boundary crossing; I am
> > reporting this as a notification correctness bug.
>
> Thanks for the report. To clarify is this a result of a code review
> (personal or by LLM) or some real application was hitting the problem?
>
> Also for the next time I'd like to ask you to try to keep your report a b=
it
> more condensed (either by instructing LLM or by selecting the substantial
> content from LLM output). E.g. in this case the above two paragraphs
> explain substance of the problem and reproducibility, the scheme in "The
> race" section shows how the problem happens and the rest is mostly just
> uninteresting noise so this report could have been less than two screens
> worth of text whereas now it is over 7 screens in my terminal.
>
> Now to the problem:
>
> > The race
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Let P and E be marks from different groups on one inode. P initially
> > supplies event bit X to the cached aggregate, while E does not contain =
X.
> >
> >   P update/removal                 E update/add
> >   ----------------                ---------------------------------
> >   remove X from P
> >   start connector recalculation
> >   scan E without X
> >                                   add X to E
> >                                   observe old aggregate containing X
> >                                   decide recalculation is redundant
> >   publish the older scan without X
> >   both syscalls return
> >
> > The add-side decisions are not serialized with connector->lock:
> >
> >   fanotify_mark_add_to_mask():
> >
> >     recalc =3D fsnotify_calc_mask(fsn_mark) &
> >              ~fsnotify_conn_mask(fsn_mark->connector);
> >
> >   inotify_update_existing_watch():
> >
> >     dropped =3D old_mask & ~new_mask;
> >     do_inode =3D new_mask & ~READ_ONCE(inode->i_fsnotify_mask);
> >     if (dropped || do_inode)
> >             fsnotify_recalc_mask(...);
> >
> > __fsnotify_recalc_mask() scans under connector->lock and later publishe=
s
> > the sampled union with WRITE_ONCE(). A different mark can be mutated af=
ter
> > it has been sampled. Its add-side redundancy check can still observe th=
e
> > old aggregate, which the in-flight scan then overwrites.
> >
> > After this ordering, E contains X but the aggregate does not. The state
> > persists until another operation causes a full recalculation.
>
> Yeah, right. So for simplicity I'd just solve this by always calling
> fsnotify_recalc_mask() whenever mark->mask is changed. We *could* keep th=
e
> current behavior by providing new mark->mask to fsnotify_recalc_mask() wh=
en
> adding events and then doing the check under conn->lock or even improve o=
n
> it and completely avoid scanning the whole conn->list and just add the ne=
w
> mask to the current connector mask. But at this point I think it is a
> premature optimization - we don't expect many notification groups to be
> watching the same inode and frequently adding marks to it. So let's keep
> things simple for now.
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
>
>
