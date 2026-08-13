Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7824C47CA86
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629114; cv=pass; b=HF109h1hmmvnvX7l5hPvMDUZQE1JpBi8/XLTkJXnyTfi3s5eeqcLHcNlSR4hizTFjAEeYnkygwpiowhuw1COzUoUm0xhFbpxLb2xwrbretsd4WqNuojdZRG2vSE36B2XmcMwUr9tCTInaHyXBsOa5+ffEFIzjzzEyypisth1uPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629114; c=relaxed/simple;
	bh=i/TpxUYDdMY4Q9xfy8YfqP8QfSVp9kiSqoVc/8L35II=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bnwh7OWfZXZpX9R5RMEXi3OVE+hIap/m6gMpJn8J7W3RhmSxJb9Wp9hOjuUnEGDiR1pIQ0UB1aQSh1LGK/oNr26cJttfI4sWxlBnP0JMUb8E5ImiEUB5jaNJIHae2X00bVguTRl7N9HikVBHuBzf6+CcLO6jTVsZnmfXlxedShs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=HnsvWqYJ; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="HnsvWqYJ"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca7c1176317so617497a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 06:51:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786629111; cv=none;
        d=google.com; s=arc-20260327;
        b=Gil2Owe0w3q7dgZrVhiRVwXNn8pmzsq4RiDVtI2hLSU4h4WrQsyiH0Cmp7Op7R2ucp
         xwjJEUp09+dXuUH/+HvY5qiGfEudqhyk02YU1Tm3azJtqa9hwHfBw91n7sLWyFvBcH1r
         8qLtYrgKAIrg7ah0iAugmjSdYKheTr1o838gXvuY7Q/3EvMORsqDtcnJaYa+YxPxBYYa
         Bg8LF0VmM8BYheYuy2uecvWS85Sg03fV8rfAePdHZ68/1qXnCzHBm42V4uJug64dv3sr
         BfH9ZClph/RZyVlYttbmyzGK8mrtYeFvo7v69q60oeZ/CiCuZXIpS7KOc24yFH/46LqO
         2ZOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=i/TpxUYDdMY4Q9xfy8YfqP8QfSVp9kiSqoVc/8L35II=;
        fh=wVnlg+peIAOa39g3zgWge6MtEnX3axs57jz/SjoAJY8=;
        b=k17PfU2uLh/MV4wQ6X3+55F54nIQ7tE+7wD/LpWaK0KvnjII1eI+NIvSID+9SHgTrH
         bb2zgCkBclO9WpAQhbIyT3JXSoygw6lv1Xmhrsf9eYUVMidAY2+RI/6PbKEJvygtajGJ
         v8ueTYqPWvCmo2o4/GJL7ROp8KUc2bIsoJYTSNxVFr3Wnxsv7kxHwx1bpFyUi1/PNU9g
         Hx4I493jH+GMONm+Th0fDINbvEse/G8dEPH2eoCCHrhYsfl3k4G1U322956se2oyyMeP
         TF/MEIk5WL7uN+Py5ZHqxpS6omJmVGy0PX0kWJEfEFB2ViBBefMoTGy0vlEOsu2lRrGy
         zNhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1786629111; x=1787233911; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i/TpxUYDdMY4Q9xfy8YfqP8QfSVp9kiSqoVc/8L35II=;
        b=HnsvWqYJUctfTpj9sDHRkkHAEvS+S49OdB4syGYsncmHFRkwJwrwoeVQywvXKZKht1
         rRdcAJXpby+BO5+z76iPsA+0Cc4TKf9fzRfC8twzIoj7AXNpN3GYB4W5M7tBfDcht05w
         80yGgbKIOdxE5Ymc43JLKuDcql4p10sHmfGaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786629111; x=1787233911;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=i/TpxUYDdMY4Q9xfy8YfqP8QfSVp9kiSqoVc/8L35II=;
        b=JcQJ4QORPnUZVN+rNRmNc7yszzKwrvsz5YqYIY9l/1Omi4C6xq/hAHoxiF74FOC/vE
         xdE+CmyPr0HxrrowqGDW4hvqTV/JKek7eTMal77F4T2bfgzAjZgBeMKFsAS5csWzgAnl
         dpHGwvIJJj2Ew29SsOKddevZO6pTeXAgxTN3JU/l2pi5YeBfGWN3J8lyiOpectFQZNPc
         GJr2NDEto+lxmHRW3fAjQc2XEFe/pq92kTfUVd0UqqAAAvocQhF7vEwKVb6BQJlSdo3d
         Dg/HA3UaJcrsQDVjfHjFqaRLEGUjAeRbmHAB3H2Zk4KMsP4yOE419Rm8O8iXwCikGXrp
         6q8Q==
X-Forwarded-Encrypted: i=1; AHgh+RppdKXpm35sQiSuBCmhcmG9QE+/vJM+sKuOoJqzqBIUTFNJdtEOniPySOv/bBRivPzG6pTnVVY8vhN72R3q@vger.kernel.org
X-Gm-Message-State: AOJu0YyBLu0hmVRXMU2D2hZLv9+hOxxgQhVvxGNcXVRmbXw7yfgLX5hr
	UJJshn4J79q2/479WVq4Ofs6FIAn0gAFUAURLodEbqXbNoM6jVd0V5+UktMW/Bt4VwJo637DMLE
	0D4UQR6sXCWKkAnzhPIs5zi4oF39KQVHwG+0sn0Mo0g==
X-Gm-Gg: AR+sD12yPMAwAdcW53q4savUkCpVgn9KNfOxmedm5dvNczOHBDnC/+8AeQXOJosBWgS
	uD7NHF6iowgHWbJ7gEDVWniQCRI7luIQQj5+eU+tvm6YKPoIKVYeKBpLOFocaoYBPSmVgNt1idp
	YmodDHcjvvW/NJtGSGbzraYnipvM0Hn5uTN7MwzQ06AhupTOKO/8vW7Mlr/vRGSUz/a7+U5x6lo
	bmYHW1TKadoGB2fb2hylqgKrgC1YZrO3kC4ZUrYPsD2nL31Qvv0peFQGbJCuwAaal6129nyjla9
	f1wgVdRSJWDyGcAHaTjdLG8Lm2TR294Q58MCztM/GX3gwtwityJ+lT2uvbsvhctzzcmolRU50A=
	=
X-Received: by 2002:a05:6a21:62c7:b0:3c1:85d:fa2f with SMTP id
 adf61e73a8af0-3cc554d4f6dmr8080310637.36.1786629110629; Thu, 13 Aug 2026
 06:51:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813063401.1786548-1-thehajime@gmail.com> <20260813063401.1786548-4-thehajime@gmail.com>
 <2026081355-remold-sterility-84f9@gregkh> <CAFr9PX=zC8GnxwrR=wTwA4xQq89cHYpxZWooS+-=Q-WuNbjanQ@mail.gmail.com>
 <an3COKVbgQKdY52d@lucifer>
In-Reply-To: <an3COKVbgQKdY52d@lucifer>
From: Daniel Palmer <daniel@thingy.jp>
Date: Thu, 13 Aug 2026 22:51:39 +0900
X-Gm-Features: AUfX_mzxGDAqX_BvwA0fMZR4ykuQ8TryBISoFdwPrCVEwtYNSaZSFJLhnRKlb64
Message-ID: <CAFr9PX=dkFhD5Q7JWaR+rXt_Ah5n2hxi2W3biqQsUC77dAaZgQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/6] mm: nommu: fix an issue on map request to /dev/zero
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hajime Tazaki <thehajime@gmail.com>, linux-mm@kvack.org, 
	geert@linux-m68k.org, Arnd Bergmann <arnd@arndb.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

HI Lorenzo,

On Thu, 13 Aug 2026 at 22:30, Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> > One of the big problems for nommu seems to be that everyone is
> > convinced it is completely unused and totally broken. :)
>
> No, the issue is that nobody seems to do any testing or contribute any code
> aside from at least Hajime (thanks Haijme :), and possibly others (forgive me if
> I am missing people's names here!)

> There's been situtions where nommu has been broken for a year and _nobody
> noticed_.
>
> And yet whenever nommu comes up people always seem to pop up and say how
> important it is, then mention a talk etc.

It also broke sometime around LPC 2025, I spotted it, reported it..
and told the people in the room at LPC for the nommu talk that it was
borken and maybe they should take a look. :)
I think I maybe even told Tazaki-san in person that it was currently
broken in the hall outside of the session.

> Well if it's important, test it. Test the tip kernel. Report bugs. Contribute
> code. Any or all of it :)

I rebase my 68000 tree on mainline regularly and make sure it still
works. That's how I noticed and reported the above bug.
I have a bunch of stuff that claude fable found, validated with QEMU
and then I checked on real hardware but I'm not sure how to send that
without it getting instantly marked as slop. :(

Cheers,

Daniel
