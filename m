Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434ED145355
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2026 01:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777165279; cv=none; b=dK0Il0mJI2gwNCNRypoNov6/yKvKj7kTriOK9Cjx7hjG0xPr+MdoBMy0Dzzm10hD1nXeCr3FUUfRU4CfcZGrtGr/DF1NoGg/4yEHAd0/hVvckZ8CFAMGCsXGJyY2NOkh1eO11x3PvHpqIB+5I9NH6KfjE3o5Aaeo3cG8v198EdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777165279; c=relaxed/simple;
	bh=KjBBTHJ48jLtECghvSsU/coZXLhvqrlZQr8lJLrAMys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wja3yeX9i90tzKQ9BkSf9z+3VY04aNMwWNo0xchWh0w5Cz4s1mRFYXc4N6pc/zLY8RUGQMRX7JXfy7K3EGJZ2l8AgK6StM9S9X+mpBCrU2UWPx8pLp5ZPQ4spc2SzKt3QyOwssM+NC/mgFRUM5j/DlvqvKnwS6nVA5RYNXKCNX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jkqdo+JP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jkqdo+JP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A22C2BCB0
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2026 01:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777165278;
	bh=KjBBTHJ48jLtECghvSsU/coZXLhvqrlZQr8lJLrAMys=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Jkqdo+JPO7dJLIuj9ndCbPjB1JD4BaDIsOBjmvOh6HQkXaOZK/s0w+nRToM/WwHSx
	 P40RMP0vhjoHn+J3oz5zKXujpZ7ia2T947wI27+cQ1pxL9swqCiUuzjyKpwvb7KsWB
	 TiK+PfcupPGUWBxjp9iNxS3lvhRdw5qQpJsmcnRQk+GgNclzXlYk/Yx433Phz/Xn8z
	 4zYgB9HKLqk3a5prnKWG26qlifGnQU11kHREWltnYM/uQ7/i46mcOvX3kqANag7OT0
	 bHA8QDpAUEUuStRTvAKC3fsxp5hVFNqqctPMmw4GeccLCqFyosI5evRjaTEc5q24W6
	 H/D7aheHsaMBw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-677f7c29af6so6531957a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Apr 2026 18:01:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8K4Nvew5Nv6Vqe4PyLzgmNJtwoNR7KPj+ZLh9VoQFo4pM9nFFqp97b/uTBKgqvRhSzkOI4xGAKQ+M4PzME@vger.kernel.org
X-Gm-Message-State: AOJu0YxXPe54aWlRULKtF8uRIVXwaAvG+/cDXRgr29sLrtoCShnBxyMv
	qLDG1rPgeJwDrDqQQS733ojXjy7op70baq3LatNvzmB4Ca/wLZgz5KkKefXbeAMXTH0hnNkJ1pO
	CHkYLCzAMW6pVi7X8Hs29u+X44bO6Cik=
X-Received: by 2002:aa7:c391:0:b0:676:d85a:5925 with SMTP id
 4fb4d7f45d1cf-676d85a63bfmr6779236a12.27.1777165277492; Sat, 25 Apr 2026
 18:01:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425184243.116396-1-charsyam@gmail.com> <20260425184243.116396-2-charsyam@gmail.com>
In-Reply-To: <20260425184243.116396-2-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 26 Apr 2026 10:01:03 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_EF2iDP_5W54jOtM2cXv62DZ8Sbi5WgNe2TwsEREjAGQ@mail.gmail.com>
X-Gm-Features: AVHnY4InBUJ2FLCxH3flthELszyGdjFg_oGzSC_-3jS_tOzGNGNWwJkW8TcHjzA
Message-ID: <CAKYAXd_EF2iDP_5W54jOtM2cXv62DZ8Sbi5WgNe2TwsEREjAGQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ntfs: fix NULL dereference in ntfs_index_walk_down()
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> @@ -1991,8 +1995,8 @@ struct index_entry *ntfs_index_walk_down(struct index_entry *ie, struct ntfs_ind
>                         ictx->entry = ntfs_ie_get_first(&ictx->ib->index);
>                         entry = ictx->entry;
>                 } else
> -                       entry = NULL;
> -       } while (entry && (entry->flags & INDEX_ENTRY_NODE));
> +                       entry = ERR_PTR(-EIO);
> +       } while (!IS_ERR_OR_NULL(entry) && (entry->flags & INDEX_ENTRY_NODE));
Is there any reason why you use IS_ERR_OR_NULL(), not IS_ERR() ?

Thanks.
