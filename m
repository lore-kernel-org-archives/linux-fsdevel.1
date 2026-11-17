Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794954441;
	b=JQC/ZywNMAvOwjbACcMB1QaANivD0yukAnhU2iM5B6UhCYem3lwvEweuYJspKLiL36Ru
	 ofafbqa5wz0puNOOQDlPmfVfjFUBXKUP8qb4usrJiMPjvV3AtPoXRRn0StlE2P77w/xdA
	 dkxxgIwd5q+EZELMLgzZ1Bj+K4SuZfcZl8T76/4QNRFpjrCeOTEoCTT8v4klEa5J1i0sn
	 kfOkt08oCFctHotaO4x1+wXbwdaN+8nE8bPV3+9+Z/StDEbZY3awcsWlu58Nh4VfebuHb
	 H67fM31G3bJ5PogMiS9B/l/15LbfdMuINjz5A3ybELhpPHGNqaAGAU8GMsGSorUB9/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794954441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Qc4tF92xQdHPstDc9OOaR7th/jMxJe62KjbX9qJMUYY=;
	b=Ka492S3+MgZbBNkZsce+1HNcHE5OGKoP8QuN7Cwjt/wjBQdnF4pWdyGxG6PPrY9pvJN9
	 EvilgHR/vOt0HCo5SbSgzrIXyllhUNhHeq++AmUQ2KFT9ulLzbnYQqaFF1I1OIkkZOeiB
	 xCc7UPkTLfyhBavB6Dl/+sducTxV1fCY+NDM48wTDAo+H9oWoaSdK9WPwGLAkaS+RfPCZ
	 Xfg/14GG7CTJkRjGyKkKJEyIcw9pwiWf4cYQIuxJuACoFSGofzqNkUZLf5QXh8DBBoj+H
	 rsg4Kbaw0gnOcIlqiNFHNgnLlFWhRXQvnkCCLQDUjw/RxyIUtNeIeo13zQn88tZ0bgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IB9KSB2I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D35606A32A
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 22:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49D35606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IB9KSB2I
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-380b40319bdso682467eec.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 14:27:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794954439; cv=none;
        d=google.com; s=arc-20260327;
        b=el0muo02kbwft10akyU0QG5g1z8BJWJ1ngRwAZ0H//Nql17EEg7nUYsvqnyryybdTM
         bwvr5IUFnj7SZX9g1ymti2c04J3WvNkebOKmybZnhGL+mHqjLa5KGrncg1qaXLEWZV/X
         R8thuaUIY4ogQOUCQ4JGFUNEHNv2Uw9byFQouvMU/FLeFqTAy12f/G/yvhFRyz6wod/i
         an7USuKA2wJcYpdm84k8L3afGhibKoNo3VJsi55fAQL5frVg5HjR9KJzbMj1Car9RADW
         JZkTbQu3ep/mGht78VTqKFO8AIPcf6f1Z8jPygBDYd0CSwsrvfgKxCFuh8DE9cqfzRhW
         0Ehg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qc4tF92xQdHPstDc9OOaR7th/jMxJe62KjbX9qJMUYY=;
        fh=JVfkhdipYWBgBuG4WdXPxNxMaEi5Yk8zq6AiJAAcxaQ=;
        b=D2JCZ7aLYr/IbKL4DpeRavHYe0dyB9Tis88l1yRm2DGB8kG7ZhNvXC8KK8EWsdTTZ/
         7RhJ7OvBpzprrrYe7U5mqx6xkRk+T2W6KbW6OeJcLn92tMiZIxQ6hUkvnFvTWJ3D4vD0
         /KsZBjaiiqn4NXXPJeoHaLhFsr6/Yilrr+OiuEI4+WtAU8lNVDmIQ79BpcI2bRzqoE+l
         sHcihZplaLiUWoH7gpU64oFaqIlZ4yZTbVyAcxIIXDLpfnIk3XxSoy15dJdhbrWgVByY
         O3PdC2TQ6HgFQ1P+XayDqtIz1KlxRDhSwNnYGrUeHYgR+XJSu8/yKs+hmUOhGxoQpwd/
         IiFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794954439; x=1795559239; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qc4tF92xQdHPstDc9OOaR7th/jMxJe62KjbX9qJMUYY=;
        b=IB9KSB2IO7iBgCq+jpeGWdjPjnYtClNviws6DaTkktO+PylGhjg0GKWFZiRmTiYy8k
         MyTQahP6c3RdjvveNi5QxsAzzUV37zetQh/aHiKX6hMOXlz71Jnr/1tBkfzavydq9+Fj
         dSWU/IZSX6OejLPtgrnhjpR4RKxo8Qzbucd0RZrms6HayGn7wzdzbz5jUeJzI1v/Kiq0
         w3PkJrIbbIHptZ8tqCmNDuLqktqioEjbVBlGMSr9gbPdb+KMJiRCC5XmRHtJTg/Zl8Pm
         Fq8rBhEkuK1mAGxWxuZT7Hd+7i8WF8esFnW6jsWBDjMz6AlDQDuW8aneGxrCDiBy1evn
         XOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794954439; x=1795559239;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qc4tF92xQdHPstDc9OOaR7th/jMxJe62KjbX9qJMUYY=;
        b=uMYvN1HGfU0OfcZReZOKNWU8cJ5htQIp5NSDDMp1YsPjV2xun+iNiE6PoRlEm2vjgr
         qSyMpJ1DyxuOe2Azd2VKl7SwPCf/nvb9XUPQOoppNE8PhLxci2oPpTmjOiCj6UYDomeP
         YbO+AHRhwyu/YsnFRlHJI70XuQNrd1uo6ttgUht2ezcVavR0/UHHZBJUSGZnHdcDEctx
         u+WM8E19/ziX5vPaEdM8F+QvIpW1qMWeoJP/kJDoglkZLn84UMW9Q5oF2Oajw7cn/2G3
         eKrFml3qzH8IDv+xfcO3sk1buynBGtqknlaHlhHErvea4oz9DUjXcEFun8Fs4tyH8G2B
         rbcw==
X-Forwarded-Encrypted: i=1; AL+hErFd87NzIn6oMt3b1NuAQeBtHI731+PMdTj5/H3oBZvgUGbG6SwCV5V2EhW4Kb314rYEGrO9uUvZvXr4NSAI@vger.kernel.org
X-Gm-Message-State: APuU4Z8l/rCHWJMcaIsnTTcY69LafJmHCh7cQglQYlAGINZvNVWS6zxH
	LPcOda4CnFFidkpJfm4I+YXsIZG4mmv6JiB/LA6tIZ/q+/Up6TTF+tUIQVPW5sDQFFhA4/PYSlX
	XVIcnzu7qCO3TAU1yq+/hDTKSPW758ac=
X-Gm-Gg: AZFdTZc32P9HaV+AkN+AhuoDI84q0k+zbViIu+hzw+Oi3YluI/y39TBzBFbUsbxEEQ6
	h+n3SjFbaaeVdZD7IXIp8bRHqe0vJweffFh60Dy6CodHSFwXzbUjKV/DaP3oMwMYXepMu8IJi5k
	4oF0sDWd0i2hwJzbRpZopaypnegTUgjdKfsTMRVpepfHOKfBcqNlswfzdWBQzK4lOxq+Dg51SDJ
	SkTPaHp7RmAJDI1SiitcEThFpkePFL1OZqBVGEpzLkugKClFx7ZmdfGfJ/Z6v9IhDXkXlAeALfF
	Y+VFhXp5eERWGcy2SvuEaY/VBuZ9Dv/9q/aJURd2bZFaQ+wMBnZUeZhEHjuF14Nkwy9pg6C4cN5
	1x4LUXcfmuV/OP/hbsu3/2Vi2Q4CU7+l2WCgs4co/mvKotcxMFAi4RooEvWg5kWcf2azrXCgamB
	9jRpSbizq2ColKvsskOOtdHCfyJ9KYPum2dPrArzo=
X-Received: by 2002:a05:7300:7314:b0:375:c5e1:931d with SMTP id
 5a478bee46e88-38280c2e5fbmr1001348eec.25.1794954439224; Tue, 17 Nov 2026
 14:27:19 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAJ6F8CFSfgdZqaKMndGZtbaww32Xr_KVL3gA_2Jemgv9i9vskg@mail.gmail.com>
 <CAJ6F8CFgkgksyk6YM3NdMkQNhSFWV4depC4c-mHvpDHpnjhM-Q@mail.gmail.com>
 <6ab4a114-57b2-40c7-99d4-55a4ac4c9a9c@leemhuis.info> <CAJ6F8CHzm4=ryY+j3ao6doR=-67Lq=3-w-kbhk1wdvtYDhyNeA@mail.gmail.com>
 <CAGEkeHdxaC2BBg5wWOCL0pj0r4Ks6mD_a3KpE7h+en9Aupb4zA@mail.gmail.com>
In-Reply-To: <CAGEkeHdxaC2BBg5wWOCL0pj0r4Ks6mD_a3KpE7h+en9Aupb4zA@mail.gmail.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Smagghe?= <cle.smagghe@gmail.com>
Date: Tue, 17 Nov 2026 23:27:07 +0100
X-Gm-Features: Aa3M54pO67MCZLcmJlYCwS3g7jZlLsxu4gjlyt9JHnihscax6mlfWNEjuiM6Vfo
Message-ID: <CAJ6F8CF5FF6-+Z6tOA7Gz=m_Cvxz-n7G=bqVY5H+fBCV3kbo_Q@mail.gmail.com>
Subject: Re: [REGRESSION] ntfs3: existing files/dirs with ':' in their name
 became inaccessible in 7.3 (ads on by default)
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, almaz.alexandrovich@paragon-software.com, 
	ntfs3@lists.linux.dev, regressions@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, Nov 17, 2026 at 8:29 PM, Hungyu Lin <dennylin0707@gmail.com> wr=
ote :
>
> On Sat, Nov 14, 2026 at 7:43 AM Cl=C3=A9ment Smagghe <cle.smagghe@gmail.c=
om> wrote:
>
> I sent a fix that makes 'ads' opt-in again:
> https://lore.kernel.org/all/20261115103845.56074-1-dennylin0707@gmail.com=
/
>
> Could you reply with your Tested-by if it works for you?

Hi Hungyu,

Thanks a lot for the quick fix. Your patch doesn't apply as-is to
v7.3.4 (the context line 'opts->ugm =3D 1;' only exists in 7.4), so I
applied the same one-line removal on top of v7.3.4, rebuilt the ntfs3
module with the Arch config and tested on the affected volume:

- mounted without any 'ads' option: 'ads' no longer shows up in the
  mount options, both existing directories with ':' in their name can
  be stat'ed again, and a new directory with ':' in its name can be
  created, stat'ed, renamed and removed;
- mounted with an explicit 'ads' option: ADS mode is enabled and
  shown in the mount options as before.

Tested-by: Cl=C3=A9ment Smagghe <cle.smagghe@gmail.com>

A minor, non-blocking suggestion: Documentation/filesystems/ntfs3.rst
says every option can be negated with a "no" prefix, but 'noads' is
rejected (only 'ads' / 'ads=3D<bool>' are registered). Accepting
'noads', or at least documenting 'ads=3D0', would avoid confusion. Not
a blocker for this fix, though.

Thanks again,
Cl=C3=A9ment
