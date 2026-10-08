Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316953A759C
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Oct 2026 04:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791434120; cv=pass; b=SOW4BNH9z46yLJiq/UIqPh5YiTzQHklO8XW+nwDQGAJr/r0a9hOKL9jFArrChvVXYQ2VyQCRscx91dK2d+N79Purzicjpa6KJTbHh11sGdZAwhn3csKutO7q93Yo6OBKn3IiLh/N+GvBkl9QSuBj5DM9beN6/qY30wTpL97OEOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791434120; c=relaxed/simple;
	bh=XoQi1i/y3vtnJIe6lxGxfp0W8iw9WFV9zz8v6wfy7fQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSAPqNU/EmLucz/soDi/ZW/RRhMz54OqsyYVEoM0lK17SS0iHVG9w2KOBtBnr1Mvd3Wo4w2b9fI6P3NGbDxWuxNfFRw3KCZ090xocRsxnyoTJOlZKkrlJbH6p0FrLedXM9AMRaFaViW6neisVjrJvr/KyMy95Hnx6zEAcuhg/MQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LkYE6YqR; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LkYE6YqR"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3516c82e96cso2007298eec.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Oct 2026 21:35:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791434118; cv=none;
        d=google.com; s=arc-20260327;
        b=Y9DKPF9KFvdnwtf1sQNSEka0RKJ36aoSgtmfe9JGd4+WfNDgE/x/rJGhNpdIJniyH8
         Vn//8qS6JTMRrOFsK5oSbtMcNfRYVkhfxMm6Lqko75qeP0kZkPJXtONjwvbLGXTt6kzm
         g0T1HTU1ff/CpRRc24UW6E5+Q7NwqVe236moRNfUSmkzcZpaTdMyXCHa6krIRTHQJumP
         XtXuzSsfV++PDCwUVDCZGD8w1KEURpfisYBowhTGaCJF2+kw5QOaYbz8IWGS9moX7v+s
         TywDI0hX3lxJRzQxO9F4guzg31O8OHs0fQHj78k/aE/NqJ/j1JZK+6cAnR0Vaz/pI76k
         66lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XoQi1i/y3vtnJIe6lxGxfp0W8iw9WFV9zz8v6wfy7fQ=;
        fh=FOUxlZuHenDyE0J2tuEzCyopSoSCGcpwReqXgrHfqZA=;
        b=gHpl3RYH9JhdM3Lihnc3qg8QjxlKKpGwRuubmeX94NchmuPzOQaI+xUat+znyHPlQu
         5P9RG+Dam7yiumcSfEGDK8UG9RUKIX6mAh7Zj3oFmKX1h9QEBsWD4GZo2ebm9QgED8Rq
         zzepNDelGIWRS171+CHe16GXCwUqE2b2fcco0d50Uj/Ppy3d2H0BlxXbYRkZH0FB9QN0
         hFCdzi55wpvjcLckCEtrof/4aRkt2vsXNPbSTOp2ILaBk9yrwLx/S6wU9rFNBVM+9qxY
         Tw99SWMxrrUvkJpFPqvQlRBSTRk6sIMixqmiosLokaIJ0rpLYNLhpOwekrozMnC3tabL
         GXFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791434118; x=1792038918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XoQi1i/y3vtnJIe6lxGxfp0W8iw9WFV9zz8v6wfy7fQ=;
        b=LkYE6YqRYssGblnpYrCEP9yKmKcb7pNVl8vUqB8SXhElFQpfDl7EMOJo0XuFV31rcS
         ReBwZ8+2rlwhcvx1Of4iXnbvqkDwRT0xszvMg/UjIynF+S0fXPTjhMp1hl8D4IGu7hXh
         gHx6Ki+5EKmJ4jiTNKyL39PFr1vNRo9bzUEE/LfpidYOVjCfv+l+VCO9rOIsxFRPzwaF
         oRSxqR4riHgylJ0VOxvbb4bZV9qkCZ3ofpyiEyJeX3OC4RT8USzZvksH015y71xpcddG
         62rWmoM6tUYguy/i3HPRG5lp6VbvtzpigvWiOcMV8AEqLPxd8k/utmXbSXJyPVsqPVfr
         4iYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791434118; x=1792038918;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XoQi1i/y3vtnJIe6lxGxfp0W8iw9WFV9zz8v6wfy7fQ=;
        b=XFF8XU8WnElmfqSYQFRo2iYS0TFtqgx66Q7/ky8W21qL9OyKNxbQuFijbU7snlwW06
         miWQ9rpcjbLgRMN/BLCUx5SK5WR3T4eUF/wYWgEKKnWOkAQO4qqpudE3xKM5BWEQh4I6
         7PoVs9rZLAv5YRO6a7NasC/LFPItkMD6I7TSJX5H369WA5H6Fg7RgUAabH3HAq52uOOh
         fW9taz4sgyeseZLFiTXEcq2COKouzJT/Vx8daGgbCibhCnKdZh+U62wnjY6c4g7Hsrow
         msgPCWj28eYLNmAgIcNb2K7FlLkZVz0efYDrwp9CvRJeXox6QI+HIsFe0AxJ7pTz5IdG
         3VvQ==
X-Forwarded-Encrypted: i=1; AKwUvByguQsAczfSelvAOkGLbZRf1Fnlr1USEWzc4/kYIqoe+YCKXo9pvDQymIzpycTYw/uMuYP9O9Qb1nGB+cty@vger.kernel.org
X-Gm-Message-State: AFuF++kBXhS0grLj3va83/qyPCB5oU1R7jDAmEzqikkgW8TLOH3XMudb
	wdeMW7TeQlzyQCaICIBpbHTnrX1vNEjB7YmP/uf4IosK7dWkB9tKPeU46HhLi8UjQtiyuV7WXs2
	9jdqoSboLRVEnCthiZMi5gSu1v+zBGvcPaVfZEaBK
X-Gm-Gg: AYBFou3b+bSDzJRQ7EgDHRABG6HOx/tbo7KZnZTyoA4IiXVCQmtatdVtj6lLwHqnv01
	NleiZ391/HjD3Ts0DKhgKCC4RTshGB7yBYvEHKp6arQGtiZS28YS1MEJiyzxRotIhnIu0zK5jHK
	l5ai61xGB/QvrSNqhKsZ7k6ILZIXIbg5DH0zQDRzBcU3oKEvUg/lvyox0syMShMIBdNy8x/G9A7
	EmzLCqvJMdLJlVEavN6APgC7w4SVPGuHlx6n84xesPjedK4fffbNjWxVQLXqwu/IMOm5DUUV2Wd
	v60v9CbIfpubnWBK92iIJ4kQSJhknD7uK4RHymVTeAKj6/4E7jT+iYHzBTa6Y5uJmbwOBIybbN8
	7+aA9Cs3HzlBlWM742ko2ft7NnkuA6KYCEKEdaOZJImDGynnD4/ABlQ2+V1lS63XzKqcVucJ2lK
	94+7Xp+SfwJxzbHttHlVjhcOMkYiYYLR0Aq38=
X-Received: by 2002:a05:7022:f507:b0:143:5c63:23bb with SMTP id
 a92af1059eb24-16204a7e49amr4513231c88.11.1791434117336; Wed, 07 Oct 2026
 21:35:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com> <20261005-work-unix-passpidfd-v4-2-350183b6e02a@amutable.com>
In-Reply-To: <20261005-work-unix-passpidfd-v4-2-350183b6e02a@amutable.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 7 Oct 2026 21:35:03 -0700
X-Gm-Features: AclHuK_YeTHnG90eRnjnXcfKby1j5D3PmWK-RpBbV20qfOkhK5av9kwUoFmdZto
Message-ID: <CAAVpQUAywU4_xzYUEHb6E3H+mARYE5kLAhQo=uBL76kG5DDraw@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] af_unix: record the pid of the sending thread
To: Andrew Halaney <andrew@amutable.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 8:09=E2=80=AFAM Andrew Halaney <andrew@amutable.com>=
 wrote:
>
> From: Christian Brauner <brauner@kernel.org>
>
> Currently only the struct pid of the thread-group leader is recorded.
> The identity of the actual thread that sent the message or is connected
> to a given socket cannot be retrieved.
>
> Add the plumbing to make it possible to retrieve a pidfd for the sender.
> Nothing uses the thread-specific struct pid yet. No functional changes.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> Signed-off-by: Andrew Halaney <andrew@amutable.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
