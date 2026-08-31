Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273C746DFE8
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 13:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184082; cv=pass; b=Z2ocMtRBdEQ8vzwcORa5Xyip3dts1m1gZlJOeZeUct/2ef0F7yQ/QUa03Zv8QwyqY0n4Xh/EMBd3qPFNy24nFMYyyLTbATPl9IgPhHSX40VnUm/BkYp8ehE1vxE4282t4k1/Eom9O/UPMqVzb+NyqMk2DhNGCtwbGExVPB7XQuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184082; c=relaxed/simple;
	bh=6EmNPbgdthlv6HmYz6yjs79CFf+7Dk2QeNRcHQINiD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3h+NfnJ+78l4jI6nRdvrTyjnH0RC+AW7w2zSq/WLRIOde13Zn9LF5BOVzXN1F25xSfmrDhoZZFls0glXyxAuEEQjVs3blXyO1B6P6gwvel3PZ8p6GIwqL7KCSca67NbW7hHz8O8jk+Eij6D2ZEogycE48po9hkHab0IY/nYTTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3NnNCrv; arc=pass smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3NnNCrv"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6aa9606ddadso1164096eaf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 06:48:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788184079; cv=none;
        d=google.com; s=arc-20260327;
        b=aRwqmKyEN4aoZBQThwmQ5J+kOCLgj1f1aty21RatuFX5bCasCJcvHNq26wAfJAVipL
         +tVOwIkVDqLfGzhyDDo0P7+MScuL/tUTZaHJjg3j56GQawm2uOqscaiwdOpbuH8EojGD
         k9aCsgEod/JrKJDD6KpV0xjsK7UQtniXJKr36aFfMeh+RlCbzvAiiug4zpNjVhfAxaGi
         0q8V4dpouRVXcT/iwltc5yDvg7y6vOsm6GoBXq3ZDtjZQxoTVuaNjLdbfu79X6lSSxb4
         ju9jLqRdz0BgEpn68ZolcDgKEpCWj7+2d5RKNFriTaMfLd22Xk/0DlUoKDn1pQ+iGiJD
         tLzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3dOxHAFAAnCNkFLAXANF8z/KGOYsJeBy4b5mYI3CnXY=;
        fh=3slhszVvfXa59C6q2H+s47xWMtOJjiDjtV52Zv+tzuE=;
        b=Gst96MoG/bAhs9HVNT11gA66uFzcNHCjIl2goKQcoKqU/rsQO+RYKWegtxW0IgnxqP
         CR8mR9ga/CfG/HxCfm0NqPjo7PJGFV/ycSYPpiQNNWh+RDnytgQxBz+zKSmKR33OAI2m
         oCqh6v2jTgnUigszbZ08J6Ml93wOl6KLNYrn5IvxaxD3a/92kZBmt2Io0RUNgexCWiX5
         riYVgR/tIBtNZT0QnkZxkC7mR5m9jqcRNqiSb6lg4bYOlN8UctB47fgOiPgdYgaJ7sWE
         l+GYItymLe7jsyH9IzYchlIuyRg4AeXKfzDmvSxR0FdpOi5LQezvoCnLZebHYUIXkCRX
         2QJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788184079; x=1788788879; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3dOxHAFAAnCNkFLAXANF8z/KGOYsJeBy4b5mYI3CnXY=;
        b=O3NnNCrv8fE+NwgENRV1hTWmfNlmYQ04qnTpHeyCr23Fszt14vlRqOb1klG6VGPuIM
         r9JvptzArNTlUaDCIVnBbcOnJlAXLK0rOsOwNyeFRLDTJN7Ixj5DAyrBA3azQthyUG09
         VcYxjs4FbKX9TWSTCJOCoWJWTtMJfd9MGYJwhRIsmikqdUB6MSzZazHPeGV52sYQ89Pm
         rxusbQb1lj8/HjcHXMP8lJuOkl5EAfWJb61G9cesuVJwIP9CvBzcA2zdtsNX3eN60f7m
         BQ3xS2p/vG3UzbWx86PniiA04tVscsBreLzSJx5XMZRV/X0UoLfGYgGEz/jz90bICLKP
         NMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788184079; x=1788788879;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3dOxHAFAAnCNkFLAXANF8z/KGOYsJeBy4b5mYI3CnXY=;
        b=HHVNMEGXaPZg/HDv6n9hRlLpTH4Bdn++zRGmwcq/Gxr2wNJUXK+GuMsuv7ITngWjq2
         k05buWLGpl/FC7+UaT79zBa3pnr86D2QTTAHeZp+M7ibfGMem5Rk9u5KEk0IDQyceuMx
         bE7qrY39LYTnjc9LAR1uyxnbc8bS66+6I1OiZn1ft5z5rEn6FI2K/cbbQg5no+KDj9jZ
         zDHlFgljlgYdvksfu5CGqmhQUF1oQAcXOG2JjWilwMOij/zIMikbECx0DcnGt5yutMhp
         pjfqXHhVtlx/rhKJowLmqr4yB/rPA82aDCkTeRrw6Aq+MwMT6sEnQ25ZxKUTTQdnoXpE
         TMFw==
X-Forwarded-Encrypted: i=1; AHgh+Rr+Zxg9D+wAL6G3N10ZEbCCZlSOH/Lu4HI+hykEsVUJZO4W/jm8szuk2y5fjfMWIHHYubxLjQXNvOpiOnuN@vger.kernel.org
X-Gm-Message-State: AFuF++ktG4EZFGRVRjNAVmn/nQwWuzeRxLEH5wDRsFGjlWV0olOZcHFO
	ptse8vdW5bV4pBdgyhsDAnv6fwHLo9uUYjYaKxb9DTnS04ZDNHGki9YxSjXTqXSKRBaQPEP/mEA
	Hr0462JvHf6p3gvU8SaANQwAgWbIu8/U=
X-Gm-Gg: AR+sD11V2+1J4UFHP93sP1Mn7+gyACWDbqErtygH7J5V4HGc/AM1EdYE3nLA20peCTn
	DoexWtLH4E8eR228ccRPICu+gE5tMJZM2HJ0tbr0P7GlI398zi00xvirrfdGGbWHWvtQkpwaa/a
	od+2E9wRVyd09wdj3sQ3k9XqmCClz4ZscYSWZB0tICViT2yl0h4fJ2rO3jqsiL7HJ1va2jpD5hg
	ms671hZ7WHvXX8wGsvdyH9kSVlqM6LoUHB/7YwiSWDXW7rrVnSYHDzUL4qC7OTD0p5sy81fzr0C
	7cM3vFgXCbGXJUrTfhyIb8csSTIakC7RNlfvgvLs3H3zHdcrLhhEN+Pl
X-Received: by 2002:a05:6820:26a:b0:6ae:c68b:3a7 with SMTP id
 006d021491bc7-6b1c6753623mr18493696eaf.16.1788184078901; Mon, 31 Aug 2026
 06:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260829213256.51527-1-kmehltretter@gmail.com> <20260829213256.51527-3-kmehltretter@gmail.com>
In-Reply-To: <20260829213256.51527-3-kmehltretter@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 31 Aug 2026 09:47:47 -0400
X-Gm-Features: AcwNN1W99CqXWvenoG8rROnmu5fRwQuT08OeAJUbXEa2X-h97G_VigU5iiBhoYc
Message-ID: <CAEjxPJ6TRV5CZyuMHatON021ptwzfhsniVKER-vE6ASh0qhpRQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] selinux: recheck intermediate backing files on mprotect
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	Baokun Li <libaokun@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 29, 2026 at 5:33=E2=80=AFPM Karl Mehltretter <kmehltretter@gmai=
l.com> wrote:
>
> mprotect() can be used to bypass the SELinux checks that mmap() performs
> against the intermediate layers of a stacked filesystem.
>
> mmap() checks every backing layer as the request descends through the
> stack.  mprotect() only has the lowest backing file in vma->vm_file, so i=
t
> rechecks the top-level user and the lowest mounter, but skips the mounter=
s
> of every layer in between.  With two nested overlayfs mounts and a policy
> denying mounter_t -> middle_file_t:file { execute }, a direct
> mmap(PROT_EXEC) is denied:
>
>   avc:  denied  { execute } for  pid=3D71 comm=3D"nested_exec"
>     path=3D"/payload" dev=3D"overlay" ino=3D9
>     scontext=3Duser_u:base_r:mounter_t
>     tcontext=3Duser_u:object_r:middle_file_t tclass=3Dfile permissive=3D0
>
> while mmap(PROT_NONE) followed by mprotect(PROT_EXEC) succeeds.
>
> Preserve each intermediate path, mounter SID and file-description SID in
> the backing-file security blob, copying the saved entries when another
> backing layer is opened.  Allocate the array only for nested backing file=
s,
> and release it and the path references in the backing_file_free hook.
>
> During mprotect(), recheck fd { use } and the requested inode permissions
> for every saved mounter, and include the intermediate layers in the execm=
od
> checks.  Policy for nested stacking may then need to grant intermediate
> mounters what a direct mmap() already requires, and execmod on intermedia=
te
> labels for binaries using text relocations.
>
> Tested on arm64 QEMU with a small BusyBox initramfs and a purpose-built
> SELinux policy, on a mainline tree containing
> commit f2381b546e7e ("fs: fix user path of nested backing files").
>
> Fixes: 82544d36b172 ("selinux: fix overlayfs mmap() and mprotect() access=
 checks")
> Cc: <stable@vger.kernel.org>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
