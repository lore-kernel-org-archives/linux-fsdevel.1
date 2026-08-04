Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86F03E00BE
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 12:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785848260; cv=pass; b=gITPGekMZUC8+PAOTJ8I03mPWAdRFBBpxWMLYJ6xvEH3Pd8y1ldnuM3/KhxbXFJgDTF64oEg6Ls3mbaR6+c0wmUjDqktjNOLjrOEO4y0C+I6kV3NG3zLqP3O0ptCGOWu9SeXhvqknMQYo8I/tsyqiqwVcZ1Yx0TquWMOCayegQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785848260; c=relaxed/simple;
	bh=+WmRghJef1r5J+QMpdMAEUZ9j2c1Uw767yzVkm0wDNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPAnTDGijYBfPXyasw5N35vbynP2V8WioxxwcyaHF6K5Zu5ZoLzKA2HHKaqkoMpwlnF2cKro5wnySjfDcjy+l6rnuFS//I/brUGZDBCpwQImGtp9iwA3ffTerQaIMLIvSdOxhK2jkTmxjUEzT92hZmrGp+kWe0weTqM5R+49ddo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/sIO0rM; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/sIO0rM"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a051b737d8so4767212a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 05:57:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785848257; cv=none;
        d=google.com; s=arc-20260327;
        b=NMzNBuErWOBEhMZMZSO8tWsTDbRt1feA5TojKXkshri9oFx3EGsYwLmAh4s9QgVNGB
         +aPOsDxGpgwByzZ6kfWPE3as0De91vz88HOiAq5gy3STC48DwCO3nTtTRmJcEbFYcC0+
         yasN10/8j4X+mZeZPHtNpkt+5q/NLAY9ZmaejANeCaTeYEmnioZVmGGWLJrlmOCusXOG
         /b16APdYLt9qMEYCglKkr4vua6bQrukjKCSBy0L9CZOZjPfR3s+Z4mVVJDm2Hr3BtusL
         +yy+woRFLsUCn+en+qRf2JN0E9izRv8+PRHve9dCmUA9ZbEccKhyiOzsNwX6pnBEiZzO
         RBqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+WmRghJef1r5J+QMpdMAEUZ9j2c1Uw767yzVkm0wDNU=;
        fh=F6zUubHYlYLsOnEpRq/7NYSxcWNLj/K9tc34U5Y+TUM=;
        b=Vybmmp/nsFHuM4fofClY5fA4Bp/OgJ7viKL44C12IBuJAutZ4dG0SB/MJUp5odt7hN
         QbWB1luYtIQH6UeIhDEbui34lnt0hR5u4W65yNoJjS2jmWxOdr3DvSwzoH9sidaytduy
         HVSkVcfpMM6Mu424rNs0WrVxOsVITlj6ZlqFcHYqrU6hgEffuO+rLBflelxST2S0qjeA
         JvSe9/+SSTEPAaliG2tVHIy/A/Qz7dK+2VFeQ8RHgzRSQyB+JTy2pr5bfBSJuVbovWBy
         4mNZoYmasaEouk6ycPfJ7T42bxVrfp0TkODsVzXly9kDoDkx0+xxhpdBmfhE7UwF/0xb
         EZNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785848257; x=1786453057; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+WmRghJef1r5J+QMpdMAEUZ9j2c1Uw767yzVkm0wDNU=;
        b=C/sIO0rM8eRwvBwCBzyXbcxX35ZAfc61TSZrb/dx5BqgNWgqdPL7xgJLZMyPOIuZmB
         sqZiezOg/NnvVOaxZUuV+jCD6nJifdwyN7Do+W3eOhv58cQgmv8MceGSQkMP6W5CnKEx
         Duc/NomN1WwNXBpS4eveyrcbt/LfN/Rr2DG0TIAfDctsK54Gfz2VC+afAThD2vSFPOOq
         Q1cXDb1Ttorw2kKIqy2jTaTOTXsZu38aOEAtvST7SRKgjNN+J3NWoOu5ONaKc+GRY3TV
         d+hAwwMjWIfP5b+rv3EPRdj3Kgb5w1JOGKhl/XRP1nNAob8EYc5F1mF8sbR2s/Ga/fir
         WUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785848257; x=1786453057;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+WmRghJef1r5J+QMpdMAEUZ9j2c1Uw767yzVkm0wDNU=;
        b=OZPxyNAxsKNuVDExeJrv7wEIT+rjIgQQp2JcYWSuRfDB7fx/xaTzMSKKe7IzPOf58S
         Am1v6py/d2S2imI0u+/6cXXXHtefhRAW/gYIsrYYyTBxfmdUyOstuQnsbcaFKwXbrGCs
         chRoyylgV014GeYkOuNrERkew1bqdh6ha8d3GFmf6ErgfWPYOQ3Fx3NFmtjYONrs7xju
         4oI9g/tQRD4PIJUy661dKs3Znu3MTEFS+eX4tUf42HP/35oSADYI9fxROQYRrxxw4q4T
         Vv5lX+O5hNBRAqs3Ex2z3r8cmufhm39WwVllU+uNOQ+PvGIiypwY3V4DWh4iw/B/c6kP
         rWvg==
X-Forwarded-Encrypted: i=1; AHgh+RoJnw8VIJXiCrFwtglZhERWyYxAk389vdRA0nMMqrvhagNvZnDUwhAwgy+BnlVH9LvCWTBexjsV6h4o8aqE@vger.kernel.org
X-Gm-Message-State: AOJu0YwXU3MQmNqE1Lhc7oKQ4rZ3KvBJoXUa8waycuJ88ZVC5869GPYb
	K2QcGv765TlKKJdWnbNVD0Udj14G77RQhfEIvuIUiFrTxnDtbpy+akxTxW8pGsMEPvi8P6CFHXy
	D2fn+lTp2Kswd5jz1Cxv1hUoL9Zskgw==
X-Gm-Gg: AR+sD13vjwSBl1KHG9xgisBhQNIa22gEBLKWwqQGsHX9Qh5OS/wJaehw85PfVobiQ07
	PwqChIZw8d/uWPwbzbuEBGJeX/IPkkWelqeAo7/8AB2UjvwytXnkI5MXT3jYjumkmCEW1VmU6D4
	UuNj0wIWA2eymY8F07Bn7dYhUIyTm1xwDA/d63lNPaTMEFJ7vA4AphGOt02uw2suwJDAyXIrtyC
	BQEfoPyJ1HDB3VQe+XCQdFZ/KGZIXOPhcn/HIsRnAFzeQWc/LLDSMKeXrSu7B84siNCZFK5SCIg
	d2mN7pDdXlRfD3eSCSs5AI+3sHNSvF8hvUCNmMib0gktDfadhptZKwdsxAbGvzuonlNIiGpbPRR
	/P5NMCZqWK9gJkL8=
X-Received: by 2002:a05:6402:3241:b0:697:e8e1:d3c0 with SMTP id
 4fb4d7f45d1cf-6a0a7c60f6fmr9974383a12.2.1785848256625; Tue, 04 Aug 2026
 05:57:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804123928.736596-1-hch@lst.de> <20260804123928.736596-4-hch@lst.de>
In-Reply-To: <20260804123928.736596-4-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 4 Aug 2026 18:26:58 +0530
X-Gm-Features: AUfX_mwFmmpC_U35ny59wFjG-bBG3cjk5l5jGDZtPGJTJ13E215K0Y1Na_HqAxM
Message-ID: <CACzX3AtEvhTmX8aGVi6zrWWu1=Cfoi8z9=Z17RsZB+pD0LU=9w@mail.gmail.com>
Subject: Re: [PATCH 3/3] block: handle nogenerate/noverify properly in fs-integrity
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Pretty sure I reviewed this patch before, but FWIW:
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
