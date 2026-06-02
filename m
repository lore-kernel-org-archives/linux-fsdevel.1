Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5418B389DE3
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410179; cv=none; b=prNwJL7SrrKzC+rIz1+VJhviqXze4/yCdnWj1o1z2Hf32k8vFWoMi6CbaHmQ+TXqdgHkCOMjE5GyQgDE26nauPNWgsy1TDwMHXq4nqytEs2Wo056qZ/jRehvl20WzfagSR9E11dG+QIP19hPQXWkDH+KjkmHdbA1u0GDLODJViA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410179; c=relaxed/simple;
	bh=KcFRx5tRsorRG0WnYO7fy66k2j2WzGLkPyoQZNG1p0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcMT41jsPoLVQnYoP7xMyHcXcauQNHV62UdehHQaIOOB52dHk9d7jXbCGTPxS8VXOWBDXi4YXzjIOIthORQv0CjGGDiToolGGqfqcgDl5uJ3qFXnXsNdVVPzD9oiPn5ADZoIbAh8XnUeLY9+G8yXX3PU5+BOvjqZPMQqd57iOj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWKsEG2O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWKsEG2O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F2C1F00893
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 14:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780410177;
	bh=KcFRx5tRsorRG0WnYO7fy66k2j2WzGLkPyoQZNG1p0s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SWKsEG2OrNxFrRbPU6n/kDxpifLRTTtrVyYqxm2zLfVE3bsQkQLHM5BUyzhYG22Pw
	 Lxo7j3ElrfIEyAPMPGBRJXUaxxNOkaeGPAQHcqFfjob3laPCy7R5y7G5d+lt10xBlK
	 yRSYqoK8xuwoks/yL5oKnFzCA4+6XVyH4D/MOo4lS0/ay/fd4y2knyXylewOJIJZbQ
	 FwV494//RfaZJgheTfn+pW6TiZoTIhMVLcRZVZ2mTnVOBukz9Z0oss2Fjh7HgkK+ow
	 w2ssspDAeW3uU1fNlo3dnq1egeWvOGy45hw+yJMzQH/Ap+npWP/ZS3vTgXJrKlPuK/
	 jGkckmSJb7bfA==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-68bac6e24fdso7238156a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2026 07:22:57 -0700 (PDT)
X-Gm-Message-State: AOJu0YxJfmzZR+eNcdVXxGuYkv7pnrDnY2SEimwDiOd4QffKbFzv+uRF
	SXA3+1vMPiF4/9LBDD7V9+xQeyb3zLmxYUkWa8xgI0x1VnCjz9G2Mbx5GFIWJ1J1VhfhIMnxSUM
	dzeWGFh+2UmqtsqsBw4beJpCpRXrD/38=
X-Received: by 2002:a17:907:1b16:b0:bda:a98:e584 with SMTP id
 a640c23a62f3a-beab1a9b8cemr985175966b.23.1780410176694; Tue, 02 Jun 2026
 07:22:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602-t-serialize-label-v1-1-a7f753bd3c79@gmail.com>
In-Reply-To: <20260602-t-serialize-label-v1-1-a7f753bd3c79@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 2 Jun 2026 23:22:44 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-LeRRkcwBr6-Umop78y0zvS_PPvbNFf0NN4=EyDX-gQw@mail.gmail.com>
X-Gm-Features: AVHnY4LZEefjM18yWEcncEPPTsvIahLT5s0D22AJutud8IOGG6RPh2wtcm5B8qY
Message-ID: <CAKYAXd-LeRRkcwBr6-Umop78y0zvS_PPvbNFf0NN4=EyDX-gQw@mail.gmail.com>
Subject: Re: [PATCH] ntfs: serialize volume label accesses
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 1:53=E2=80=AFPM Hyunchul Lee <hyc.lee@gmail.com> wro=
te:
>
> Protect vol->volume_label with a mutex and snaphost the label before
> copy_to_user. This prevent a use-after-free when FS_IOC_SETFSLABEL
> replaces the vol->volume_label and FS_IOC_GETTSLABEL reads it
> concurrently.
>
> Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Applied it to #ntfs-next.
Thanks!
