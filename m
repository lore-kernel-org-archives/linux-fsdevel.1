Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B939E44AB6F
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784813808; cv=pass; b=aJMQfSAUUssX/LsWJRDVBHaQdpb5dEo9hDhqJrUZZpkYEtwUAF5aPMFTXUSRauf+h9Rb7W1d9QzI9QXnCBmluLS4OXhP8kzOwDoPAg5DcfHTcRs4VoTiJuQTY9mJU1H9ijGySmB/dRCTmGS4phyuWou64NtXi1NvBKWetI50szQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784813808; c=relaxed/simple;
	bh=1hDmEyNzjOlJy44GJhsNgpUOmcmTUW8/lfO1ur59H4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DxFiDHXJz/ZTJnXgcfZG6sTY3Hfoz7R981USLhSLioV4Id1tnBwevVKqe9fnZY4ZXOAz2USl5fji47baYnaN7+cxrfAqXQ6ipgzkMhO+c1h6Js50jY5rUAEljYu31sxQdx3TGnJ5XOjLmoqC4kBbzRSC+fKsCY6ff+gjfSCZ5gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBGuBJws; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBGuBJws"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso1008916a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 06:36:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784813801; cv=none;
        d=google.com; s=arc-20260327;
        b=EPjCtAe8cdJweSVrkmVyLyKBgnRJq7m0CF/AGVZotE5jkSnQUI8A5sJBElXcxpMYJj
         2qrcPOiH9YjKqc2/kJw/hp0LYFttSCZKTe66Tl4BuyFbQIR47Hz5X0ErSdEzkfV8wWYD
         3pjyL8Wa8bfelLQf0AVrTpceH8VwizilYmZmUEE3lxA5zVLoD3SKbTykSSa7uJlBZK1U
         gxsCBODgxHdrK0fvZYyj932JPmDLcKvYET2rhEMn7iqzlor2nVmoyMs2BlIhdmQ9bR3H
         LtC3ostrkJAiwf5KW/7cVTqPlowS7+BcbwVlZ4v4STq165+3uS7UbMcMtzRoVtSD6d5Y
         4TCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1hDmEyNzjOlJy44GJhsNgpUOmcmTUW8/lfO1ur59H4E=;
        fh=OZFpS9NYzPSLYtZ4yVp+7NDJ1FwMndIItJfPmdaZklw=;
        b=WTPYfUp14WjknoL9s3JwCCW/u3AnWkma89yJYsrHIcOp70YHH4PYg+yV5EUIodT9fP
         XytiFfyGcL7faetua9B07iueWo+azwF+Pv0l5NJhZ5SRlmEqFOXuq/ti1cWz/WktZ0zC
         RSmCoV9tYahncLgC/rQOLyHJSquv6rIjLyljdybQ+nSGWdXeBVfDxxqezWbx8LnboIn8
         ifLvctbynWAd+WYsWTm84RSYfO4s44N+tBNd/HFg4N7aotllZKatuJsyAiBnYFSe+bIr
         bXYz4nZRQ7tkc8dIeqVD0avpNYnat+JvG/gN+LqzwWaz07DyotebzmFNV/vVhCzXItx8
         pPgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784813801; x=1785418601; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1hDmEyNzjOlJy44GJhsNgpUOmcmTUW8/lfO1ur59H4E=;
        b=OBGuBJwsOvZ8W2EHkFXJ2Z/c5Czp9pEIWMfhEJ4JhF5FyDsKTQvaq2xZB/zKZG+z3y
         42v3oMCckvC1B7LcB7VTM95bxj2BsBEqKzYCLfqKEcxZkeKGs4i+L0GpV0hZB0FdKTxD
         FXXegTAOvnvNvz5tEToBKw8marDVosdefl7QKr5ftQgVN17e8T2FhrSKplxlw710vb0N
         ap8kdoPkz/7tI9oY1OhiuyjorcXkuowE0NSIyNuPy6NBfE7d7Q4TNBMSp9rsJaEg9bKs
         N5ziWjyG5SVb3ZoKzN7t+6EMPO/SaSgd2AFb+kRsndQjmaThV3pq2rE9thHM/qEblRaT
         hsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784813801; x=1785418601;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1hDmEyNzjOlJy44GJhsNgpUOmcmTUW8/lfO1ur59H4E=;
        b=NUWOvKMMKWHRVM+Z+1/tHxzqu+Ru+AqHnt8GlOKTlIb8ooLJTJt9vtaLF7jpwvmeWc
         lo/L9iOe2gL3shs3GpOMQYnEbCT1IofRZ1/jEyisUwr7QsT71A3nuT6Sufxv+wJzhLO3
         2WCW7wbL1EnVqUQkIHQr6EXZji+n8X+SqivDpfGkMZxmH3OJCEYwGr5lr5mEvcD1+k3T
         sfTvP6KLAM3Lqi2H/UM/nPo0EyMyk7AeMEEQTJDt9i5b2UYIKsc4ge3RibzW0ATqG/aD
         E3nEprVsSYyorWH3OXAREWvFcAB1hX8w/iEI7ecgWDxnrStmDUqlo+eajOgt6HLRJBHp
         BeLg==
X-Forwarded-Encrypted: i=1; AHgh+RrSKc3Ood8wnjJYGBpyMU6jkM+pEGBK2aCoJasz5BkoQwLNh4/cGU7ik7EHOpLHOcllJ0uCcecKYHmWkMLZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+vg9q9hqklrd5RwlAJIx0AqN3Vw/su3crbCQiuOy9UkB670SX
	AoGG7o3/VeCc+uHtOOEqpDT/3QNAYUhUgz2LURq15tdL4LXjCukBsoIjzej6xV6A0gLhgvwXRVA
	i7ZK8m3nsLj1g1nM5WVftStIC87bG9Y8=
X-Gm-Gg: AR+sD12zg/yaU22h1Lqd8IbIcgtK9Llh/xGN/jfoE+uriZVnGLXEhsIla3uLkrquvDT
	+odccfW2RKDfotOqMwudwZeaqYp2QABBfY2jPsRBQVTr4B3jdy5C6VS+90l4KNO+ymg6VtvxUVq
	9V4md5ACImBxQ8QwXtKpo+ZHkJwTGCpgGHOaMbYADhDzVBSoxqdTa1+scPzXuF/S9k3bdqfW4eV
	wmBITybRrzqwaURtcHP/0dX1ZKBDy0jHqilJKzT22HTv8FuGg9OKe2XGVFJqTlnZmAPSI5quQ==
X-Received: by 2002:a05:6402:510f:b0:698:87ac:33c2 with SMTP id
 4fb4d7f45d1cf-69f6b142efcmr1180945a12.9.1784813801039; Thu, 23 Jul 2026
 06:36:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723114848.1212429-1-amir73il@gmail.com> <CAO8sHcn=b94SL6KTfPtnqau++-g9CXD0LOpPjp4L+b9cu8mMSQ@mail.gmail.com>
In-Reply-To: <CAO8sHcn=b94SL6KTfPtnqau++-g9CXD0LOpPjp4L+b9cu8mMSQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 23 Jul 2026 15:36:28 +0200
X-Gm-Features: AUfX_mz_oyfTmFTsWe4DqyoTwZaT4FqILYbq_ROAU2MaHiET5jL3AiHVyZbENNo
Message-ID: <CAOQ4uxjk_Se3dq3exxd5WS98g287HUMjVAucipxBX=T0W-8d6A@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/5] Proposal for Cross-fs copy_file_range()
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 3:05=E2=80=AFPM Daan De Meyer <daan.j.demeyer@gmail=
.com> wrote:
>
> Hi Amir,
>
> I tested the series on top of f6cde11eb46e and cherry-picked these
> selftests:
>
> https://github.com/daandemeyer/vfs/commit/0b0e47d408311fe2b4a3e1711656f83=
6b56e10f4
>
> All four tests failed.
>
> The accounting test reports two reads and writes, and 128 KiB
> accounted in each direction, for one 64 KiB copy. The outer and
> recursive backing-file VFS calls both account the operation.
>
> The credential test fails with EPERM. The explicit source check uses
> the source mount credentials, but the recursive VFS call checks the
> real source again while the destination mount credentials are active.
>
> The permission-order test times out because the real source
> FAN_ACCESS_PERM event happens after the destination inode has been
> locked. The process handling the event cannot update the destination
> while the copy is waiting for its response.
>
> Finally, denying that permission event still clears the destination's
> setuid and setgid bits. ovl_copyfile() removes them before checking
> permission on the real source.
>
> It looks like the root cause is that OverlayFS-to-OverlayFS is
> classified as FS_COPY_SAME_FS before the FOP_CROSS_FS_COPY checks.
> That leaves it on the existing recursive VFS path, so these issues
> remain even with the series applied.

I am baffled by this statement.

As far as I can see, OverlayFS-to-OverlayFS, which is classified
as FS_COPY_SAME_FS should not have changed behavior at all.
That was my intention at least, maybe I have a bug (?).

If I am right and behavior did not change then what are you saying?
That OverlayFS-to-OverlayFS copy_file_range() in upstream has issues?
Are those issues unique to copy_file_range() or also exist for clone
and splice and regular read/write?

Note the overlayfs model - do every operation on both overlayfs mount
(with user creds) and on backing mount (with ovl mounter creds).
Taking this model into consideration, what in your opinion is broken w.r.t
upstream [1] behavior of OverlayFS-to-OverlayFS copy?

Thanks,
Amir.

[1] upstream + this fix
https://lore.kernel.org/linux-unionfs/20260712122421.203113-1-amir73il@gmai=
l.com/
