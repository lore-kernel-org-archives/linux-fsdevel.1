Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6853F19067C
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 02:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780884111; cv=pass; b=j49kl2iC9ekPl0DMqOdxY40NfrdygMKvhfnuo5HOEV59hb3ec3Ovi8G9AZGlFwsYC4abReYUpJW+MzJc54OmISosI22N/wHPhizW/feEGltwhE8r2D8v20jg1fvFZcAyCu6mqtIymJmSEvAVFRSOUyGmdmoiFNNVnFayrlvowxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780884111; c=relaxed/simple;
	bh=2AqziK+qsyowJ2tzEBehA0XQh0T9AiwqQCYEVrUIktg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XqigeS3to/+87Am4RsZxm7w7Ez7DrXpLOUEJb+5fiT0qSkoKB2AHag4+9vuV8QoID5yQ2O4xihqIZlJrwmqeZqeDk4tHo6H/MQoqIWkad4luHf2YVYT2GlTu7zp/7jXaCZTFHLQ6qQI3Hf3l3RsSlnrcODMzLE1UtVda9I05mMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rM2+yu9N; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rM2+yu9N"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aa624ff3cbso3759518e87.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Jun 2026 19:01:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780884109; cv=none;
        d=google.com; s=arc-20240605;
        b=loiyy/vK9jTlnqQPZE/Dnf0pl2Ye2BhlW2YcJZXjwJC4VVuwM3aJkF+Xt5XtE1dZJ8
         yDgyqm55aWtZj9srmAD9Umh8Nb4N1iAdA+auuqR4F7jmih+8683Re36peISMh5gloi4M
         HR2YZPfg/t+kbtuwnvgqYBPQDYzq7zsolVt2qque78mRPy+fNZ5R9F4Ipq21VWGmGGcg
         DfNNSDOw/+AMrE/c78guNQg76Msp8RjBRevgbZ/tDIopzsxMFjnZopfZm1mWKSi/nLGW
         hzg1k1EaPVKh51MZkcp/mjssfoUKQBkH8IeFl1niyBmc0MLdTpNp5umpmjTjRZsSTGAm
         BPWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SuXv0YXVfzFo1MawAMc5QnyJByAh5bon2yTSSj4xZdo=;
        fh=Vfx/xB/wad+eqaz0d2mUM/IH5+zpR4WFB2JLjIENEwA=;
        b=LdAodZicNqfMDw0rWZ/3xs01DZy2gMcqClasg3tCo9Yxt1yNwqs1H9Cr3oWWiH/rxi
         zPvOOtZcChMgnsTfKWkzqsMVIdThghYll4IEvXd8TLV+My1d6da7KyA9D4nlJTwvn/dv
         2pBbzwaYXj/a6PkbhGYDonURJR1opA0dT8bxBWTgRgrhu84DKCOKQjFbXXcv0ZVDW7Sz
         hhWZ/UEXmue72Gpsx/Vzvd12z7X3kuolEo44vFmXsrqc606JrPWdtmCdijUMv3/OTc8r
         L30G/kYwYVMUoj1mNiEsPesiemj0vkDhMY0VhaEkg8NDUi6VT2dXTUaBW8WOFAQfXnoE
         djoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780884109; x=1781488909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuXv0YXVfzFo1MawAMc5QnyJByAh5bon2yTSSj4xZdo=;
        b=rM2+yu9NitVuTlGANyqS6fUFv1nXfcxdy3mxEw99rxhgV6eXofX9VDFIQWgY6zI8D0
         qq9oZ4GRDO9w71lnMvWcLJTO9uEIi/ZsiUbnJx7lTAbIFwrIFXHolieykRXdiddmOjtG
         EGG2gJ4JYqGUJZBV1/5Lo+ch9LzdWAxP3qCIXXkA/46fnd/Vo5dUhzR+XP3IRHhLmZLI
         oFbVfnzcbQLlK2Zu717luyAn7ExOwq2IybQF4xB7DYPgkrYuCpM6y2bubtBFipIul6vI
         HtAJSznC5gkA1MZquKSXalsmTWJpVQVyp7GYWrB4urMNCBLcXXJ9S+hzhv/9Qj9xANOt
         M3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780884109; x=1781488909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SuXv0YXVfzFo1MawAMc5QnyJByAh5bon2yTSSj4xZdo=;
        b=pv/mtLtZWxL64ulWWgBRDIV/k7xzp5Ycf3Zexf+4QIpCPCITIleU+e4KbJc3/W0Dgm
         8Rij+ZjRz/Jp6zIHzXV71DpIr1vxg3JsRe6muxpDnzKIQ2QQ/tKg0zux5m6VoeRCq0Cf
         Tym/otdH/ET9uPDcLX9cCKh4+mQVoarDVXfhgtV+c4hBp3qmwWuwi9jysT6sZhV2zZQB
         BO15OsZSPqoLm8HLKRNSwkO9zuGMcLeMxUZB5fZ4QUTmB/Kpmw33zM1Tc8ZPeh5wMqKp
         MAizVf8SN4IF3dBZXHpH6Ktl+iq5XO9HoOsUNsxJjNowGxrQt5lbp68jZbeqG5hWs4sI
         bhLQ==
X-Forwarded-Encrypted: i=1; AFNElJ8BkOQFVRRoMYEkFu3lSyonZ2US72BPx8coOCW7wWtCKA+xATby9aGLMWKy+ShuOK8D3eUpgrMxuu8C+TxL@vger.kernel.org
X-Gm-Message-State: AOJu0YyOTrb4Zlelnyqketc/6wgow8nXCp2E8Vn2blU+pr4X/YPqIeIF
	2OHyAXIkbHmZ356jt1fhg7x+juHYcW0DdABxJV+YM7ewBQ5nHz5TqjKTqa6/mbytSmkqmsHRSnI
	ytlQm7q3KKhxSVVgPgGjRFYbtGuerpkbaWg==
X-Gm-Gg: Acq92OGP3cLArmgCugJkRrUSMVaHVzmnJ1BzsLFDYeWaeB5cKlmw4GVyu24CDXzalL6
	0OKDWQ/+5IbqiBHvk6VKnqBozc7KBbgVoIn3gNM1GF0wjud+U7Ra/TS5w/v34VvCyrszIV2YURS
	01N6GyMJribuNohEuBQ87lVrii4iztWQzbA2Li2K/dUf+ze+61EFLJAiOIejhMllWmBHF09s8WX
	9DtL0Y6oZX4zYuc5WJHtP2q7YA4lyuWFu1H+2VCgBTYJu0+dSbP/8DrodRdYxtviBhX7tNhYUWt
	s+kDwIJhzWm6+FABTHmXiQXWAhQU
X-Received: by 2002:a05:651c:210a:b0:396:70ac:840d with SMTP id
 38308e7fff4ca-396d0a66d0bmr34723311fa.29.1780884108239; Sun, 07 Jun 2026
 19:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607203000.700100-1-hexlabsecurity@proton.me> <20260607203000.700100-3-hexlabsecurity@proton.me>
In-Reply-To: <20260607203000.700100-3-hexlabsecurity@proton.me>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Mon, 8 Jun 2026 11:01:36 +0900
X-Gm-Features: AVVi8Ceu2qSLUX9X_djoocxfd08_0wBfnxZEw3Dtacr0CvF9SxEj0t_AnpAeMws
Message-ID: <CANFS6bZr3pR9PY0ugGFWsz7a9bjWeLEB0qJS5x7bq6-cFuhk9Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] ntfs: bound the attribute-list entry in ntfs_read_inode_mount()
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 6=EC=9B=94 8=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 10:51, B=
ryam Vargas <hexlabsecurity@proton.me>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
>
> The $MFT attribute-list walk in ntfs_read_inode_mount() validates each
> entry only with "(u8 *)al_entry + 6 > al_end" and
> "(u8 *)al_entry + le16_to_cpu(al_entry->length) > al_end", but then reads
> al_entry->lowest_vcn (an __le64 at offset 8) and al_entry->mft_reference
> (offset 16) -- fields beyond the 6 bytes proven in range. al_entry->lengt=
h
> is attacker-controlled and only required non-zero, so a short entry (e.g.
> length 8) placed at the tail passes both checks while the lowest_vcn /
> mft_reference reads fall past al_end.
>
> al_end is ni->attr_list + attr_list_size (the on-disk size); the buffer i=
s
> kvzalloc(round_up(attr_list_size, SECTOR_SIZE)), so the sector rounding
> usually absorbs the over-read -- but when attr_list_size is a multiple of
> SECTOR_SIZE there is no slack and a crafted $MFT attribute list produces =
an
> out-of-bounds read at mount time.
>
> Validate the entry with ntfs_attr_list_entry_is_valid() (added in patch
> 1/3) before dereferencing it, matching the bound the other attribute-list
> walks now use. The validator already requires the length to cover the fix=
ed
> header, which makes the separate "!al_entry->length" check redundant, so
> drop it too.
>
> Fixes: 1e9ea7e04472 ("Revert "fs: Remove NTFS classic"")
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
> v4: also drop the now-redundant "if (!al_entry->length)" check, per
>     Hyunchul's review -- ntfs_attr_list_entry_is_valid() forces
>     name_offset =3D=3D sizeof(struct attr_list_entry) and requires
>     name_offset + name_length * sizeof(__le16) <=3D length, so length =3D=
=3D 0 is
>     already rejected there (and length is a multiple of 8, so a valid ent=
ry
>     is at least 32 bytes and next_al_entry still advances -- no
>     zero-length loop). Rebased onto the "ntfs: validate attribute values =
on
>     lookup" series (0001-0004) now applied to ntfs-next; added the Fixes:
>     tag. Compile-tested on ntfs-next.
> v3 (Hyunchul Lee review): validate with the extracted
>     ntfs_attr_list_entry_is_valid() helper rather than an open-coded boun=
d,
>     matching the other attribute-list walks.
> v2: dropped the redundant Reported-by; reproducer omitted on the public
>     list (available to the maintainers on request).
>
> Sibling of the ntfs_external_attr_find() look-ahead OOB (2/3): the same
> struct attr_list_entry fixed fields (lowest_vcn at 8, mft_reference at 16=
)
> are read here with a weaker bound. Geometry is arch-independent (identica=
l
> -m32/-m64).
>
>  fs/ntfs/inode.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> index 8a7798d7f5fc..2f2634baa285 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -1997,10 +1997,7 @@ int ntfs_read_inode_mount(struct inode *vi)
>                         /* Catch the end of the attribute list. */
>                         if ((u8 *)al_entry =3D=3D al_end)
>                                 goto em_put_err_out;
> -                       if (!al_entry->length)
> -                               goto em_put_err_out;
> -                       if ((u8 *)al_entry + 6 > al_end ||
> -                           (u8 *)al_entry + le16_to_cpu(al_entry->length=
) > al_end)
> +                       if (!ntfs_attr_list_entry_is_valid(al_entry, al_e=
nd))
>                                 goto em_put_err_out;
>                         next_al_entry =3D (struct attr_list_entry *)((u8 =
*)al_entry +
>                                         le16_to_cpu(al_entry->length));
> --
> 2.43.0
>


--=20
Thanks,
Hyunchul
