Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0CA2253EE
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Jun 2026 00:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780790427; cv=pass; b=hzrVQy4EbTMs+4ukBtTnCTpad9rcsqL1E317oR7SnWuyNAP6xpFccYPqRWXE+0bpDFGd4qXGLG4mwCiukrT5LvfuJBOS5LS52kpLOmrLMGwt+dqjFJuPnsbaYFCCc4Qu8jFjOQpFw5y3TKqVAuOtMsJjU3685hGSF7wevreBOv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780790427; c=relaxed/simple;
	bh=wo5MJ1kc34LNUuz5NAIVBZ7FOOwm8htL3ltn0HCZwy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f60SwKEPyIhbc78UzhXNfSS098bgcaR8nR7F914cLNqmvVpp2FASqwb9gokHZrcqkOnl8W6SzsgpHq4HRDoux2cv1ZLk4Kbng9T4eiSMyZX3CPy67ejAqURdv8s/qgRKZbKhiWtvG4kZp4xTOZEA9u+t54TjOWD6IRPaPgF1WTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZYC+se9; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZYC+se9"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66042e1ad22so155311d50.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Jun 2026 17:00:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780790425; cv=none;
        d=google.com; s=arc-20240605;
        b=kVYD2lKS6M1HvU85sNcw6iQw1HlU5ILzAQL1yGzyULcOnNUYMMpkXAaX+LUxkv/PlB
         erZFvtent5JL8td8iC0q43ptZiQmFLITadJD/HoWGEOQkFYVFlSj+ZYrIrnkuZdaxDsG
         IErNw/0gxWEUujosS2dQTcp0HT5H/KoV239Y40lFgkymygIzQk2sgBSEa88LqDRRWfSY
         B1tDFFlpNmfK3fF1iP3V6cFAiHHN+27mAk6OtAmN6Gt0oFfpOLCiHvxDiZ6hlfwm9qWJ
         417I71nyGbl3saTbLFnNv+K6bGOBhq+Ku+GOyJEtb6m5ZaRKxxI8biviyGamAsNkQWx9
         QVSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R/hCJs147ToPFiUHfg+hj1HTRG41gZsskdp6jaxbY0s=;
        fh=nMgzSZCuqL9QYQt+YNW2sGmc6uWhuBFQ7YHLMXHNsTM=;
        b=DTn+DQKRq4wEnnncbeW9Z0Td+p1YCvFSurq+px29mp9bvpQ2AmmiGmCyE9Mf3TGDbC
         SbVHAuL4fP6Ikes2jnUT4r5vaBKcunG9WXnEQuW1Eo0BWuM1S2Exm3obl3TneR+mFr2g
         rW3Do3E58BTAkxIlX3/xxMhGcNZPF06sZQ73Bz4GpnlSQnyWC7Mp9KKtzJ4xFY+9eweB
         wR7y9FYrAVhaT6y2ecNWTtE06jWrAhM9+Zo3aNXDMe9zaRvPGLXHYIdjuP2pVArIfNji
         1dfy2CVg6rMPmoB8VQC/hfiflGhB8uq5kt3ASjfDNE9LGMe6isG/vwAMMu/UUscsu5/m
         0TTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780790425; x=1781395225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/hCJs147ToPFiUHfg+hj1HTRG41gZsskdp6jaxbY0s=;
        b=nZYC+se9rn2FtlGEj5LrMhELmWAGr+DZlAthY69HVS2k2slUhHUGdEieobGdSwaIzN
         aN8ycU8uGVdvaEKE41v3Xfw+sL6ZiSp3dw3LjaR/ArWTCjg9hWh01Huf6eonem0KX914
         yAXBpGSDb1ClAPEfZKGAdfuAj/O8DR87eipWfup5f3xdVM4sJRFqx8LjEMsiqEteS5nk
         +/N9/I5s8YKAkPD6L4rCtVMMSoUiYdI/63buhDHbMTq1v+9qT4b+yw1Rt26NFn3EcPHg
         T0qhKMxnZ6xu68LJVbrRMSjb0meLi1GmDrLzCtyf7zvsSh3KQ4DVnEwm01xraJoiGsmK
         y37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780790425; x=1781395225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R/hCJs147ToPFiUHfg+hj1HTRG41gZsskdp6jaxbY0s=;
        b=blfL8a2Gi15xXJipUV6D3T5tJnrZXI4Dx5RJuilS9lYeMHAUgOTyC2+sHtRygvjJCd
         4NzFU00g+v3QF0+kLLC3fsZiWSVstZdII3rXNzliGAQbjc8xok5wLrrXY8OfgpsLBE9p
         AeRX+vnn/grZCr8mB2qSRc+Y4+hW8GF36qUBArJO/npvo4kLAH1HUgW5ii5h45DkvnMr
         LsMhHq3oHWPmu0vCOy3Quuhcy9FujWPcTvtmtnSn/UuM3YBqPlSBtmnBf/isU+Jn/fag
         EClfA9VhWXaO37UJYaKYNYDZdbttIggN7vtGIzBsroGOQodUcCBxIFutyaCPzIkEeAv2
         rv7Q==
X-Forwarded-Encrypted: i=1; AFNElJ+3AfQbiFwH0ntWxJLxCxBh+/MS3DBVzvObS0Qbp6UfkHF4v2o1KEq5vuE5eqnho/SzFUfeDCd28yOEkap4@vger.kernel.org
X-Gm-Message-State: AOJu0YwUqCqF6cEGO0pzsoU6YQ9tb/8KA9mMt4arCvpuHsfxv64swLga
	lv1r0usyNQyxaYCDXC8wBb+9R6L4sQ8iQHP25f1D7uErPRacp7w6oOjCpkpmi5PRb9ic33hab8b
	8yO3zLqKa+UGDDsEv0JWcjjMzBlFb18LXhp4x
X-Gm-Gg: Acq92OHSxn1Ikwjc1eDCK8CWWranXFzkfdEyZbN/DxK90wGuEisgIQFV+9SDSTUxMwI
	kYgTyd78jmr7zVlMeqIiGTwMC9DSSjw1JSiGd99MzPOr9BWhWcE9EeidYOVy4BfpBjwN0GDbgqs
	urZ6CJqESdcrqA2cgwa1bua/BpHiu4rkkO+zFvHfb494OtIpbqQEFZxBCTE9y2gI6gbUdt0NS5/
	DJJUXLtCHofNQRjCzQjLsWPx+x/JLJPmhc0vVET39JUInygNQOpsrBo8tzxMzHlfOm57cEuPChN
	W9AaXmofKeLcCAxUHg==
X-Received: by 2002:a05:690e:168f:b0:653:1298:2757 with SMTP id
 956f58d0204a3-66106f2fc61mr5005286d50.3.1780790425151; Sat, 06 Jun 2026
 17:00:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530143514.3083601-1-charsyam@gmail.com> <CAKYAXd-MxgdSfr+rmu96JYicyv6JS9m-ZosiS-RwU+C-79XXyA@mail.gmail.com>
In-Reply-To: <CAKYAXd-MxgdSfr+rmu96JYicyv6JS9m-ZosiS-RwU+C-79XXyA@mail.gmail.com>
From: CharSyam <charsyam@gmail.com>
Date: Sun, 7 Jun 2026 09:00:10 +0900
X-Gm-Features: AVVi8Cc1BxRgDiJOTI2-8jhZmWP8fekVllDCrujbGdkVvscxdn2ZrojnhBA_uyw
Message-ID: <CAMrLSE4ztrMttNjrtTymQVoz=KhL+ELLMm71-QUZxeP0VEapPw@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] ntfs: validate attribute values on lookup
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namjae,

Thanks for applying patches 0001 through 0004.

Skipping 0005/0006 for now makes sense. After re-checking the
generic/013 failure, I found that v4 only fixed one side of the
$INDEX_ROOT resize ordering. Patch 0005 handled the shrink side in
ntfs_ir_truncate(), but v4 missed the grow side in ntfs_ir_reparent():
the code could publish a larger index_length/allocated_size before the
resident value was grown. If that resize then hit -ENOSPC, the recovery
path could re-lookup a transiently inconsistent $INDEX_ROOT.

So 0005 was not intended as a workaround, but it was incomplete as a
prerequisite for the $INDEX_ROOT validator. I will send the remaining
$INDEX_ROOT work as a small v5 follow-up series on top of the tree with
0001-0004 applied.

For the allocated_size question: the driver currently consumes
index.allocated_size as the usable capacity of the shared index_header,
including resident $INDEX_ROOTs. ntfs_ie_add() uses it to decide whether
an insertion can be done in place or whether the root has to grow, and
ntfs_ie_insert() does not re-check the resident value boundary. So I
think the validator should still reject allocated_size values that extend
past the resident index area.

The extent-inode lifetime race I found while testing is independent, so
I will send that separately instead of mixing it into this series.

Thanks,
DaeMyung

2026=EB=85=84 6=EC=9B=94 6=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 12:30, N=
amjae Jeon <linkinjeon@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Sat, May 30, 2026 at 11:35=E2=80=AFPM DaeMyung Kang <charsyam@gmail.co=
m> wrote:
> >
> > This v4 supersedes the previous single-patch v3. Per review, it expands
> > the lookup-time attribute value validation into a series so $VOLUME_NAM=
E
> > and $INDEX_ROOT can be validated safely.
> >
> > The first patch keeps the original $FILE_NAME corruption fix and moves
> > the duplicated non-resident mapping-pairs metadata checks into the comm=
on
> > attribute value validator. It also keeps resident value matching in the
> > external attribute lookup path on the actual value length and fixes the
> > matching attrlist duplicate check for resident attributes. The next
> > patches prepare the volume label write and mount read paths to cope wit=
h
> > a rejected $VOLUME_NAME, add $VOLUME_NAME validation, fix the
> > ntfs_ir_truncate() shrink ordering issue, and then enable $INDEX_ROOT
> > validation.
> >
> > Changes since v3:
> > - Expand the single patch into a 6-patch series as requested.
> > - Keep corruption messages using numeric attribute types and drop the
> >   attribute type name helper.
> > - Move non-resident mapping-pairs metadata validation into the shared
> >   ntfs_attr_value_is_valid() helper.
> > - Preserve resident @val matching in ntfs_external_attr_find() using th=
e
> >   actual resident value length, and avoid reading the non-resident
> >   lowest_vcn union member when checking resident attrlist duplicates.
> > - Make ntfs_write_volume_label() add a replacement only after successfu=
l
> >   removal or after -ENOENT, and propagate other lookup/removal errors.
> > - Reinitialize the mount-time search context before the
> >   $VOLUME_INFORMATION lookup, since a rejected $VOLUME_NAME leaves the
> >   context in an undefined state.
> > - Add $VOLUME_NAME-specific validation, and reject non-resident
> >   $VOLUME_NAME records like non-resident $FILE_NAME.
> > - Include the ntfs_ir_truncate() shrink ordering fix.
> > - Add $INDEX_ROOT-specific validation on top of the shrink fix.
> >
> > DaeMyung Kang (6):
> >   ntfs: validate attribute values on lookup
> >   ntfs: do not replace volume name after lookup errors
> >   ntfs: reinit search context before volume information lookup
> >   ntfs: validate resident volume name values on lookup
> >   ntfs: update index root allocated size before shrink
> >   ntfs: validate resident index root values on lookup
> I have applied patches 0001 ~ 0004 first, as we are continuously
> receiving similar patches. I skipped patch 0005 for now since it seems
> like a workaround, and as you know, 0006 patch couldn't be applied due
> to xfstests failures.
> Thanks!
