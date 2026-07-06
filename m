Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA11E35AC24
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783337544; cv=none; b=ImwCbh+8OgStyvj2NbwhTKNoumlZxlmJAbYPfhlkqf4y1pUy9jY6jE5R+2H3THET0h36lODia/BvTmWl6fKiH3W5GACgwOzMBsAhc7PT28v+Ne4LtrcVZUHQjBv/vhAtSQ5hVMDDAUlZzGhp2srX/eH1C669wr1A9weMXbce2Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783337544; c=relaxed/simple;
	bh=Bt2D3hmoLMs3vR+dQvIjEGP6c75OreldWw9QwUg8eFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EZEE7q4FE2FrH90YeT2tXfPFDtdKjZ0XV4fnVe+l+e+I1iNSkieDWqLxdiirSeCKc742hp6M2mxJiGFos1lZ9gstSvi9FUOHNkq1l8/nF7UdJfEMVJCEhn8IkxoS2VCcqpUhb3msB+w2EubI7C65uDg1ggaIdh+dQMsUoQ2eqTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqD4yvKf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqD4yvKf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B5E1F000E9
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 11:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783337543;
	bh=Bt2D3hmoLMs3vR+dQvIjEGP6c75OreldWw9QwUg8eFI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cqD4yvKfBhHfs5ftIdtgCpW9S9V5M9W+P/3XFiCfhleqReYHF2PkVK0tprMRVPVSe
	 MhJMlB4qPGr9eWwircZX8nGovS5qgb/t24eNV3x6Q2VH/Og12c5n9dqM2TDvt8tG85
	 vv0l7I6F58d/dvu7mwr+in+SPwcvf20RbHTlz6B6iXPJgYYNrmB+KeUhqzIpqw5cyw
	 bAg8E+KnG71pef6Lcdxbnst+zfHAzxWdiFIKGLUWzekydq0LGWj58evgrIIy7Rtm0G
	 0yaWL7O0WguowQ5t3NgN1GowrL6MVByA9DpVFTRNRaH/JqrR84Ly0/m3t6UsI6I3Ih
	 iSNGrRrSgGEcw==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c0c15bd6b8fso273677466b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 04:32:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpfcQ8ty7STjejDeAPXywerUr/gxkiZOb5w9GZUEsuQPmIIefyo/DS5cMOqLUmr3xKW3UqrmZF4GJ+Znz7f@vger.kernel.org
X-Gm-Message-State: AOJu0YxiVbqG4Oh93RZs92kxo7FgilJuuKiAtfjHFw1Krs3eiBkzWJz5
	45kWWjqjbTFbPEGNmsqPoJXSr6wPzu1L2wDGQwRofgKnB87ax9xOw00cQ1dW0tTHZw2VTyh6AD3
	dXUfkLbHtJ23ya69cC0cKtSwZh3Fwcfc=
X-Received: by 2002:a17:906:bcd7:b0:c12:2d16:c505 with SMTP id
 a640c23a62f3a-c15a692b917mr4687666b.42.1783337542485; Mon, 06 Jul 2026
 04:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703173301.89289-1-mdshahid03@gmail.com>
In-Reply-To: <20260703173301.89289-1-mdshahid03@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 6 Jul 2026 20:32:09 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_27-+Bk-1NFqrOTwAuSO7U5v7xeV8e-1pVB23jakrCKg@mail.gmail.com>
X-Gm-Features: AVVi8CcJKbPqR0dEyOsKZRlmiQmlT5OS2k7reJ8DPe5CGaKCNaJfSRtmYa6RjIU
Message-ID: <CAKYAXd_27-+Bk-1NFqrOTwAuSO7U5v7xeV8e-1pVB23jakrCKg@mail.gmail.com>
Subject: Re: [PATCH] ntfs: reparse: remove redundant NULL checks before kvfree()
To: mdshahid03@gmail.com
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 4, 2026 at 2:33=E2=80=AFAM <mdshahid03@gmail.com> wrote:
>
> From: Mohammad Shahid <mdshahid03@gmail.com>
>
> kvfree() safely handles NULL pointers, so the explicit NULL checks
> before calling kvfree() are unnecessary.
>
> This issue was reported by ifnullfree.cocci.
>
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
Applied it to #ntfs-next.
Thanks!
