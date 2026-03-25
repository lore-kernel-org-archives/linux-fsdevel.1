Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6901F20D4FF
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 03:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774409691; cv=pass; b=NoNhD4pT9yzyqenIh+Q/I+86ViIORJurT2YQVoNs6JYqpi2t5FOK67E4fD8GqebQnt0dARfrld65Vx3ebVLLdz+BIHM1ELgqxQ5YbM5YqqxmQ8E1+CmWX9yk+hOTA4dMaiDj8ZwATajzSVuDwfBEoNsucNYtD3mCHFGNdiQH/3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774409691; c=relaxed/simple;
	bh=rDwnVq8YQqgIdrpG6SRPSDA4A9rN+CNsQ5l7v2A2z+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=DOrwYjACYxDyIMLSk6SJcmPCc55s1twBJcmnSwbYxK8cLAQ/sP2uobG32oau/OdLUiPXDl7JeivUT1sP+YiuZimUJjZ2JHrEpWLejNPRF8Nb5F08+32OI7+9Ac74JhURV7Dy4KY/wWSzXU6A+qdjrtDxRLjeJHUBqTKMU6qng6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=En4qOb9h; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="En4qOb9h"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a12c310e8aso4792663e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 20:34:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774409688; cv=none;
        d=google.com; s=arc-20240605;
        b=JUL7hmJPwl/RN04SAeRmRc/e2KTjhjIGMwxt4yE2beHSkdxUrzn1gJobzlb1X5aq+H
         kY69RF5LOAZEKI6MJ8+f51fg3FBWgPJscURpwlzgmqdi7+dWq0jPoeNnX1Af4TRkh+Ms
         jfbo7by5y1atC7idei03+vbNanTAulhn/idbS57wx06bSPzOY/GeP4JywmuPOTwkPcQg
         lPfnOaSeov3U8wv9RUioshr5s5IW8zAlWWKT4lNKUBYx/idJxlImUTaIfuNnekvSKYM5
         OktebbQpVI0yuyqeKmn1pBg3AObyjz/iPmoPqS11XlS16oUKLJb5azdw05v3qoiogfnd
         i+lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rDwnVq8YQqgIdrpG6SRPSDA4A9rN+CNsQ5l7v2A2z+Q=;
        fh=on5so1iZ1tYm751VXv8x5u+l+XerJy9A4qWb/XOx/D0=;
        b=b/o0gzNlhdr5HWq8tKWPIgaNW1SudsN7P11S6d/Xs92B5GDYZfiKvqgI2y2scy4SWk
         UIQXkNc/kICnubc+MRdQaFP2KuPJB0imhLm2N8RCceqjUW/FKkJcEDc5EHkBWeZCVH9x
         42alWHq3Q2jqsBuzPNz9qhAIHQmdxMb/RaFQuViuozAKcxTKXK/kU4FLHtnfZQ+px/ak
         eUD1T/vtUWLKqm6aDr6Hi4bfJeO1WeYhKdw4shcXsGdd6vo5u+ekmF64YTaeDypU2v1G
         9lVQSuyQH6CFsjYeyRKWiaUCX0OSi4VfPMLsl0Nxd16mbGuWR6Wx1CB+oKIUz04oJnJg
         LhQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774409688; x=1775014488; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDwnVq8YQqgIdrpG6SRPSDA4A9rN+CNsQ5l7v2A2z+Q=;
        b=En4qOb9h4Q3CUl+GcUXG2OqSYf9+7Z6d+B5Z8uOCczYFu9dvDUmfeKb8J3mV4neoEW
         mkMK3EmWf3IHWbwjjsMCf0/tM5dxnW8wPo/wEPwVWeYTdw8GK6guAEXeAYtFLigEMU1T
         bUxb0KlhnJP2a5tqlD0+hby308Ik2Sk6QLjhyAlrSioWngayhnLXCkPR6W8N0Xd1iGMX
         GyMkdX1PXYw2sM8tbEiJLUu7mW/NbN2mInJkYXRKxof/Y+94Mc0ESFfS4uKiXFG1ng0N
         RMXytTfbejzw586nA5T0m6spB3o7+WROABj2RciZv93XcRCMY2KE2H5U/CNAvYLBxDJY
         q3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774409688; x=1775014488;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rDwnVq8YQqgIdrpG6SRPSDA4A9rN+CNsQ5l7v2A2z+Q=;
        b=F1ILvXIBGV2LMkOx6qVX8bJYnTZY+rb7x7ijAbt5ZboTrY1rZm2PLrJUiDdoF5yuG/
         ulZRIU3jJsKJzEKAanZ3Rq9vcXd0c/C3ePc5gHp4McsFdVK/7IXMj60qzJ6CzpLFRnN0
         tISG61tgrhMSSKrrUhxu/zNmkqRAUencxx9L9dXCR76M9+eKmLhBAdacDsgPDrumHo+l
         aSr26Pwmss3QiYudZNfQfmF/WWgAPpmBJDvqGkv0Q4pt8wPlMOOAEb6t3d0yR+qYc23J
         6PpMVtyDJOQ0y9l9t5dS0+/MowSIIZW+aLQRrp0ioLx6UIqSt0zrr87SgbvV2GnVZUUi
         36jQ==
X-Gm-Message-State: AOJu0YznLrnz/sZVh9QmMUSheuU1rMeuqkkDjPXzND7vyQUClaCKglXp
	YzLHn9nKgQrPP5qMUioRmSH1qNW1MnnIziDH8BRQDaH+VLv7J3opDdS4uQSvlhaw5CH+iqP3naT
	97RXW/nC9MeywQV8uvsMa8/U2VEvDjQUlLg==
X-Gm-Gg: ATEYQzxXe50lHeRvtZmsnZL12GA0dAGk1FMar3gILg/MP+lDKLsOjGe8KwfY9GAeVTi
	0rZcMiJ/W+elPCt1FNMeK/DFo2SEaHPMIhvN3GDpr1YwoaJ6+tMm8XJPgE87NuDARRsd7HuoVXn
	UoajxOMzbiI8G87Iq6JwgJc8Wd1KprFYLynbdHNvfq+OA4TxO3rPlGgyrvOwdln2+BqERj+/VUk
	7C4zCX8LbwFiv6GL8LyWDCHEnDDCNEyvbaHNJogY7NaBnzfWjbt2WIknXdtXA8YRJJY+KkGD4TE
	xx7p
X-Received: by 2002:a05:6512:10d1:b0:5a0:f95a:1602 with SMTP id
 2adb3069b0e04-5a29b9852e1mr708821e87.17.1774409688215; Tue, 24 Mar 2026
 20:34:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOx6djOWbr=uhxXrwc+Z8L0SvKWRDD8RSWOj2-FXwGEfdkiN2g@mail.gmail.com>
In-Reply-To: <CAOx6djOWbr=uhxXrwc+Z8L0SvKWRDD8RSWOj2-FXwGEfdkiN2g@mail.gmail.com>
From: Sean Smith <defendthedisabled@gmail.com>
Date: Tue, 24 Mar 2026 22:34:37 -0500
X-Gm-Features: AQROBzC-dYfjnu1FYIn32Spui1JwVlU9oZkTq-P5pEI-yHwkquIErwI8ECzF-2A
Message-ID: <CAOx6djPeKDjmJCdDH387AYPCFT4=sxi7q6M7Y0=s84rtgYhAow@mail.gmail.com>
Subject: Re: subscribe
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

newbie mistake. Please delete thread.

On Tue, Mar 24, 2026 at 10:28=E2=80=AFPM Sean Smith <defendthedisabled@gmai=
l.com> wrote:
>
> Sincerely,
> Sean Smith
> DefendTheDisabled.org
