Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDE140757E
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777318220; cv=pass; b=OS7qxIQwewIixtP99OoXsTUhQ8OJgWIGkva5KX5t85igdbzvY1p4sZ9O0L5UqshjIiaNvWPXNFrk2nYW5xWrqlIfBr1170TyhVYOzESA7MJgGuC4e+rBcE4ZAbQR16bE6NruERl6uaRK6IGDE0Geh7bAAHv4Y2UjyLbDv3opzn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777318220; c=relaxed/simple;
	bh=tFwWXFMBRiZ625fBY85CbmrUKBhnr2mQs0FLjof1s+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4hjZXLMlbD+/KriwfTN2fgcqEbOIWflUPGHTxrx+OTRBySKy/bBzpPonAezV0JdBKPzpuxb9A0JasCYRtTS3LyoyBjxtIBgXl5A32m1NfkU1ap1T7J6eQhkmBH1f+F8peADBS0NSmjkCHVTh2rcTABjrEhVnp7B4D1VQdMiRn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEJ6siu3; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEJ6siu3"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-671d60ef9c6so14620238a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 12:30:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777318218; cv=none;
        d=google.com; s=arc-20240605;
        b=j/tnhdPwBNXl1zLdsd4/ci9y4EVJPV/teQf3E7c1SLo1u54h69Xfu8JQVWD4ikFo6J
         79EQR9/avrDA5O4zyoB/VQcRvQlMH81h1wQEmVOwVH6MMMy4d3KpBwainbMNStuX1jLy
         gNOTGS+6nc94+j+f3joFI859PmYgFN8Uyd9KcVduIshsuuHHLSJjZ+w9G/GnwjT6mKJo
         D0bqJ1Oqa7QqhfEEd7SCOR+iiODRbcuvUPO4cUViwihYvnkpk0GA7Ct15BOijroc2M+Z
         HzySQGrRMaeOEfp43KvqsRy9HETRLX3AAAcSpqFoIrw0hQupIuEb7aGVM55WUoxAmbsQ
         eWDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EjxomAVUCGQNHhYEOLpf88vdvIXmsFPyPItvbeA3C0s=;
        fh=96Q/0g+gM3Mvw3WX53ZDrn7XaWPs/rFu4fEawcA+bI8=;
        b=FEOkMz+zGfoqUex9VOusHogviX37nF5pRK+Lyx2uKoAWt+I+ndxXiXnls6EtQnmgvY
         MwgygPk63QkKQTPpXaYJNq5nlXdQYnsMhnEUaOncEnErPBhY830jwMfcApYb4MFBnNUm
         4trJ2T7Vgsag+5VVxz4AyMx1ZFdzECyj4PZBgmPNt5bQIJTMToTw9/fLFYxPwlTnOJG8
         dbkNtEwocr3pz9XD1a5jUikl3uuPKhKVM9T+su1UA8NNXXtRLKaXYxqauLZ+q0Vgso0b
         7I3TcG7eArmRbgau9HAGfDHvTFfDPIIA8GbPyz9Z64k5NrGwK3C8R2jwsKxyNrtR02mE
         lNVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777318218; x=1777923018; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EjxomAVUCGQNHhYEOLpf88vdvIXmsFPyPItvbeA3C0s=;
        b=AEJ6siu3gXRhPOEHqAHc5w1xtO0/8quf60bLPA+rXiBYDH7noBtmBT8VXPmOdLnKwD
         5yQ9uj6SlXOKsYJaJ8kmAfXqFE7MRverlRZ+g2W+rkBUG2tHe2poSr3JoMbF5ijATmwM
         AwICHBb+toZ9uey82DrRE/naQ7pYqifZQ3ygWQfzP+Bxa6ii1kYZZSRGJ7LlkoqXUC1S
         4xwL0HEFIDLe+BmJtc0Jh2OnFob4Alv1q4tk1kMSMd5lKFlXXbURkrmpIu05WbKK5aNF
         i8Rkb0GUrRQiMXV8yVRK2xjGigkC4x0ecEqU9dAUqcKfSkTDXu32SX4stytSZIuTQ+vG
         H7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777318218; x=1777923018;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjxomAVUCGQNHhYEOLpf88vdvIXmsFPyPItvbeA3C0s=;
        b=IwmgFj+BMC6Vbp57dTCKD//LedLJHYB61ZVeWUqo8Wv+GBUgCubcZqqtCw+pZXrWdD
         8HvuilaQAj+MYyaqiRnwoyuiWyExVwwmuvQadVw3VBPUzxwG64xmDh8old7+nps074T5
         D6MU8p801eBCrcMNNmtHIQsTyeXr13QjF/eHQjf9MxVFRDA18zK7WSkkczrfYYmssUK2
         NiN9aZH598iEhzIAVGi8Ej45GW+wBD+xv87FNVTcBrmfuV3Pio7DhBicdT/s2RQRr29u
         qBafq3o3ptR38bdLYLDYfr23a1n0bqe5xnVOHdveHjW3hasy1idfzsmq2xCIONvxvzdr
         oFKQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ggpifmnZpDkpnnvrgqLyfkoMk5faBLdGNt5dqiatj6W5fqgSoAUBLdNnTQT2NIuElE8uVxlmii+Bjt773@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0OcGRB1G/ArkUzdlJ/blc8unxWTG/ylcv/oyhqbl9DcmNtIoV
	VUc94+utUDVr4m6yJ++tzl5Xq9vRPkpf9BMJCHWtjeajqaOdZMeYAiZqNieIp+NbunmaliDsEBe
	4h/7agV4WBoS1Ugys+EE/KKQVwfbPHUU=
X-Gm-Gg: AeBDies0e/A7o/qfjdBOZ3RGzpuP+JF/y7moZpj8kExr9RZ4CkA35AlETlZ/h4C2HiA
	R3Qlp/jiBSQL4wIcYFRYVYCDQyHmLNkw3PNcifFfOTniPj1xLgzw8+X946sKIdyd+Ow1zSBmbRS
	aX5iAx41yLtP6va1tIve0FKw8JDMQbGcYmLN1jXGpfbxjFbf8oyUPuTfCmSYkucTvnuTXkSPPFP
	NuilcfKhu9zH/pr+cXNMeadN4FTlykmABvcI5VzXEbMcy0INdqA+yCCGXOuLCkY1xs81RRONn2k
	xPNAon0/aharf4pRDblxZ4/ATJVA/+3NUJy9u4kpW9HVJtShF9Ox
X-Received: by 2002:a17:907:1b09:b0:b9c:69df:4d8e with SMTP id
 a640c23a62f3a-bb804245b53mr7307766b.25.1777318217596; Mon, 27 Apr 2026
 12:30:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422125212.1743006-1-amir73il@gmail.com> <20260427154818.GL7765@frogsfrogsfrogs>
In-Reply-To: <20260427154818.GL7765@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 27 Apr 2026 21:30:06 +0200
X-Gm-Features: AVHnY4IwMOHJKeGqDPpTyIpVtgoBWooU1GnAjk8YsCWdvO4eXmpSVkRuQnPFzAc
Message-ID: <CAOQ4uxg=Yi5eOPshMsA9HV6vrs9SnZ3XFvoqjR4s-AJQPX4FSw@mail.gmail.com>
Subject: Re: [PATCH v3] docs: add guidelines for submitting new filesystems
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Theodore Tso <tytso@mit.edu>, 
	Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

> > +Be testable
> > +  The filesystem must be testable in a meaningful way.  The
> > +  `fstests <https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git>`_
> > +  framework (also known as xfstests) is the standard testing infrastructure
>
> It's been known as 'fstests' (without the leading 'x') ever since other
> filesystems started using it for their QA.

Sorry, I couldn't parse the requested fix.
The document already refers to it as 'fstests'.
I'd rather just drop "(also known as xfstests)".
The aliases of fstests and their history are  out of scope for this doc.
The repo URL link does not leave any room for confusion.

Christian, assuming that we all agree on this, could you make this change?

>
> With that fixed,
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
>

Thanks,
Amir.
