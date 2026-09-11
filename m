Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3644A3D28
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150504; cv=pass; b=EWBzUvnGC+o+AWa5zNyGj+118H5mqMqhEiDq4dOGA9OSFKCZdoChOtg4THGRe9/274rwjjrbcQtwsLiVcMABrl6/s1URxt4gIyXbeLRt0p8HykHSSOMdYZrsesqcRiHQyaKPDZ0pL4MZftnRt8R3GOEmcpgyCUk3c2N++6t2TMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150504; c=relaxed/simple;
	bh=aXuYUBA4qgCRVJnQLD/3rrlsxYP5kIO8eP6F/R2gRWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMt+7M3SHbLj8O8TozTu77S1/yitfWs/YqJNFVS9mUM5r3hMrZR9bjfw7zgXnrn1NWpJ9CEQDbsWszyZVxVOJvbHlBbKkQBmqk7NrcqBeFJpWCCrsKlZyIDz1VTvOh/eWoeLkzSN/p+zj0TjlhKk8bWQ9q3LrsIXNUXy6lpXCTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NyWNpt81; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NyWNpt81"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3964e480f76so1632520a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 11:15:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789150502; cv=none;
        d=google.com; s=arc-20260327;
        b=ELAjp+ZeQeY/zy+NkdhNiZkm/sDAEFKcD0mKBzveHqnGtWDFT7PRejNXWvKJigV/6n
         hBs3qqXUa3gZv9pPp4JygPrSb6edIhuCDXyukNp6eSu3qhs+tcL22D+faCr52+LoS6aC
         XJLpt9jY0oeZaQSaIpct1pAPT4NalIYV/hMB4hlWaH/2uVXkf7wYQJLDQdSdPYTFIsJF
         Zy9J80U3Y9pWr4+TCUcLLzXt5pOWDBWGUjipXQhXKI+96D5Q5zxwauijI3rF0BVqbT0F
         rAlJ5uNZDZCsfR/FTT4ptdteIrC1qF4WpqUIFbQR0K+Rdjt8q8PszIio3zWUqBbXpY4T
         vH0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yRboA2lJ2kIoc1yVrTeE0yKRXBLg8DrW4V7cxpnbj5w=;
        fh=3SsIvkFCbyWYxtKw/CgGQh2IsiRrbxG7ra4wlZZ/J+c=;
        b=bxBKOzq9sU6j9GeQ8fABkVZ+tU0irOZaBAust5VNlOhylqn4IHKHogUlcB5Avb69VQ
         IM2hmdWaOkqPbOas7+ZWG6sVZc33U+/UCuAdgki7teicYcUOQHllPWAIyh0urp3ek8Eh
         EcLCZj7uqIw/eTRN8pEeHbL5z5JPGZXIlmKI3vsryQ4lzAnBNgrDrqZtY0p3JNEpMt1k
         BCDc5F/Stm+OGroxlKigZH31aRO7Xk/04dR4y5BiMFhTJmz33JJIiaXz1tpfk9RUEC+/
         /jY7SIdZ/enFMblJJq8y07i8IlqoPiKg7L46eKB7eFlk2VxRNUe9mwrqacUCftrhFGu0
         DdPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789150502; x=1789755302; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yRboA2lJ2kIoc1yVrTeE0yKRXBLg8DrW4V7cxpnbj5w=;
        b=NyWNpt817nBZzAUEFKJbFRkfyTX2T6OfjjOF1hr+J9dpdOG9VTkH84QLSXnPfkKwwL
         qap0hOiWYxAdmluq6327JF+228ATOO3X1QOhuj8QJk9FlwlcfBuDxJ2etLB/UAZSaZ+H
         0S8nnVWXXirEBCy7ryFgYSd7Z+sYaR/wD/se1CyJ0vLjLbzijI2MEWLjvtcQzE+XPPu0
         Xtxaka9fQ7SVQqLwaM3xc0sVsqkcrJn0fVA2yKjLgSuyScpchalidRYcW5KDTng8X54Y
         xI0Mdx6CtacQ9t69jxeNhuqtKdd6mrOqeYzeGUfW5yu77+5d0t10CgiPkACB0TZyInWO
         AxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789150502; x=1789755302;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yRboA2lJ2kIoc1yVrTeE0yKRXBLg8DrW4V7cxpnbj5w=;
        b=G6oivr7ssmfyF0NHggasvRylzSpuSPXX/g3ArogIuR+ve5rCtaCL9R1OC1qkI9cPrH
         cVAS+J8YWuOknr/wIy7dXD7KeB84xn7zjyOM9NE/+OBIN1bBz3LwGxFv2UA+kOSlwQOT
         bF1K5jbVP0sYODDySh8cd4/QezjKaWTH222E4bzrPEKizrearJ4yTaKx/YecxgHNjklw
         B/Slr31NgjQLvowCS/mhbQEXVgDd2jS/CicfxGldPkX05cMUkR5t2erL1gGc/S0dZTcJ
         B5DuK+EyjBuokvejdZjI2YIUvZF0Ro2aGdM57OaixUgsu2XY9u/yZxp/tvTwBRchs2/s
         Rkjw==
X-Forwarded-Encrypted: i=1; AKwUvBzduLnZQGdbR6Z717Gel5Bz19sMUWfCKc2tOoXQHmDb5D3Luho4Z3lUwh53OKamDllbfR4z7/YMeSz2RMcU@vger.kernel.org
X-Gm-Message-State: AFuF++ljPQSidniXvFWbjG58df5uuwRO9h9Zz6uwrVVFCb6pqXL+Kvpg
	e7g4JBb41MewG2A2Skdtnne79H0XFTxjtCqWnOSuoh8VyQElQWlbGK7+am0geZeC8xpEoA/Hd/i
	MbklhsHdkhMId/3S4LP21AWMsAj6WrwD8B9PGz4zP
X-Gm-Gg: AYBFou1TfQHDAUjTxYq6Oq2fxXkO2S3sGi+R7kKJMgpF6OY+Op8s215ZEOa6gScF2dl
	WnhxZG6oimQdfccRs5QH/3EXaoZR3mgv47jXL+ar77u/Az+5WJfXcJLPtJnEtkaTMmxOxjLw6uJ
	PkF1ydf59AMolXMxjuW3z6nGjDr7jgfZEbv7ytsKfwHLK0wx7yMdV9Bh2nopPugzZU1k+KzstRl
	o6S9Yh7TykEmt3tkb8TcQvB0ugHuv/nOHjBbuV2yRiDSjW+5ZIvWjdw8zccUkAoiVWNeZi7SxAe
	G1iJMMKk909iePd/OnqnNoDkVChoT0oxlLD+MJI1IwAcQFOYH75BlrI0tDXPVc2zGTot8QsNhWv
	wLGDw3UA1USk=
X-Received: by 2002:a17:90a:d64c:b0:396:d27b:89b9 with SMTP id
 98e67ed59e1d1-39d9bd6197bmr9465904a91.10.1789150502370; Fri, 11 Sep 2026
 11:15:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-lsm-mount-idmaps-v3-0-920a1963675d@amutable.com> <20260904-lsm-mount-idmaps-v3-2-920a1963675d@amutable.com>
In-Reply-To: <20260904-lsm-mount-idmaps-v3-2-920a1963675d@amutable.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 11 Sep 2026 14:14:50 -0400
X-Gm-Features: AcwNN1XvZ2t1QpElaSJ_H9N8jEw7pF3zTUmE1E90vyMLzERl5dKL7VmQb1Vrt48
Message-ID: <CAHC9VhQPprfmHVwi1r+Ddvussdp8FW60A2Q7bXCfSYJ8n7PzPA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] selftests/bpf: verify mount idmaps reach inode hooks
To: daan@amutable.com
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 10:48=E2=80=AFAM Daan De Meyer via B4 Relay
<devnull+daan.amutable.com@kernel.org> wrote:
>
> From: Daan De Meyer <daan@amutable.com>
>
> Extend the BPF LSM selftest to exercise create, link, symlink, mkdir,
> mknod, and permission through both the VFS identity idmap and a real
> idmapped tmpfs mount.
>
> Record the idmap observed by each hook and verify that every updated hook
> receives the mapping used by the VFS operation. This provides regression
> coverage for passing mount idmaps through inode security hooks.
>
> Signed-off-by: Daan De Meyer <daan@amutable.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/test_lsm.c | 231 ++++++++++++++++=
++++++
>  tools/testing/selftests/bpf/progs/lsm.c           |  79 ++++++++
>  2 files changed, 310 insertions(+)

Merged into lsm/dev, thanks everyone!

--=20
paul-moore.com
