Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1AB2D1907
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 02:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779677803; cv=none; b=mNiyAKrR02+rP3Yn2yY/b4u/eGj1z+ZaX3Ombj2JUGJnQlvEuBy0fZz3O4b5feTAxvWIpB87nVL9/g+mE94KrASY41ukYh0jH3/wGDflkF5PBiXZlV3BAHy9p6Ps7OQUCAbPNNaLWnYMZrNNexY4cLYoW2zYhbWi+Kdw7jYY9wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779677803; c=relaxed/simple;
	bh=Lm89h2MJxccPvYk1YGke2jFsEfvNuvjOON9UnBc+W+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EZ9JuEWWxI4Gk3eUnc3BPFHSmvOx9wuf93Dxa2CNppmfAbeUq+/b6P0ZgTtSyzE4jBOm7AsocYJVfCvmeUIl9Rj3ZSojCRbFatG4X5Q477tWwfFi27ztrOhQrp1/vi8d3iGEz1trtI6qyVRXFscNqntWjE+f5FjoXHm+3Jlg7s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/0sCV/8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/0sCV/8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541DD1F00A3C
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 02:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779677800;
	bh=5U+MPnKlyCvcR79bv9eJdVnfUr7FpUVnaM+rwcdB708=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=h/0sCV/8NWuNJrS6gGQG2WwUqiOzZmfLeMh3+FnuzkgjYKrvbF1XXUCx4B2Rrb9So
	 /QxC6DFKIOdv1cQpjplq4NiKRnojbwSj37oL3xbjdAkJ3W2Z5So09Qn28CvsQYlbGi
	 lgCw1B4m6v2IgRrkkkxO+2/ybibv0cAXG8k/FQhGQF74z2Kk51FKMsCasMZJ6dKoEa
	 5FzKBPaNNmTDSFeXs7LbEm1mPouhqCRIQ4UCRwgGKR1vvDLGgpSeD9vZ+DgjfJRnxo
	 gjQAz+0ceYBhpzRQzbGovxeXWfUDDbZH8GXALUjJUJUERmVaL+LP93jHnrZT6qqI0n
	 ihizbt54+inlA==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-67be41d5eeeso14152011a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 May 2026 19:56:40 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy05BC/nD+Z25q5MN+80DrMKz15QHHwmHqlreau+0C+pvd1KZ/4
	LHtpXyJjbDe+QZXKkg9n1Cf3fZtIyKBZ5O5bvpqoh+4fAI4F0hMWTSl+4hwQhBtLbSMttMvVZ1I
	POEXWsghL5ITySa15gn6BzEPG1t3gw4U=
X-Received: by 2002:a17:907:3c86:b0:bd8:f51f:c91 with SMTP id
 a640c23a62f3a-bdd25ce92c0mr683351466b.30.1779677799041; Sun, 24 May 2026
 19:56:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523041423.2726275-1-hyc.lee@gmail.com>
In-Reply-To: <20260523041423.2726275-1-hyc.lee@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 25 May 2026 11:56:26 +0900
X-Gmail-Original-Message-ID: <CAKYAXd96fX4k0cZvveNaHuDnBtKkzKSYcVpijgQ0hT4HySVbWg@mail.gmail.com>
X-Gm-Features: AVHnY4Jp0i97CUyhmKWZkX6s5z6u5JtX3emms5ZKfCMsbTTMnQhtAZq2XP8pfG4
Message-ID: <CAKYAXd96fX4k0cZvveNaHuDnBtKkzKSYcVpijgQ0hT4HySVbWg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] ntfs: tighten EA and index metadata validation
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	charsyam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026 at 1:14=E2=80=AFPM Hyunchul Lee <hyc.lee@gmail.com> wr=
ote:
>
> This series tightens validation of on-disk NTFS metadata in the read path=
.
>
> The first four patches move index validation closer to the point
> where index metadata is read and tighten the structural checks for both
> $INDEX_ROOT and INDX block headers. The last patch adds a missing bounds
> check before accessing fields in an EA entry.
>
> To: Namjae Jeon <linkinjeon@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: charsyam@gmail.com
> Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
>
> Hyunchul Lee (4):
>   ntfs: validate index block header more strictly
>   ntfs: centalize $INDEX_ROOT header validation
>   ntfs: validate index entries on reading
>   ntfs: add bounds check before accessing EA entries
Applied them to #ntfs-next.
Thanks!
