Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5613947A4
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787936243; cv=none; b=SEon40KGwYLFY1zBljaJjdpp/M0P2lclJ8hiSaOU8go7W5jt4DtW/A6RNM/2JJs0vDnsMXTt9nlGCTjE6u7NcMhsRKHzSsWNYSJIaKbYA2Gh5B58cg3v1J7WRsZjCruaG9+7ATd+5X6+2i97xWa9qEyzhTj2wWGxRWQ/wH8ajTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787936243; c=relaxed/simple;
	bh=fF1N3e8fDmDlaR1Qwut9sEeRm4wTOJlhz9arcSQW7ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIVpOwZUJJjD/eaWxHWouPWjR5v2ZcGMwkWxXOIlYHMaqIRgtDk59cqS8RgLUnYLfilri/NrkkmlRENMQlw4nvvo/7vBQ5auD0MsEXOdVbTz+WkJi0K8B2cxS1PbTJ5/M0U2QjIdZqRtEG1BHM/UfbAPyyh2fp9coXwVQ/qQlIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Lg1Zbz2j; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Lg1Zbz2j"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a6165b4402so1158269a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 09:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1787936237; x=1788541037; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fqWP1cvvzzLBgenvSOHjdbQzbLJm8dhm2YNn3syViIg=;
        b=Lg1Zbz2jw7M1yP3H6AZbxdgs8qVDIgVqBqRqxl5Fsm9Zm95ckEEu/IsGeB027Q4L5e
         MQj+soNeQZseChBCei0uRDYEgZBhzZDcfhV/cUJKku3R26dk+DIhMUhdT42Lf+JRnLGd
         Y5lK5ajIGHuAcDvr84AihbLoxEsGKgO71R3EY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787936237; x=1788541037;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fqWP1cvvzzLBgenvSOHjdbQzbLJm8dhm2YNn3syViIg=;
        b=Wu3Ndvs4E6uLH6b9Kzlq9FKitUzobLyk0dziqQ0Ab15p8hBrqIsbGAE9PIiTaEaoi2
         wcF0XqPq9YKz9oz6/aozuhHHXG2Xu43lWj5F47CzBnAs5SXAFsAq8foQVVetgmJep/bR
         yON+otByMjm1KkFlcA7QbyeZa6OwQRf9cQH5SMnZ2PkAWo3oUpCtrNNki2i17WU0n2yN
         d21SSfapVhNIa+XXPTL7GRN1xyml1vEfSSEg2Py7EdDu2vx/iYUMyk/LiFBmjxD3SQa6
         L+grY6t06x5S/VxvC+gfYY12kD1qQAeSCI460hXRvU3jtRWY7ey5iBJoXlPjQ7+1oymk
         VWPg==
X-Forwarded-Encrypted: i=1; AHgh+Rqa3sOOvs0iH3uZsIT1qKPS7vIdCpKbd09RITuDKI+WZBnR6uukW8Qn2T6JI0GjDmFMHQAczWAPUQC5ZWQH@vger.kernel.org
X-Gm-Message-State: AFuF++l7v7MrDS2bgpbK0TVKxYsfM0BskBl7gl3B77gTB8LKOT4dRARH
	AvrZItBHqE/hgnDYHgovkwVENZI1DZJq4lbvrqoCqb8x+l/NnmveHkDCSyM+zS2gfeUBho/RUAR
	QTNAsdko=
X-Gm-Gg: AR+sD13xEMTgUquvEq06h4z37tmgLWb0u80zcnskXovfMvSH62TPBwThV0BuW40tEHS
	RFcl9HekuGNsM7kIIuWN6AmshHuBBN9AfaFXZ/8wD+R4rJxbU1TW7BhQg4/4GlPyXWpUGMVm+v3
	0FwObvkx1gmVkST3bjeccad2JNJibSABLChKCtXv9DerTybte78j8TG8v9VwAlhJcaCgqQEQAcR
	t2YPVprKJzpM2ohshQtSQRVpbIZEZn0znUVO/84Dn425s4ViJsVlUuerwEnVVf+/U+c8ByFbKdi
	2c1CrAZPlQi1Ze0n0LO2LwN2/nmJ3fh2Fm6hOb3h1Syzj667neJSc2i5TRbMsFR4rQpT23/s386
	CT1p3qeALV9YWeeuGGQrzwXQ2aGSpwzAqFtxEWBscCPMEIOSmAFdRllSuatJhP9LMT4Bpvv2bwE
	EY4quxkJXUVvPzucwWvXiszVeLdseTlh//xdXq+DMDn5gGQNKrawdeZQNCDCdzD/57XqckrZuma
	125A9vE69S9WWjWZSnaDBWFJOBlF57Ft/EQ8w==
X-Received: by 2002:a05:6402:455a:b0:6a6:cd4:5f7c with SMTP id 4fb4d7f45d1cf-6a60d3d5f42mr4534324a12.15.1787936236759;
        Fri, 28 Aug 2026 09:57:16 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a611b5c5bdsm676439a12.2.2026.08.28.09.57.16
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 09:57:16 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a6165b4402so1158219a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 09:57:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrF4yU0rkS946lvC4MFCUlYOZL5njGu0UV0I9lyAQZTRoEeIlZfchcaKHJZ91qwqPrbJix1t2QmLNkdwCJa@vger.kernel.org
X-Received: by 2002:a05:6402:24c9:b0:6a3:714e:f5b4 with SMTP id
 4fb4d7f45d1cf-6a60d3a5f5cmr4955636a12.9.1787936235799; Fri, 28 Aug 2026
 09:57:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <apG8g-5krNRUFUuD@casper.infradead.org>
In-Reply-To: <apG8g-5krNRUFUuD@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 28 Aug 2026 09:56:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiY22BnQkAMMc8-h6xaRksvVAbASpg=pj+=kVaXXQYo6w@mail.gmail.com>
X-Gm-Features: AcwNN1WR0kJ5fa4772K72bkb1NaLJxumbwJKKrqGtowAymofDWBsxumI0FifkBg
Message-ID: <CAHk-=wiY22BnQkAMMc8-h6xaRksvVAbASpg=pj+=kVaXXQYo6w@mail.gmail.com>
Subject: Re: [GIT PULL] Remove dependencies on pagemap.h
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Aug 2026 at 09:51, Matthew Wilcox <willy@infradead.org> wrote:
>
> My apologies for not sending you a signed tag.

I'm not pulling non-signed stuff.

And it's way too late in the merge window to try to fix this. Make a
new key, and we can do this next time around.

                 Linus
