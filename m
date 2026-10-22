Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.202.193.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792668493;
	b=T0cVh9qCgWhvIpbXPwgZBMem7f2yT9fBoufvj53nvDbMVpIgcVtdjQteh2RAbdRIT4lx
	 YX+joi+tWLy6Nd1xHjNtcpETwl0KLXpW3s5KjVk1vacwFd9jTyLtKsEdeMR2rNbH5xbbN
	 MyGu6DhdDQsv/9rbps1yoYtpdpSy0WgG7DcKuS22JFKXe/+3523cZvCCnLjdPAMMHSxSB
	 177N08kNq8X/VRHMrWNrQIwSex9qE+ykPZ0B/IgFMkBToCg+P1ibdAtoAlLfdwWGdynio
	 TJlhOc2CLQwHUIdkk2OmFH1Qb423DFq+uf2uyq0TIS+d3qp1qDxFMO/1s9Nj3lHRA4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792668493;
	h=DMARC-Filter:DKIM-Signature:Feedback-ID:X-Pm-Original-To:Received:
	 Received:X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=J6YI7+gHBY7EK1SmqLnbwCa4P9bf8M/zCyX1MY9akck=;
	b=dPpY/RAxwwTBpXra1eWUd5Q3Ws36ng+RxjJo3BBtoolnQOWMSZDuMeOaXelDHAx6l+WD
	 CYUZ5hFEzev0Mt1m1zq/6st2kCgLoSQrJw8JX5ALUrNVgi+rlRKmcWFHIdYdtyEKAYIW+
	 NuS4w/kyo4fxRWlGg+5rq6Mguy9vSnmG/s+9rLdWjU5iRWZzvTOk7i8e7Q/Kroe617H10
	 loxFgReGEbKju5vdpbUpRMQgW9G0TpG8c5vF0qXDnKiMxin0zMPx894bCyutcv6YZX58u
	 e51z2PTOr1y06C9mq9x2O0eoh1IuyEHev6QFUt0xUklvh5VMM6vA5keDphERmePTGeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=maurycy.com;
	spf=pass smtp.mailfrom=maurycy.com;
	dkim=pass header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail1 header.b="Jnsfh/Rl";
	arc=none smtp.remote-ip=34.202.193.197
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB940606A324
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 11:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB940606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maurycy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maurycy.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail1 header.b=Jnsfh/Rl
DKIM-Signature: a=rsa-sha256; b=Jnsfh/RlLQA40lKTgFr0Sq3RqsRyXf/H7HBuYLCZLmaX69W+mkJM77pTndLi4f78Pvm2iKhiCpbNZcJBOpXOano9tjO9XdOHaLjdKrdZ2nFcZ76sbUaAIRRIfEZi/8QdbagPoSzITSeYVeUuUxZczw4qQIdOntJezTqJmMrhxBBs2n3YvTN0ONIU5DbLtoJNmjHatq+6+nbU+mnw2oC2cQ7juDFIcTXR9H0Jky43ZhJx6eDQlpym60GqfxPpz1awd3b6iAtZR2FkJfIce+Lpus6vqbZ+cfFLSf4DUK9jZ9Prw9QLEMfRH/uAIPNpzua+lTpDFjDBt5w22kyZP2vqRQ==; s=purelymail1; d=purelymail.com; v=1; bh=mimxsNqhVnd0lCdCb8owKuPr5DmEBgQ0iSGfQxmJLIA=; h=Feedback-ID:Received:Received:From:Date:Subject:To;
Feedback-ID: 1351280:50731:null:purelymail
X-Pm-Original-To: linux-fsdevel@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -603348955
          for <linux-fsdevel@vger.kernel.org>
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 22 Oct 2026 11:28:09 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a06b436dffso726864b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 04:28:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByEwIuBo0QbOTBvtRQBLPpWW71XytFPgMLWyYD7c5/5HOS3qLym2ga+0pzERseRu0yqiBkc59TcvTugErmN@vger.kernel.org
X-Gm-Message-State: AFq9FYK/Fq0m2zz5lPsrGF5g8VEZdb00caWU81mxDnQqk8uOKMPomJu8
	KAbh5S0Hfq2Mp/NAY+opvQevt9lcfnAZ9Yw6rFL5eSCJW6c+RVUQhtp5F4ZapMYXuWbnrfM0MP/
	ChOHgFmNFck5ITjbI5dh/Te0T/J5PLBk=
X-Received: by 2002:a05:6a21:6b18:b0:3e2:200b:dc1f with SMTP id
 adf61e73a8af0-3e287f3fd67mr3785808637.74.1792668488506; Thu, 22 Oct 2026
 04:28:08 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022111700.1288273-1-hengyul@cs.unc.edu>
In-Reply-To: <20261022111700.1288273-1-hengyul@cs.unc.edu>
From: Maurycy Pawlowski-Wieronski <maurycy@maurycy.com>
Date: Thu, 22 Oct 2026 13:27:32 +0200
X-Gmail-Original-Message-ID: <CANFf4eCN7rRRfts1pQozdAq2Nn_eKJCSBTAGNjx1BOEKTtLN-Q@mail.gmail.com>
X-Gm-Features: AclHuK9kQpiKgR2aJ0KID_d9uvfCjDr7iW2kpKGkhhqYBC0Tuy32_mm2vN23hJs
Message-ID: <CANFf4eCN7rRRfts1pQozdAq2Nn_eKJCSBTAGNjx1BOEKTtLN-Q@mail.gmail.com>
Subject: Re: [PATCH v2] hfsplus: fix truncated xattr names in listxattr()
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	kees@kernel.org, justinstitt@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm sorry for the late response. Fine with me! Everything looks good
to me. Thank you for keeping me as the author.


On Thu, Oct 22, 2026 at 1:17=E2=80=AFPM Hengyu Liang <hengyul@cs.unc.edu> w=
rote:
>
> From: Maurycy Pawlowski-Wieronski <maurycy@maurycy.com>
>
> Commit 7dcbf17e3f91 ("hfsplus: refactor copy_name to not use strncpy")
> made copy_name() build names in the osx. namespace with scnprintf().
>
> However, the size passed to scnprintf() leaves no room for the
> terminating NUL, so the last character of the name is dropped. As of
> now, listxattr() returns every osx. name without its last character,
> and these names cannot be passed back to getxattr().
>
> The issue can be reproduced with:
>
>     truncate -s 64M hfs.img
>     mkfs.hfsplus hfs.img
>     mount -o loop hfs.img /mnt
>     touch /mnt/file
>     setfattr -n osx.test -v 1 /mnt/file
>     getfattr -m - /mnt/file
>
> Without this patch, getfattr lists "osx.com.apple.FinderInf" and
> "osx.tes". With this patch, it lists "osx.com.apple.FinderInfo" and
> "osx.test".
>
> This patch adds room for the NUL to the size passed to scnprintf().
>
> Fixes: 7dcbf17e3f91 ("hfsplus: refactor copy_name to not use strncpy")
> Cc: stable@vger.kernel.org # v6.10+
> Signed-off-by: Maurycy Pawlowski-Wieronski <maurycy@maurycy.com>
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
> ---
> Changes in v2:
> - Rewrite the commit message. No code change.
> - v1: https://lore.kernel.org/r/20260828-hfsplus-copy_name-fix-v1-1-75ed9=
f0f378c@maurycy.com
>
> Maurycy, v1 got no follow-up, so I am resending it as Viacheslav asked
> in the thread below, with you kept as the author. Let me know if you
> would rather send it yourself.
> https://lore.kernel.org/r/dc187921249a3f6716b829624853e64c10321cd1.camel@=
dubeyko.com
>
> Answers to the questions on v1:
> - generic/377 passes with and without this patch. It only uses user.
>   names, which go through the strscpy() branch. That branch already
>   passes name_len + 1. No xfstests test uses osx. names.
> - Why + 1 helps: the prefix and the name are name_len +
>   XATTR_MAC_OSX_PREFIX_LEN characters long, and scnprintf() writes at
>   most size - 1 characters before the NUL. Zeroing the buffer first
>   does not help, as the last character is never written.
> - Why the write stays in bounds: both callers check that the buffer
>   has room for name_len() bytes, which covers the prefix, the name and
>   the NUL, before calling copy_name(). This is also the number of bytes
>   copy_name() wrote before commit 7dcbf17e3f91.
> - All xfstests: see the full run below.
>
> Tested in KVM with KASAN on a804c5742bff, without and with this patch:
> - The commands above, and a C test that compares listxattr() with the
>   names set on files and a directory: short, long (up to 127
>   characters) and non-ASCII osx. names, FinderInfo, and user. and
>   trusted. names. Without the patch, every osx. name loses its last
>   character, fewer bytes are copied than the size query returns, a
>   buffer one byte short does not get -ERANGE, and getxattr() fails on
>   the listed osx. names. With it, the names match, the copied length
>   equals the size query, and a buffer one byte short gets -ERANGE.
>   KASAN reported nothing with exact-size buffers.
> - generic/377 and generic/062: 5/5 passed on both kernels.
> - Full fstests (805 generic tests, 608 not run on both kernels): 188
>   passed and 9 failed without the patch, 187 and 10 with it. The only
>   difference is generic/617, which fails on both kernels most of the
>   time (19 of 20 reruns without the patch, 18 of 20 with it).
>   fsck.hfsplus -fn reported no errors.
>
>  fs/hfsplus/xattr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index 71364e093fa7..470f090b2699 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -515,8 +515,8 @@ static ssize_t copy_name(char *buffer, const char *xa=
ttr_name, size_t name_len)
>         memset(buffer, 0, name_len);
>
>         if (!is_known_namespace(xattr_name)) {
> -               len =3D scnprintf(buffer, name_len + XATTR_MAC_OSX_PREFIX=
_LEN,
> -                                "%s%s", XATTR_MAC_OSX_PREFIX, xattr_name=
);
> +               len =3D scnprintf(buffer, name_len + XATTR_MAC_OSX_PREFIX=
_LEN + 1,
> +                               "%s%s", XATTR_MAC_OSX_PREFIX, xattr_name)=
;
>         } else {
>                 len =3D strscpy(buffer, xattr_name, name_len + 1);
>                 if (len < 0) {
>
> base-commit: a804c5742bff224d4cb4d25dd383554d598be32b
> --
> 2.53.0
>
>
