Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B3E2F0C74
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785244117; cv=none; b=f2OjCreKPYQoa5sElNQZ6eoYnfFviIrjpzovCyL05t4jev7b3eegzZpTfe2FvL0PjHO+e8kjoVodJPmpd7bkE9onGaGEJ/pfuxtSnGCAlP2nFBaSbGqp4DjvCK016I/RCaLqRxfntX90DFh3A9zQxbV1tWIW3dSUr65E5HbkeeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785244117; c=relaxed/simple;
	bh=FL24vU2K1IRAj/lusFyX5dHAMJ/v+2ExGx336kLq6Q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L4pEfyvkxfWtmKgJxPsYZEhbpm9WUvC9j8vNhaZNWeYX36Isy7kuG2+7eQ/V1Qg0eZ5n+aJD35ntVtHYtlAW6yhiNMeA4pdMCw5uQhMpvedgYDyhT5N72oUP+fSjBdPQ/hgopZyw4QZP2lXsJtBwe0RsXK0UMDGHA3G6l4Qpp/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C//ez7el; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C//ez7el"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C521F00A3E
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 13:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785244116;
	bh=FL24vU2K1IRAj/lusFyX5dHAMJ/v+2ExGx336kLq6Q8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=C//ez7el/8buqQd8N48JDFwtLhD7knADUxkxuKvgmvXiMa2I78WvZAA1pCnAHau/w
	 WS52vKKANmjerF4X6Qdweli/nBSjXMfUa+kpLwhT+//cpPvkMIof0v89+u8Qraqb1s
	 4zoQLliFk52PasGuJVPgY0fWVvyTvYx8XXHhd9njWnsqfzKIFxAQOqeSXGbl2RB8Wm
	 bnLeDZk5JGzPz4sPYc8CtEkleeOkMIe/Q4F6LmmbHmH+kOglLJvZKlTeJukSiCdHTc
	 +e1cCOF7tYJqLxFnNAEm9nK8GOtkZlcGzUxCuPjv22qP0UPtnELkj+K0O+25NRBfkG
	 zdwRpaL4gTx8Q==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-697bd21fdc2so6265614a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 06:08:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrof5C7NZR+sqI1jnfsRIIdxcSjRI1SZx3xDCv/lxORNB75wHJCNMmo27QQVj7uay4ohQsV1alqatJlJXcS@vger.kernel.org
X-Gm-Message-State: AOJu0YzbWmJNOLBRbLhlItJe/nNc0B/2WC5YePXEzjiUQfVNu6TBhFMU
	Ma24Z6FlV3yUrOumv+wVX+ofAJFpR5OB0A4HT3X3UIXlUxYxbUOwCyXaBBFI3WY9admPy96kBIn
	VYE3otDRZVeUx+7S3+yuX2xqKjZv7Aao=
X-Received: by 2002:a17:906:6a27:b0:c1f:5349:361e with SMTP id
 a640c23a62f3a-c1f72251cffmr118090966b.65.1785244114538; Tue, 28 Jul 2026
 06:08:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727153749.385152-1-dmantipov@yandex.ru>
In-Reply-To: <20260727153749.385152-1-dmantipov@yandex.ru>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 28 Jul 2026 22:08:21 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-wWfS_ii_1HwK+bHMtiaiND0LEfvXSpSWc0gnno=oiMw@mail.gmail.com>
X-Gm-Features: AUfX_myqe4UhzbEV6y-LBvGBkdnVSB3m6kUat-4d7L7PyV25qVR1RN8H-2H0LsY
Message-ID: <CAKYAXd-wWfS_ii_1HwK+bHMtiaiND0LEfvXSpSWc0gnno=oiMw@mail.gmail.com>
Subject: Re: [PATCH] ntfs: simplify ntfs_reparse_set_native_symlink()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 12:38=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.r=
u> wrote:
>
> Avoid redundant 'strlen()' and use the convenient 'strreplace()'
> to simplify 'ntfs_reparse_set_native_symlink()'.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Applied it to #ntfs-next.
Thanks!
