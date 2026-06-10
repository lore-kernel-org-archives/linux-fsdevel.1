Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553EB40D592
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079801; cv=none; b=YpvcrA3aZdXupMYDdcVA4mYaBC26m7n9Zytu+ulWvt6PDL84FvUSu+8+s9Zm0Dx4OSL3mFCxbsln2i3ElKF+7s2lnaAK1caoqr3rtL0vhWiVk/NSr7yNa1YTY+OoxNYfXO3TxDhsHCsQS3WAocQTvIOdCKjukLWYWCco0lJWTHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079801; c=relaxed/simple;
	bh=lajdHLmGzJ6pdX86UEP0jatoJWsgRPCbLlvPhculls8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHge+MoR+0orhkUAG/QzgxxEufWNbSvngJTqkE9dAvH8yYYx2TKZkXoxo1Z/BvJGs/b858iT+5U6inIKMLugaQTcMJuOyaKZMg3ueEQNYwXHI2JSJanL1LBVIC3fmeiBW5tBuTqMaT857Zv8E/TbdVeixAhxqI/Pk82zW2IWKlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p57hANoW; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p57hANoW"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490a76757e5so42198555e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 01:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781079799; x=1781684599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RQ6rVmHZAbMgF/zkjs+bnm+j5nIq8bjUQyfEZeFsfHU=;
        b=p57hANoWgkZLqkyXMlo5VpVo2xbDZqBn1VQo3yo+eRZn8bonrcu3cFImG5MK7LwINc
         RgEfp3+Hiy5ElmuDfaCfjeI3n/ybvb2+ytm2n1eKfaBrlSMx+7y7R+qHFViEX+X4tI/n
         5JHPI3RavIbcJOL00+b/tNWR1jVFASPkI2n+b9p48l94fa70M0+2BiV5l5WJsQYuqO96
         +qo3N0l9hwA+2cQPHWOmX7hZshx4LE09y4oYfqQ4OfUY//aaC4eIbxsbVZlgF443THJQ
         nd67Sf/bLvuWMNFISFfSucAzxue+RedkUpIiKtxGhhni6eCSRaooyV6flXu5Z2Q6LHiL
         w8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781079799; x=1781684599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQ6rVmHZAbMgF/zkjs+bnm+j5nIq8bjUQyfEZeFsfHU=;
        b=nl8UVCUsamqWZdhUIkgnnVjsddoYEXEPY2Ervp/ASE8LdPKtZzGPTqYP8GsedZeMUa
         Xlqpw0YiInvS8HWa+T5cNkM8ByVM6VTM30FIh6njIg2XED+kZOP46daGPUyuKzhDRB0c
         +mNPn8TrLry1T4e90ceLnej0U+aNal387/aCzTEUpV2DcKUHEyKHe+m3g0Zx5wLcjrcg
         /Y3g7ENwUG6Xy2cYACznhbWIPs3uVKiG7Sn851JT+7YpagVc6DwYP6S7fhgQtTm94kZx
         7iDLxvr/ubqPr2zXbP34+A5mLZmokt5gGXbX9Qvu/LmEqnAJwkJM/SyrEXGyDV6CSoSw
         TWUA==
X-Forwarded-Encrypted: i=1; AFNElJ+cbQlm5PFHMZWcxXq6BuVIGELjKJbLFrUBYM2Lh4+H7ypydl17+vG9fC9u1OCV2wNpOxhcAYtrQUy53/Gt@vger.kernel.org
X-Gm-Message-State: AOJu0YyIVW8t8TfJADORrz384dGiD4bQCvMtm8ZPPEnoF6uKD3gTAicN
	aCiritgq71UkP717o76c3Eq5XZJ5kCol3k9yIPGjXtUYE2QWSiwLR/RAyiBTdOHk
X-Gm-Gg: Acq92OGLkDG/g8kXppyU2EHO/bYiK9UrFQaZ1qZA1MzpzaYoHMSuK7Apxxm9nSr8TY1
	r3xPIIkS+GOTsbqmKFkJE1xE7I86MuNNkb0JO534VB9S1HBZuyanjkKWj0g3412Cov35fajoCdO
	ph0PvwX8p/17fOkv823muT60af5AlunoAUdbwaZ1vltpzAotet9fbWEg3ysLWWVXMtSp1yUQm/c
	K9WskCpRFfLa8p7ZtWuRMM2IX3N3MbKaV8/lfCwF2rmrFzCxCt0azLvdSRjn233IRksJ4nw4MSw
	bH+KTJV4kq0WZuCi65odMMhYEY3lRQZp3EJzX75r+7IuUBRpQVdk1RxJ7CRxGVcB3zsEO9nMomQ
	xRAWdEUjw7JM2jNsU1Psapgpgw6mj4Q6zhQ8HUbHxfiHB2cUerQKrlx8qQVgbpiaz1Y9Mj4Ciym
	rtGDfGgbR1a8vlC/NPhhKaVTwGHpjGuoDXZleEO22jL8BF/waBZHSmY8Hce2m6xOUM2t1IyUVzM
	0RBZHb6OHiG9Ua1rLFBmk8OWEyiK+kHiNEjXCILDy/6
X-Received: by 2002:a05:600c:620d:b0:48f:e249:4094 with SMTP id 5b1f17b1804b1-490c25fa907mr347359715e9.18.1781079798508;
        Wed, 10 Jun 2026 01:23:18 -0700 (PDT)
Received: from fedora (cpc92878-cmbg18-2-0-cust539.5-4.cable.virginm.net. [86.16.54.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cc0f8sm540427225e9.8.2026.06.10.01.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:23:17 -0700 (PDT)
Date: Wed, 10 Jun 2026 09:23:16 +0100
From: Vishal Moola <vishal.moola@gmail.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Ye Liu <liuye@kylinos.cn>
Subject: Re: [PATCH v2 5/6] show_page_info: Remove printing of page index
Message-ID: <aike9DgWxRIdlmWz@fedora>
References: <20260608210618.3437216-1-willy@infradead.org>
 <20260608210618.3437216-6-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608210618.3437216-6-willy@infradead.org>

On Mon, Jun 08, 2026 at 10:06:15PM +0100, Matthew Wilcox (Oracle) wrote:
> Pages don't have indexes, folios have indexes.  Just delete it.  This
> script is going to become increasingly barren unless somebody steps up
> to maintain it.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Ye Liu <liuye@kylinos.cn>

Reviewed-by: Vishal Moola <vishal.moola@gmail.com>
