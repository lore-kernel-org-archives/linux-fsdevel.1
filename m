Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487BD3947A4
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 08:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266012; cv=pass; b=AOpAjo5GK1u/HTepzdTBdYmYGtD8laYIbE6bfPd09HwRUc4KYRoGewiO5iirMrOLB/0AeXJpeIwl7quX5O3OG+yXg7hT0QBgeeHUyAe5MOgATK9OR+nDb7etkdpDiyFUtvT9khEAa7vdev8p7RSNj23pUq4UcLGcBkzV2bmkhqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266012; c=relaxed/simple;
	bh=yj7nKyFrj7zU2yYnwm4/LaF7qhH6Xk4MypSMzLI7D08=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=p0w0RPQ8IQ2EZZdzFCS2ugNVjySyAumtJ0UtOBlHwqP1rK1pvHDA3D7U95FHYxU7fIEPEKxr18F7lT2MAK7EmLDWWlIdcrOiGzxzPrTyh5kHUNj0NNPRaXFY+h6dW7evlSwfNBIncJIlFcuHYbAa8hNAXOuOKOunV1mFjLXun+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjCs5eCE; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjCs5eCE"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38be5e86918so60325361fa.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 01:33:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779266009; cv=none;
        d=google.com; s=arc-20240605;
        b=i+iDc41rlULBwCdfDvzWLShf7FN6/wrWtjCgrtKWaT7SAvcMFrDNkLHK4r3DEhE2iK
         lfxYa7WAHw2dtMaO/ywFugalMa+NGUFq0jI44Dja+U+kZmRcxIB2VF/ChkS4gIdiwlgo
         ekPqS7DxkjL5GSim8zFbAmEmK4QrX/mmHLA9yMtCJYZu68ZxlK/4E/xCJwiRioTTAg/U
         rnRAxyWUSquBsrTTIfZKr9f1Qo3ISsGGHqdsKifcVSZ+5ONwicaovOKfaHC8gbfxmf8P
         bEPxmgV0fD8hJFlVf0FlLsyiS1Np63m4DQSz8OP9nfIS2jjzj90n6aujrXkVsnBdVvcx
         3kuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :dkim-signature;
        bh=yj7nKyFrj7zU2yYnwm4/LaF7qhH6Xk4MypSMzLI7D08=;
        fh=on5so1iZ1tYm751VXv8x5u+l+XerJy9A4qWb/XOx/D0=;
        b=P6kuz+aaY/zSUK/nCpl9dNpJ3hBdNZTkC37c0tHji9lNyHuOObwBtuiDapFJK2ZkUZ
         ERpeLm7Edc/yC661ytb3p+59FMoA9WJY8RwMsRBhC2eRVUgsYootDeqVJ/jgU96Ozv9O
         X0aQxD1H9fa3vg1miJmvlZ+6EbCM9Ojn+zkTn9Ui2IXhYUqGwvdOW1/nq8kEyGhIEAk2
         SybIJR5NKAziWW1qcp19+VD5fRshbPlIGCnStUZAz6NfY0Tfy8ufTVEgnxqLAtAyhmy7
         a/GCrRV2yLk5ROt24+sMeXvlTAemHO1OPX4QM7IzThrRW7VThrC2455NIAbKNzK4Lhw/
         +fqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779266009; x=1779870809; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yj7nKyFrj7zU2yYnwm4/LaF7qhH6Xk4MypSMzLI7D08=;
        b=cjCs5eCEJgrcADq8HOh9AxTBkd7Rp6VtFc4IpooUpePDSHSanE+9a5Lx/Z1OmK9wYh
         F/9zFWqrfVk3BZ+2NSGeTBeM33PekIsGdkQi+Y1ZEtYOJKQM5V3+ewXINn0O1p/Oc4RJ
         D2p9Peoza6q1wZh8WpaauFRj+ZVuHpoqyYKzZQqpn/yLBKTsArrFT+70lVZhkGu3c+mm
         tOW5A0O2kXw2NrCn2oGjMlD753wFbG8KB8GiMYGlch50L2BxOYUCciDdqH6E46yUCI1c
         C/hTV0cqDwq5UngerxU3msaDUodYzP8U4oIQE4/yfnd4GvlFssFzWrZCjYcb48Jc6YtA
         IHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779266009; x=1779870809;
        h=to:subject:message-id:date:from:reply-to:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yj7nKyFrj7zU2yYnwm4/LaF7qhH6Xk4MypSMzLI7D08=;
        b=WQnCmGxR6bJrF9zpyIyuANKN2QdLK2Tin4oZIqacXKvhb8KTdh703g/e4oNhXE/vE7
         Ng7uZIqo8YfK+Vd3adIhGFR7jeNMYP/9uYTsC2jVCHP0pHoPOnys3GALM7Ty1VHGngIu
         wch3mT9fsLpe021XQYLnCHZ/Zvy53L7AgRc70772mIiJIDsLb0yxwhnK/VIKZNpN1nSh
         ZTSDIkvFBLDZob8nnVLJzdjS5FAi+AW+KTZBWHnlcYpjDlu7c6lALokFicafHat85hb4
         cJaxdpN2RXI4Vcg6aoX8X+V2npQQLSK+d8t4oGsGnWqTCbunxAP/iT/5I0Qdh5ncF+N4
         dYgA==
X-Gm-Message-State: AOJu0YwtrjYFzM9PpwHU3ijuLEx81m/ESOeqkEndRrSmmXz0sCrgBQ6t
	PIvRQvn8F0TUiuhwx+GylGAmBX4zH7bmeaZGzWC2Z++gqlMQlPpl4kodFEJvEWceyYR887O5n0D
	mjzL4HUnf5GBLvLaT6w91yTFaHhpphwOXMvNO
X-Gm-Gg: Acq92OEVHcOGMTs4IgzWVgWJF+WGBgIk8I+7bNmuqMBMtkFNfmWBwmFGn9EaDISpnO3
	QoGJewqOEZ8PT93CH5MncDSdb5ffZB6UTa/XNLYNBQRGCPe/4jQZrPmxPw6sOhgNy0j2pHTPA2r
	SKqH533YHm4v7yGXt6t6PNm8JUnRxs5VO+M+gEwcLgSDcw8gLT8zMMgLTcHN+SROKiYS6BGmfLc
	eV9AingLcjIFSW56xIGuNGU0WIgY1MJgd8sEJCyR4hgE0zE1o5K/x1Zp84OrNnNdFnif7PkgQNt
	xEk/q8J9
X-Received: by 2002:a05:651c:885:b0:395:b670:71ce with SMTP id
 38308e7fff4ca-395b67075e9mr12239001fa.2.1779266009258; Wed, 20 May 2026
 01:33:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Wed, 20 May 2026 10:32:53 +0200
X-Gm-Features: AVHnY4KyREv1yCQ7RQ6D4YzFTHPAISpM1OIGE9ooYJPmgaRPPy1lI6j505yG6HY
Message-ID: <CA+icZUVRSX6QSVFw7zoT3abFThtMkaSmf0e=Odop79QKu67=Rg@mail.gmail.com>
Subject: unsubscribe linux-fsdevel
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

unsubscribe linux-fsdevel
