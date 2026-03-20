Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B2B2BE04B
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774016880; cv=pass; b=HhoxnUU6CYqshx6BYu65L0btjdnXpzeY8ukh/BdZWnbM4wH7/p3cfmu5xEkKgH9J5/9MkyUR7wEOrLtE5adJYaSuAS1mJrMxPWLu9+UsT822QPm7mokbEm511Caz7b5SU6dgECKPhgekIdQ+LX5ohcUno93HytJmen4bu4NgmXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774016880; c=relaxed/simple;
	bh=sq5y9rCrfmdXx5v+6rAZwS+YQg6Cnpqc4tC/4D/bCVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JXjbfKbtRWOD4NNoIsqr2JB2QQy54wx+oLgkMIo57cwpbNmQ9kGIoZwQyWNtdXh6YHHclTvItTg+U72TSejsUmqccD5tBIYzOmNEQTg8SNSaSoZoeHjSEOM1loVYw9TCWhtfu/j0jZjI4UK1z7FhBb+g/pHooq4uynpFvk44f6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=RX09rC2v; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="RX09rC2v"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-668d9dba217so1170709a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 07:27:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774016876; cv=none;
        d=google.com; s=arc-20240605;
        b=K9MQaQOx032ged7XwuYr33K1PRvTqmQGrEs4gyV7OX+36PomCRLqlxqARKaIfktaaG
         9dK+5ZzLZv2/U8vKJzV1wg/jXmsrT2ywMj0CYWqpCqJwZDQ6i8BQzNWrfpl0sESCAZP2
         qQz/20tTjEEFxkQA2Qauyp10PdYSbhVo1LLsMwLJTRt5HPGjssHyFdot3vRcfIDA/3rW
         r4uBYqn9O1VmHfVJDtFg7jzG0lqaJAcXHCB7mwSFl0C6g5g9G5UosD8dTAEZzsSj8cwE
         FNU0X417W9EXKZYo4Vd3q9K5P/y+dGWTuAe9DEM/tONRXn0sHF2BFCYV/px/U0rd1ASQ
         y+ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D5anaHbzdYbs1EudtIkOl9bSB2SSJTEzjzjFR/hSjgE=;
        fh=jq4wk985Sfdro8/66hpb8m0uW7aeHWCVgPFUBkO2JDc=;
        b=AlEnly5W8Qq0TQ6obt8JUaRvGx5mnL3778+N3zKmAbVJIB1hX7tVt1rbre1titcVjP
         enTzcZ4VyojwpZ8ngpNAQ2ChXWeQpiED1e9mc7Ao17mnpce/p7ercJJOi8M8PYNrVQWt
         XuRrziWSlJcDTi9w1LlrwuAN9g3n0Vr4Map15urELI1bCVmluvqmvT5KGh6Vr9KBxsdo
         WzZBo7wc3kDwov31ni0U2MmP/zIshklUUatHci9BoXcmCygBRkmIXIZ/tzHW1+wxe9qu
         Zt4gMUXCVYoRXapNxL7vnBJn9BTCbM03gZv2yX4BjbJNaTHAUXzueYNK/0DZhosfv3OX
         5htg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1774016876; x=1774621676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5anaHbzdYbs1EudtIkOl9bSB2SSJTEzjzjFR/hSjgE=;
        b=RX09rC2vo0zPsSR0we8oTdh6vs3iNpWbWBnUV405jSorThFbf2T+iXAYlmxZb7w6zj
         KDd2ZyUevllyk20aTjWkS7T4WyT62myvPTu1VRLKAjkBhG2+9d9HLMIbcL5O15bZbyap
         JwZXLsHPHDjjhfjJH8SW4YchbN+n4vjwKqVFzcJwOsbK44TNrEW7YoxVbSIFfEgkC8h/
         ER1CbqQLYmKxXm6jToIfS/xM3NVIECmXhfA9SuNr7KtlOPxETiDxX1Tx28JVLuvmuOsr
         Aj2zPimPgtexRyQodVoy8ZJ4FMOVsIHE0POoLjxZwit33wBSpVXlEO7YzwHP/ifGXLq8
         UPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774016876; x=1774621676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D5anaHbzdYbs1EudtIkOl9bSB2SSJTEzjzjFR/hSjgE=;
        b=AUZYZtuiYhHwJsIusreSe60D3MEV+0KTxWLuIfeSC5pNvTEf6f0K7NnpsCbFGCwAf0
         srUvCXAqOXsMaGDQeRsT3RAV8lYFdgvfMxel2AysAafevPZJQNVRQtYLyoP5EARCphUR
         S/GSLrBz+8R+KtmCaLJaQ475It/4h219srxZdl6Af8ohcBRDLf3E8QoM50vePRC3d0Vq
         xjBD2MznrRQ3QPpuMJm5catbo0FY/15mzNPJYkNsBtkzwoFOVt/diSGh4R5NO6RJYzJb
         W7j2tKgjsaChNyHoTr+ygZUL9I80G2mM5BTSZ2+iwF2ieUMDA8QAsVbTc3sE5B0SKwI/
         GupQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG/YdbSyFazXx0F7CRGkwNxfSB9870rpKcezGEK3EgzCB0oyHCLHkR1VUKvZLXGljeQuApNWSH+fPq1drS@vger.kernel.org
X-Gm-Message-State: AOJu0YzwM592GhtQxozciTZglUJFR6Bw/0fipBVPcPzWUWIAj7iMKdUS
	Buq0ZmVd7wuPdBvLybSs/PLZCChC7RoOzTCyiib7Blgwp55NS+ymvEWkzWFtwf97JZRxdyiJMio
	7KNy6ZYOmzSdAnlE50KFvynqmCKI4RAeW4iZfQ8kHU6GVaZvUTCCc
X-Gm-Gg: ATEYQzznPC5WGVGajQjH+TTdl8fFwnoOq1RiU8NFDKUmIAs9gwD6vtjcqspa3rHjipJ
	c1hvFfmLZx1/YnArsf1t5BCKn8zpdhoqTe0L/EB3q0xB8449AKFbQEolDs1FRt2j/uJQ6BbuWDl
	IQngDJKdzHYyzEtIXar78ppJ76Z8X2RB8PknT/kCFH7jYn8mrCPDOTiIP7Ab7CGQCy7FyipinM2
	hspanSsQRNN+QL+98pGyt9swO7UW7DpfyzF1hPq5H35ym4fSBFyToMmP0redrUtwx3eBkC01Vkf
	9vCnEV0eTckijbNO+pykmpOp2709eU/fviHerRlVGIeECfUz
X-Received: by 2002:a05:6402:4542:b0:667:ddf7:7d9d with SMTP id
 4fb4d7f45d1cf-668c971954bmr2121321a12.10.1774016876376; Fri, 20 Mar 2026
 07:27:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317023834.487682-1-pasha.tatashin@soleen.com> <gdu6kqpymqgkzbw2yrvvsrububimn2ocuyi533d6llofqu32kd@sqc6d6hsuzic>
In-Reply-To: <gdu6kqpymqgkzbw2yrvvsrububimn2ocuyi533d6llofqu32kd@sqc6d6hsuzic>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 20 Mar 2026 10:27:19 -0400
X-Gm-Features: AaiRm53KwLS0dZ_0F2E6R9Ka7xHwPaNadXUdllrLPjUjJCiW_fFG9VxgEmZKncE
Message-ID: <CA+CK2bDGvesu85nODXTbHQDy_UndWyGO-bNHcq5gDReX+fyz0A@mail.gmail.com>
Subject: Re: [RFC] liveupdate: prevent double preservation
To: Jan Kara <jack@suse.cz>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, rppt@kernel.org, 
	pratyush@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 9:47=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 16-03-26 22:38:34, Pasha Tatashin wrote:
> > Currently, LUO does not prevent the same file from being preserved twic=
e
> > across different active sessions.
> >
> > Add a new i_state flag I_LUO_PRESERVED and update luo_preserve_file()
> > to check and set this flag when a file is preserved, and clear it in
> > luo_file_unpreserve_files() when it is released. This ensures that the
> > same file (inode) cannot be preserved by multiple sessions. If another
> > session attempts to preserve an already preserved file, it will now
> > fail with -EBUSY.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >
> > Background:
> > Because LUO preserves files of absolutely different types: memfd, and
> > upcoming  vfiofd [1], iommufd [2], guestmefd (and possible kvmfd/cpufd)=
.
> > There is no common private data or guarantee on how to prevent that the
> > same file is not preserved twice beside using inode or some slower and
> > expensive method like hashtables.
>
> OK, I guess since this is a single bit, we can live with that although it
> seems a bit wrong that LUO needs this in generic struct inode. But all
> other "cleaner" variants I could think of were just an overkill. So feel
> free to add:
>
> Acked-by: Jan Kara <jack@suse.cz>
>
> Just one nit below:
>
> > [1] https://lore.kernel.org/all/20260129212510.967611-1-dmatlack@google=
.com
> > [2] https://lore.kernel.org/all/20260203220948.2176157-1-skhawaja@googl=
e.com
> >
> > @@ -744,7 +746,8 @@ enum inode_state_flags_enum {
> >       I_CREATING              =3D (1U << 15),
> >       I_DONTCACHE             =3D (1U << 16),
> >       I_SYNC_QUEUED           =3D (1U << 17),
> > -     I_PINNING_NETFS_WB      =3D (1U << 18)
> > +     I_PINNING_NETFS_WB      =3D (1U << 18),
> > +     I_LUO_PRESERVED         =3D (1U << 19)
>
> Add comma at the end of line here please so that we don't have to modify
> the last line again.

Will do.

Thank you,
Pasha

>
>                                                                 Honza
>
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
