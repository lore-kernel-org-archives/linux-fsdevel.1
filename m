Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85913314C2
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 04:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779424283; cv=none; b=DLXh6ncVZkcjwDmYErbzBiXuaijZ2lsh9fGYu/Dw7AN8b8MrVRkijb4/QQuGn2tM5nSCyB73JvjKuglBhzUQOyk/T+ATx62LWUYvgiXJw/p04cSKX3yG8AeQfhWBxoNzOj26ZpA07emjXnUvUfiV2lbNmkkVEp+a+KoSG9gOUvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779424283; c=relaxed/simple;
	bh=mvIday5n82IgM37LgcnoxN9sKtm4yO8Yc1p0GhjT0Xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idNOPbcz3BbxxvxWBviDIvkjMMg8O7IcrznqbLSsipMSGX6Iit37mGNQ4Pwg2id2iSsBgW9c/jiOw/oTwgh6f3xevtYbxCPl908BhgSy6V6oDD64sB8Je3ipsOpG1ufFQY/QEQfs8ZladJvmeHxZ6cDGixKUDI9+LGovZRxmJoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGhqFt46; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGhqFt46"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769A71F00A3F
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 04:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779424282;
	bh=mvIday5n82IgM37LgcnoxN9sKtm4yO8Yc1p0GhjT0Xk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bGhqFt46KKSjdU+CN1U40MzbrfNvRTVAgh7jf534XCC+IYerTf93V/KVo8YhbpMxf
	 Equ6RTNm8yxQoixawV8f0FW8PxiA2wusINuVsXW4S6yNKiasSM1fzq1Ew11C4xNrJW
	 cYzK4lfTVNwgGI/CNxsGOl1XsOu3NfCBNcQ+amEwzxLwEvq5KtgM5q0qmXm2VqglyR
	 Pi17lbeiTnCdIVmZRX6f0hBUvTf8OwTMJKFZ3tZyjJF+UZKJpITbRO2jIpAnrTckzu
	 KOy5dQqGVghuokC7OP99x3/FFpvUITS8ZznPUrGwcy8JBwKYAJ5njd8KiQdN+vCU/g
	 4ZlvIfsAhB3sA==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bcd0111ea98so1012864466b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 21:31:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8nuThs6SXoNi/fcYY5BMi8cYKNBnNx5MCvl4m2oroIBcYckWtW+GThAZoHPa3aHR2VBQ0d0T2BFTqVbykF@vger.kernel.org
X-Gm-Message-State: AOJu0YwjoeUthr5Cx/YeB62xmrBJmLQHb0T0SQptTPw4Uf8A7SNXqmS3
	jKEX+/BGjnloljoqh8SWPBP6SXFd7Q/34ktKPZxCB1uhy93Tp8+I1Aom/p1YQNYHuReUU1B9A8V
	cavKPzg6W7mfcY6DYT8n9hnYDGT/mWEU=
X-Received: by 2002:a17:907:741:b0:bd2:e940:db38 with SMTP id
 a640c23a62f3a-bdd2a4fe6a0mr126479166b.28.1779424281157; Thu, 21 May 2026
 21:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520170151.4115308-1-charsyam@gmail.com> <20260521101751.591345-1-charsyam@gmail.com>
 <20260521101751.591345-3-charsyam@gmail.com> <CANFS6bYVMzKP2uBV=-XMJ4JHyoBNfzqHDAteZ_8gj4t_C3e7xg@mail.gmail.com>
 <CAKYAXd8QvChDOkXobpo+1iA4TW9jpLW1sCw8zOFaqS2UsFWLkg@mail.gmail.com> <CAMrLSE49sUi=BodYybCJ4rvzf--9VLF8N__ESZwE2hUGHT31Rg@mail.gmail.com>
In-Reply-To: <CAMrLSE49sUi=BodYybCJ4rvzf--9VLF8N__ESZwE2hUGHT31Rg@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 22 May 2026 13:31:09 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8gSbrO-z59WfDgEoQVL9FTc-KOinXM2mXKPy9OxE+SMA@mail.gmail.com>
X-Gm-Features: AVHnY4LB3fgNwPVUFzdTjFLNyclEPLnQq9ysISx5618xmiKTdf48aa3_O3FY9p4
Message-ID: <CAKYAXd8gSbrO-z59WfDgEoQVL9FTc-KOinXM2mXKPy9OxE+SMA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ntfs: avoid heap allocation for free-cluster
 readahead state
To: CharSyam <charsyam@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 10:22=E2=80=AFAM CharSyam <charsyam@gmail.com> wrot=
e:
>
> Thanks for the clarification.
> I will rebase it onto ntfs-next and resend.
You can just resend this patch, not the entire series.
Thanks.
