Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6253939A2
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776165704; cv=none; b=Zin7vUKxCc1ajyJzISOJhmvbMNG44CjuosSCKoB/WItotY2ahBdWcLAfYKPm/nOQAXxjiY3k/AXHk2CQMGUAous2yqIuvgJWNiFYoHyAdVvEQogwG64mLoLWt/ITk47vaUeGadAnyZ0Yg1wzLjmipRapzuEg8629U5A6e1nCrYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776165704; c=relaxed/simple;
	bh=muFHZE8ZpXIIzHiXEnNQnN9sUvNSqQLJ8E9Rby7pedA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JrRVhn8abefH2ssSAgs0xuSUwR6W0fW5sZTSG+8G7VMb9tvmrmq4KP7nl4Hcp3hiEG8nfzpGdUtEU3z+G0II/v1uJSI6AsdBYI9BTRDf2CZtOWzvWFIiIar+iE7FI4dps+QOlfa0biW3Zjt5vKgn9ZUYvzG7pCXrSeB3MbyTyLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrKgKED8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrKgKED8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA4DC2BCB6
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 11:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776165704;
	bh=muFHZE8ZpXIIzHiXEnNQnN9sUvNSqQLJ8E9Rby7pedA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YrKgKED8KlQq2NP1T/yaARXTcYYYG+r52C3mUkes6pD+z8/qdFXy4D7pvSCxc6xnj
	 czS/waDtr+bdUuaRoGQQiCLf57mKu6+Vgq7KFgZcHedWipBI5OPdiPTdMffVwx10QO
	 MYILIXYSsXh6/jeTvv+nOksa6ar/Gg6pweMjYVQDNi2XWsZwlicOM4kKLkd1ALFIBh
	 78pLYF1dex6T5z1bhky1iN8S1624CIvk/NUDa5fMG/B2d0y+RVuSPmFhNxbdA6b6qr
	 XAr6OuDHiq8E44Ev7Q9o13DwEZNQ7SMr6WOJnK3T1kseQx9JRhOgEg2LVJaduSOHg+
	 Y/JVG3fWIiJ6g==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9e00649769so208156866b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 04:21:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8bA6vCtVIHdHpkKeGNEAiUE7qytuL4OK3mlkXlk+5t/dNnhBimrNoPAsoh/ePtEazshq2xF/QsJQR7Uuxy@vger.kernel.org
X-Gm-Message-State: AOJu0YzMHHrlvNha7VM3Y+2DSigl0kOZIEBZSPEvJash1Z0S+yxUz5fu
	p+zERqj4TPC8PjrYdjirC+c03t3zy17aTj3nYAPXsXqsSbIQc0hbxd7RMqIiY15pxVXivtxGDXH
	b0IwQGYuQciNozsd70ucaTIvj1LCY7ZA=
X-Received: by 2002:a17:907:9803:b0:b9e:345b:a900 with SMTP id
 a640c23a62f3a-b9e345baa82mr186847066b.31.1776165702461; Tue, 14 Apr 2026
 04:21:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411233251.330698-1-dxdt@dev.snart.me>
In-Reply-To: <20260411233251.330698-1-dxdt@dev.snart.me>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 14 Apr 2026 20:21:29 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_2cUqEn94TWKWHD51iGA3KrHsH26neXHsjd9UqjJ6VaA@mail.gmail.com>
X-Gm-Features: AQROBzAnE3NrTAg5P3tZfGsm3hgm-IZGJ2KtM7QYklv9moU6nw_K7hDsXZ5dcGw
Message-ID: <CAKYAXd_2cUqEn94TWKWHD51iGA3KrHsH26neXHsjd9UqjJ6VaA@mail.gmail.com>
Subject: Re: [PATCH v1] exfat: fix handling of damaged volume in exfat_create_upcase_table()
To: David Timber <dxdt@dev.snart.me>
Cc: Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 12, 2026 at 8:33=E2=80=AFAM David Timber <dxdt@dev.snart.me> wr=
ote:
>
> When the size of the upcase table is set to zero in the dentry for any
> reason(e.g. corrupted media or misbehaving device), an integer overflow
> causes the module to loop indefinitely.
>
> If the size of the upcase table is read zero, do not attempt to load the
> table. Instead, fallback to loading the default upcase table. If the
> size of the upcase table is zero or no upcase table is found, raise
> exfat_fs_error() to mark the volume read-only.
>
> Signed-off-by: David Timber <dxdt@dev.snart.me>
Applied it to #dev.
Thanks.
