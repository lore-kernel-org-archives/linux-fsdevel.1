Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E17D3559E1
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782754283; cv=pass; b=aUY0qkvemZ8wI3ia8z7LHyUimDIJqG26qgy0RN/+PBRg5dB7cDFxuQktya2w47Z7SuRQc5yFs2XjFohHnDh37fM4690uVmJaWo44ie06pdZP8pV2wf0kCoE7GOgD09bjBJfE9wukBxHFHakFUfhBwYHbEXodWFOPq3/4PkCcK6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782754283; c=relaxed/simple;
	bh=eOClBfv6lfdCI5t+K8NOrbjIYwBgmecurDoITjBEbHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRfUegwvW/USS2VWOwqlTkbVx7mmOEzDY9k7CTLGpZC4f4NJWae6KchMvsVHuxRpPC8FCzG5N8Ug6DXF5hRyMlw3YQnA0ItLaerHpD8xbrq11kW/mUjvYhltGL6oUdrchlJi8m+JIXnJUEJmmUwwT7ZjXmARCSUEXUv3LRM/Q+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOB0tbQz; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOB0tbQz"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-693c69b97e7so6905808a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 10:31:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782754281; cv=none;
        d=google.com; s=arc-20260327;
        b=ODbhr6f4ySIicjkmWYJzLK0ufte4a+mL0F2qN08bpMAG7DSLNWDNzReDd3n54ApNru
         4gF3oXQOclMO8eGPhOhy//RhjVnbPCfgBsOUKqXKpV4yiskyWq5NnIuTKCuoEw1Mde4v
         qXqUHxfV7R2HGtlXF6ktngu/zwqkcHRBXhZdWd8lGifUL5ZxccKJDoDzmkoICyt+FBTd
         73VfHz6ELBGY/BtXijTrzx68swa3tN/iX1t67bGPqwZOYG+caeSslBr/4zpG3WbMke8L
         kL9MwZY+Rfd7v5GQVf79IiTIrJvHDhPlgEFcNnJSIUe7x5qSAozt/VkH+3e5xTH1gewE
         sQ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eOClBfv6lfdCI5t+K8NOrbjIYwBgmecurDoITjBEbHY=;
        fh=+QFwzdkWFX6KoDDPJjjcEftaBDrFQRzNpuOkhD4mLus=;
        b=dLGz5huCLH8+EGO+Fnj4E+KokJWfLgfOtcDFT5waKaCyS2DZHHX/DExOEPK6bYF88a
         mGSBLHVBw+SbRTEaRBdnIMst0T5xK016Exm9XW6MfDtxJEgKxRSh7CzHDNsDexgu2zY5
         yeOS1vYWIN0qYAEhavrXbNTVcYQHZD4FJAz1D0jlISV5JMuvlwv3sw2T9CHmPw5WdXL5
         w5jThPZcnHDHpi+Bn/5C8vNbsGhi/aa6ccU27lMHN6t0hjkHI38nbcoGuz3VP4As7qer
         ajqFUghdVY1raIYn9fiVH1ewEeoOqNTkbRX1z9FRYY0ALGkK9/Rz2bn0n4DJjML+iXml
         QqYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782754281; x=1783359081; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eOClBfv6lfdCI5t+K8NOrbjIYwBgmecurDoITjBEbHY=;
        b=VOB0tbQzXHx225/eBRLGEzWz6vX02N24U92aDSCNpfdq7DZv9iI6NGkOHF5VJSXBf0
         iZEHeZ0V5mC0F3hIMX5sla7sCwE6QUNe99CfMZz+3kF02NmreX29GtPeIhhn9/tvERdq
         6rIHJEfwGNs7g3Qtc2MU325nY7nvEWm2h/9qTqpSpa6S67zweReqCilX7ZHuwu06Afw2
         Tp0haJ2b/3LKr4BGQqiyRCz5NDX62Jd6SCIPaTHgyHwtVcs9J/8SW3WLPHp/mOLeDDnB
         HbauBnc7gNry89jY+RZ4nsQ9ECd+RxPZvUBef39i/RgCTiFo8PTy4LyUjrjbVd51dDKN
         dcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782754281; x=1783359081;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eOClBfv6lfdCI5t+K8NOrbjIYwBgmecurDoITjBEbHY=;
        b=Rgy/Eqig2bGjoFXSb5AfT3EeMLb9XkG46TUJHaq1QL/ZD6goiwRrDbuSIvCQJYw9/h
         0q4ANnuE/NHRlUGe5R68MiRBL0/xw1k+TA/3vZW8N0aFoKVI/UMaxGbxFbqKnE+heL8r
         BJO+4sTec1/4hQcA6sHeOOrL0hYqjONtHVjY48/df86DD9sCVUCsbqQbXcXiDVVTx352
         bfakNh9jVNuaC29qcmYh/MSFDGwkl1l8lCyZXqh8T+zgrD7K+rvNiKntDwEvNgwf23eZ
         LleSgvmi8t9skC2mKDlgDE8DCjsq01d88wgyOVrhbVwcHhCvmCsNd3D2J2ulRt3+9ePL
         9/vQ==
X-Forwarded-Encrypted: i=1; AHgh+RrjfCL3NtjRBQh5D6G5COHm7Lail8BvxVUN7ybYGVaRtefOyhyp6B8EfjK5FuOaC24Fg6Gjmu8tEn7jlJAz@vger.kernel.org
X-Gm-Message-State: AOJu0YzK72RJq9Y70VYRVlGXkeJMGNHK/VsTduykb8C3kpB6yNEx1VDA
	Tc+xvW2VqCpl4z4isEXHP9v3vGh8lQksQ43pjUVFoNRb3z5O7jnw/qDhjiJeTsVDaHCWrVdJ3wl
	00DX0DSGoGLczsBQvrv3GtIKx7juAWOU=
X-Gm-Gg: AfdE7ckb1tjTNonNSErlgW7lmhP+tm+pFZEvRh9Nu1cgZwgEl1Q3GECha/AYjSA0P8L
	BDQn3LsRZJBlDoYeiQr8Z+XTocbOVwCL/VZR5IhdtSPTz2vT6hYg88L491iKK+XVoL5Gz0tx1j1
	UAffmm+kNUTJ/5WiN4K4OK068GXM8x60S1e9qQup+sPO7/SjN21mj4Pkij/TKGO7ff6rI5tv1K2
	6IMeXt1v1xMQzI5bOaviLrvMiRQaKupXYECUBfKYi1O3GVgQqkyABlCRFjdqL9/UNwz8HwC+RF8
	fLH9xOdwr/nDX0aWQ3U+87MYnw0BEPI=
X-Received: by 2002:a05:6402:390a:b0:68f:cc95:8c10 with SMTP id
 4fb4d7f45d1cf-69879e4b974mr46982a12.27.1782754280332; Mon, 29 Jun 2026
 10:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629070653.580879-1-caixinchen1@huawei.com>
In-Reply-To: <20260629070653.580879-1-caixinchen1@huawei.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 29 Jun 2026 19:31:09 +0200
X-Gm-Features: AVVi8CfvDZzdzYVHdraWAewZEFEyCZ6yZ4zu-tcKsdp7diMSLlszm49WqjY_Vvs
Message-ID: <CAOQ4uxjcD0-PHqqmrpEvkLRgtKJGe8-n+6DQyBngjN2TorwU+g@mail.gmail.com>
Subject: Re: [PATCH stable/linux-5.10.y 0/7] Backport Fix incorrect overlayfs
 mmap() and mprotect() LSM access controls
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	miklos@szeredi.hu, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	gregkh@linuxfoundation.org, sashal@kernel.org, bboscaccy@linux.microsoft.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org, 
	lujialin4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 8:38=E2=80=AFAM Cai Xinchen <caixinchen1@huawei.com=
> wrote:
>
> ackport the patch series
> "Fix incorrect overlayfs mmap() and mprotect() LSM access controls" [1]
> to 5.10 lts

Chai,

First of all, I don't think that stable maintainers are picking backports
to 5.10 that were not backported to 6.1 and 5.15.

Second, backporting backing_file as a dependency to LTS kernels is a pretty
intrusive change, so your description above is very much lacking.

Please do not backport backing_file to any of the LTS kernels without provi=
ding
detailed explanation to try and convince the vfs maintainers that you
verified this
bacport is safe for the LTS kernel, because honestly, this looks a bit
risky for me.

Thanks,
Amir.
