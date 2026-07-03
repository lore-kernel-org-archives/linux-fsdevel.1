Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACC631E834
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 04:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783053926; cv=none; b=jGHSDNOcJwRprZiEjsNExXMmfRmn9LVBb7y0WFshCv/XZ31cPJWRGoUZOSdq6KAzaWrETL5kaT8Kk11EswBmC8Q+jG2n1ut664d1L353S/ityFhiEIfKuu4GWFCiCu+DhzFNyTW9YdfRQDYPsv3qr7dYKb8XQTwEq8SHectxVWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783053926; c=relaxed/simple;
	bh=HQu/KpmsUgMDgEIzd3oJ8hbVWomFMbBHzDLc2Xf+T5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oe3IGW//OuCRv9GYtPwQyfYBWBcKNA/Dn2Kjjf1SG6lB+rbmRY/WaRVn2usZTaaQ/s4m/u1yknVlgmzEbyvzZKqqjqcFjkutW/pSrPvlzBh41mzUaEk8VjNpS/OA9RHeQnBexeJzGKRl6gmI0KJhML47Jn1t1feH8VrFiLauAeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Np0MXFDu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Np0MXFDu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE84F1F00A3F
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 04:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783053915;
	bh=HQu/KpmsUgMDgEIzd3oJ8hbVWomFMbBHzDLc2Xf+T5Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Np0MXFDuKeAxnOSxBbkLV7gXyBXwnA6FP1GnKAH5tiOSvFfLz0M3b0hUo1nz6UWBD
	 VbBRJ/V3n9OrF78cfbJuJOuEpbraGjQfYqu3Tz9Su6UBs5c+G/DvmnedYkqgOqhwci
	 +IxF+5S0CIbkiaor7I0cra8UJ0uZtuWC103Ymr8yJGr/PdDsMWVmyGt8QcQYkAs7L0
	 OeyBGz5pUjSM6oFt+3sRmcATOpH5bUzlhoeAsHUoNXTir98/kGjtNWkEOJBvKuKed2
	 Ak9CQLOdDJL3Jt1aW0ynEgzeOzhI3ZeTdidbkiPd126DQB4njYOwWzMYTfOR1dmESq
	 o6oqTt6v+aE8A==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c12788a75abso11903766b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 21:45:15 -0700 (PDT)
X-Gm-Message-State: AOJu0YyYhzFhTw+OF4NR9Hvfjqh73lRsGL5H+Hjiu6dKdMkB8MXxc85j
	BLuYWg/OgCi6dV8Pu+ITZs9Bjcz37Wy+r8uJ4VeepCZDzl8wNdZITAtWMoNvW5d46gHxOWh7C5J
	XCEYLpYlJerpANOMLLvOvKjhJGd70ifA=
X-Received: by 2002:a17:907:3f82:b0:c12:34f0:f7b9 with SMTP id
 a640c23a62f3a-c12ae75562amr438141066b.56.1783053914438; Thu, 02 Jul 2026
 21:45:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702024534.847681-1-chizhiling@163.com> <CAKYAXd-3RuD03RJJvdKGvLbm1QuwuGFhGDcAdmjQ+OStUxPCDg@mail.gmail.com>
 <07eb8caf-cb21-44c2-b869-47fd8f0a7b68@163.com>
In-Reply-To: <07eb8caf-cb21-44c2-b869-47fd8f0a7b68@163.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 3 Jul 2026 13:45:01 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_ZJYecV0D2VGSHy3pn=hbpF_u4+OBzhPuP=c9gkuKM+Q@mail.gmail.com>
X-Gm-Features: AVVi8CddKpx7DhqgMpe6MCYnPJmdKnN-dCfcpQgvM5soGW_iYgVGyQvlsbz9grY
Message-ID: <CAKYAXd_ZJYecV0D2VGSHy3pn=hbpF_u4+OBzhPuP=c9gkuKM+Q@mail.gmail.com>
Subject: Re: [PATCH v3] exfat: validate cached iomaps during buffered writes
 and writeback
To: Chi Zhiling <chizhiling@163.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Chi Zhiling <chizhiling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 10:31=E2=80=AFPM Chi Zhiling <chizhiling@163.com> wr=
ote:
>
> On 7/2/26 8:54 PM, Namjae Jeon wrote:
> > On Thu, Jul 2, 2026 at 11:45=E2=80=AFAM Chi Zhiling <chizhiling@163.com=
> wrote:
> >>
> >> From: Chi Zhiling <chizhiling@kylinos.cn>
> >>
> >> Writeback does not hold i_rwsem and can race with truncate or other
> >> operations that change the file's block mapping. This may leave cached
> >> iomaps stale, causing writeback to write data to blocks that no longer
> >> belong to the file.
> > Do you have an actual reproducer or an observed corruption for this ?
> > Thanks.
>
> I haven't actually observed any data corruption, and I haven't been able
> to reproduce the issue.
>
> I just checked the code again, and it seems this issue cannot actually
> occur. The reason is that no operation other than truncate can modify
> the block mapping, and truncate waits for page reclaim to complete
> before releasing it.
>
> Sorry for taking up your time, and thank you very much for your help :)
No problem at all, Thank you for checking again and confirming that
there is no issue.
