Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7F8228CB8
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 May 2026 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778337022; cv=none; b=FF20WR5fs9abNFlJTlSDV4CTVi4W6tqcijPmSssewjsFpj82/pajSJE7wlmhMsyC8rqezXCBm7OCNS/NE6H38PhoiBaQRxeaL7JbVxfD+Meea95y5xlqgCY0uVl5/pdxT3E8ue8IloM71xis5EolL3j6o6uF2aZeFT5ct8UfDyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778337022; c=relaxed/simple;
	bh=F1jmSFSHCMDf0SKxoA9vtA8j17BRti975HalxExVeik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHIlMAG1hL9qolXtPha4HWOwnr95zQoh66HZRXlrpMVeJHgCmbHw1E72X8VhthziIvg8MoEgdt6o4V8tHYsN6VWg+I5UA9u3jdvjk8CXKT2Z0GJqfdPkDLwEdrFSoj7xR5IpGaAzapw4Y5Lc9DIvNQh0AFQb7Avq4ERXnXYRwKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uM5KMaIl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uM5KMaIl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D70C2BCF7
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 May 2026 14:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778337022;
	bh=F1jmSFSHCMDf0SKxoA9vtA8j17BRti975HalxExVeik=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uM5KMaIlj9zOA+TeMUVurtVzAT4FEn5hnCMqnUmDfw+F7JCExcyO/o6gukqWEH+oP
	 6gWrB432FWyUOV7MEPfWET6SZRIioZ5wX3sWz2vslKpW+VLOgG6b1P19VsSfRUi/sE
	 vOioLdb6yFmUI0lmiOg+VN+T8Fl+vKc1edHe54zvDjV9NTjOmRt/sSmKtgHN5JyvWH
	 +rrPlqQyEeDJ6wBhUgYOKFM2tsHxQHZJSlQSBkRYLZMYQFyLNvx9GvmFEgygFMHu16
	 Xv8KNzb5uOdI2ZQri960SlQT5ZnX0EJUUJCxuLx/RfpwjEOytsTm9xCQUWnUu45A3v
	 2ZPRDB+I6+SeQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bc264a50e7fso542831466b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 May 2026 07:30:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/NJcVKeCvEBeRfSM48ZJd9sFoK5NG+jDZ3XeIGyk0VJWZZU8jiGqB3kNFIrOBqoJ89y2ouVv6W7apdKKkl@vger.kernel.org
X-Gm-Message-State: AOJu0YwcxGz1RFY50qG30ryXNOBiHfc58AXYERutumyfduRScIx1clS0
	kXtP0rIatGXUPFIyP41JJeTgwSUOkyM4urcq8NiZvkhtCUSpOjI6MyFYCPK91KX9W4t5A41/Nra
	FZ8NzjfkG7OVkE6Tl0S2OUTBviCNDw0Y=
X-Received: by 2002:a17:907:a186:b0:bcb:8b03:9fc2 with SMTP id
 a640c23a62f3a-bcb8b03a05dmr201604166b.15.1778337020547; Sat, 09 May 2026
 07:30:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507124238.7313-1-linkinjeon@kernel.org> <20260507124238.7313-6-linkinjeon@kernel.org>
 <9452723a-0c46-48ae-bbe4-9620923b179e@163.com>
In-Reply-To: <9452723a-0c46-48ae-bbe4-9620923b179e@163.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 9 May 2026 23:30:07 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9u2gzukNkycTojY4RKXaK2dUS1Cja1vovEkwxAMjoh=w@mail.gmail.com>
X-Gm-Features: AVHnY4I2Suk3dbyv9ReTb4i5oqHwGqk0eWcCZEAb3zM66KykJIJ6WDoO7fQaD2s
Message-ID: <CAKYAXd9u2gzukNkycTojY4RKXaK2dUS1Cja1vovEkwxAMjoh=w@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] iomap: introduce IOMAP_F_ZERO_TAIL flag
To: Chi Zhiling <chizhiling@163.com>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, brauner@kernel.org, 
	djwong@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	anmuxixixi@gmail.com, dxdt@dev.snart.me, chizhiling@kylinos.cn, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> Hi, Namjae
Hi Chi,
>
> While testing this patch series, I found that generic/299 can cause my
> virtual machine to become unresponsive for a long time. Calling
> balance_dirty_pages_ratelimited in the loop of iomap_zero_iter can
> resolve this issue, so perhaps we need to add this change.
I agree that this should be fixed with a separate patch as you
suggested. I would be very grateful if you could send a patch for this
fix. I will also take a look.
>
> I am continuing to test this patch series, but I'm not sure I will be
> able to find all possible issues :)
Let me know if you find more issues.
Thanks!
