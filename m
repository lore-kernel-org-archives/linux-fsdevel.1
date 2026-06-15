Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BEA18CBE1
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781546598; cv=pass; b=RcopD/9vEfnTCdYy0rk0+SRrgpn0YjViLxz5aHQYhfhkflkoxY5NqJz9ivptiXGWclZk1v6f3vx86kt2JjLgqLB26pWeIyaegpbSl4w63GOu6H9kiaGloRkYiGtZZB9RvsHM5ynNKdiBUotlCfGttVDMXAgvQu3OEjckSzIyhT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781546598; c=relaxed/simple;
	bh=hBOi3p0V03qyFPtScOsJhsmSy+M+ZuyXWOL5390UOjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=neL0xPDoFq3z/5uY8JIygOQDYrrhpDaHfnswLlcSNvqWJyrJd9cRCrFU30hWDpfcHS1q4sWyIoj9KPYlpSMMrL+eN6qODHtubrsGe4dAxomqYv109ufZdIrFPaEmvCdvgIzO8EyGJ5yJ10KsRD1WhW80AM3yMTSoocbYraBWwLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myIZemFv; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myIZemFv"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6913fb25322so4697578a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 11:03:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781546595; cv=none;
        d=google.com; s=arc-20240605;
        b=Lklaj+w9lbsUOtjxvse9z78LklCHlZQEWaZD5Py946NEPIJ50+/E2BLQidOKPN4gPR
         erAJz/ulPkWNC78GjaQLEFRK1anK68gBMj36d/NkYFquTqN6JETd3w60BaT7RVIyxePu
         xmi5vdETwMCeV5jZ1j2NRxFx7mi8Jmbo9j6d8anKfW+DMkGScJtELS9EfP2BHRB20/0k
         zmldhfrvvSnNr5CzRm1uVxTuxtcuVcJnw70GnpgIcLj06aDaY39087oLu57CK+1tGM3w
         oP/lG3mbMdN+rc5DuZgRJv7S7naeXlMMYBGZCg6RowaJ8Bq9zOdUdLHptMeNl7MoeCO4
         yHKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hBOi3p0V03qyFPtScOsJhsmSy+M+ZuyXWOL5390UOjQ=;
        fh=zM4RxeK3ePPj+r9HtUWBPhwyjS9ANH3Kv/xHikbl1TE=;
        b=lkR9oMvHkaEG6EVHRLfn9Lu7Pfi+2BqYIMb9ExQ6oweaCZSI4Or/pF7VD0d5KdZy5Q
         U4AaYxI95r+TrHNcl/sGJYamyUUi3vQXI/c2R0K8TdCif1eQbkkxs53etyN7rgj0bo6o
         tfOsgGGEvruG7uUIib7DowMVJUpd8/MQYcMjF/AMz/l50TFAeipEfHxr2dE3JX2INXEN
         uSbhlpFUR6Rgwp/mZqx2Hn0RvwIupkhC1iNx/P8g/ctgUPnMpOoX+a/N3ntT+H6Zwtgg
         G1qNwzD0OxED3yTQxG6i4DHOguAsRRQUcBa5ZUXahxu8/KoyRDoxzFyoKg+BN0FFT1sO
         Gm7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781546595; x=1782151395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBOi3p0V03qyFPtScOsJhsmSy+M+ZuyXWOL5390UOjQ=;
        b=myIZemFvoTlAinWuw3Orhm2XFDBji4wzeW6yNOCib9ozeADZEaYk/q0fhzr6IONarQ
         Yz7KWrYjYwGUX/rDDB49HDNe9DjyVi1MwS6mhgW4R/EG1ZJ2xzGSaa4g4sL1T6maKRpu
         y3LwvoyxIfcw/hh/Eqy1MxPb8NCPXYtPSi0f8dW+Zx2gb4kcwU3gmbGOZCkU1dRpLvVh
         /1XwvNSKM6AbxmIwiG3IPdDitc+bMYCAj2W4iXHkafHWS4UHNgTj946eY63jZLb+61lc
         LTowbs9p0s9ytXozYIKEGLGq2V0fSZ1BXt7MARCqcqyuJTHufK0DKyR/HC/RZVFGFx+G
         c6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781546595; x=1782151395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hBOi3p0V03qyFPtScOsJhsmSy+M+ZuyXWOL5390UOjQ=;
        b=CzHmxDRTEe8niY3X1yfA872qfSpeWCG7ly32YTjYg1Ab+QUg97jgk/gXz8vTuOnhGq
         oJK6bSyOGqv6chCzAivgSnmMrcNqS3I+/Ko5/vo8OVkMdPxOI5PYEcXpYSodtKOPuhKs
         2638ol5XMgnH1BWyVC+LfJjm609KKYGDQJBovKhw5ZG1zrlBH/wvuL6TfD47WbcU0x27
         6O7x7BLfHL3IV38KlcUdLMwQw3Mp+qKLoilpH1x++g+2FnBaFR27CQxcLYyYtVHKWUKU
         BKYqzHUPqKX99yRpiC+eFXlqXQFTD3aBp8xh0q1Ksn2vCmeFm8sBuE0pKWdctHXvP9WO
         NlVw==
X-Forwarded-Encrypted: i=1; AFNElJ8rZIo/Qkl4pDpqV+xZEPhVDiQT8HrbzbbWNjgEmVD310Wwsr+Iun5jZaY0wHFbDI6EIRScLAKTeIjYGh/F@vger.kernel.org
X-Gm-Message-State: AOJu0YwMWrmjKkXTWlCaRVLf3KhCQlh3kcW1jX33MWr4iPDEWDuoU9Eb
	3eKa3NQfKhlBV0mjJxxdp6NtWsycqo7M3TJdKbY8xs0J5Prb4DgAFOqCG6Aey9XiiPM1OFVmuYG
	ft2HFhi/ld343mglY7f9MDmUnfQlinLDMi9MbUsM=
X-Gm-Gg: Acq92OEcvoYWAPP6Qi9P2Bsk1xeTwjIePKtuwgUC9urmu40Y+3+FPYFmzZ7hbqbyfDi
	22+TOZxd5ZYJBPmopGeu/q49bFGyz8okttoRSG0yFFNtaAARVFcuvQJeCjPcZgJggy2dTTlpCFn
	z9gVVtdNiFAN5Flf+j2Y5GfC4fSO3PEEryJyTdmxr+fXiwRUZvu9FQU66fH0FozmjZRhtB3bZHI
	7ZrU0NnIsCoe5lLkWBSCUZgNHC0uPPdCAddTcxDJcYBpL1TUMnMiju8daDTQziJofkW4Pii0Ngs
	5TAOOKcVBriMFrHtt+4hRbGBkyyBt/4BBAXId2tnrA==
X-Received: by 2002:a05:6402:5d0:b0:691:706b:183a with SMTP id
 4fb4d7f45d1cf-693788fb0c2mr7319496a12.6.1781546595064; Mon, 15 Jun 2026
 11:03:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615-overlay-idmapped-vfstest-v1-0-c6b3b2228092@kernel.org> <20260615-overlay-idmapped-vfstest-v1-2-c6b3b2228092@kernel.org>
In-Reply-To: <20260615-overlay-idmapped-vfstest-v1-2-c6b3b2228092@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 15 Jun 2026 20:03:02 +0200
X-Gm-Features: AVVi8CdpMlwPdMYy_oKn-YBrEOug14SXeIqtiRTYC62U7wjb_HcLETp8cI_hDMM
Message-ID: <CAOQ4uxjtTd0H=DjyyxaOm56be0JOy2y4ZYV8AbVRnsdGnv4hxA@mail.gmail.com>
Subject: Re: [PATCH 2/2] src/vfs: skip whiteout-device fixtures on overlayfs
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Zorro Lang <zlang@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 5:33=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> The idmapped mount tests create a whiteout device,
> mknod(S_IFCHR, makedev(0, 0)), as a fixture: a whiteout device is the
> only character device an unprivileged caller may create, since it is
> exempt from the CAP_MKNOD check. overlayfs reserves a 0:0 character
> device as its on-disk whiteout marker, so ovl_mknod() returns -EPERM
> and the fixture cannot be created, failing generic/633, generic/696 and
> generic/697 on overlayfs.
>
> Add an is_overlayfs() helper and skip the whiteout-device fixtures and
> the checks that depend on them on overlayfs. The makedev(5, 1)
> "creation must fail" probes are unaffected and keep running. No-op on
> every other filesystem.

I have no strong objection to this patch but there was actually a request t=
o
support makedev(0, 0) in overlayfs for creating overlayfs on an overlayfs r=
oot,
so perhaps it would be better to probe for makedev(0, 0) by fs owner instea=
d
of the is_overlayfs() check.

Thanks,
Amir.
