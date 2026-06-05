Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFD03290D2
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 12:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780663090; cv=pass; b=YKm3DZWZ3E0Btg/9db9iqZLQ6zMCTlPo8b5pp9DWDImJMWLY4+fP+y40w4nSFu1VQJaWneJiBYQFgLCYS0IbPo42zACHbbEw05tB/YEHtZNKTPMr2wMEsSZUypB4BD2N8rwDBWqEhQQOpJ4PAXoECcgEdMPIXQduoRRlX13hOjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780663090; c=relaxed/simple;
	bh=jaIH6xUqz6qcuESYoZJL7a5QWsRjb8U7RVmYk0JRpxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ccfNUYjqwOnLLXc18+wEUG6rMRV33Y39qqsQ8F5FjApJMELpKy7Oj2eIstRyqSdVI7/0iLI22NMRVbcRWLXA16Whn708MO8G585X0VBr4iyPfZtfKZ9LxgDv/yHU3z2qUO+FSyvDdqZQ9qw2OSMC6+7Cj/QPzXA9Xfzt0n9idT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=YPPzw+jP; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="YPPzw+jP"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-13810b63a1aso47307c88.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 05:38:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780663087; cv=none;
        d=google.com; s=arc-20240605;
        b=TyyjK8S6dAmfHlOYhRTn+XBgJPze9+EYFckZUCyymJHCDeTk3IGg1MDdOJ/AOKAcge
         +Jur7fwWiKPrSHZ2zdIgueKDcgIYKJrtcs6EBg0vYaxuSEU0cjQ35f6lmD7eGRIpzFGM
         +V8Fza+L72w8PcgZF9ip1tPDG3BPsYvnYLEJc/dFt216CtlZejCiSKvS6E06ZtksHHOt
         idSUiwlXnqrfMS/2VeuGtcgOebBciraZo1LJaJ3+EdWo2By6gYHOaOb6jeuEbVpt66Kc
         dPXBvyZp/anmf+7vB1WQasAsaqTDbtJ48rbf8pYJXPTJyvfuMQzqxARhJ/hP0JCmNpyS
         PsOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jaIH6xUqz6qcuESYoZJL7a5QWsRjb8U7RVmYk0JRpxw=;
        fh=7T66dxV3x1e/b2844NiBGMCvt0K2HyPRaVtSmIZPwBE=;
        b=hOU/mc6xHDFAQr9mnV5hEVF8rGbDSwK+Y7s4Yy7ih4lshMtu3jgeTtlgCSh/rkXM1p
         L4DyPkQvpGYwUzVnRwyDxWOoY6L7EPfVGvznzExzApaUfkUsgMvwWTlL2fyLKw4xzMXh
         ZRJZF+1EQGQlK70GDui25XoqBDp0AA6SfNRlZgGPjuKjHpLHqDeIEYmvswhYOsCFrtsJ
         0/XjUBlxTqg1eQSwniwZSjAI++4hQpUx7sfEWwTesyV7EmoBwyWEPNY9jRjzjpbcIJZM
         g2OA03BKGvAxTMXWVKxqwJcp3/h6mfdx/g22J0eVAViGFH5oPZhxssmpugyRYAe1PJ73
         RDXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1780663087; x=1781267887; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jaIH6xUqz6qcuESYoZJL7a5QWsRjb8U7RVmYk0JRpxw=;
        b=YPPzw+jP3cwIB44tz3RkHAAgXsfqo5wRNfiUV5MqnQkMZif2DsWu9EGASd3iMBNC1x
         nw2nmyZayfVq3uuDMUPcN6h37UkGCRcY2cFe4U4oc8xbv40Vp4z24kXs3RGPAGzN52Ah
         DfRIgqh1HvuKHtkxSBgAsmQ3aGShYgmtuLpig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780663087; x=1781267887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaIH6xUqz6qcuESYoZJL7a5QWsRjb8U7RVmYk0JRpxw=;
        b=Dvx8B8Rk4ul6bkZtzGuHuPTwbyn1NRMFsqYaWya1CX1qU+u9VYh0pNsgT6Cgu3/woh
         pBRLq5TXiAGn08AetiOS8VAdR/lxttMbzE1Ewek2TpF+tX6MR12mqMIqo7VNqQQ0QsOY
         agknn9qQsE0fjrZoTi8b89Cfmax/jVPcujL1goo7ji4oah/v05ouDO1S/7ke3ehO7aAF
         UBfTwDWqoS5ujVYTuGKJtMDyhZI4UyEHZtt3QWdl38mMiNPMCR7ux8Bxs64WcsAhKaiu
         iyofa5gpsjkZNHlwVaUCsWI+gLOXOPOnzTwtNNZCGPy9CDSln+NRervdK9Bef3x8yq/r
         rhog==
X-Forwarded-Encrypted: i=1; AFNElJ+sXY9I+QP5ph9f75O7Q8FsHLsP6OF/D2lqyZCS59bfcZKMv5iAQxpnEDUdpPV/stvelhNMg5zeK3OrSZMg@vger.kernel.org
X-Gm-Message-State: AOJu0YyRxV24S113m6x7O+hKaG5i/bvH+khz4evB03p0NEwt42X8kDe2
	S1UjPMKaw7tAQMceCRTIKZgxTkHL3+QSwR4djsS1Run9N/eNhpNpxtEJU875z1rct7D6jVyUHTO
	SMRHExj+uryFnjFcux7DQLgUjX9qvGbN+5QIpvGnFiw==
X-Gm-Gg: Acq92OEbHUHcOTl/sgfSBbdvdjTFsCS/iuaHtpFIgi+1lKfccEl+ptsPH3jz4zpRGeR
	LONHWaz6fAz/3n22oaVKmnH2L3FgbKT7nqTC3zYpTwFyxJsgaKl9H7AAYKa4T8zHlkCli4cXMC9
	XSzkSOUtXqlCeZzHSwAddOlTrbfr3qibVkwu0pROZ/GLZE2TcnV2kw9eWFtcZwUpdtugSmjbShV
	TL2rNNy6JmSY2FpbbSiKqBU9bJseKhzEVEjcajSCsTOLzsiBaCBjFh1XQz0Ge+pmallvRDtlAm6
	ris554ATkGWDJV5aLXfJ0hWoYTct7DQT9o3MfVtAphaiPCY=
X-Received: by 2002:a05:693c:37c8:b0:304:6d18:3646 with SMTP id
 5a478bee46e88-3077aeb08e2mr1619952eec.0.1780663086996; Fri, 05 Jun 2026
 05:38:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601162454.2116375-1-mszeredi@redhat.com> <20260603-fehlschlag-teamleistung-korpulent-5e0b7fa7f12c@brauner>
In-Reply-To: <20260603-fehlschlag-teamleistung-korpulent-5e0b7fa7f12c@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 5 Jun 2026 14:37:53 +0200
X-Gm-Features: AVVi8CcsjS-pOQInTF6xJp7mIhrit2P92AFENeMBRNq41bIxUZ72aQoIYL-42L4
Message-ID: <CAJfpegvuY_EcQz8fgyWk22=agPq1sboiribP780DjR4i+eqUUg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] simple xattr improvements
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jun 2026 at 09:31, Christian Brauner <brauner@kernel.org> wrote:

> I've fixed a bunch of that before already but thanks for sending it
> again. Fwiw, we now also carry support for bpf xattr in the
> vfs-7.2.xattr branch. I'm still applying my kernfs fix on top.

And sashiko keeps finding bugs, so I keep resending the patchset.

One of them was a pre-existing bug with kernfs, where inode locking
isn't sufficient due to kernfs nodes being shared across super blocks.

Thanks,
Miklos
