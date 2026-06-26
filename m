Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735FB3E2AAF
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782487882; cv=pass; b=K4eYQVFpuAAfUyLzaq/EPCbzsZgn7RYeuKKrmzD/pvnwGTURGDA9Cx2Vb+ESSsMsuEIZLuy5UBgFhXHrNK4AFQ+2EonSii4ia3+2UJXADGkXEz0MvtHbFEVAzJ4hcyHGIS1tAOtMYXhu6OLR1TD4v+UuPYPGUsSbMcF4HmR7XWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782487882; c=relaxed/simple;
	bh=wqSHr1EWMYBXrlSAKcagfIVqRtNYI8IHYjPj6F5FHLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=REDvz0oy9rZRcxvVn83Bwr6vStDWgDBhblmeSXK9+/gadYwoLK1NWCp+ShB5WIfW4ymJIwIEpDE0cnRZwK2KmYCuUOkjFMQRDwkhxfsBSyIBpC3WdEQg8vSJd8C0cxr/xUqN1yafxHIxLEsKT9NlMwUKPm6G6X2cfWXQrU4CWMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WwfMYccq; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WwfMYccq"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c81d799ef2so3743185ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 08:31:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782487878; cv=none;
        d=google.com; s=arc-20260327;
        b=fXWQvi0FqiMknoxSndTkOFgBncplBiZFEpXQW7hTqFyvm3vLOMuLjpafZsm+93MQvE
         gUA+9+J+YqpSx/KdUG1t59NaUryo4AwbV911kSIhaucJLG39tcvt9qWiVe2l2sPazs2R
         rVSRSA4Jvli2eOQT9AHhzOMYqf/kFZSXawqmSBoDlj+Xv/so6D0gitsust0i/XPfOfEO
         4eNIqqQpqEh8mJwm2+1Pyw1xvBD7ho6V5Vyt/tHfpgkvW25KUxK/pEr92sW4iFNUsZm8
         6HDjYELzO6akuqS5QBdbsQam16Sx53v4S+ShyuSTGBRw1qVUtHP7HZ574+H5xDNdz2u6
         sGDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M3UX0w5EKmMEqjBcGu53wO3BCmqVyWzVn/8cvHr+BeY=;
        fh=zwIByXtYwzZb5N7+B6tZrzj9LGaWwiTY/Fr66Ki3lQw=;
        b=aSkhLqLsNfiw2iRGtrCsXdltjmLO1lODVMDOhoJUAC5fcMIJ37YGyGpfzZB25031PH
         yZILMk/eVvZYUBxKrooRcJNm5dSKABohgCHSYMgFtPtRXVGdtCKwgUQzFlHazJtUbpt1
         YNtBMgOsOPPXvDa2SSLneOWNwuLYD3i8U8Sz9vQ2RU0JaLUGMq2yeeY5EEUYcafUeESo
         9d60KO8SoWH0so5JRY11HjALFhtPO56z69NxzkXPxZrTW+shml7yXRyuO+X8gXRLZUtU
         jUnUyZnTqyjiLKUtk6u5P6eQltWcOfF95viSWjd1N6UCHu0eX0WH8vRhrKlVdRWgi8ST
         P5VQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782487878; x=1783092678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3UX0w5EKmMEqjBcGu53wO3BCmqVyWzVn/8cvHr+BeY=;
        b=WwfMYccqsBUm52y+juQmzKEuofwm83E6WcDoFZNUzyJe0gmz4JB7GEVKXZw041gsMV
         uc8FpKgARxiBJaydTkAoB7nahiyicI6V/fSCwGPhcuWYVWXEWURzLc/vkASlYt+73GHA
         suEC6Lhnvm2rtiTG3Hrtg3RrTR+wwTxasPIxIciVuUcAi839yxU0NG5TrTTjLklazc5T
         AJZ0Wnz2y6Zh/h00p/GmVmCW35Wz/C/sJoidyWn8qM/Ty86vGK5zfcGv1uIE6dSlaxkY
         k/H6FRuNTpIFkz3h0OmTD2O7aJ87rQBiQMZ/SauMUpkQ9zyhHaWCOTDNCWJEQ7BR7Tly
         K86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782487878; x=1783092678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M3UX0w5EKmMEqjBcGu53wO3BCmqVyWzVn/8cvHr+BeY=;
        b=KJVBviDsXg8SmVQ9RLj/gKUscTKIgduHAEum4IGcwQcNdHIkaNl3q/KlW7AglSU+Ly
         zPyPdDMZgIGVoHBoR68yf3he9QBK4J4BR9c2O6Ew0vjBRRlpwTXnYK3NIT1FGmP60dyh
         H9et+3QdbK73JbYB0GOdKevX7RiOa6DI/LrNdvklkZ+qnVPB9ofr6uyVxABUKo7Drt43
         TWS2+z43yymJmopDpbF6qRuukZ7izM22Jw+uREdyF3QSv0EHCdJvyNGIa/vKwvSoFRst
         BPHBx8E1WrrkWzMPHK5fbc5CvNPI1LGvvC2ahXeBnQmAwTquJjTvCMW8N5cbxoZ4IeGV
         PSpw==
X-Gm-Message-State: AOJu0YzLZAUORNh8n3aja1GC8BHCYNNajWiWlJketUZJNsaq5MPeBf/y
	MP38s/eu956SFB1LEKHgceBDAawyioEQ54wrqsUfdHk1H+X8oLZVNiAtIqChPt9SMTo0in9ojee
	xPkjRFUBEQpARvaEd+utIvQYjJ0KNg6Hz5L7ELQDT
X-Gm-Gg: AfdE7ckGJ07ppCT8vRAuJP/XICLdJcL5t1gJwiGSuraUS9xqWoCYabCqnAT1+oXD8tU
	LIRHsDLss5Qu/QSN/yGXsRn4bOLs0RtWBjYwu483/2T52R1Ilyt5YUbHzz0GxTcacl8jqpNgOkG
	Bo5Sx6G3c3zBfA5YwoOXpbdJWnaIstAWraupl9ehZgjaUYAuVRCimgNcEWDvfgCGcwyovh2NTsg
	Vk7/PuZdI6AlJ/Vi9NUTLK/MSJayHCIqzBKXhxDQPD5yuKLvJUl8/Bbt8QDilhDb0hKcXXK
X-Received: by 2002:a17:903:19eb:b0:2c2:62ee:5a0d with SMTP id
 d9443c01a7336-2c7fc74ed9bmr77478525ad.14.1782487878522; Fri, 26 Jun 2026
 08:31:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626114533.102138-1-cem@kernel.org> <20260626114533.102138-2-cem@kernel.org>
In-Reply-To: <20260626114533.102138-2-cem@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 26 Jun 2026 11:31:06 -0400
X-Gm-Features: AVVi8CcEZMeN8u2CIiqk4TLj89kobhoxWYGuWAl5i77ATSryI4gp2OXB1rc_eGY
Message-ID: <CAHC9VhQNURc=d4AOVDF-z29fjLasCiLf120Y-N3txEBccpkfSA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] capabily: Add new capable_noaudit
To: cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, jack@suze.cz, djwong@kernel.org, hch@lst.de, 
	serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 7:49=E2=80=AFAM <cem@kernel.org> wrote:
>
> From: Carlos Maiolino <cem@kernel.org>
>
> In some situations (quota enforcement bypass in this case) we'd like to
> check for a specific capability without triggering spurious audit
> messages from security modules like selinux.
>
> Add a new helper so we don't need to use ns_capable_noaudit() directly.
>
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> ---
>  include/linux/capability.h |  5 +++++
>  kernel/capability.c        | 17 +++++++++++++++++
>  2 files changed, 22 insertions(+)

This is Serge's call, not mine, but FWIW, I somewhat prefer to see
code use the ns_capable_XXX() variants directly as I like to think it
means some thought went into ensuring the capability check is being
done in the right namespace.  Yes, we all know that capable() just
uses the init namespace, but I like to think that having to type that
out in the parameter list might be a good double check ;)

--=20
paul-moore.com
