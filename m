Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935D7392C2E
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 13:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781271376; cv=none; b=Z8OpHigfFynyWbw0LZLhXFEgl5q3m6BfMxxasZq3ZYeIoyQhZyAt4KfkQyABk6AtwuR2aNImxmnd/hb4tAiRiD5Lc3wBGG62r2wJ+kGc4QdRzNnJfFdXVzXFCk9P9Eu++FY1CTx8eZ8oV7/bJseCAyTbAcRz9tB0QrdvBspX/H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781271376; c=relaxed/simple;
	bh=BdbZnS205RBIWlBrb7HcRuKuX9yU1AEJplEp7V1xyyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MOpfVABXAXky3I9a8xj7b7rOsAPCu5vXYo8OegFl7gezaeFVetRsIGwbVzTVrpHQNYSV85nwO2v42BZcbXQZoiTLrvd7Vpe62HDxCIOrixyW0G8xqaQa+1zMg4pvtZUGkIs+l2C90MN8FxyuQecQu0zTPkYMSM2OcLyai1rY+3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMWDn9nk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMWDn9nk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531FC1F000E9
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 13:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781271375;
	bh=fM/yoIZKpCHbxUi9J8huif8P2cZaSw2v6mr2mrAiSUE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RMWDn9nkLqGeU8qu1Wd38Uk1L8AQx8YGjubTwoYaMC/pK9mfII/x7lXftSdkDqclo
	 HpM3F56UTPIjEnj0gaQBQTM+1WgOv6N8YfIW4dUJd6ToWQ7YUMuHPtSvnH+KsIumV/
	 DMNffMLw2Lak7RmXALG5TVQn7/cYFpe/A32XEJvie4V8DBSwXOQWTdNQ9BftvhYbUl
	 lK5+66Euag8dbMV6vlKfDC6Npx7uhf0jJMOQYXNemYE0TBoSOqOEi7rn38FMJto+3J
	 tsYrqA//yfBfwjVoqQ32gcfjRbctPB8inxy1zHhHhwjfznqD9FShsdcKKnaq31hFjS
	 im/5OidT1AZFg==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7e1c3f47d78so10788797b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 06:36:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9UpFaIXFXQ7yNanJ9AXb22mOD/J0RiyBq6eoZR4IH72ZtUdvZjhqfHHi0lvtEjBpWZ6vAxzCKk8aRN4Bq2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0K74ubatWuUrSLt4n1tcJBqmEBd4nqme4rFpVeuywt33a+PA5
	QPnVOIPWlHkawWsrR279iYKxjhENLxABI9qQdj7YfLG2/KNTVpZpeKINPM+ERdmf69ugruutBnC
	W1G0sWX7cGz6p/9pmGJruwf0tW+GnGtI=
X-Received: by 2002:a05:690c:ecc:b0:7ba:f3a8:7a87 with SMTP id
 00721157ae682-7f7b901ae69mr26690477b3.40.1781271374759; Fri, 12 Jun 2026
 06:36:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610135423.202730-1-anmuxixixi@gmail.com>
In-Reply-To: <20260610135423.202730-1-anmuxixixi@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 12 Jun 2026 22:36:00 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_fLQqb8JnkzeKoBwJ822AcGa72WeQ07XQRDoiCdOHixA@mail.gmail.com>
X-Gm-Features: AVVi8CeiZ1UnBniQQevPdYI2a9xKu_iVSc2HlpgWjrFTLdvtjckUQiYyrdg0d8w
Message-ID: <CAKYAXd_fLQqb8JnkzeKoBwJ822AcGa72WeQ07XQRDoiCdOHixA@mail.gmail.com>
Subject: Re: [PATCH 1/2] exfat: reuse valid negative dentries for file creation
To: Yang Wen <anmuxixixi@gmail.com>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
> index b7d5e44ad38e..fe26fbf6a0f2 100644
> --- a/fs/exfat/namei.c
> +++ b/fs/exfat/namei.c
> @@ -24,12 +24,9 @@ static inline void exfat_d_version_set(struct dentry *dentry,
>  }
>
>  /*
> - * If new entry was created in the parent, it could create the 8.3 alias (the
> - * shortname of logname).  So, the parent may have the negative-dentry which
> - * matches the created 8.3 alias.
> - *
> - * If it happened, the negative dentry isn't actually negative anymore.  So,
> - * drop it.
> + * exFAT has no FAT-style 8.3 alias entries. A negative dentry can therefore
> + * be reused for creation as long as the parent directory version did not
> + * change since the lookup that created it.
>   */
>  static int exfat_d_revalidate(struct inode *dir, const struct qstr *name,
>                               struct dentry *dentry, unsigned int flags)
> @@ -54,7 +51,7 @@ static int exfat_d_revalidate(struct inode *dir, const struct qstr *name,
>          * Drop the negative dentry, in order to make sure to use the case
>          * sensitive name which is specified by user if this is for creation.
>          */
> -       if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET))
> +       if (flags & LOOKUP_RENAME_TARGET)
Removing LOOKUP_CREATE breaks case-preserving creation.

    $ stat foo 2>/dev/null || true
    $ touch FOO
    $ ls
    foo

The cached negative dentry for "foo" is reused for "FOO". I think only
the obsolete 8.3 alias comment should be updated, while keeping the
LOOKUP_CREATE check.
