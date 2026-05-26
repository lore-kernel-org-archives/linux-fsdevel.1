Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC21352C52
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 23:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779836572; cv=pass; b=Z08K9cx8wBSBwoxBbaU2oSkcuIz0AoQSKxVVJItVNIcPfND4zTjKIVRMrwUPNXzlOtwgHbYrYBPGs0af7nn8oWuNwHsxmDcFHAIK4ktjttFUSolpAws78ZRq4eJ9FT2Na0HfJ2upFe02R9S3s5UxxbL1EhVLJZZOskjt1UfmPxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779836572; c=relaxed/simple;
	bh=s8kEYiZm/hmtAIvQwNbKn/Wg0qAsNeUH0ZP7UDqtVe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBq12wekweRRHQi3dxoNKH4nl28rVBjQKRDU3j8iAWbovOe8zkbvqL+6V+Bvji76/w2BU0gqyKKMubBlPXfXoFOQN1YjRE7NSkpNruduWOLDyN1OOWR9K3Ede//Ozpc/MF3moA9Thv2AaWvNQTNxRjzk6C82Y1og4HWckH0kUqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=RMxZRS6A; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="RMxZRS6A"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7b4ee3a88e1so106230087b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 16:02:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779836569; cv=none;
        d=google.com; s=arc-20240605;
        b=AQ/9NE13vp9bR9XmKpVghbTFSePmayrutBhsJ55qbMSFLGA/bkUreO/tTAyitQp4ze
         nDbpUvqSomvvWY7WcMW0xhhQPDPmm1FKXRTj0XbskyxmKHsDE0WGmpte0Kw9J5mFMWLg
         ZdrDuU2wM5yz7vBGb7VPdC61J6UUSe2tzRDXliwXQTiZ6oB77oGamkOURr7h7KcWyZGs
         6V1Hfz+lsdHLRALxwKUKCMEkjWUhBfrra4lwC9ZiG6RsBzVYiS66n8h4mz50/q17uDJY
         Y3PIICjnIKvV1kVUeV11GJDnMHpjJnrE+KBbipohqo2t2+0Y+irsTZwwc2/H+GKynDAz
         narA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6XyOTzumBLhN7AaNcowHTDfalRU1Y9Pn1vzjroVkGII=;
        fh=76XSOg/+O8LilTE1gSx03caUd1COkQy8RuclYA2ftoc=;
        b=AZRrOSn4G/WU5aSPeK6GpxqpZ2ZR9aNpgnFs4qDTpjaWiGBBJG66n4UveJ6HMDoVZl
         /DTKKHep5KU8bFjZLTIWgSGxRZSoolCf8Fq67SFZbCmvqOhtkShTxN1GiNJP/kYy1IwL
         sKnPYNVE53q2IXVF/xlneg3zPpYPFTme19lK/H9vjThwJLT2iCLYoEX5U9mdmvgLFUTt
         QgPb071flbCOE73HeOdX/IiKsO/VKeJCLWwJ6kL7StpIRYK5o3OFfWhTiohjTex1mxiV
         rXKUvgf+GeR5wSaI6ZSB58kYTo8CcaFkReX4Hi+t8RWrvPEsoxqvfXJ1/jCM3ThB1vM/
         k4/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1779836569; x=1780441369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XyOTzumBLhN7AaNcowHTDfalRU1Y9Pn1vzjroVkGII=;
        b=RMxZRS6Ayl7vo4mqcWudjxyfoCYOfROsipJSX8jBJ7EK13mKwdhqB+hrO1ga7MYgHh
         uW7dY4GS1OUQbMnFlWMAg8UdTeLj7+jAxKnbDYiI7f/XbeCAdv0+zmeLHW/3HCoHJUJl
         Dao+fB9PYJwMPjzC0vghW9RpfIrkV0xzMbADkzNs4oSnY3f0/z23a4GF80mXM8+rUSg0
         r22hkoCAwobXGDcnJrEOkJZfdT2AKtyR0+tsYHICZX5TGQFVGHGRHW22zxihu3fyfErI
         yzSkOx4OMxweDu9oZPMpoX7iOR9+X6IC5fwRXuvzIAV+aK+wQ4PAnMFzsns4+vS2GYxA
         Jupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779836569; x=1780441369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6XyOTzumBLhN7AaNcowHTDfalRU1Y9Pn1vzjroVkGII=;
        b=h6XHlqEDDmAjgkmvkRvnpRFGye6oSpOSTwOnmKjp57bTNOXY7CR3YiH2FMx5+rNYIx
         hIOFQuAdSjI7YjW+5oQ6gvCAHE8STP0OPT4lKjwX+kTP3EEeMLl6SzFd5k8xrte8rXM2
         ootRCxXqtcz8pGDD+QxlvASTXKmWiOu6b1kNNXsH7Ylg78RmYOaNGiPV1b5PAWTSzoiC
         v8BXVu39mPqPWC3FSVQiX+oCqmcei2wQ/OPz147bXtHBKqao9jpi3PN4L8Ndxo29uXCj
         AqcHl1w7Kkyy7Ue1YzFf3WFioZbEh6Afd2aVAiGclYblpXoP72T+wSdlTtPvcNEabQjK
         AlGQ==
X-Forwarded-Encrypted: i=1; AFNElJ+dVvSCYR7DooD5D0NoCv76OJS7yd6FBj0hMS9NR8mUBg6e+fdtxq/dWQyiV7VYca/lWZWKxnBgz8wbCg5V@vger.kernel.org
X-Gm-Message-State: AOJu0YxuOZgP2AhZ5xL69Fxi+0035owSnnSeKGKqKM5IRxTx6pThZ6hf
	Q1/atMgrUlOFz8I7snxwkSwkHK6eJpjM7bylO0skDbhWIrujx9ujQPNQhjnUg9pIxQp+ZHz8ZAh
	9anXgVhgz/Q9ykgdIy82K5MFd7h9JtmTFNujbOXau
X-Gm-Gg: Acq92OFTXqOjzqHozmosKrbzIWDBekrGF3nNxKJXr+WFwjn7xiqg1Yj6SdA4uPx9uNk
	3Vy7HyB3Fagysq6Gsn8ydm1GnIFZTkW/+GZ6bAUljye3pG4+S43fU4IYXF5b5lQk/IJLI80jdNY
	+Cd4R/IL8xhI2MksFYlszxPlh0s99DyjdS4eWbLWARbFwUjF71x03Sg+C9oOeIwPCTt/PIWi27l
	74+kuF/+nFREYO35bTwzoLcVUbktP4NmzThNeYNX/hL/lIoNm85jD1WPsOYD7NUYT7dWR0hugXI
	l5Q48BCQIzuiQWMnh2BlYQcHuOnnXEGrVeTQS2Qbd/ADGNeUsSCo
X-Received: by 2002:a05:690c:3502:b0:7ba:eefe:9fa1 with SMTP id
 00721157ae682-7d333ad9b03mr226944547b3.6.1779836568170; Tue, 26 May 2026
 16:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+0ovCg9e3_2jyM7x67A2rp8E=BR2gLX1FBZHyXdctFAhcG+qg@mail.gmail.com>
 <20260526224956.GF2636677@ZenIV>
In-Reply-To: <20260526224956.GF2636677@ZenIV>
From: Farhad Alemi <farhad.alemi@berkeley.edu>
Date: Tue, 26 May 2026 16:02:36 -0700
X-Gm-Features: AVHnY4Imm4NOQ19K_H3mIQWwmPrDL3-6AMNOZH_PiHopiSzygYmNsZ-PEfT0K-k
Message-ID: <CA+0ovCip_OYAW5u2PDr+DPtFgxMXanvYm1UV_NyPrLXH6eM2jA@mail.gmail.com>
Subject: Re: [BUG] ufs: UBSAN shift-out-of-bounds in ufs_fill_super() at fs/ufs/super.c:1181
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sounds good, Al--thanks. Happy to test the series when you post it.

On Tue, May 26, 2026 at 3:49=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Tue, May 26, 2026 at 02:47:30PM -0700, Farhad Alemi wrote:
> > Hello Al and the linux-fsdevel team,
> >
> > I am reporting a UFS crash found by syzkaller. fs/ufs has no named
> > M: entry in MAINTAINERS, so I'm routing by commit-history affinity.
>
> Same comment as for your previous report, really.  I'll resurrect
> an old patch adding sanity checks to ufs_fill_super() (rejecting the
> same things BSD does), will Cc you when it's posted.  Might be a week
> or so, though - plenty of shit on my platter at the moment.
