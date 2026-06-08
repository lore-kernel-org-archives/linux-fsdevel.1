Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BF436F8EF
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 05:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780897148; cv=pass; b=eurq6APqb0srv8baPGgFWhX/s926Tvu3pnqtJ7s2NvDp/s+zEfoqWzPs17PAWBVRR01UUkO4mkxyLk9wpYbxGVYd8PYakSIMcqJRLAtDouOGK2E3zn4jmlkOrrwdE5kbRVn9grFRnzbDeWcmWdkC2gXDLvNlwQaW8CxeRf8kils=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780897148; c=relaxed/simple;
	bh=66wk01tyIR3nRIFMsX/yJnA1R7qbnVarmixlA77ZsCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ruOffnMnMicQutnaCr25/4oiGSyPqB7/NOi55RQfZDa0gt48fUWKQXD99MzgypWe6FhKDazh7v3+l4NMseTjyAb6M40Vd5P4IMqiUI1N0yoYHxHbmusDqxru+6eEqWx7t3/2IVaO4pCMQONxbQkKt5zwiV6y8P1YLXx8M8YiX4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfywXbwM; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfywXbwM"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66077ebd1d3so300380d50.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Jun 2026 22:39:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780897146; cv=none;
        d=google.com; s=arc-20240605;
        b=DRIQUZhYjpd8MukeFYcGwOS77E81OYXIVEdS8t1kY2fmsQLFMqZgtbTYa2dCazqxAj
         BudyqBUOVo7GahsVGk0A5OI5jQaIUkRYPDu24spMBjErr4nVotgHmWCQbyrH4F84oO8T
         LgWVyQYLmR3iQR8jblMNQRKq3u2HcRLu4Vs+cFyz3NF6gR7HZZf7VT49rz2V/h2yHnlh
         CFCX5/bnMgwbsJt0gIthtzxHumIIyOEzubCVpnWtoVk4XywP8ga0dGFK6HOZaUyeOEcN
         hufnT7nMF1+yAiJiSAatmW/57Ljff/dMg8Thfb8sGj0Mxorfx3b7YD8WZ7bI6JycsTvl
         Pyng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h2r81C4x2ykoEmuhwhHmheI7se9d6k/iLvhsccrvPxo=;
        fh=xM9mJmSXi1MPChWhlecOmCWRbS4HNaFS6swy/Ty+2VY=;
        b=VRG3UkkQfYPRlkKhzcthfT6BgxN70MEgM2bIa8dJz8atcwR0NarzUxS+d68P5I37gs
         5V+uH+PG/pXkoudFn83MnheD2DgW97Gn/jiRUKGGS3jyIbSFthf5hA0PbDpD61M+mmsV
         MZnt+CzkkLbwvWeAO2iiJQMCqFWZDTIx3Mp9NKesh40662CRH4jN8Ec08ARALVz5t047
         +ESYDpi0C2971dB8RZIy9Jv/haXYEUCO2rOL7z6tuf8jhlVzD66Pp73iW6+jOdAnWMdx
         wPFfZG4KwVO5n6rcncVGHEgxdCjBq3sSAD1I3xSO/kR8eySL+/hjUAYPioCwOyl/0kRR
         9+Bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780897146; x=1781501946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2r81C4x2ykoEmuhwhHmheI7se9d6k/iLvhsccrvPxo=;
        b=OfywXbwM/3q+IKwV0PSEmGOr3b733ZY6lgsqhhJcLBb5itEcl0ewLujq/DLm1ugXms
         90aUsNCMMeTU1n/e0yEtQI7CMHxfhgr1oBZWZ6njyDgsp39ZCy3P4fQgavoYsKmiVIcd
         xWKkANPWsQ3fO46qxyJ0IA68q7+M57oqSeyYicWRoU5DVk1rRyxvXX/L3hdP4FQaku5J
         884lJBj4NnR2IEcMSeug3WHNlF13/5mADPhVK5vY9QiJ6Fa8nJEs4y/h1Unhp8qrRC9Z
         r/WwkpE9gW9I7jVsow21GfG0D5/i9kJ84u/0fNPryZd9rf8ils6p/roiMQPERe7RNnnh
         MMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780897146; x=1781501946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h2r81C4x2ykoEmuhwhHmheI7se9d6k/iLvhsccrvPxo=;
        b=oLc847RM9FMit7m3HZsFqbtQ90Bfo1ZifABq1kWTeceEupj4+qqW2sH6dyTfmyAGi0
         GvwhVA/xkRaMMc5mRcfVcv6UWPKwyNSCNi1kR2NyOJyd/KJNbhDOUq2Q7cHa4G3gFI8t
         gp9Z96NT96P6XNHCTwwY9QzJpETqm3amTqbpJyCD6l2VHjNRJFUPJIRtSYgfyVjrtRk8
         alr7uqaMROjZkXTZDm62G6EHHTnXOCH847fcqiLjK1BMKcNeR6HRcvvxHzJldbGmsreb
         mBVQ+KQX5m2W5d5UFJxpNMCcatMxV2XbyjTy6a7ZinPSQcUNbieNNjL1CjVOshXjU1fU
         PfqQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Sw/Vv/B/ekU5Ljo2rqvZMrhyIU7KX44/BWVF5o7U8J6tJRG3yWJk6CgKaY+WuyoAnEMhhG79sHWzA+pcF@vger.kernel.org
X-Gm-Message-State: AOJu0YzcCK16FeJP51nd/oSnnXUH7AJjUqJvjFRR36oFhkaZ7QK7RLoi
	1iQ2KXB24avtAfEHdX0p7iCumQ2xRco8UhKOZ3WuNNbZovpy+za4HxbLlTANVC3hpB67G+chfb4
	N2TzXrypa39U/UxLoYaUT3BVd1A7grkE=
X-Gm-Gg: Acq92OHXa1Glx+ayQ8wK5qVB/o/4pi+f6slJZCxC+dCW1fZwYY89S11ZU/Du4capAQl
	cYk/Fn1c0nMjUVfXRedKMWS8Tlo0OtAeY5P9PQ0U6dfaMpIA/ijJjS1d65mI2ZWC36GD9MXjZmB
	xCJp+M9ITWdXqwjGF0C7IjzBxvuJAaut74PkUgWx1ZZSULQPPzGk72yFzc9gYkS5ImcJefxIscX
	mQQTNpD3FkQqcivNFuTgkOY6cAp3DbZSEogVCBDYC/p+BOLdAVu4le0CE+yrhL8Z+YtRdXKx4cO
	Wo5OijQbCBs15Dk=
X-Received: by 2002:a53:b104:0:b0:660:edb1:f715 with SMTP id
 956f58d0204a3-66106dd1b99mr5270117d50.1.1780897145974; Sun, 07 Jun 2026
 22:39:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607051723.1499833-1-charsyam@gmail.com> <20260607051723.1499833-5-charsyam@gmail.com>
 <CANFS6batLwvN5KY2pLFrvmM-ZLa5+yQKUXP+kTPzJo5CqTebZw@mail.gmail.com>
In-Reply-To: <CANFS6batLwvN5KY2pLFrvmM-ZLa5+yQKUXP+kTPzJo5CqTebZw@mail.gmail.com>
From: CharSyam <charsyam@gmail.com>
Date: Mon, 8 Jun 2026 14:38:54 +0900
X-Gm-Features: AVVi8Cfm5b7W4KhJUd7p2jCFMX4iQJMEyXK3HlJt0MfHleJDJKpiz_Nbszb9OCY
Message-ID: <CAMrLSE7BSRsOOgtZDrB1GjvkaiV7codDYOwwXvEb-tb2DoB5-Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] ntfs: validate index root allocated_size on lookup
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Hyunchul.

The current patch series was prepared on top of ntfs-next,
assuming that V4 0001=E2=80=930004 had already been merged.
I'll resend the entire series as V6, including those patches,
to make the dependency explicit.

Thanks.
DaeMyung

2026=EB=85=84 6=EC=9B=94 8=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 2:08, Hy=
unchul Lee <hyc.lee@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi Daemyung,
>
> 2026=EB=85=84 6=EC=9B=94 7=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 2:17, =
DaeMyung Kang <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > The resident $INDEX_ROOT validator already checks the index root header
> > fields, but it still does not bound index_length through allocated_size=
 or
> > ensure allocated_size stays within the resident index area.
> >
> > Callers consume index.allocated_size as the resident root capacity.
> > ntfs_ie_add() uses it to decide whether an insertion can be done in pla=
ce,
> > and ntfs_ie_insert() then updates the root without re-checking the resi=
dent
> > value boundary.
> >
> > Read allocated_size in the resident $INDEX_ROOT validator, require it t=
o be
> > 8-byte aligned, require index_length <=3D allocated_size, and require
> > allocated_size <=3D the resident index area. Valid slack remains allowe=
d.
> >
> > Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
> > ---
> >  fs/ntfs/attrib.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> > index cf49eade6b22..49c8f1f3b9dd 100644
> > --- a/fs/ntfs/attrib.c
> > +++ b/fs/ntfs/attrib.c
> > @@ -657,15 +657,19 @@ static bool ntfs_index_root_attr_value_is_valid(c=
onst u8 *value, const u32 value
>
> Applying this patch failed.
> It seems that the patch below has not been merged yet.
> https://lore.kernel.org/all/20260530143514.3083601-7-charsyam@gmail.com/
>
> >         u32 index_size;
> >         u32 entries_offset;
> >         u32 index_length;
> > +       u32 allocated_size;
> >
> >         ir =3D (const struct index_root *)value;
> >         index_size =3D value_length - offsetof(struct index_root, index=
);
> >         entries_offset =3D le32_to_cpu(ir->index.entries_offset);
> >         index_length =3D le32_to_cpu(ir->index.index_length);
> > +       allocated_size =3D le32_to_cpu(ir->index.allocated_size);
> >
> > -       if ((entries_offset | index_length) & 7 ||
> > +       if ((entries_offset | index_length | allocated_size) & 7 ||
> >             entries_offset < sizeof(struct index_header) ||
> >             entries_offset > index_length ||
> > +           index_length > allocated_size ||
> > +           allocated_size > index_size ||
> >             index_length - entries_offset < sizeof(struct index_entry_h=
eader))
> >                 return false;
> >
> > --
> > 2.43.0
>
>
>
> --
> Thanks,
> Hyunchul
