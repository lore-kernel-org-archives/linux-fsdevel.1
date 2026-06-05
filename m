Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA54A233949
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780673419; cv=none; b=FT0zdvEM7RrqqOPYhDiRCl9yFZwyqXC8o6Kpx1ev7SkeLAEnyz+3ZNYGlozR4+0NUPxRkz6qgfwChLIVFkZODKAecgQ+3eZLwOCeRcQVwqnHhgVTT7DPVBIowK3TZHJqCQC8nCHJqmwhzq4xrltWwnqzqmv55UYmbGLdmLb6Gbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780673419; c=relaxed/simple;
	bh=3q34xYg13PHfj6O6W2amU8KBYHRgeHmjE2xEVZTV/8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KTc/2hbc8g44ftMXuFEB67FDvuQ6oIiSL54Z/7l/7BXcrFpIv92VXpy+1NAagcEAOQNiswurAFBwq2B9F7jyI5iZEqlqRZGFL8vfHvIBZjzsdk28bd+ElT+Doht8W8HaUu7SWyOi/HoV6IzBYJN0Bvqs4c0FngQWIJhs0zlsvlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJtSkUhL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJtSkUhL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724131F0089A
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 15:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780673417;
	bh=iTHdUnooTIxn9y2+nDMWOMTJtZCQjAU4lrejloT3oH4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YJtSkUhL7Ws0V5ImY4CecuKwS+Qn9gA6IY3ozbVn69kEBJ0yISXcodHlKb6qxbSsz
	 3Vi4T9fY/1hWHA1mNaZzc0uJedbIZxdXcQNVV1zxDOHO/3jVG8WIGKXZxnpXq/R1b4
	 xdZNz7DEDVIV3q83MYdqrSfjjCZF0BDDALscpj5nQy30Mk45iLJPlozR9A1tN6+6yp
	 WXrwhZAaJdX9GdIqrDApuM+2CP/XZSYxKlmfw49ta1vdWamoeTLuG8O9ix5Q8vQpxI
	 VA577Ij4FQs4vqNCORFKL/0VEH2N+2m4UkjqGOAbCghhEXxHxMYDWw+qM4tYoxWNFN
	 aYBQq/BId8lSw==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bec405a6ea5so301152966b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 08:30:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9O+CiXtkJNYX5QuFo9Mn8qtszA6mJaaS+t5vlesNE57G3XjxydGtGhgtAhFUzvEfrct4GBBVZyORiW9KqI@vger.kernel.org
X-Gm-Message-State: AOJu0YxKyUgcZHBGfA+TWzxlCoSjEyHPyz82Hn3T/hslsP+pRaHlMc6G
	TkF0jaaS/wYDvZy2+4JqTLDNh086Z4OnWTjiiOyTf4TceaESYpire9ku1WvhWymE8T+1k1VCNZi
	DTawZU90H+xqFwwSdB71SAIE9tehjrus=
X-Received: by 2002:a17:907:8693:b0:bea:3e9b:83b5 with SMTP id
 a640c23a62f3a-bf370e63a84mr208405666b.22.1780673416076; Fri, 05 Jun 2026
 08:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530143514.3083601-1-charsyam@gmail.com>
In-Reply-To: <20260530143514.3083601-1-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 6 Jun 2026 00:30:04 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-MxgdSfr+rmu96JYicyv6JS9m-ZosiS-RwU+C-79XXyA@mail.gmail.com>
X-Gm-Features: AVVi8CfqBmaWR2okGRJL5AOCtrH_3d9jNN7YG0stO_bZJoUsBnEolRTh1FA7AOg
Message-ID: <CAKYAXd-MxgdSfr+rmu96JYicyv6JS9m-ZosiS-RwU+C-79XXyA@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] ntfs: validate attribute values on lookup
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 11:35=E2=80=AFPM DaeMyung Kang <charsyam@gmail.com>=
 wrote:
>
> This v4 supersedes the previous single-patch v3. Per review, it expands
> the lookup-time attribute value validation into a series so $VOLUME_NAME
> and $INDEX_ROOT can be validated safely.
>
> The first patch keeps the original $FILE_NAME corruption fix and moves
> the duplicated non-resident mapping-pairs metadata checks into the common
> attribute value validator. It also keeps resident value matching in the
> external attribute lookup path on the actual value length and fixes the
> matching attrlist duplicate check for resident attributes. The next
> patches prepare the volume label write and mount read paths to cope with
> a rejected $VOLUME_NAME, add $VOLUME_NAME validation, fix the
> ntfs_ir_truncate() shrink ordering issue, and then enable $INDEX_ROOT
> validation.
>
> Changes since v3:
> - Expand the single patch into a 6-patch series as requested.
> - Keep corruption messages using numeric attribute types and drop the
>   attribute type name helper.
> - Move non-resident mapping-pairs metadata validation into the shared
>   ntfs_attr_value_is_valid() helper.
> - Preserve resident @val matching in ntfs_external_attr_find() using the
>   actual resident value length, and avoid reading the non-resident
>   lowest_vcn union member when checking resident attrlist duplicates.
> - Make ntfs_write_volume_label() add a replacement only after successful
>   removal or after -ENOENT, and propagate other lookup/removal errors.
> - Reinitialize the mount-time search context before the
>   $VOLUME_INFORMATION lookup, since a rejected $VOLUME_NAME leaves the
>   context in an undefined state.
> - Add $VOLUME_NAME-specific validation, and reject non-resident
>   $VOLUME_NAME records like non-resident $FILE_NAME.
> - Include the ntfs_ir_truncate() shrink ordering fix.
> - Add $INDEX_ROOT-specific validation on top of the shrink fix.
>
> DaeMyung Kang (6):
>   ntfs: validate attribute values on lookup
>   ntfs: do not replace volume name after lookup errors
>   ntfs: reinit search context before volume information lookup
>   ntfs: validate resident volume name values on lookup
>   ntfs: update index root allocated size before shrink
>   ntfs: validate resident index root values on lookup
I have applied patches 0001 ~ 0004 first, as we are continuously
receiving similar patches. I skipped patch 0005 for now since it seems
like a workaround, and as you know, 0006 patch couldn't be applied due
to xfstests failures.
Thanks!
