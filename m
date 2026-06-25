Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074613AE1A6
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397828; cv=none; b=fmjUSf2kypvdcDsMdvXHB2C7W3de488Un6NZ0sKSfiZCIO6nlzFLPBSBQfA0CK8NeCIwCBNaGEBupQvbTEcux5q55Uhb6oiKza08PJyfuJ7mNnFUHRPqu4bx4cYP7Rgpmjcz0a1ZvIueQI1SRgI0tfaBCBKR2V3ZDn5ke6rnpGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397828; c=relaxed/simple;
	bh=Z6QnWMF1uF0OTi2Uhs/q7U1X2oPoWlSEhAaBYzSr7rU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvJCp+l39CYv9wj4OEOPd7KfZj8tw1lHww9n02lb7cxXdNxiE6efuLdZJoToN2wbzfx6l+azgtBp7t39pZSAb3EUzBEuDXvnmge7Wxf0FWs1RwlSWuWZjNNs4edI4WaDnML7yWbsB21Iwjj2hdoydXpXChL9j4oAERmIv54+abs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5gBWS1G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5gBWS1G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C08A1F000E9
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 14:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782397822;
	bh=Z6QnWMF1uF0OTi2Uhs/q7U1X2oPoWlSEhAaBYzSr7rU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=J5gBWS1G3wt/oy9ZBcyraozR+nUPI2xxSo5IAvb4NrLevzYn/NLKJARjXVsHx0RGO
	 NGJqEnhzSFlwsFS7FycgZcq2TSBPwdejugyBsTkNLMDtxykWU/GJik0YK1zvghb2Mo
	 jnjJKtIOohdAJVz9wnOxHMYNxY1hnanxtMgp01P6QD4mtzn7zMDRy9YVUmkppK4gsV
	 IOFZAPE1PxjUQb+tHX9MrJf9Evmbyi/m/u0tiW7HUnGlSz/LODhUaDG4f5lY5WTBJl
	 zKOvdpJANcDDfjP/BOaLYIQxF+e8pLfqC9MORW41VNsZq4XNN4n79VP2/VnAQGoB6P
	 SvSh5gKN1UCtA==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c0e12cb1d90so390752066b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 07:30:22 -0700 (PDT)
X-Gm-Message-State: AOJu0YzMmzNofraJYSybgbjQ3fAop3uIizIzV27PVtLDZUDPQqpTfjb1
	WLx0IPHp2/cHKbbuC10MQKqACLIj7rBIUkBApt82AXHb7+T22bdYZOFaj7DDwLLKb+YWwXYEOzM
	rU3ebYpmUy2ey6/FCNwgEikt3GriNh1I=
X-Received: by 2002:a17:907:6d26:b0:bfb:c8ec:7f9e with SMTP id
 a640c23a62f3a-c1206183caemr193123166b.35.1782397820919; Thu, 25 Jun 2026
 07:30:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF3PHDynqk0fbtthp8cPQCtgFajrjNvCxmDp8Lq=Gs4TD=ztgw@mail.gmail.com>
In-Reply-To: <CAF3PHDynqk0fbtthp8cPQCtgFajrjNvCxmDp8Lq=Gs4TD=ztgw@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 25 Jun 2026 23:30:09 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8fYZ9ZXM=F7H6q3bCW66NYT96ckQk20dmfzramV8FxrQ@mail.gmail.com>
X-Gm-Features: AVVi8Cf_-V9LWD3Yq9Ijsb4Z2KnzoRcrucP581jl2ZHIANmmRCTd7q5Imiao9nk
Message-ID: <CAKYAXd8fYZ9ZXM=F7H6q3bCW66NYT96ckQk20dmfzramV8FxrQ@mail.gmail.com>
Subject: Re: ntfs: RO->RW remount is broken - two bugs in the quota-marking path
To: Razvan Dinculescu <razvandinculescu@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 4:33=E2=80=AFPM Razvan Dinculescu
<razvandinculescu@gmail.com> wrote:
>
> Hi Namjae,
Hi Razvan,
>
> Thanks for the new in-kernel ntfs driver. read-only -> read-write remount
> fails on any clean NTFS volume. I tracked it to TWO bugs in the quota-mar=
king
> path and verified the analysis by building a patched module against 7.1.1=
 and
> confirming that fixing both makes remount,rw succeed.
Could you please test the patch below if it fixes this issue ? It has
already been merged into 7.2-rc1.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/f=
s/ntfs?id=3Dcbe287fd65f1a51eb1720e93ceca7ee8d8b011bc

If you confirm that this fixes the problem, I will submit a backport
patch for the 7.1 stable kernel.
Thanks for the report.
