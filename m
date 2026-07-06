Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AF441D4CD
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 11:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783337560; cv=none; b=Ws7Tq4Q+DRO8Z37kWiPv7K522Ge4pNDYAhZRHV9W0TR3gQrx6Rlg80lDI4rKvOYy6ve7F5f4A4ySa1YhDAe0zzbnmUtLhzUD46mGAF7lqAn2ZY3kMwsrN49/PqeOqjXOQT1LU3S7ikzz1u6OKoUhItDkaQcTEpKejHgAipEi6Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783337560; c=relaxed/simple;
	bh=Ypfd698Sc0+iLXvotBeHCtp8UUtTo8nRtPh5tKxLyJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pp2/iVNswxKllxJCj2TTXb54P54gc6h75+Z3FJlH42g2T2h4apJ8Kvq9JfCgMPfy9k51gRtfOTbUjdHKZaDAEk5MDPDmOZHyeJLsWi5vnUh09v8owkRTooRXnjuPKKPkiyPC83cNjdiR3Hts1R11NN8Oe60ZaOcf/MNkqjJhflE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdMqFsDX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdMqFsDX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B299E1F00AC4
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 11:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783337558;
	bh=Ypfd698Sc0+iLXvotBeHCtp8UUtTo8nRtPh5tKxLyJI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WdMqFsDX1g5qC9sjecwVKVAOJLoSrTIIzWRrC9uWGRcUzEab8xRGi4UW3Lvwy44EE
	 SO9cdEwSZGblEViVnzpl0PTlcV0NBsX/Wq3Gue125/8RWkzJU+xEgwCiPHOGK1LsIA
	 EZfRjie5Jj2ZiHkVolTuwT1bEeGj3Mj2Lp1G5OBm9QPHUZp2f4GcmjK6mB3PG7w/EI
	 f9vm8ybC01KCdi2ivMTKWDI0oM/gTil208cZMGk9yDOIefPXrNA8+HI1E6hzV6gS/s
	 76jKFmHJUqeh3fI1wJzOWl5/LqAlWHCI9vvWyBqUIpXJGFJTX7TMOUxlh/RuCHu+zR
	 xNjGLOvQNyaLw==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-697763eeafcso4532392a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 04:32:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoePn55OiIsqjheXK/c2cgJIqU1OMKhGv02od1uUE93GYg9A97jMaKifz6zp9e2WTLdUq2VIzD45mGiDTER@vger.kernel.org
X-Gm-Message-State: AOJu0YyKR3QV8S+DS+yOhEC7K1dsBzgc7vIT3B+FXsHOSC1pMm4NcDlB
	Lw1TugqoZXOWj4Nb9hd0IrkVnMofivnq9ymKxBWTcMeli6NRhAt6gOn3pS9TzfPAWD3Kb68eYCD
	ZkNPJh/4QVpoxr74TUw1M7BGVs9DlX8A=
X-Received: by 2002:a17:906:6296:b0:c12:da4a:97d5 with SMTP id
 a640c23a62f3a-c15a699cf08mr6645466b.50.1783337557389; Mon, 06 Jul 2026
 04:32:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704111057.114173-1-mdshahid03@gmail.com>
In-Reply-To: <20260704111057.114173-1-mdshahid03@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 6 Jul 2026 20:32:23 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9MOf7O=kkrfLecVxUEhQmQ9-PXZCg6uysnNVpbLVNVvg@mail.gmail.com>
X-Gm-Features: AVVi8Ce_AUl76vCSgMF4Z_cHtw-dwO6qrpX8AQ3hMQEYy5XtzGRo56QWwpi0C-Q
Message-ID: <CAKYAXd9MOf7O=kkrfLecVxUEhQmQ9-PXZCg6uysnNVpbLVNVvg@mail.gmail.com>
Subject: Re: [PATCH] ntfs: mft: use kmemdup() instead of kmalloc() and memcpy()
To: mdshahid03@gmail.com
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 4, 2026 at 8:11=E2=80=AFPM <mdshahid03@gmail.com> wrote:
>
> From: Mohammad Shahid <mdshahid03@gmail.com>
>
> Use kmemdup() instead of a separate kmalloc() and memcpy()
> pair, simplifying the code while preserving the existing
> behavior.
>
> This issue was reported by memdup.cocci.
>
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
Applied it to #ntfs-next.
Thanks!
