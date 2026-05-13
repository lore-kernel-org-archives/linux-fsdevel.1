Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21763F4132
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778681519; cv=none; b=VjifHakGJFdXjVQzZ+3X6c4GqFaN1Vd3Vkwmn3UpMcVX6ukiI2PsxwIdEe72GJNE2Q5EYdx10WVU/038H/HJ/ZmjRCx+bamnIHwfoSOWJUnsgQU4x5zPCvI1rpEsx9qsQ4ygTW04uJ5XcKcaKsBE4xQmNyTEZpSce46lxC1eOmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778681519; c=relaxed/simple;
	bh=rNAe5qFIEco0xAiCQ4hEBQtMa7POyo2CUeXe3NuQ6aY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5Zxz+4bR46dQEJooHdJk2ZdmcboAMul+0Un4OE7/pV9vwGtw8JAE3ITNkWkiEiKKOmxoMDb88oE2XtffM6mjrD9l+jB0lWmUL57FpYwjT+u/ljwQoipzbbhL9ULRFFNkYqV5UTC2mWMixH8w9gphHSVH0nc/vbuR5kmokY9Fuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBuFwrze; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBuFwrze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94698C4AF09
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 14:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778681519;
	bh=rNAe5qFIEco0xAiCQ4hEBQtMa7POyo2CUeXe3NuQ6aY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HBuFwrze8XaLdAlylNYxMFHUPy4GiqksIlfuPyppmgMHShxhAqKDPhs0Qu3jW7aqS
	 6KdmMLPfVqRvw5vwij2UTCvYElJlDVS6rJBPHgMT8e1ZPmITk8GADG90nLamj4m9n7
	 f6Mybq8EdBsvtsvGYfQ/Tok7cu+BZ4vKm21LcrlI2ZpexET4VhmO1vmqtle8i/CzCD
	 homLM5dDTy0wWul4SnhpR21Rd5L0PUeWTUKL9JwMrWtre/mk+nV98nq6bjg2pSKlxi
	 0QR1M5ZcOMhiaUZrggufw9JZc2/IRpJO1RETNYMb18NBjGB1rJmEgfwI1oFkL5SnSg
	 W0QXmdLaHt5XQ==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-67b8d9c26bbso12404216a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 07:11:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/5jnORq76JvuWfrygLe9e5Mq3Q5tEl/MV1sxhHeoFd6ZU4BNKNCN3XvrxSbHSo05PSe3VWg1kR5k8kLHnJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzCTwUgr9SwmWYrQs5IstJqo/JNbyq5L60em1Ppj+EiTJYQe36D
	x9LLdDEqk4Xi7gdl+ItznIhheLG3zYq6pKWTNGk3ihuPoi0znrnTRkV49juBEBrm8XhT4Qg+s0a
	xZOlI8j142bTGbGZwds8KC8IZgWCBb3Q=
X-Received: by 2002:a05:6402:1cc5:b0:67b:d0e3:771d with SMTP id
 4fb4d7f45d1cf-682a700bab5mr1651619a12.7.1778681518099; Wed, 13 May 2026
 07:11:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513112156.9122-1-linkinjeon@kernel.org> <20260513112156.9122-5-linkinjeon@kernel.org>
 <CAMrLSE7nvE97mwy__geEVadC8cmzSShGFPK5ZpnjrcPpYXyaPQ@mail.gmail.com>
In-Reply-To: <CAMrLSE7nvE97mwy__geEVadC8cmzSShGFPK5ZpnjrcPpYXyaPQ@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 13 May 2026 23:11:46 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9xSRD8hkEObSSQosVz0fKsw-XQH2KL4Ak4u5akYmVG3g@mail.gmail.com>
X-Gm-Features: AVHnY4LSydBG8c7X1UdGFk_02of-x5mMK9rQ-jyRI0F00eyY0-JKkOyN6qV32Fs
Message-ID: <CAKYAXd9xSRD8hkEObSSQosVz0fKsw-XQH2KL4Ak4u5akYmVG3g@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] exfat: add exfat_file_open()
To: CharSyam <charsyam@gmail.com>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, brauner@kernel.org, 
	djwong@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	anmuxixixi@gmail.com, dxdt@dev.snart.me, chizhiling@kylinos.cn, 
	chizhiling@163.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 9:06=E2=80=AFPM CharSyam <charsyam@gmail.com> wrote=
:
>
> Hi, Namjae.
Hi DaeMyung,
>
> Looks good to me.
Thanks for the review:)
>
> Thanks.
> DaeMyung.
