Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348A637EFEA
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2026 11:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777892420; cv=none; b=Xty3N0/330PBsYQs7B3RY0OYS7UfjPNAv4Icr8nGgrDSTbWiMXtTTPt75oamkpaPgD6bSenXtWGNfCerR4bXSfldCOxkSajaicOiMU6xkQTpQer3c4L7D3Z4Hl8GoPyiT7AmCYkfElOzXT8OyHhLFwAA0agjurma9d1JDGEMh0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777892420; c=relaxed/simple;
	bh=adGl3HFc8DxycsEzJhdZI0on7iTnVP7M3nJyfGjuhYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+sCbhWUcMoqS5qWKGpGbgyyqK0jnaCiocBZt/qyqkI6+Hsdv0cwQMItXI/FyLGRJQOnDQxzQvAjF4ZsDDSOyOrsYlqB/FnvF9WoSlzyC1FAAtQss9JW+B5AJ7TJpyx5Kxlkuj8IcDxDkIXRTYbeCd9p2PZSxEEMkT7X+9T9ItE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9UZNaj0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9UZNaj0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E57C2BCB9
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2026 11:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777892419;
	bh=adGl3HFc8DxycsEzJhdZI0on7iTnVP7M3nJyfGjuhYQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p9UZNaj0f5wm4en1bB68dM4dVA3iVboorfXfa0IcEuKnKaiv1U5JWHotdibFxw1cj
	 a55sVPDvXTEKFohq/tO11b3EIuwmKYzAktQZf4HfbAm85nAcLKfLv062mJaKE776vc
	 F1Tmg60wNaaMwQQruxXFX6Uw6STF1kRRG7Mqi4QinEkvXhFZOzWDDBUHffDPJvRQuL
	 /0jbQqQJrop7xzP9mE2kTZLT3zbRoDoyB+rWa1zu0iiVBwVOOPhKjTwNE/iYw1G5Gz
	 jxpNi7tz0MzJ3z2JPeTP1GIehIxEQFJ3V2hCmHfT0doUqfPBV6fp4jkXnLiOU+++7L
	 OuRKdSyQnEmSA==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b9c603ec2dfso532008166b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2026 04:00:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/2o8IA7ZbLQ6f3lsJX9Ke2VaxVuml1GXGmVFa2wdhwTCA54zGU0rkvnDJzBH6xR0dRLPKE+3F0XlTbNH2H@vger.kernel.org
X-Gm-Message-State: AOJu0YwiBNtwlR1P/2us7danxBBrnJkN6lg0hwSpvqh6uX5Uz5FDmWFm
	NdutRaqLHWRMydZ6PIAfltRxMLQcSpDpOBLxq//w/J6o5dKbf1XsOeDG8O/y60vYXXHLSrBaSWK
	dU6rAMSAUaIEHcTNnNICNKTHtYxYtkN0=
X-Received: by 2002:a17:907:70e:b0:bbf:74d7:1c4a with SMTP id
 a640c23a62f3a-bbffddc4664mr426063666b.40.1777892418424; Mon, 04 May 2026
 04:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502004852.491934-1-charsyam@gmail.com>
In-Reply-To: <20260502004852.491934-1-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 4 May 2026 20:00:05 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_xwjc2kNyPeHZopH+4dSn4DpBgZiKDJv83LA5-+mJgzg@mail.gmail.com>
X-Gm-Features: AVHnY4JEbew4lS_NOCpb7kC2NXED9DjP9qYqgpQlWXB2-dm95IKS7S8qCOX7W7A
Message-ID: <CAKYAXd_xwjc2kNyPeHZopH+4dSn4DpBgZiKDJv83LA5-+mJgzg@mail.gmail.com>
Subject: Re: [PATCH] ntfs: fix copy length in ntfs_bdev_write() for
 non-page-aligned start
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 2, 2026 at 9:49=E2=80=AFAM DaeMyung Kang <charsyam@gmail.com> w=
rote:
>
> This is not a normal data I/O hot path.  The single in-tree caller is
> the $LogFile emptying path used during read-write mount/remount, and
> the bug only becomes visible on NTFS volumes whose cluster_size is
> strictly smaller than the kernel's PAGE_SIZE (typically 4 KiB on
> x86_64).  Per Microsoft's format command documentation, NTFS supports
> allocation unit sizes starting at 512 bytes, so 512 B, 1 KiB and 2 KiB
> clusters are uncommon but valid on-disk configurations.  When
> cluster_size >=3D PAGE_SIZE every "start" passed in is page-aligned and
> the buggy "from !=3D 0" path is never taken.
>
> ntfs_bdev_write() splits the write across one or more block-device
> folios.  Inside the loop, "to" is computed as the *end byte offset*
> within the current page (0..PAGE_SIZE), and "from" is the start byte
> offset within the page (reset to 0 from the second iteration onward).
> The copy length should therefore be "to - from", but the current code
> uses "to" directly:
>
>         to =3D min_t(u32, end - offset, PAGE_SIZE);
>         memcpy_to_folio(folio, from, buf + buf_off, to);
>         buf_off +=3D to;
>
> When "from !=3D 0" (i.e. "start" is not page-aligned) memcpy_to_folio()
> copies "from" extra bytes:
>
>   - it reads "from" bytes past the source buffer into kernel heap;
>   - it writes "from" bytes past the requested range into the next part
>     of the block-device page (or, if "from + to > PAGE_SIZE", past the
>     folio boundary entirely, which trips the VM_BUG_ON inside
>     memcpy_to_folio() on CONFIG_DEBUG_VM=3Dy kernels).
>
> "buf_off" is then advanced by the wrong amount, so every subsequent
> iteration also reads the source buffer at the wrong offset and writes
> the wrong content to disk.
>
> ntfs_empty_logfile() calls
>
>         ntfs_bdev_write(sb, empty_buf, NTFS_CLU_TO_B(vol, lcn),
>                         vol->cluster_size);
>
> with empty_buf sized to vol->cluster_size.  On a sub-PAGE_SIZE-cluster
> volume, any $LogFile run whose LCN is not aligned to
> PAGE_SIZE / cluster_size reaches the non-page-aligned path.  The
> over-copy can read beyond empty_buf and overwrite the sectors following
> the requested cluster in the block-device page with unrelated kernel
> heap contents while $LogFile is being emptied.
>
> A userspace reducer of the same arithmetic and copy loop confirms the
> bug under AddressSanitizer: ASan reports a heap-buffer-overflow read
> past the source buffer for the buggy length, and the fixed version is
> ASan-clean.
>
> Compute the copy length as "to - from" and advance buf_off by the same
> amount.
>
> Fixes: 5218cd102aec ("ntfs: update misc operations")
> Link: https://learn.microsoft.com/en-us/windows-server/administration/win=
dows-commands/format
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Applied it to #ntfs-next
Thanks!
