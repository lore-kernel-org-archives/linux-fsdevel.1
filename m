Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6955B8472
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 02:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791771728; cv=none; b=kqknCjpz98yo3Z5eGcqfIU8UW8RVBUeBtAriQITFQnKRBnjL8bWhdRb6/TxwH8Rhobv/BGC+d7I8nQmhx1XWOR3j61eAvgla7SK48LUNvqV6FOKzJeM1LaOgRzfsLOvVLBGmCmOOwz7NaoJzRUz8OU+sR/YTjHnXu6szCJ+rUFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791771728; c=relaxed/simple;
	bh=Ymr2M8tmbeArtnwibozcSm+gURIEMEPwfokPOMw4nPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+vAwlye7U9LExfzowMJoOpxBLEOdhbiaKbOpLB8DrRHHh6ikmv8fkCvQ9ODqKut2UhqwedGUp3WvxokBlkggX5LfaiMhb5Sx1JcI5csLpyt0OmfJEeBj7dzOIfLJPzKH6qjmcsBoQgJNPoIpCUsY/59smxlnKkrAnyo66N2DfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbI7a29V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbI7a29V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D29E1F0089F
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 02:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791771727;
	bh=u9uzcr9frkzVZVmeQUgcs1aHQ1jhJPMLYSxLsi7p5FE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GbI7a29V1lEbb3VAw9K0Achacd19fDBLBA1aTAZ7fvgkMeGdUMWLiHai5aMRn/IYW
	 8muxmZnOXre70OyCTDQmaYQb8X0OEeNZXzqjpaCxLr54TjPrNFOfBzfoUkg80mEmvs
	 rFIiHZs524us+P8UsoTCw0uzxt8i/mBsNNpEDFe6RutrpLI3aaHRoyzsfPadc84EOZ
	 RYIoXn4JtW+/TwR0L7z97Lly7IDCa+MugD99N5ov3uAzrxNheSW9oJyHB+WBPXI/M5
	 pNbCMYQfCjnlc2vRGGDAx6Xf8KrGQ8FFkXhCRFZHxVOTO/I2V1sT+fH2zmIr/psdMZ
	 s51aoMvjebQhQ==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c2e3846d1caso246887266b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Oct 2026 19:22:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx7ixx39K6ZuTbOqyFGuM/e30G3enVSzjvzp5lTyz5IxFkbKj/TuXl/dDB085h0mxjqr4uux73ffkaZeIyD@vger.kernel.org
X-Gm-Message-State: AFq9FYI6aM/iTR3E6LChaigZJ9XTCB89HC6oWGZk9t9C517NW40yCCrp
	Rs8naG/6X6gPyjEAzFgib3KZiQieGANBJkux4abJJAY7hKAvv73HX90RKRHjBoSAaqloT/0cold
	tkCnvXfJGLoKi7r7Vki1EVcPLCAGD4S4=
X-Received: by 2002:a17:907:bb49:b0:c29:62d8:68af with SMTP id
 a640c23a62f3a-c31a9ffda78mr775633966b.47.1791771725753; Sun, 11 Oct 2026
 19:22:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011221648.6811-1-linkinjeon@kernel.org> <20261011221648.6811-2-linkinjeon@kernel.org>
 <CAMrLSE6bL_T5=c2KhJCP01F9pG8UpeTCaOxgCf1q8_KCAPuhxw@mail.gmail.com>
In-Reply-To: <CAMrLSE6bL_T5=c2KhJCP01F9pG8UpeTCaOxgCf1q8_KCAPuhxw@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 12 Oct 2026 11:21:53 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8PNeg9+Rg6CzpFGbci40rArqEwQBu15ByT4K0V4YtkxQ@mail.gmail.com>
X-Gm-Features: AclHuK8yrJk-Z70YiLRNC5EwxGnzS4aNdev-za7xQYggvftFWVek0nt_XYK88cM
Message-ID: <CAKYAXd8PNeg9+Rg6CzpFGbci40rArqEwQBu15ByT4K0V4YtkxQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] ntfs: add pathname access for named streams
To: CharSyam <charsyam@gmail.com>
Cc: hyc.lee@gmail.com, ntfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sebastian.n.feld@gmail.com, 
	cedric.blancher@gmail.com, Lionelcons1972@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 10:27=E2=80=AFAM CharSyam <charsyam@gmail.com> wrot=
e:
>
> Hi, Namjae.
>
> I noticed a remount issue with streams_interface. During
> reconfiguration, fc->s_fs_info points to a newly allocated
> ntfs_volume, rather than
>   the mounted volume. Consequently, remounting with the existing
> windows setting fails, while requesting none succeeds without changing
> the
>   active setting.
>
>   The check should use the mounted volume:
>
>   diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
>   @@ -275,8 +275,8 @@ static int ntfs_parse_param(struct fs_context
> *fc, struct fs_parameter *param)
>                         result.uint_32 =3D=3D STREAMS_INTERFACE_WINDOWS;
>
>                 if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE &&
>   -                 NVolStreamsWindows(vol) !=3D streams_windows) {
>   -                     ntfs_error(vol->sb,
>   +                 NVolStreamsWindows(NTFS_SB(fc->root->d_sb)) !=3D
> streams_windows) {
>   +                     ntfs_error(fc->root->d_sb,
>                                    "Cannot change streams_interface on
> remount.");
>                         return -EINVAL;
>                 }
>
>   Since pathname support is already committed to ntfs-next, I will
> send this as a separate follow-up patch.
Okay. You can send it.
Thanks for the review.
