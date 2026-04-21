Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0901459FA
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 02:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776738206; cv=none; b=C9MUCBigjL6+GGUlkZ07FgqThoPksOHqDktmNmIrb6VwBQS+9meqrpAKN8KLiHOZLCcSlDaT/jKQkUjXry6p4NFJNuVMoWrcCm1R+x9k8SmiutbI9kKTzCx9I+lR4ukDiooM/eKd4KWzqamBxyINJH1mh7adxJWFh5818OxhCm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776738206; c=relaxed/simple;
	bh=uoen5uZfm0FLPZXGe7hnQh3SX3X9FNKPB8zTYJUEWWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OjRS7tg4qp6g4vw36D5mNPAuaMt5DrCy7Qp5krywIVnJjS13aTtd/xwo0R1xgRiUFzftfLMTVOwukRywdy6heDxMyn0u9mCp9BJxj7VNfvGgvOodPRylnnhLPL+6JnfrxD9ZXOvkxWEAdg/YVOF61LThAKsaUWnxni3/J4vO4GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UewE2Vl3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UewE2Vl3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D94C4AF09
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 02:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776738206;
	bh=uoen5uZfm0FLPZXGe7hnQh3SX3X9FNKPB8zTYJUEWWM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UewE2Vl37v7mehoxQNg0Tl3HRzIOHftgKsZFv/LzAYXowFZ7i5YN0rDQDshMCvcBd
	 zU9wvU81ChMfeWp/OQU6/PJTshPG+rfv4AN5czle6ZfoeC/wEwum66BHAbsT1toI7g
	 niY5akRkZnugHwOs2Aydo6zC+ZYwARFColkJm2pUUhzBXCQZb5LswdAPrAbzjBRcBA
	 JtwcQ0smJErt4AZAMPClCvhK8tFOwAT1NH3SicngO0iuiE3cROkPzFMCHx0PYzkYDQ
	 YBQuFLOxKchmmki+eEVBntWB6mfrHUDUWXC9SHm9/pgp1oMgEQuttiDYj5c0O76z0n
	 1WyP52dIqBEaA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ba9ad0fbc3aso16425266b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 19:23:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9cMePrz6Pt6kOwfVrztCAJlEeVbIpB7EHQEfS003GuAwwE8KNqS/QI5JU584fL9Y7hk9oaPoqPtTmKabq1@vger.kernel.org
X-Gm-Message-State: AOJu0Yzej2DViPnmstTpT0fRupxo3MKTsg4+CV9FAXaJ3Dr2Bdattnnm
	sRCv0a3uko85ttLf0pOv/RW1u3GIW19ugTWmf6cjd4/HoiMgSARkMNYlDNa7rUkhfmfTbRlEN/a
	RF+HuJZ+W9Qd+eASYT/p1QKBW+AUPZB8=
X-Received: by 2002:a17:907:d40e:b0:ba2:e022:c146 with SMTP id
 a640c23a62f3a-ba41b3e451amr812505166b.43.1776738204631; Mon, 20 Apr 2026
 19:23:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414055643.1833401-1-dxdt@dev.snart.me> <20260414055643.1833401-3-dxdt@dev.snart.me>
 <a6fe6a13-f46f-453c-a56a-925dffaec825@dev.snart.me>
In-Reply-To: <a6fe6a13-f46f-453c-a56a-925dffaec825@dev.snart.me>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 21 Apr 2026 11:23:10 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8HdPJBkpWi4SNLCwW0-5G+xMiLXvQmNhNjF28M4r8BTQ@mail.gmail.com>
X-Gm-Features: AQROBzCiOi_JpnV38_VDhqgxDoHat_oKev-ixETGzr3edbiWaoz0fZgkzDJs_NM
Message-ID: <CAKYAXd8HdPJBkpWi4SNLCwW0-5G+xMiLXvQmNhNjF28M4r8BTQ@mail.gmail.com>
Subject: Re: [PATCH v0 2/4] exfat: use upcase_ptable and upcase_range_info to
 reduce memory footprint
To: David Timber <dxdt@dev.snart.me>
Cc: Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 6:54=E2=80=AFAM David Timber <dxdt@dev.snart.me> wr=
ote:
>
> Just self-reviewed the patches I submitted with a cool head and found
> some obvious mistakes I made along with some comments I'd like to add.
>
> On 4/14/26 14:56, David Timber wrote:
> > @@ -301,48 +321,32 @@ static int exfat_load_upcase_table(struct super_b=
lock *sb,
> >               brelse(bh);
> >       }
> >
> > -     if (index >=3D 0xFFFF && utbl_checksum =3D=3D chksum)
> > +     if (index >=3D 0xFFFF && utbl_checksum =3D=3D chksum) {
> > +             /*
> > +              * is_default being set does not necessarily mean the con=
tents are exact same as the
> > +              * upcase table loaded from the volume may be missing som=
e entries. The checksum
> > +              * matching should be enough to cover that case.
> > +              */
> > +             if (is_default && utbl_checksum =3D=3D EXFAT_DEF_UTBL_CHK=
SUM) {
> > +                     exfat_free_upcase_ptable(upcase_table);
> > +                     kvfree(upcase_table);
> > +             } else {
> > +                     sbi->vol_utbl =3D sbi->vol_utbl_own =3D upcase_ta=
ble;
> > +                     exfat_info(sb, "using non-default upcase table (c=
hksum: 0x%08x, entries: %u, memsize: %zu+)",
> > +                                chksum, entries, upcase_table->cnt * E=
XFAT_UPTBL_PAGESIZE);
> > +             }
> > +
> >               return 0;
> > +     }
> >
> >       exfat_err(sb, "failed to load upcase table (idx : 0x%08x, chksum =
: 0x%08x, utbl_chksum : 0x%08x)",
> >                 index, chksum, utbl_checksum);
> I think exfat_fs_error() should be used here so that the volume
> continues to operate in rw mode to prevent further the damage. That's
> what other implementations(FUSE and MS Windows) do. I just didn't dare
> to change the behaviour without consulting the maintainers first.
I agree with your thoughts. Please send the v2 patchset including your
self-review points.
Thanks.
