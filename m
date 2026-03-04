Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62F23542D8
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 10:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772619915; cv=none; b=WXP5ir24sPdh2GqJt+5ZbmYJsEj4TCn69zC1D/iRS6lxtuV6wvqKce0UdDOtgZgEe0uSNZ/YdStaLmMCWv2WmXJTJhY2HHXww8I3ZgJRYJq4pCNgW/mTXvGirpOZ0JMn8DA1d9QzUDAM6eOnTTXntzrgYra7z4mmiZhnu/c+pQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772619915; c=relaxed/simple;
	bh=MJiEwsGpr8xbb3Ya6VRds3CGOWDT+83FIlcH4E8zp0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7HRWR4grDtnF2Qjt+hEXZDr1aKd1aMz57Ymt3Yj12NXmoii209SfTF7vXRxwwIhmCQ55y6MjW9P3BL2tJw4LPI8rY8qXVjPLngZdlo8od8wPOJMJDVbhEu8tdO9onnaijP2oiE8HB+DirNt8JN9ehmldocC5BSyqvYJOmIUSfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWNhgY/F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWNhgY/F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18DEC2BC87
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 10:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772619915;
	bh=MJiEwsGpr8xbb3Ya6VRds3CGOWDT+83FIlcH4E8zp0w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jWNhgY/FrH3JY4m8CwrjU9buvzGsk+9X5DE1ZWEpVOl9KzGuKfVAKhKgcfNub2hFJ
	 fhhvBAJ/PyTF9S4zgduDSNCHBApMAGnuWBH75f6sa3RtAgsAhYjd9iE8L+qiX2TGvS
	 DSHXfmjshdCiOkUMtpHMISOW2ea7s3uR3nrt5l1GJrgW8JpnQ3cEGL8KWRrT38DLU8
	 cWmWmbnz9eiuJ6b5Q+2VNvpU8hyvXBGXrWjLCERYch4n5WM+8616T7seBkBJT03rkz
	 UZddwvp0sPAQUo0T6AJeB/y6zLq1FO5AbloVUk/G+YLINNKOsUuna1AxKZRhlCm55P
	 nhFNmFYslemOA==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8f992167dcso668608366b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Mar 2026 02:25:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVcPZJvvvr27hB06hhnwqv0jLhpD079nxKHOPRAfy2SPS6ITaiSyWJu0loUwFFZo5ZHPBC2Yxvz0xTtwIPA@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl9VPuMDSaZnstfpbZoa/bLC659HaRGRuDA+ZnDjBlvRtjo0AD
	HEbes1g1jbJuGAlgoUuUKe2myPvE1rOP8RVBNVcPWFwt+xtZ5e1AtmwFP0ysqGmESi/R27JhZPZ
	49uRu2zBMPEJHc5I6ssTje99CPpkqtos=
X-Received: by 2002:a17:907:3ea5:b0:b93:3792:4b03 with SMTP id
 a640c23a62f3a-b93f1403760mr88427366b.32.1772619914180; Wed, 04 Mar 2026
 02:25:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772534707.git.p.hahn@avm.de>
In-Reply-To: <cover.1772534707.git.p.hahn@avm.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 4 Mar 2026 19:25:01 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-VKhdVneArtYbf8+9ks+f=W7evzzkt9ERccoBsQrfMdg@mail.gmail.com>
X-Gm-Features: AaiRm529rJBv5O-giz8Qa4GobAnw4oXe8VowJPks4n2FW6OA8m_B4lI-m_HzyEc
Message-ID: <CAKYAXd-VKhdVneArtYbf8+9ks+f=W7evzzkt9ERccoBsQrfMdg@mail.gmail.com>
Subject: Re: [PATCH] exfat: Fix 2 issues found by static code analysis
To: Philipp Hahn <phahn-oss@avm.de>
Cc: Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 7:59=E2=80=AFPM Philipp Hahn <phahn-oss@avm.de> wrot=
e:
>
> Hello,
>
> I'm going through our list of issues found by static code analysis using =
Klocwork.
> It found two issues worth fixing:
>
> 1. The 1st seems to be a real bug due to C's integer coercion, where the
>    inverted bitmask `s_blocksize` gets 0 extended.
> 2. The 2nd might just be a dead variable assignment, but maybe `num_clust=
ers`
>    is supposed to be returned or stored elsewhere?
>
> I hope my alaysis is correct. If yes, please apply. Thank you.
>
> Philipp Hahn (2):
>   exfat: Fix bitwise operation having different size
>   exfat: Drop dead assignment of num_clusters
Applied them to #dev.
Thanks!
