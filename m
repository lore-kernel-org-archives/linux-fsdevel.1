Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0960F270EC3
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849255; cv=none; b=PLVyMO1bgLmHYxZO0KD5z0hMYcxnCTDFzg98q69HM4KOpLPJcsOYjMxDNdFzdh+KkJxfu9xCaZTgApZGpjx+K5S1/I78BPl8IXYavf+pf4GSf9nR9/EyoFw2ObMOO0GRgWt/ExrLQ/PJG8Rj/AxDstKjsiEPBgQZ85Tgt5crsIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849255; c=relaxed/simple;
	bh=xgvD3lQsmqbWSc6Z+faarCZC8gFURf7pN19cTADdH3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dohNUWrRdoVNR0O3oDGkKJ69Mpv+tGfTtK2mhBomDo2m0xZXx416CiYR9N8Ic8j9qZgwYUm6ixSRjgq18TD8XyQal1pDTnirWuvrg0vcBJR+c1kfn+amfBLbGGryCbuPYcqYzMx5VyzJEJ4FI93l5b83oKlBYGhUe/XM5o60ovg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Quz7K+EK; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Quz7K+EK"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b97d5b790cbso296477666b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 08:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1773849250; x=1774454050; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tUxBVfEiZedfPTdhNB6oXQHVFfNRENYC/6ujYtjVGek=;
        b=Quz7K+EKFtRwYGxJ6J/TFGwnG6FlsHjCv1rMVU2/xzG/JeC/hRl86FCSerpVLJJNOj
         3XK+8ZSPU6IfqX+qIj0luSfpVtfeZsTYQmxYdgX69q+lqEceqRk3nZRijnQcZ0FrAaFs
         Gd6TnK0j5wOK7sbqSwRqy11Dzm4QgovKOK1nA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773849250; x=1774454050;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUxBVfEiZedfPTdhNB6oXQHVFfNRENYC/6ujYtjVGek=;
        b=dBn8ONgoxBhzg0CNU96NurqJItppr37A52LfAADyZg/LOz5EdM5e8uidrBe4ExjbU1
         pRpsrcJIrX+e0wCkQbuKNiPR+3tt/uuPIytWgn/Pho6XAhlk2a1jagTpCrXcO3rqYdek
         FIrQ3IoxCJHhQinDi6As7JSx2OFwmPrCe/rA2G1Hb0a5p12zR++lbSQfakZ2nMDxaCZc
         N6ffe+adL4Eetn07iLBcMjn6aJ7kOrsoNxlvhfAibNy/mgG8yD5MjJH0TC9kyj7ts5YM
         zrHUgH/JkhMg18nn6cTNKpgyiArDJkrJUoEgc62x1SLgAtGK4UKelRja8L/ELc9kR3Qe
         ugkA==
X-Forwarded-Encrypted: i=1; AJvYcCVVgX1VDD4rLz9TwazTbo0uAwCS8UQZYsiYgp/pEGB+8Y9M1YFm7B/VQh4fWwPZxIFZvmJTlUu1Ei9XBt2I@vger.kernel.org
X-Gm-Message-State: AOJu0YyfYytxG2jy3Hzw957SqknEEJt77hphzbtFjdc2RvUawIMkgP9Z
	ItjNnYVsRxxdq20lujMO0Gu9cozTxxwCeJfGcCcVXGjuvZGrK68n3URQFb9QRaTYvUI6CkeVv8p
	qTI3g/s8=
X-Gm-Gg: ATEYQzyI3BwpjqLPxlkrg35VB5ZTBvUKJETpUKZXgxJw6MmeGbUyHTZht4Pj/RlhJwD
	F2PsIZtaW8ipErW+ZMdD8wwKxQwE/TK7/SYJxcWJfoLAZbcKeN7YGCzLBUS1fEbZBLcMI8vHTAX
	L2Jkz0FUKpcXd2YM22/GbJJCe3eFh7RwbxTYnYJeo4m+pBuwx8Xyi2kskB2LeHPYG0kKRulW3gL
	zdUuRATRrntwFJyKudq07Cyy9py7DH6uieH6oG6rtQa1BdkkL92ou6J35+5s4pbcYUZHW9yGHl/
	eKXZK2KtZKMZlsZ5TXxBJ2PEeZ97QJ5lV7R3BVn6ho/72gSAtn34F+TIr0/o/m6XCq518yB0goM
	9pb7ZKVez/htS48mn1ssP2MR8btLaeJM+sZ6IR3NfcdtTnrLN/CNZICk3NyPTMLBcFBfDXphIg+
	Rf1b+8yi4jbaMo5dHkZW4SsIGlr7wmGyfbO0Jdti3KYvLr2Q9bgVFiUOmbXqlL7edDY1+x3ghz
X-Received: by 2002:a17:906:30cf:b0:b96:ecc3:783e with SMTP id a640c23a62f3a-b97f4913dbfmr195623766b.17.1773849249919;
        Wed, 18 Mar 2026 08:54:09 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f144e53bsm248185766b.25.2026.03.18.08.54.09
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 08:54:09 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b97ba4c2be2so436529966b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 08:54:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUViL8/UsvyVkPaVKoCOayuHfsyd8Sik+RU1HL540ULFGETOunBO0OY2Yxg0ib2WqOlZyJZxlUata7WfYQe@vger.kernel.org
X-Received: by 2002:a17:906:7145:b0:b93:5405:9260 with SMTP id
 a640c23a62f3a-b97f4a7e80bmr229542066b.30.1773849249180; Wed, 18 Mar 2026
 08:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23f19c88e763beb852a4891b2a908890bdd01b66.1773651096.git.chleroy@kernel.org>
 <CAHk-=whFS7D1M4=cMi9cR06Uoxr1QeM8HUtRB6V3cQth=QNoXg@mail.gmail.com>
 <e19d7d3f-d2f3-4bb0-be4d-af2679673f68@kernel.org> <CAHk-=wiJVSCmiQAQYYjdQqo9Z1k7WQcep2qW+DiqHyP7Y1_SnQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiJVSCmiQAQYYjdQqo9Z1k7WQcep2qW+DiqHyP7Y1_SnQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Mar 2026 08:53:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=widw8GwXNuq5ALr+NgDDUN+=pc77U=EczqUiVZeD2Dz+Q@mail.gmail.com>
X-Gm-Features: AaiRm539lD1lg7YT_R0JcN1Ew-djJg_3Rfcx7oosKSEdTx6Pe23SVEtBvqYcOks
Message-ID: <CAHk-=widw8GwXNuq5ALr+NgDDUN+=pc77U=EczqUiVZeD2Dz+Q@mail.gmail.com>
Subject: Re: [PATCH v3] fs: Replace user_access_{begin/end} by scoped user access
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Thomas Gleixner <tglx@linutronix.de>, David Laight <david.laight.linux@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Mar 2026 at 08:49, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>     #define dirent_size(dirent, len) offsetof(typeof(dirent), d_name[len])

That 'typeof(dirent)' needs to be 'typeof(*(dirent))' to be convenient.

It was correct in the patch I attached, but I'll just point it out anyway.

And we actually have a helper macro for that: struct_offset(). Which
wasn't what I used in that attached patch, but *should* have been.

IOW, the macro should look something like

    #define dirent_size(dirent, len) struct_offset(dirent, d_name[len])

instead. That looks fairly clean, no?

                Linus
