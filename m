Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76EC3BED7F
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 19:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379391; cv=pass; b=ZiS/A3BTOfb4FkWnmBm72Utz1GVk46C3/8/PwVJ2rvz1owcvFUrzNKQXnY54mVVlH8gbFqaoSbykoSuwSlZJO+XJJP7MC096qyk5SC4TmBu+yyIX2PJUtHtq/lC028AHS8vdYwDxsMZEwdvORsNDkj187xffZ1TDZB2f8SmVHec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379391; c=relaxed/simple;
	bh=ga4JV9/szVDdjkZ43SYWlrewDuBoIpvwjFPyFW+tFfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEySl9/kQwNYMZfbM4z2cLtXvowT2MqXbwIj6vKKMMR6rAXyrZ5pEViT5t2JjtTw6ogc3088/rsAMxoh32QQyELPzVl0dnCBNJQ6lXopr1MnlD5w3LpuxVcmrTz4VyPHHZcMLdV4GI46AKArQscg3hOMvbEJ6/+3eG6R0SmmLe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ml2A5gc2; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ml2A5gc2"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6674cba2c50so339135a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 12:09:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774379386; cv=none;
        d=google.com; s=arc-20240605;
        b=YhWezEg2owbnvRrkx4yAQFzeDyatYFZRgsZb1D677mR6XmY7kZVMX2pMC/GrBNs/7X
         UAwX8qLSrMXLntfn96BkiFhUR58diAdJrPZjpB4hqFX7RYJwq+k/t7jTPvna2FzIkfgT
         PSmwVD0GfADbc0BHltxCwz/f0ttoHTjehxUr2gKGSf7JRFlx5MI+Z0eZwD8V3tBcxq2C
         p5FtRvpw7q2QaO8qBJMxod/f3MSxCFQgL6KBADJ9rRnn/ottcLE3iWWrPnOn1VJUzZN1
         ihq4/Ykz6eCL9KQ3dgEbmZGLk6RVZFgvsdpqcwGKHA3wSIBPc8ycnfpQuwvRNRJPMzml
         NauA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ga4JV9/szVDdjkZ43SYWlrewDuBoIpvwjFPyFW+tFfI=;
        fh=e3Q9M71Wbb8E838LPF8GMlBC0W5v3NDyM9njFiv86ts=;
        b=IN85NV94XCoPK+dYFjR33J3jNUx1YqUM5OZWDuxaEAJBVHdupDX8PaawBoUSu2/t3k
         CQ6lbHSOElNLTeVZ2LM13PYFENKUqbJfdKD/M6pErBNN9hpa0xfKPoCiyAbhHB+z1d4w
         Hh77MaZe25A1LT4+GerLnD0Ulfexh3pP5ePTwmZ26Sg/U2/MIEXNAChP/aIzdHsnnQyb
         0hItOcjp25vPgvkcLFYIzJXGxe+XUY2W6wt/JBODk0eqE6adomKWBSEsYvQRuLXTw2YP
         ffPzjW/j/refVMLIYRGgrc3xCFFaREj6yWP6SP3D9CVxa+XmqPlExYhrPud5WTUR4OWQ
         VJtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774379386; x=1774984186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ga4JV9/szVDdjkZ43SYWlrewDuBoIpvwjFPyFW+tFfI=;
        b=ml2A5gc23gixB6w2ls+wZD2LzDVFGcFqVAWFp5zsZv/MTpUePrCo+GHu/6tHQFzwTI
         7IhsnArMGNH2e3jlv+eNSqD04QiwQ1L1uXA71LjyFfMYuE75zlikwCu2B/dDphs3EcJV
         0L8HDliyyqdMqL6NwF49ZCn6bRqZ0DwQ570biJ9lBBBfVvi7KV5KyNbzfpEp3teRKabs
         4a16yx5QOxVLZtA+vYg/8bj5uImShoPztCO7zkIWFvlXJt+sdE3uLP9QkE2VOkKRqcEL
         +cX+jaLZBSQ5affNchdCwL0VyScyaFNOf1RTe6dukca41DUC6z2uzIYEX4KfeUq6jK8x
         HeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774379386; x=1774984186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ga4JV9/szVDdjkZ43SYWlrewDuBoIpvwjFPyFW+tFfI=;
        b=qVNQQm0GUQ5u8CTkGTD/IPSkB7jy9RJIeHgHsb19J9rY20mRP6b3uCvxLdtPZPbtwF
         pppjwylbj6VzxNZ645Ftcw9AVfSL5aNEEtNrAkpEsPnWr+mu8MSeo/+PeXRo0c4ndPAv
         1it8A/tzkJ7gxLhoe3CIdQnJTdPChPE+3OOIx9pRAQ9lTD6zZaWZWdk3jpY8gmMexvSp
         cLgO1Pq8iXgaZ+uGf64sahdoXMUQ17ozYom9/CNC8Ig1hMv3EqTG9/zRJObRCTw2wM5c
         XcIWjQamSejC99RfxCeLTN3j5Wmq6c0yg+fA/H/mSJb94WIDKU9osCAa3/bgBAcmRNel
         ZWdg==
X-Forwarded-Encrypted: i=1; AJvYcCW2Spkq4pqXhUYKGvosJk4m/o2Vy7RLuJiXMxMjX7kf1tMQiR1uGp2XrCIESNxmrGthS0fXVrmS/KS7PnY2@vger.kernel.org
X-Gm-Message-State: AOJu0YxU9lGd8vAdQE38gLbavhVYKJiNGQukfx/Y21KcZt9nhVrNbL0k
	PKS9iHNfUYeYrsm0v8tGwsbx7DSQhbqnS8yI5Te2sJ4wvYqjgrkgbvg4Ik9JXT+36lxtu8CmfTy
	QENA6nTMhzhTomHN6QPDPoCbOwGTNY9A=
X-Gm-Gg: ATEYQzzEnYcNQGN4M4PLd/+1dOUFBUOIaH3kZcHqXiUp5HUAjY1zPhMzBOeb5NiXq+b
	sfeBdsUagJluYWHecGJzpT3EQ2iQYyAEtmrUWAB9TqXJLw9SY4V7e130g01N0ALxhCpqB8YjmJ8
	mPmPQ5WOn/kzJJKTRitKqLQ2zorLSKhwdAuT675Bg25V7Dw2b0/KDSGgvmKGoZRO2ykeo2fGybT
	B9DKwgtkLZ6OF90lnhfbBBBD9F+p6rQff+rHXEcTyloZiCm8xjQxAnYdfR5IuaqBCZcAzfo2rgD
	XZbBol0O31gtXwzevOq13TzooEV/brjOA3WGtK3bjw==
X-Received: by 2002:a17:907:d506:b0:b98:65e:8fb with SMTP id
 a640c23a62f3a-b99ae1f8cecmr68146766b.5.1774379385581; Tue, 24 Mar 2026
 12:09:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324145750.90719-1-amir73il@gmail.com> <CAOdxtTY0jsqrJVXH=eQzYcowEpkDxwrk1DMgg8QD4ojygWJQ_Q@mail.gmail.com>
In-Reply-To: <CAOdxtTY0jsqrJVXH=eQzYcowEpkDxwrk1DMgg8QD4ojygWJQ_Q@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 24 Mar 2026 20:09:33 +0100
X-Gm-Features: AQROBzAWKQvwMoV1EBx8nxLnWhG3imj_5RCL11KUWt-xZJuWrBziHsnhxgQh7j0
Message-ID: <CAOQ4uxhdpJ5+awnceRzRxmP-ot25_w0LogLYpncLJZXxQOj33Q@mail.gmail.com>
Subject: Re: [PATCH] ovl: make fsync after metadata copy-up opt-in mount option
To: Chenglong Tang <chenglongtang@google.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, Fei Lv <feilv@asrmicro.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 7:04=E2=80=AFPM Chenglong Tang <chenglongtang@googl=
e.com> wrote:
>
> Hi,
>
> Regarding the patch: because we are currently locked to the 6.12 LTS
> kernel, this patch doesn't apply cleanly to our tree (due to missing
> mainline dependencies like the str_on_off helper).

Hence:
Depends: 50e638beb67e0 ("ovl: Use str_on_off() helper in ovl_show_options()=
")
I added it for bots and humans that do backporting to 6.12.

It is not a "real" dependency. It is a weak dependency for clean apply
which works well for 6.12.y.

>
> Since we are actively tracking this for a Google COS customer
> escalation, do you have a rough timeline for when you expect this to
> be merged into mainline and subsequently picked up by the 6.12 stable
> queue?
>

It's queued on the ovl-fixes branch to be merged into linux-next
tonight.

If there are no rejects from bots or humans, I plan to send it to Linus
before the weekend.

> We will officially pull it into the COS tree as soon as it lands in
> linux-stable.
>
> Thanks again for the excellent support,

Your report was very informative and well prepared.
This helps :)

Thanks,
Amir.
